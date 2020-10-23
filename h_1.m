function H = h_1(x)
% hessian of function3
% input x should be in 1 by 100 form
% output H should be in 100 by 100 form
H = zeros(100,100);
for i = 1:100
    H(i,i) = i*2;
end

end