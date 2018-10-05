

 %PSO FUNC1
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('PSO', 'uf2', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 %
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('PSO', 'uf2', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)
 %
% Bui et al. - DQP
%
[stopGeneration state] = oscTaxonomy('PSO', 'uf2', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)

%
[stopGeneration , ~] = oscTaxonomy('PSO', 'uf2', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)

% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('PSO', 'uf2', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('PSO', 'uf2', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}

  %PSO FUNC2
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('PSO', 'sch1', 1, 1000, 1, ...
    {'maxCD'}, {'std'}, {'threshold'}, params)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('PSO', 'sch1', 1, 1000, 1, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, params)
%
% Wagner et al. - OCD (Classic)
params.standardize = true;
params.combine = true;
%
[stopGeneration state] = oscTaxonomy('PSO', 'sch1', 1, 1000, 1, ...
    {'hv', 'epsilon', 'r'}, {'std', 'reg'}, {'adaptTest'}, params)
%
% Bui et al. - DQP

[stopGeneration state] = oscTaxonomy('PSO', 'sch1', 1, 1000, 1, ...
    {'dqp'}, {'direct'}, {'threshold'}, params)
%
% Guerrero et al. - LSSC
params.standardize = false;
params.combine = false;
%
[stopGeneration , ~] = oscTaxonomy('PSO', 'sch1', 1, 1000, 1, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, params)

% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('PSO', 'sch1', 1, 1000, 1, ...
    {'hv'}, {'std'}, {'adaptTest'}, params)
%
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('PSO', 'sch1', 1, 1000, 1, ...
    {'cr'}, {'moving'}, {'threshold'}, params)
%}

    %PSO FUNC3
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('PSO', 'hce', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('PSO', 'hce', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)
 %

[stopGeneration state] = oscTaxonomy('PSO', 'hce', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)

%
[stopGeneration , ~] = oscTaxonomy('PSO', 'hce', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)

% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('PSO', 'hce', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('PSO', 'hce', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}

      %PSO FUNC4
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('PSO', 'sch2', 1, 1000, 1, ...
    {'maxCD'}, {'std'}, {'threshold'}, params)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('PSO', 'sch2', 1, 1000, 1, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, params)
 %
% Wagner et al. - OCD (Classic)
params.standardize = true;
params.combine = true;
%
[stopGeneration state] = oscTaxonomy('PSO', 'sch2', 1, 1000, 1, ...
    {'hv', 'epsilon', 'r'}, {'std', 'reg'}, {'adaptTest'}, params)
%
% Bui et al. - DQP

[stopGeneration state] = oscTaxonomy('PSO', 'sch2', 1, 1000, 1, ...
    {'dqp'}, {'direct'}, {'threshold'}, params)
%
% Guerrero et al. - LSSC
params.standardize = false;
params.combine = false;
%
[stopGeneration , ~] = oscTaxonomy('PSO', 'sch2', 1, 1000, 1, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, params)

% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('PSO', 'sch2', 1, 1000, 1, ...
    {'hv'}, {'std'}, {'adaptTest'}, params)
%
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('PSO', 'sch2', 1, 1000, 1, ...
    {'cr'}, {'moving'}, {'threshold'}, params)
%}

      
            %PSO FUNC5
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('PSO', 'sch3', 1, 1000, 1, ...
    {'maxCD'}, {'std'}, {'threshold'}, params)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('PSO', 'sch3', 1, 1000, 1, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, params)
 %
% Wagner et al. - OCD (Classic)
params.standardize = true;
params.combine = true;
%
[stopGeneration state] = oscTaxonomy('PSO', 'sch3', 1, 1000, 1, ...
    {'hv', 'epsilon', 'r'}, {'std', 'reg'}, {'adaptTest'}, params)
%
% Bui et al. - DQP

[stopGeneration state] = oscTaxonomy('PSO', 'sch3', 1, 1000, 1, ...
    {'dqp'}, {'direct'}, {'threshold'}, params)
%
% Guerrero et al. - LSSC
params.standardize = false;
params.combine = false;
%
[stopGeneration , ~] = oscTaxonomy('PSO', 'sch3', 1, 1000, 1, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, params)

% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('PSO', 'sch3', 1, 1000, 1, ...
    {'hv'}, {'std'}, {'adaptTest'}, params)
%
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('PSO', 'sch3', 1, 1000, 1, ...
    {'cr'}, {'moving'}, {'threshold'}, params)
%}

            
            %PSO FUNC6
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('PSO', 'ros', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('PSO', 'ros', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)

% Bui et al. - DQP

[stopGeneration state] = oscTaxonomy('PSO', 'ros', 1, 300, 10, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%

[stopGeneration , ~] = oscTaxonomy('PSO', 'ros', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('PSO', 'ros', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('PSO', 'ros', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}

                 %PSO FUNC7
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('PSO', 'ef8', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('PSO', 'ef8', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)
%
% Bui et al. - DQP

[stopGeneration state] = oscTaxonomy('PSO', 'ef8', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%

[stopGeneration , ~] = oscTaxonomy('PSO', 'ef8', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)

% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('PSO', 'ef8', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('PSO', 'ef8', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}
               %PSO FUNC8
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('PSO', 'hy1', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 %
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('PSO', 'hy1', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)
%
% Bui et al. - DQP

[stopGeneration state] = oscTaxonomy('PSO', 'hy1', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%

[stopGeneration , ~] = oscTaxonomy('PSO', 'hy1', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)

% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('PSO', 'hy1', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('PSO', 'hy1', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}
      
    
  %DE FUNC1
%
%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('DE', 'uf2', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 %
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('DE', 'uf2', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)
% Wagner et al. - OCD (Classic)
  %

[stopGeneration state] = oscTaxonomy('DE', 'uf2', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%

[stopGeneration , ~] = oscTaxonomy('DE', 'uf2', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('DE', 'uf2', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
    %
%
  
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('DE', 'uf2', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}

    %DE FUNC2

%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('DE', 'sch1', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 %
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('DE', 'sch1', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)
% Wagner et al. - OCD (Classic)
  %

%
[stopGeneration state] = oscTaxonomy('DE', 'sch1', 1, 300, 10, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%

[stopGeneration , ~] = oscTaxonomy('DE', 'sch1', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('DE', 'sch1', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
  
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('DE', 'sch1', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}

        %DE FUNC3

%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('DE', 'hce', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('DE', 'hce', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)
% Wagner et al. - OCD (Classic)

%
% Bui et al. - DQP
%
[stopGeneration state] = oscTaxonomy('DE', 'hce', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%
% Guerrero et al. - LSSC

%
[stopGeneration , ~] = oscTaxonomy('DE', 'hce', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('DE', 'hce', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
  
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('DE', 'hce', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}
  
   %DE FUNC4

%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('DE', 'sch2', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('DE', 'sch2', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)
% Wagner et al. - OCD (Classic)
 %
params.standardize = true;
params.combine = true;

% Bui et al. - DQP
%
[stopGeneration state] = oscTaxonomy('DE', 'sch2', 1, 300, 10, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%
% Guerrero et al. - LSSC
params.standardize = false;
params.combine = false;
%
[stopGeneration , ~] = oscTaxonomy('DE', 'sch2', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('DE', 'sch2', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
  
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('DE', 'sch2', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}
  
      %DE FUNC5

%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('DE', 'sch3', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('DE', 'sch3', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)

% Bui et al. - DQP
%
[stopGeneration state] = oscTaxonomy('DE', 'sch3', 1, 300, 10, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%
% Guerrero et al. - LSSC
%
[stopGeneration , ~] = oscTaxonomy('DE', 'sch3', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('DE', 'sch3', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
  
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('DE', 'sch3', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}

        %DE FUNC6

%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('DE', 'ros', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('DE', 'ros', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)

% Bui et al. - DQP
%
[stopGeneration state] = oscTaxonomy('DE', 'ros', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%
% Guerrero et al. - LSSC
%
[stopGeneration , ~] = oscTaxonomy('DE', 'ros', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('DE', 'ros', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
  
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('DE', 'ros', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}

             %DE FUNC7

%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('DE', 'ef8', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('DE', 'ef8', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)

% Bui et al. - DQP
%
[stopGeneration state] = oscTaxonomy('DE', 'ef8', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%
% Guerrero et al. - LSSC
%
[stopGeneration , ~] = oscTaxonomy('DE', 'ef8', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('DE', 'ef8', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
  
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('DE', 'ef8', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}
             
                      %DE FUNC8

%{
% Rudenko and Schoenauer - Stability measure
[stopGeneration state] = oscTaxonomy('DE', 'hy1', 1, 300, 30, ...
    {'maxCD'}, {'std'}, {'threshold'}, 1)
 
% Marti et al. - MGBM criterion
[stopGeneration state] = oscTaxonomy('DE', 'hy1', 1, 300, 30, ...
    {'mdr'}, {'kalman'}, {'ciNormal'}, 2)

% Bui et al. - DQP
%
[stopGeneration state] = oscTaxonomy('DE', 'hy1', 1, 300, 30, ...
    {'dqp'}, {'direct'}, {'threshold'}, 3)
%
% Guerrero et al. - LSSC
%
[stopGeneration , ~] = oscTaxonomy('DE', 'hy1', 1, 300, 30, ...
    {'mdr', 'hv', 'epsilon'}, {'reg'}, {'validThreshold'}, 4)
%
% Wagner et al. - OCD-HV
[stopGeneration state] = oscTaxonomy('DE', 'hy1', 1, 300, 30, ...
    {'hv'}, {'std'}, {'adaptTest'}, 5)
%
  
% Goel and Stander - CR
[stopGeneration state] = oscTaxonomy('DE', 'hy1', 1, 300, 30, ...
    {'cr'}, {'moving'}, {'threshold'}, 6)
%}
                      
              %DE test

%{
[stopGeneration , ~] = oscTaxonomy('DE', 'uf2', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
[stopGeneration , ~] = oscTaxonomy('DE', 'hce', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
              %
[stopGeneration , ~] = oscTaxonomy('DE', 'ros', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
[stopGeneration , ~] = oscTaxonomy('DE', 'ef8', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
[stopGeneration , ~] = oscTaxonomy('DE', 'hy1', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);

%}
                            %PSO test

%
[stopGeneration , ~] = oscTaxonomy('PSO', 'uf2', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
[stopGeneration , ~] = oscTaxonomy('PSO', 'hce', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
              %
[stopGeneration , ~] = oscTaxonomy('PSO', 'ros', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
[stopGeneration , ~] = oscTaxonomy('PSO', 'ef8', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
[stopGeneration , ~] = oscTaxonomy('PSO', 'hy1', 1, 300, 30, ...
    {'eud1', 'eud2', 'kul'}, {'vote'}, {'hausThreshold'}, 7);
