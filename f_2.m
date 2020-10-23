function y = f_2(x,A,b,c)
% function2 
% input x should be in 100 by N form
y = c'*x-sum(log(b-A*x));

end