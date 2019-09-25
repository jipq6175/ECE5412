%q27

%% (a)
A = [.3 .3 .4; .1 .9 .0; .1 .1 .8];
[V, D] = eig(A'); 
stationary = abs(V(:, 2));
stationary = stationary / sum(stationary); 
x = itmc(500); 

% for plotting
y = tabulate(x);
figure(10);
subplot(1,3,1);
bar(y(:,1), y(:,2));
hold on;
plot(500 * stationary, 'r.', 'MarkerSize', 30); 
xlabel('state');
ylabel('# of visits'); 
legend('empirical', 'stationary')
title('Inverse Transform')

% (b)
x = armc(500); 

% for plotting
y = tabulate(x);
subplot(1,3,2);
bar(y(:,1), y(:,2));
hold on;
plot(500 * stationary, 'r.', 'MarkerSize', 30); 
xlabel('state');
ylabel('# of visits'); 
legend('empirical', 'stationary')
title('Acceptance Rejection')

% (c)

p = estimatemc(x);
[V2, D2] = eig(p'); 
stationary2 = abs(V2(:, 2));
stationary2 = stationary2 / sum(stationary2); 

subplot(1,3,3);
bar(y(:,1), y(:,2));
hold on;
plot(500 * stationary, 'r.', 'MarkerSize', 30); 
plot(500 * stationary2, 'mo', 'MarkerSize', 15, 'LineWidth', 5); 
xlabel('state');
ylabel('# of visits'); 
legend('empirical', '\pi_\infty', '\pi*_\infty ')

