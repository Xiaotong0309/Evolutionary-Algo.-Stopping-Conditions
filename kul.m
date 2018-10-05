function state = kul(nonDomCurrent, state, params)

new = nonDomCurrent.PF;
% check input
if ~isfield(state, 'HausdPreGen')
    % first generation: no values without reference generation
    state.kul = NaN;
    return;
end
old = state.HausdPreGen;
% compute kul
n = length(old);
for i = 1:n
    for j = 1:n
    dis(j) =abs( old(i) - new(j))/min(old(i), new(j));
    end
    mindis(i) = min(dis);
end
maxdis = max(mindis);
state.kul = maxdis;