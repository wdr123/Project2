function H = h_2(x, A,b,c)
% hessian of function2
% input x should be in 1 by 100 form
% output H should be in 100 by 100 form
H = A'*diag(1./((b-A*x).^2))*A;

end