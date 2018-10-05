function y = HCE(x)
% examplary objective function implementation
load('testproblem/high_cond_elliptic_rot_data')
load('testproblem/elliptic_M_D2')
[ps, D] = size(x);
if length(o) >= D
    o = o(1 : D);
else
    o = -100 + 200 * rand(1, D);
end
x = x - repmat(o, ps, 1);
x = x * M;
a = 1e+6;
y = 0;
for i = 1 : D
    y = y + a .^ ((i - 1) / (D - 1)) .* x(:, i).^2;
end