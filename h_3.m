function H = h_3(x, A,b,c)
% hessian of function3
% input x should be in 1 by 2 form
% output H should be in 2 by 2 form
H = [1200*x(1)^2-400*x(2)+2,-400*x(1);
    -400*x(1),200];

end