
% Question 2


%% 2 (a)
n = 10000; 
x = zeros(n+1, 1); 
x(1) = randn();
i = 2;

while i <= n+1
    
    % sample new x from N(x_old, 1) (random walk MH)
    tmp = randn() + x(i-1);
    
    % calculate the acceptance rate 
    r = (cos(tmp)^2 * sin(2*tmp)^2 * normpdf(tmp))/(cos(x(i-1))^2 * sin(2*x(i-1))^2 * normpdf(x(i-1)));
    
    if rand() < r
        x(i) = tmp;
        i = i + 1;
    end
end


% For plotting the pdf and cdf
t = -5:0.01:5; 
p = cos(t).^2 .* sin(2*t).^2 .* normpdf(t); 
[f, xtick] = hist(x, 100);
figure(1); 
subplot(1,2,1);
hold all
bar(xtick, f / trapz(xtick, f))
plot(t, p / trapz(t, p), 'r-', 'LineWidth', 1.5)
hold off
legend('MH Simulation', 'True PDF');
title('PDF');
subplot(1,2,2);
hold all; 
ecdf(x); 
plot(t, cumsum(p / trapz(t, p)) * 0.01)
hold off;
legend('MH Simulation', 'True CDF');
title('CDF');

% assign v = x for part c
v = x;

%% Question 2(c)

rng('default');
n = 1000; 
x0 = 2.0; % initial state of x
x = [x0; zeros(n, 1)];
% Generate 1000 x and y
for i = 2:n+1
    x(i) = x(i-1) + randn();
end
y = x + randsample(v, n+1, true);


% apply the kalman filter
y_hat = q2kf(y, std(v)^2); 
error = y - y_hat; 

display('MSE of Kalman Filter = ');
display(mean(error.^2)); 

% for plotting
figure(2); 
subplot(2,1,1);
hold all;
plot(1:1:n, y(2:end), 'LineWidth', 1.5);
plot(1:1:n, y_hat(2:end), 'g-', 'LineWidth', 2.0);
hold off;
xlim([0, 1000]); 
legend('Measurement', 'KF Estimate'); 
title('Measurement/KF Filter')

subplot(2,1,2);
hold all;

plot(error(2:end)/y_hat(2:end)*100, 'r.', 'MarkerSize', 15.0);
plot(zeros(n, 1), 'k-', 'LineWidth', 2.0);
title('Error Percentage')




%% Question 2(e)
% simulations using different number of particles
numparticles = round(100 * 1.5.^(0:20));
mse = zeros(length(numparticles), 2);
pvar = zeros(length(numparticles), 1);

% might take a while
tic();
for i = 1:length(numparticles)
    pf = q2pf(y, numparticles(i)); 
    mse(i, :) = [mean((y - pf(:,1)).^2) std((y - pf(:,1)).^2)];
    pvar(i) = mean(pf(:,2));
end
toc(); % ~280 seconds

%% plotting
figure(3);
hold all;
plot(numparticles, mse(:,1), 'b.', 'MarkerSize', 15.0);
%plot(numparticles, pvar, 'r-', 'LineWidth', 3.0);
plot(numparticles, 0.23*ones(length(numparticles), 1), 'k-', 'LineWidth', 2.0);
hold off;
set(gca, 'xscale', 'log');
xlabel('Number of Particles');
legend('MSE of Particle Filter', 'Kalman Filter from (b)');
ylim([0.0, 0.5]);
xlim([100, 350000]);
title('MSE')

