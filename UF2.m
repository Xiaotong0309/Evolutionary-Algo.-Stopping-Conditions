function y = UF2(x)
% examplary objective function implementation
load('testproblem/sphere_func_data')
[ps, D] = size(x);
if length(o) >= D
    o = o(1 : D);
else
    o = -100 + 200 * rand(1, D);
end
x = x - repmat(o, ps, 1);
y = sum(x .^ 2, 2);