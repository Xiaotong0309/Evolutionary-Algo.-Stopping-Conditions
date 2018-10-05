function flag = hausThreshold(state, params)
% implementation of a simple threshold decision for the online stopping
% criteria framework
epsi = 0.000001;
n = size(state.vote);
flag = [];
for i = 1:n
    if(state.vote(i) < epsi)
        flag(i) = 1;
    else flag(i) = 0;
    end
end