function state = vote(state, params)
M = [];
for j = 1:length(state.PI)
    M(j) = state.(state.PI{j}) * 1000;  
end;
state.vote = M;