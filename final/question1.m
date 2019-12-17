% Question 1

%% Question 1(c)
rng('default')
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

%% experiment 1
rng('default'); 
A = 2.5; 
w = 2*pi/60; 
n = 1000;
y = q1generate(A, w, n);
maxiter = 200; 
tol = 0.005; 
nexp = 5; 
guess = [-5; -1; 3; 5; 10];
stop1 = zeros(nexp, 1);
exp1 = zeros(maxiter, 2*nexp);
for i = 1:nexp
    st = q1em(y, guess(i), w, maxiter, tol);
    stop1(i) = size(st, 1);
    exp1(1:stop1(i), (2*i-1):(2*i)) = st; 
end

%% experiment 2

rng('default'); 
A = 12.4; 
w = 2*pi/60; 
n = 1000;
y = q1generate(A, w, n);
maxiter = 200; 
tol = 0.005; 
nexp = 5; 
guess = [-5; 1; 7; 15; 21];
stop2 = zeros(nexp, 1);
exp2 = zeros(maxiter, 2*nexp);
for i = 1:nexp
    st = q1em(y, guess(i), w, maxiter, tol);
    stop2(i) = size(st, 1);
    exp2(1:stop2(i), (2*i-1):(2*i)) = st; 
end


%% plotting
figure(4);
subplot(2,2,1);
hold all;
for i = 1:nexp
    plot(1:1:stop1(i), exp1(1:stop1(i), 2*i-1), 'LineWidth', 3.0); 
end
plot(1:1:max(stop1), 2.5*ones(max(stop1), 1), 'k-', 'LineWidth', 1.5);
hold off;
title('A traces'); 

subplot(2,2,2);
hold all;
for i = 1:nexp
    plot(1:1:stop1(i), exp1(1:stop1(i), 2*i), 'LineWidth', 3.0); 
end
hold off;
title('Log-likelihood traces'); 

subplot(2,2,3);
hold all;
for i = 1:nexp
    plot(1:1:stop2(i), exp2(1:stop2(i), 2*i-1), 'LineWidth', 3.0); 
end
plot(1:1:max(stop2), 12.4*ones(max(stop2), 1), 'k-', 'LineWidth', 1.5);
hold off;
title('A traces'); 

subplot(2,2,4);
hold all;
for i = 1:nexp
    plot(1:1:stop2(i), exp2(1:stop2(i), 2*i), 'LineWidth', 3.0); 
end
hold off;
title('Log-likelihood traces'); 


