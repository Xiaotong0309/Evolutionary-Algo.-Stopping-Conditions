function flag = thresholdDecision(state, params)
% implementation of a simple threshold decision for the online stopping
% criteria framework

% initialize flag matrix
flag = false(length(state.EGP), length(state.PI));
% initialize memory of former decisions
if ~isfield(state, 'flagPreGen')
    state.flagPreGen = false(length(state.EGP), length(state.PI), ...
        params.hits);
end;

% compute stopping decision
for j = 1:length(state.EGP)
    egpValues = getfield(state, state.EGP{j});%getfield函数是读取结构体数组中相应字段的值
    for k = 1:length(state.PI)
        if ~isnan(egpValues(k,1))
            temp = egpValues(k,1) < params.epsilon(j,k);
            state.flagPreGen(j,k,:) = updateVector(temp, ...
                reshape(state.flagPreGen(j,k,:), 1, params.hits), ...%就是变换成特定维数的矩阵,.是按照列的顺序进行转换的，也就是第一列读完，读第二列，下面请看具体例子
                params.hits);
            flag(j,k) = all(state.flagPreGen(j,k,:)); %all 检测矩阵中是否全为非零元素，如果是，则返回1，否则，返回0
        end;
    end;
end;

% aggregate decision from the set of proposals
switch params.aggregate
    case 'any'
        flag = any(flag(:));%any函数：检测矩阵中是否有非零元素，如果有，则返回1，否则，返回0。
    case 'allPIanyEGP'
        flag = any(all(flag,2));
    case 'anyPIallEGP'
        flag = all(any(flag,2));
    case 'all'
        flag = all(flag(:));
    case 'majority'
        flag = nansum(flag(:)) > 0.5.*sum(~isnan(flag(:)));
end;