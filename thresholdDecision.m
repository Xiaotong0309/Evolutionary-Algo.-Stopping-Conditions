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
    egpValues = getfield(state, state.EGP{j});%getfield�����Ƕ�ȡ�ṹ����������Ӧ�ֶε�ֵ
    for k = 1:length(state.PI)
        if ~isnan(egpValues(k,1))
            temp = egpValues(k,1) < params.epsilon(j,k);
            state.flagPreGen(j,k,:) = updateVector(temp, ...
                reshape(state.flagPreGen(j,k,:), 1, params.hits), ...%���Ǳ任���ض�ά���ľ���,.�ǰ����е�˳�����ת���ģ�Ҳ���ǵ�һ�ж��꣬���ڶ��У������뿴��������
                params.hits);
            flag(j,k) = all(state.flagPreGen(j,k,:)); %all ���������Ƿ�ȫΪ����Ԫ�أ�����ǣ��򷵻�1�����򣬷���0
        end;
    end;
end;

% aggregate decision from the set of proposals
switch params.aggregate
    case 'any'
        flag = any(flag(:));%any���������������Ƿ��з���Ԫ�أ�����У��򷵻�1�����򣬷���0��
    case 'allPIanyEGP'
        flag = any(all(flag,2));
    case 'anyPIallEGP'
        flag = all(any(flag,2));
    case 'all'
        flag = all(flag(:));
    case 'majority'
        flag = nansum(flag(:)) > 0.5.*sum(~isnan(flag(:)));
end;