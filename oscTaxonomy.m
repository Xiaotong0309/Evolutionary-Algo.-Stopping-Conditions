function [stopGeneration state] = oscTaxonomy(algorithm, testcase, nObj, ...
    maxGen, run, indicator, evidenceGathering, stopDecision, stopTag)
% Framework for the evaluation of the online stopping criteria on
% pregenerated data. Each run is stored in a zip
%
% call: [stopGeneration state] = oscTaxonomy(algorithm, testcase, maxGen, run,...
%                                   indicator, evidenceGathering, stopDecision,...
%                                    params)
%
% Input
% algorithm:        name of the moead (string)
% testcase:         name of the test function (string)
% maxGen:           maximum number of generations to test (integer)
% run:              run number (integer)
% indicator:        Pi - PIs for input data generation (cell array of string)
%                   !! transformed for minimization (lower PI are better)
% evidenceGathering:Upsilon - methods to aggregate data (cell array of string)
%                   !! transformed for maximization (lower EGP corresponds to
%                   a lower improvement in the PF)
% stopDecision:     Phi - methods to decide on convergence (cell array of string)
% params:           struct with parameters for indicators, e.g.,
%                   reference or ideal points, the evidence gathering,
%                   e.g., the size of the time window tmem, and the
%                   stopping decision, e.g., the threshold epsilon
%                   (refer to the function initializeParams.m for the
%                    required parameters, their exact names and defaults)
%
% Output
% stopGeneration:   generation for stopping the algorithm
% state:            final state of the criterion
%
% ---
% Version: $Id: runExperiment.m 83 2010-10-05 20:06:36Z marti-big $

% 初始化params

if strcmp(testcase, 'uf2')
    params.objFunc = 'UF2';
elseif strcmp(testcase, 'sch1')
    params.objFunc = 'SCH1';
elseif strcmp(testcase, 'sch2')
    params.objFunc = 'SCH2'; 
elseif strcmp(testcase, 'sch3')
    params.objFunc = 'SCH3';
elseif strcmp(testcase, 'hce')
    params.objFunc = 'HCE';
elseif strcmp(testcase, 'ros')
    params.objFunc = 'ROS';
elseif strcmp(testcase, 'ef8')
    params.objFunc = 'EF8';
elseif strcmp(testcase, 'ros')
    params.objFunc = 'ROS';
elseif strcmp(testcase, 'hy1')
    params.objFunc = 'HY1';
end
if strcmp(algorithm, 'PSO')
    params.refPoint   = [4e+10];
elseif strcmp(algorithm, 'DE')
    params.refPoint   = [20000];
end
params.idealPoint = [0];
stopGeneration = zeros();
if strcmp(indicator, 'dqp')
    params.standardize = true;
    params.combine = true;
end;
params = initializeParams(indicator, evidenceGathering, stopDecision, params);

if params.plot
    figure();
    colors = 'r';
    hold on;
end;
xlabel('迭代次数');

