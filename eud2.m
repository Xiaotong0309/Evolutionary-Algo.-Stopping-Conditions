function state = eud2(nonDomCurrent, state, params)

new = nonDomCurrent.PF;
% check input
if ~isfield(state, 'HausdPreGen')
    % first generation: no values without reference generation
    state.eud2 = NaN;
    return;
end
old = state.HausdPreGen;
% compute kul
n = length(old);
for i = 1:n
    for j = 1:n
    dis(j) = abs(old(i) - mean(old) - (new(j) - mean(new)));
    end
    mindis(i) = min(dis);
end
maxdis = max(mindis);
state.eud2 = maxdis;