 /*
 * =============================================================
 * IH.c
 *
 * Calculate the hypervolume of a non-dominated set
 * This is a modified version of hypervol.c by Eckart Zitzler
 *
 * Aimin ZHOU
 * azhou@essex.ac.uk
 * Copyright (c) 2006 Dept. of Computer Science, Uinv. of Essex
 * =============================================================
 */

#include "mex.h"
#include "math.h"
// #include "malloc.h"

#define ERROR(x)  fprintf(stderr, x), fprintf(stderr, "\n"), exit(1)

/*
 point1 dominates point2	: 1
 point2 dominates point1	: -1
 non-dominates each other	: 0
*/
int Dominates(double point1[], double point2[], int noObjectives)
{
	int strictBetter = 0;
	int strictWorse  = 0;
	int better		 = 0;
	int worse		 = 0;
	int i;

	for(i=0; i<noObjectives; i++)
	{
		if(point1[i]<=point2[i])
		{
			better++;
			strictBetter += point1[i]<point2[i] ? 1:0;
		}
		if(point1[i]>=point2[i])
		{
			worse++;
			strictWorse += point1[i]>point2[i] ? 1:0;
		}
	}

	if(better == noObjectives && strictBetter > 0) return 1;
	if(worse  == noObjectives && strictWorse  > 0) return -1;
	return 0;
}

void Swap(double *front[], int i, int j)
{
	double *temp;

	temp 		= front[i];
	front[i] 	= front[j];
	front[j] 	= temp;
}

/* all nondominated points regarding the first 'noObjectives' dimensions
are collected; the points referenced by 'front[0..noPoints-1]' are
considered; 'front' is resorted, such that 'front[0..n-1]' contains
the nondominated points; n is returned */
int FilterNondominatedSet(double *front[], int noPoints, int noObjectives)
{
	int i, j, n, dom;

	n = noPoints;
	i = 0;
	while (i < n)
	{
		j = i + 1;
		while (j < n)
		{
			dom = Dominates(front[i], front[j], noObjectives);
			if(dom > 0)
			{
				n--;
				Swap(front, j, n);
			}
			else if(dom < 0)
			{
				n--;
				Swap(front, i, n);
				i--;
				break;
			}
			else
			{
				j++;
			}
		}
		i++;
	}
	return n;
} /* FilterNondominatedSet */

/* calculate next value regarding dimension 'objective'; consider
points referenced in 'front[0..noPoints-1]' */
double SurfaceUnchangedTo(double *front[], int noPoints, int objective)

{
	int   i;
	double maxValue;

	if (noPoints < 1) ERROR("run-time error");
	maxValue = front[0][objective];
	for (i = 1; i < noPoints; i++)
		if (front[i][objective] > maxValue) maxValue = front[i][objective];
	return maxValue;
} /* SurfaceUnchangedTo */

/* remove all points which have a value >= 'threshold' regarding the
dimension 'objective'; the points referenced by
'front[0..noPoints-1]' are considered; 'front' is resorted, such that
'front[0..n-1]' contains the remaining points; 'n' is returned */
int ReduceNondominatedSet(double *front[], int noPoints, int objective, double threshold)
{
	int i,n;

	n = noPoints;
	for(i = 0; i < n; i++)
		if (front[i][objective] >= threshold)
		{
			n--;
			Swap(front, i, n);
		}
	return n;
} /* ReduceNondominatedSet */

double CalculateHypervolume(double *front[], double refpoint[], int noPoints, int noObjectives)
{
	int   n;
	double volume, distance;

	volume 	= 0;
	distance= refpoint[noObjectives-1];
	n 		= noPoints;
	while (n > 0)
	{
		int   noNondominatedPoints;
		double tempVolume, tempDistance;

		noNondominatedPoints = FilterNondominatedSet(front, n, noObjectives - 1);
		tempVolume = 0;
		if (noObjectives < 3)
		{
			if (noNondominatedPoints < 1) ERROR("run-time error");
			tempVolume = refpoint[0] - front[0][0];
		}
		else
		{
			tempVolume 	= CalculateHypervolume(front, refpoint, noNondominatedPoints, noObjectives - 1);
		}
		tempDistance	= SurfaceUnchangedTo(front, n, noObjectives - 1);
		volume 		   += tempVolume * (distance - tempDistance);
		distance 		= tempDistance;
		n				= ReduceNondominatedSet(front, n, noObjectives - 1, distance);
	}
	return volume;
} /* CalculateHypervolume */

/* The gateway routine */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
  double *pData, *pRef;
  double **pDataArray;
  int i, j, k, dim, size, csize, dom, *pExist;

  /*mexPrintf("start\n");*/

  /*  Check for proper number of arguments. */
  if (nrhs != 2) mexErrMsgTxt("Two inputs required.");
  if (nlhs != 1) mexErrMsgTxt("One output required.");

  /* Create pointers to the input matrix S, Q. */
  pData = mxGetPr(prhs[0]);
  pRef 	= mxGetPr(prhs[1]);

  /* Get the dimensions of the matrix input */
  dim 	= mxGetM(prhs[0]);
  size 	= mxGetN(prhs[0]);
  if( mxGetM(prhs[1]) != dim) mexErrMsgTxt("Data must have the same dimension (column vector).");
  if( mxGetN(prhs[1]) != 1  ) mexErrMsgTxt("Only one reference point is required.");

  /*mexPrintf("%d %d %d %d", Srows, Scols, Qrows, Qcols);*/

  /*selecte data*/
  csize = 0;
  pExist = (int*)malloc(sizeof(int)*size);
  for(i=0; i<size; i++)
  {
    dom = Dominates(pRef, pData+i*dim, dim);
    if(dom>=0) pExist[i] = 0;
    else       { pExist[i] = 1; csize++; }
  }

  if(csize<1)
  {
    free(pExist);
  	plhs[0] = mxCreateDoubleMatrix(1,1, mxREAL);
  	*(mxGetPr(plhs[0])) = 0.0;
  }
  else
  {
	/*assign data*/
  	pDataArray= (double**)malloc(sizeof(double*)*csize);
  	k         = 0;
  	for(i=0; i<size; i++)
  	if(pExist[i] > 0)
  	{
		pDataArray[k] = (double*)malloc(sizeof(double)*dim);
		for(j=0; j<dim; j++) pDataArray[k][j] = pData[i*dim + j];
      	k++;
  	}

  	plhs[0] = mxCreateDoubleMatrix(1,1, mxREAL);
  	*(mxGetPr(plhs[0])) = CalculateHypervolume(pDataArray, pRef, csize, dim);

  	/*delete space*/
  	for(i=0; i<csize; i++) free(pDataArray[i]);
  	free(pDataArray);
    free(pExist);
  }
}

