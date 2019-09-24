
% Generate a random P
P = rand(3);
for i = 1:3
    P(i, :) = P(i, :) / sum(P(i, :));
end

% Get eigenvalues and eigenvectors
[V, D] = eig(P');

lambda2 = abs(D(2,2));
stationary = V(:, 1) / sum(V(:, 1));
state = [1.; 2.; 3.];
mu = state' * stationary; 

% start simulations
n = 20; 

% initialize pi0
initial = rand(3, 1);
initial = initial / sum(initial);
s = initial; 

difference = [];
pred = [];

for i = 1:n
    s = P' * s;
    difference = [difference abs(mu - state' * s)];
    pred = [pred difference(1) * lambda2^(i-1)];
end




figure(1);
plot(log(difference), 'b.', 'MarkerSize', 25);
hold on;
plot(log(pred), 'r-', 'LineWidth', 3);
title('Convergence');
legend('Difference', 'O(|\lambda_2|^n)');
xlabel('n');
ylabel('log(\mu_n - \mu)')
