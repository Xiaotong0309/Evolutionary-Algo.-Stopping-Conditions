%**************************************************************************************************
%Author: Yong Wang
%Last Edited: July 1, 2010
%Email: ywang@csu.edu.cn
%Reference: Differential Evolution with Composite Trial Vector Generation Strategies
%                                                    and Control Parameters
%                           IEEE Transactions on Evolutionary Computation, Accepted
%**************************************************************************************************

clc;
clear all;
tic;

path('testproblem',path); 

format long;
format compact;
c1=1.4962;             %加速常数即学习因子1  
c2=1.4962;             %加速常数即学习因子2  
w=0.7298;              %惯性权重  
MaxDT=300;           %最大迭代次数  
D=2;                  %搜索空间维数（测试函数sphere中未知数个数）  
N=30;                  %初始化群体个体数目  
eps=10^(-7);           %设置精度(在已知最小值时候用)  
problemSet = [1 : 6 8 : 24];
for tms = 8  : 30
for problemIndex = 14 : 14 %1,3,6,12,14

    problem = problemSet(problemIndex)

    % Define the dimension of the problem
    n = D;

    switch problem

        case 1
            testcase = 'uf2';

            % lu: define the upper and lower bounds of the variables
            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            % Load the data for this test function
            load sphere_func_data
            A = []; M = []; a = []; alpha = []; b = [];

        case 2
            testcase = 'sch1';
            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            load schwefel_102_data
            A = []; M = []; a = []; alpha = []; b = [];

        case 3
            testcase = 'hce';
            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            load high_cond_elliptic_rot_data
            A = []; a = []; alpha = []; b = [];

            if n == 2, load elliptic_M_D2,
            elseif n == 10, load elliptic_M_D10,
            elseif n == 30, load elliptic_M_D30,
            elseif n == 50, load elliptic_M_D50,
            end

        case 4
            testcase = 'sch2';
            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            load schwefel_102_data
            A = []; M = []; a = []; alpha = []; b = [];

        case 5
            testcase = 'sch3';
            lu = [-100 * ones(1,n); 100 * ones(1, n)];
            load schwefel_206_data
            M = []; a = []; alpha = []; b = [];

     case 6
            testcase = 'ros';
            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            load rosenbrock_func_data
            A = []; M = []; a = []; alpha = []; b = [];

        case 7

            lu = [0 * ones(1, n); 600 * ones(1, n)];
            load griewank_func_data
            A = []; a = []; alpha = []; b = [];

            c = 3;
            if n == 2, load griewank_M_D2,
            elseif n == 10, load griewank_M_D10,
            elseif n == 30, load griewank_M_D30,
            elseif n == 50, load griewank_M_D50,
            end

        case 8

            lu = [-32 * ones(1, n); 32 * ones(1, n)];
            load ackley_func_data
            A = []; a = []; alpha = []; b = [];

            if n == 2, load ackley_M_D2,
            elseif n == 10, load ackley_M_D10,
            elseif n == 30, load ackley_M_D30,
            elseif n == 50, load ackley_M_D50,
            end

        case 9

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load rastrigin_func_data
            A = []; M = []; a = []; alpha = []; b = [];

        case 10

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load rastrigin_func_data
            A = []; a = []; alpha = []; b = [];
            if n == 2, load rastrigin_M_D2,
            elseif n == 10, load rastrigin_M_D10,
            elseif n == 30, load rastrigin_M_D30,
            elseif n == 50, load rastrigin_M_D50,
            end

        case 11

            lu = [-0.5 * ones(1, n); 0.5 * ones(1, n)];
            load weierstrass_data
            A = []; a = []; alpha = []; b = [];
            if n == 2, load weierstrass_M_D2,,
            elseif n == 10, load weierstrass_M_D10,
            elseif n == 30, load weierstrass_M_D30,
            elseif n == 50, load weierstrass_M_D50,
            end

        case 12

            lu = [-pi * ones(1, n); pi * ones(1, n)];
            load schwefel_213_data
            A = []; M = []; o = [];

        case 13
            testcase = 'ef8';
            lu = [-3 * ones(1, n); 1 * ones(1, n)];
            load EF8F2_func_data
            A = []; M = []; a = []; alpha = []; b = [];

        case 14

            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            load E_ScafferF6_func_data
            if n == 2, load E_ScafferF6_M_D2,,
            elseif n == 10, load E_ScafferF6_M_D10,
            elseif n == 30, load E_ScafferF6_M_D30,
            elseif n == 50, load E_ScafferF6_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 15
            testcase = 'hy1';
            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func1_data
            A = []; M = []; a = []; alpha = []; b = [];

        case 16

            lu = [-5 * ones(1,n); 5 * ones(1, n)];
            load hybrid_func1_data
            if n == 2, load hybrid_func1_M_D2,
            elseif n == 10, load hybrid_func1_M_D10,
            elseif n == 30, load hybrid_func1_M_D30,
            elseif n == 50, load hybrid_func1_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 17

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func1_data
            if n == 2, load hybrid_func1_M_D2,
            elseif n == 10, load hybrid_func1_M_D10,
            elseif n == 30, load hybrid_func1_M_D30,
            elseif n == 50, load hybrid_func1_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 18

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func2_data
            if n == 2, load hybrid_func2_M_D2,
            elseif n == 10, load hybrid_func2_M_D10,
            elseif n == 30, load hybrid_func2_M_D30,
            elseif n == 50, load hybrid_func2_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 19

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func2_data
            if n == 2, load hybrid_func2_M_D2,
            elseif n == 10, load hybrid_func2_M_D10,
            elseif n == 30, load hybrid_func2_M_D30,
            elseif n == 50, load hybrid_func2_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 20

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func2_data
            if n == 2, load hybrid_func2_M_D2,
            elseif n == 10, load hybrid_func2_M_D10,
            elseif n == 30, load hybrid_func2_M_D30,
            elseif n == 50, load hybrid_func2_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 21

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func3_data
            if n == 2, load hybrid_func3_M_D2,
            elseif n == 10, load hybrid_func3_M_D10,
            elseif n == 30, load hybrid_func3_M_D30,
            elseif n == 50, load hybrid_func3_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 22

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func3_data
            if n == 2, load hybrid_func3_HM_D2,
            elseif n == 10, load hybrid_func3_HM_D10,
            elseif n == 30, load hybrid_func3_HM_D30,
            elseif n == 50, load hybrid_func3_HM_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 23

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func3_data
            if n == 2, load hybrid_func3_M_D2,
            elseif n == 10, load hybrid_func3_M_D10,
            elseif n == 30, load hybrid_func3_M_D30,
            elseif n == 50, load hybrid_func3_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 24

            lu = [-5 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func4_data
            if n == 2, load hybrid_func4_M_D2,
            elseif n == 10, load hybrid_func4_M_D10,
            elseif n == 30, load hybrid_func4_M_D30,
            elseif n == 50, load hybrid_func4_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

        case 25

            lu = [2 * ones(1, n); 5 * ones(1, n)];
            load hybrid_func4_data
            if n == 2, load hybrid_func4_M_D2,
            elseif n == 10, load hybrid_func4_M_D10,
            elseif n == 30, load hybrid_func4_M_D30,
            elseif n == 50, load hybrid_func4_M_D50,
            end
            A = []; a = []; alpha = []; b = [];

    end

    % Record the best results
    outcome = [];

    % Main body
    popsize = 30;

    time = 1;

    % The total number of runs
    totalTime = 1;
    algorithm = 'PSO';

    for i=1:N  
        for j=1:D  
            x(i,j)=randn;  %产生一个服从正态分布的随机数作为初始化位置  
            v(i,j)=randn;  %产生一个服从正态分布的随机数作为初始化速度  
     end  
    end  

    %p(i)=sphere(x(i,:),D);%计算适应度，测试函数为sphere  
    tx = repmat(lu(1, :), popsize, 1) + x .* (repmat(lu(2, :) - lu(1, :), popsize, 1));  
    p = benchmark_func(tx, problem, o, A, M, a, alpha, b);
    y = x;    %初始化个体最优位置y为在时间步t=0时的粒子位置  
    Pg=x(1,:);             %Pg为全局最优位置  
    pgf = p(1,:);
    for i=2:N  
        if p(i)<pgf  
         Pg=x(i,:);%更新全局最优位置  
         pgf=p(i,:);
        end  
    end   
%------进入主要循环，按照公式依次迭代，直到满足精度要求------------  
    run = tms;
    j = 0;
    for t=1:MaxDT  
    j = j + 1;
    for i=1:N  
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(Pg-x(i,:));  
        x(i,:)=x(i,:)+v(i,:);  
        tmpx = benchmark_func(x, problem, o, A, M, a, alpha, b);
        if tmpx(i)<p(i)  
            p(i)=tmpx(i);%更新适应度  
            y(i,:)=x(i,:);%更新个体最佳位置  
        end  
        tmpy = benchmark_func(x, problem, o, A, M, a, alpha, b);
        
           if strcmp(algorithm, 'DE')
                file = sprintf('./%s/%s/%d/%s_%d_%d.txt', algorithm, ...
            testcase, run, testcase, run, j);
                folder = sprintf('./%s/%s/%d', algorithm, ...
            testcase, run);
            elseif strcmp(algorithm, 'PSO')
                 file = sprintf('./%s/%s/%d/%s_%d_%d.txt', algorithm, ...
            testcase, run, testcase, run, j);
            folder = sprintf('./%s/%s/%d', algorithm, ...
            testcase, run);
          end;
          if ~exist(folder);
            mkdir(folder);
          end
            fd=fopen(file,'w');
            [r,c]=size(tmpy);
            [r2,c2] = size(x);
            c = c2;
            for ii=1:r
                fprintf(fd,'%0.001f\t',tmpy(ii,1));
                 for jj=1:c
                     fprintf(fd,' ');
                     fprintf(fd,'%0.001f\t',x(ii,jj));
                 end
                 fprintf(fd,'\r\n');
            end
            fclose(fd);
        if p(i)<pgf  
            Pg=y(i,:);%更新群体最佳位置  
            pgf = tmpy(i);
        end  
    end  
    end  
end
end
toc %该函数表示计时结束  