% Question 1

%% Question 1(c)

A = 2.5; 
w = 2*pi/60; 
n = 1000;

% generate the sensor measurement y
y = q1generate(A, w, n);
% filtering the measurement and get the conditional estimate
y_hat = q1filter(y, A, w, rand());
% compute the error
error = y - y_hat; 
% print the mse
display(mean(error.^2)); 

% plotting the measurement/filtered estimate and error
figure(1); 
subplot(2,1,1);
hold all;
plot(1:1:n, y, 'LineWidth', 2.0);
plot(1:1:n, y_hat, 'g-', 'LineWidth', 4.0); 
hold off;
legend('Sensor measurements', 'Filtered Estimate');
ylim([-5, 5]);
title('Measurement/Estimate Traces')
subplot(2,1,2);
hold all; 
plot(1:1:n, zeros(n, 1), 'k-', 'LineWidth', 2.0);
plot(1:1:n, error, 'r.', 'MarkerSize', 15.0);
hold off;
title('Error');


%% Question 1(d)

nsim = 50;
mse = zeros(nsim, 1);
for i = 1:nsim
    y = q1generate(A, w, n);
    y_hat = q1filter(y, A, w, rand());
    error = y - y_hat; 
    mse(i) = mean(error.^2);
end

display(mean(mse));
display(std(mse));


%% Question 1(e)

y = q1generate(A, w, n);
y_hat = q1filter(y, A, w, rand());
% smoother 
y_smooth = q1smoother(y, A, w);

display('Filter MSE = ');
display(mean((y - y_hat).^2));
display('Smoother MSE = ');
display(mean((y - y_smooth).^2));


%% Question 1(f)
% might take a while to run
mse_filter = zeros(nsim, 1);
mse_smoother = zeros(nsim, 1);
tic();
for i = 1:nsim
    y = q1generate(A, w, n);
    y_hat = q1filter(y, A, w, rand());
    y_smooth = q1smoother(y, A, w);
    mse_filter(i) = mean((y - y_hat).^2);
    mse_smoother(i) = mean((y - y_smooth).^2);
end
toc(); % about 250 seconds

display('Filter MSE = ');
display(mean(mse_filter));
display(std(mse_filter));
display('Smoother MSE = ');
display(mean(mse_smoother));
display(std(mse_smoother));



%% Question 1(h)