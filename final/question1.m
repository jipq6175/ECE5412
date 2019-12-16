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