function y = g_3(x)
% gradient of function3
% input x should be in 1 by 2 form
y = zeros(2,1);
y(1) = 400*x(1)^3-400*x(1)*x(2)+2*x(1)-2;
y(2) = 200*(x(2)-x(1)^2);
end