% prob 59

n = 10000;
mu = [3 -2];
x0 = mvnrnd(mu, eye(2), n);
x1 = zeros([n, 2]); 
x2 = zeros([n, 2]); 
x3 = zeros([n, 2]); 

sigma = [1 1.5; 1.5 3];

for i = 1:n
    x1(i, :) = mvnrnd(sin(x0(i, :)), sigma, 1);
    x2(i, :) = mvnrnd(sin(x1(i, :)), sigma, 1);
    x3(i, :) = mvnrnd(sin(x2(i, :)), sigma, 1);
end


figure(1);
subplot(1,2,1);
hold all;
scatter(x0(:,1), x0(:,2), 'b.'); 
scatter(x1(:,1), x1(:,2), 'c.'); 
scatter(x2(:,1), x2(:,2), 'g.'); 
scatter(x3(:,1), x3(:,2), 'r.'); 
hold off; 
xlim([-8 8]);
ylim([-8 8]);
legend('x0', 'x1', 'x2', 'x3');
title('First Simulation: ');
display('First Simulation: ');
display(mean(x1));
display(cov(x1));
display(mean(x2));
display(cov(x2));
display(mean(x3));
display(cov(x3));



sigma = [1 -0.8; -0.8 0.9];
for i = 1:n
    x1(i, :) = mvnrnd(sin(x0(i, :)), sigma, 1);
    x2(i, :) = mvnrnd(sin(x1(i, :)), sigma, 1);
    x3(i, :) = mvnrnd(sin(x2(i, :)), sigma, 1);
end

subplot(1,2,2);
hold all;
scatter(x0(:,1), x0(:,2), 'b.'); 
scatter(x1(:,1), x1(:,2), 'c.'); 
scatter(x2(:,1), x2(:,2), 'g.'); 
scatter(x3(:,1), x3(:,2), 'r.'); 
hold off; 
xlim([-8 8]);
ylim([-8 8]);
legend('x0', 'x1', 'x2', 'x3');
title('Second Simulation: ');
display('Second Simulation: ');
display(mean(x1));
display(cov(x1));
display(mean(x2));
display(cov(x2));
display(mean(x3));
display(cov(x3));