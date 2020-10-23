function y = g_2(x,A,b,c)
% gradient of function2 
% input x should be in 1 by 100 form
y = c + A'*(1./(b-A*x));
end