Results = zeros(run,maxGen);%所有迭代结果
for r = 1:run
clear state;
state.PI = indicator;
state.EGP = evidenceGathering;
for i = 1:maxGen
    
    % 读测试数据
    
    if strcmp(algorithm, 'PSO')
        file = sprintf('./%s/%s/%d/%s_%d_%d.txt', algorithm, ...
            testcase, r, testcase, r, i);
    elseif strcmp(algorithm, 'DE')
        file = sprintf('./%s/%s/%d/%s_%d_%d.txt', algorithm, ...
            testcase, r, testcase, r, i);
    end;
    if ~exist(file, 'file')
        warning('OSC:fileNotFound', 'data file %s not found', file);
        continue;
    else
        
        in = load(file);
        %opt = paretofront(in(:,1:nObj));
        %PFt.PF = in(opt, 1:nObj);
        %PFt.PS = in(opt, nObj+1:end);  %>2
        PFt.PF = in(:, 1:nObj);
        PFt.PS = in(:, nObj+1:end);  %>2
        
    end
    
    % 计算增益指标
    for k = 1:length(indicator) % multiple indicators possible (as in OCD, LSSC)
        switch(indicator{k})
            case 'mdr'
                state = mdrIndicator(PFt, state, params);
            case 'hv'
                state = hypervolumeIndicator(PFt, state, params);
            case 'r'
                state = rInd(PFt, state, params);
            case 'epsilon'
                state = epsInd(PFt, state, params);
            case 'cm'
                state = convergenceMetric(PFt, state, params);
                % case 'dm'
                %   % complex to calculate, will be integrated soon
                %   state = diversityMetric(PFt, state, params);
            case 'maxCD'
                state = maximumCrowdingIndicator(PFt, state, params);
            case 'dqp'
                state = dominanceBasedQuality(PFt, state, params);
            case 'cr'
                state = consolidationRatio(PFt, state, params);
             case 'eud1'
                state = eud1(PFt, state, params);
             case 'eud2'
                state = eud2(PFt, state, params);
             case 'kul'
                state = kul(PFt, state, params);
            otherwise
                error('unknown progress indicator!');
        end;
    end;
    %更新state中的PF
    % update previous PF stored in the state (add your PI if required)
    if ~isempty(strmatch('mdr', indicator, 'exact')) || ...
            ~isempty(strmatch('r', indicator, 'exact')) || ...
            ~isempty(strmatch('epsilon', indicator, 'exact'))
        state = updatePreGen(PFt.PF, state, params);
    end;
    %更新state中的archive
    % update archives stored in the state (add your PI if required)
    if ~isempty(strmatch('cr', indicator, 'exact'))
        state = updateArchive(PFt.PF, state, params);
    end;
     if ~isempty(strmatch('kul', indicator, 'exact')) || ...
            ~isempty(strmatch('eud1', indicator, 'exact')) || ...
            ~isempty(strmatch('eud2', indicator, 'exact'))
        state = updateHausdPreGen(PFt.PF, state, params);
    end;
    % 对增益指标进行处理
    for k = 1:length(evidenceGathering) % multiple EGPs possible (as in OCD)
        switch(evidenceGathering{k})
            case 'direct'
                state = directTransfer(state, params);
                if params.plot
                    for j = 1:size(state.direct,1)
                        %plot(i, state.direct(j,1), 'Marker', '+', ...
                          %  'Color', colors);
                          if  ~isnan(state.direct(j,1))
                               Results(r,i) = state.direct(j,1);
                           end
                    end;
                end;
            case 'std'
                state = stdEvidenceGathering(state, params);
                if params.plot
                    for j = 1:size(state.std,1)
                       % plot(i, state.std(j,1), 'Marker', 'o', ...
                           % 'Color', colors);
                           if  ~isnan(state.std(j,1))
                               Results(r,i) = state.std(j,1);
                           end
                    end;
                end;
            case 'kalman'
                state = kalmanEvidenceGathering(state, params);
                if params.plot
                    for j = 1:size(state.kalman,1)
                        %plot(i, state.kalman(j,1), 'Marker', '*', ...
                            %'Color', colors);
                           if  ~isnan(state.kalman(j,1))
                               Results(r,i) = state.kalman(j,1);
                           end
                    end;
                end;
            case 'reg'
                state = regressionEvidenceGathering(state, params);
                if params.plot
                    for j = 1:size(state.reg,1)
                       % plot(i, state.reg(j,1), 'Marker', 'x', ...
                           % 'Color', colors);
                        if  ~isnan(state.reg(j,1))
                               Results(r,i) = state.reg(j,1);
                        end
                    end;
                end;
            case 'moving'
                state = movingAverageEvidenceGathering(state, params);
                if params.plot
                    for j = 1:size(state.moving,1)
                        %plot(i, state.moving(j,1), 'Marker', 's', ...
                           % 'Color', colors);
                        if  ~isnan(state.moving(j,1))
                               Results(r,i) = state.moving(j,1);
                        end
                    end;
                end;
                 case 'vote'
                state = vote(state, params);
                if params.plot
                    for j = 1:size(state.vote)
                        %plot(i, state.moving(j,1), 'Marker', 's', ...
                           % 'Color', colors);
                        if  ~isnan(state.vote(1,j))
                               Results(r,i) = state.vote(1,j);
                        end
                    end;
                end;
            otherwise
                error('unknown evidence gathering process!');
        end
    end
    
    % 决定是否停机
    flag = false(length(stopDecision),1);
    for k = 1:length(stopDecision) % multiple stop decisions possible (as in OCD)
        switch(stopDecision{k})
            case 'threshold'
                flag(k) = thresholdDecision(state, params);
            case 'ciNormal'
                flag(k) = ciNormalDecision(state, params);
            case 'adaptTest'
                [flag(k),state] = adaptiveTestingDecision(state, params);
            case 'validThreshold'
                flag(k) = validatedThresholdDecision(state, params);
            case 'hausThreshold'
                flag(k) = hausThreshold(state, params);
            otherwise
                error('unknown stopping decision!');
        end;
    end;
    
    % 所有的增益指标均达到停机标准则停机
    if all(flag)
        stopGeneration(r) = i;
        break;
    end
end;
end
%作图
stopG = ceil(sum(stopGeneration) / run);
for i = 1:stopG
    tr = 0;
    tc = 0;
    for j = 1:run
    if(Results(j,i) > 0)
            Results(j,i) = Results(j,i) * 1000;
        tr = tr + Results(j,i);
        tc = tc + 1;
    end
    end
        plot(i, ceil(tr/tc), 'Marker', '*', ...
                          'Color', colors);
end
stdStopG = std(stopGeneration);
tit = sprintf('stopGeneration = %d stdGeneration = %6.2f', stopG, stdStopG);
title(tit);
nm = sprintf('C:/Users/apple.apple-PC/Downloads/计算机系毕业论文文件/fig/new/%s_%s_%d_3.jpg', algorithm, testcase, stopTag);
hold off;
saveas(gcf,nm);
