function y = SCH1(x)
% examplary objective function implementation
load('testproblem/schwefel_102_data')
[ps, D] = size(x);
if length(o) >= D
    o = o(1 : D);
else
    o = -100 + 200 * rand(1, D);
end
x = x - repmat(o, ps, 1);
y = 0;
for i = 1 : D
    y = y + sum(x(:, 1 : i), 2).^2;
end