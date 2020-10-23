function [final_x, final_y, iter_y, k] = general_optimize(f,g,H,x_0,N, delta1, smooth, alpha,rho,choice,fun, img)
if nargin <= 11
    img = 0;
end
k = 1;
count = 0;
n = size(x_0,1);
step = 0;
x_k = x_0;
x_k1 = x_0;
init_a = alpha;
iter_y = zeros(1,10000);
F = eye(size(x_0,1));
fid = fopen('fun2_A.txt','r');
A = fscanf(fid,'%e ',[500,100]);
fclose(fid);
fid = fopen('fun2_b.txt','r');
b = fscanf(fid,'%e ',[500,1]);
fclose(fid);
fid = fopen('fun2_c.txt','r');
c = fscanf(fid,'%e ',[100,1]);
fclose(fid);
if fun == 3 && img==1
    figure('name','contour');
    [x1, x2] = meshgrid(-2000:100:2000);
    Z = 100*((x2-(x1.^2)).^2)+(1-x1).^2;
    contour(x1,x2,Z,20);
    [U,V] = gradient(Z,100,100);
    hold on;
    quiver(x1,x2,U,V);
    hold off;
end
% 
while(k<=N && ((k==1)|| step>delta1))
    pre_x = x_k;
    x_k = x_k1;
    if choice == 1
        % gradient descent
        if fun == 2
            p = -g(x_k,A,b,c);
        else          
            p = -g(x_k);
        end
        
    elseif choice == 2
        % newton
        if fun == 2
            p = -H(x_k,A,b,c)\g(x_k,A,b,c);
        else
            p = -H(x_k)\g(x_k);
        end
            
    elseif choice == 3
        % quasi-newton
        if fun == 2
            if(k>1)
                yk = g(x_k,A,b,c) - g(pre_x,A,b,c);
                sk = x_k - pre_x;
%                 sk
                F = F + yk'*((F*yk+sk)/(yk'*sk)^2)*(sk*sk')-(sk*yk'*F+F*yk*sk')/(yk'*sk);
                p = -F*g(x_k,A,b,c);
            else
                p = -F*g(x_k,A,b,c);
            end
        else
            if(k>1)
                yk = g(x_k) - g(pre_x);
                sk = x_k - pre_x;
                F = F + yk'*((F*yk+sk)/(yk'*sk)^2)*(sk*sk')-(sk*yk'*F+F*yk*sk')/(yk'*sk);
                p = -F*g(x_k);
            else
                p = -F*g(x_k);
            end
        end
        
    else
        % conjugate gradient method
        if count == n
            count = 0;
        end
        if fun == 2
            if(count>0)
                p = -g(x_k,A,b,c) + norm(g(x_k,A,b,c))/norm(g(pre_x,A,b,c))*pre_p;
                pre_p = p;
            else
                p = -g(x_k,A,b,c);
                pre_p = p;
            end
        else
            if(count>0)
                p = -g(x_k) + norm(g(x_k))/norm(g(pre_x))*pre_p;
                pre_p = p;
            else
                p = -g(x_k);
                pre_p = p;
            end
        end
    end
    
%    p = -g(x_k)*inverse(h(x));
    alpha = init_a;
    while(alpha>0) 
        if fun==2
            if (f(x_k+alpha*p,A,b,c) > f(x_k,A,b,c) + alpha*smooth*p'*g(x_k,A,b,c))||(~all(A*(x_k+alpha*p)-b<0))
                alpha = alpha * rho;
            else
                break;
            end
        else
            if f(x_k+alpha*p) > f(x_k) + alpha*smooth*p'*g(x_k)
                alpha = alpha * rho;
            else
                break;
            end
        end       
    end
    x_k1 = x_k + alpha*p;
%     alpha
%     p
%     x_k
    step = norm(x_k1 - x_k)^2;
    %step
    %f(x_k)
    if fun == 3 && img==1
        hold on;
        plot(x_k(1),x_k(2),'r.','markersize',10);%红点容标记指定的点(x,y)
        text(x_k(1),x_k(2),num2str(k));%文字说明
        hold off;
    end
    
    if fun ==2 
        iter_y(k) = f(x_k,A,b,c);
    else
        iter_y(k) = f(x_k);
    end

    
    count = count + 1;
    k = k + 1;
end
k = k - 1;

figure('name','迭代性能图');
plot(1:k,iter_y(1:k),'r-o');



final_x = x_k;
if fun == 2 
    final_y = f(x_k,A,b,c);
else
    final_y = f(x_k);
end

end