% test conjungate gradient method
% by TomHeaven, hanlin_tan@nudt.edu.cn, 2015.08.25

%% define function and variable
syms x1 x2;
%f = xs^2+2*ys^2-2*xs*ys + 2*ys + 2;
f = (x1-1)^4 + (x1 - x2)^2;
%f = (1-x1)^2 + 2*(x2 - x1^2)^2;
x = {x1, x2};

% initial value
x0 = [0 0];
% tolerance
epsilon = 1e-1;

%% call conjungate gradient method
show_detail = true;
[bestf, bestx, count] = conjungate_gradient(f, x, x0, epsilon, show_detail);
% print result
fprintf('bestx = %s, bestf = %f, count = %d\n', num2str(bestx), bestf, count);