[~, ~, iter_y1, k1] = general_optimize(@f_3,@g_3,@h_3,x_0,N,delta1,c,alpha,rho,1,3);
[~, ~, iter_y2, k2] = general_optimize(@f_3,@g_3,@h_3,x_0,N,delta1,c,alpha,rho,2,3);
[~, ~, iter_y3, k3] = general_optimize(@f_3,@g_3,@h_3,x_0,N,delta1,c,alpha,rho,3,3);
figure('name','∂‘±»Õº');
plot(1:k1,iter_y1(1:k1),'r-o');
hold on;
plot(1:k2,iter_y2(1:k2),'r-*');
plot(1:k3,iter_y3(1:k3),'r-s');
legend({'gradient','newton','quasi-newton'},'Location','northeast')
hold off;