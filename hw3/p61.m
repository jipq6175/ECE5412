% prob 61

% set up some constants
d = 0.005; 
A = eye(4); 
A(1, 2) = d;
A(3, 4) = d;
f = [0.5*d^2 0; d 0; 0 0.5*d^2; 0 d];
C = [1 0 0 0; 0 0 1 0];

% set up positive def matrices
rng('default')
M = randn(4); 
Q = M * M'; 
M = randn(2);
R = 10*M * M'; 

%
n = 1000; 
z = [0 0 0 0; zeros([n, 4])]; 
y = [z(1,:) * C' + mvnrnd(zeros([2,1]), R, 1); zeros([n, 2])];
r = randn([2,1]);

%
% simulation
for i = 1:n
    z(i+1, :) = z(i, :) * A' + r' * f' + mvnrnd(zeros([4,1]), Q, 1); 
    y(i+1, :) = z(i,:) * C' + mvnrnd(zeros([2,1]), R, 1);
end

% KF estimate
kfe = zeros(size(z));
Sigma2 = Q; 
for i = 1:n
    x = A * kfe(i, :)' + f * r;
    Sigma1 = A * Sigma2 * A' + Q;
    S = C * Sigma1 * C' + R;
    S1 = inv(S);
    kfe(i+1, :) = (x + Sigma1 * C' * S1 * (y(i+1, :)' - C * x))';
    Sigma2 = Sigma1 - Sigma1 * C' * S1 * C * Sigma1; 
end

% plots
figure(1);
subplot(1,3,1);
hold all; 
plot(z(:,1), z(:,3), 'k-', 'LineWidth', 2.0);
plot(y(:,1), y(:,2), 'b-', 'LineWidth', 1.0); 
hold off;
xlabel('x');
ylabel('y'); 
legend('True State', 'Observation');

subplot(1,3,2);
hold all; 
plot(z(:,1), z(:,3), 'k-', 'LineWidth', 2.0);
plot(kfe(:,1), kfe(:,3), 'r--', 'LineWidth', 1.0);
hold off;
xlabel('x');
ylabel('y');
legend('True State', 'KF Estimation');
title('Position');

subplot(1,3,3);
hold all;
plot(z(:,2), 'b-', 'LineWidth', 2.0);
plot(z(:,4), 'r-', 'LineWidth', 2.0);
plot(kfe(:,2), 'c-', 'LineWidth', 1.0);
plot(kfe(:,4), 'm-', 'LineWidth', 1.0);
hold off;
xlabel('vx');
ylabel('vy');
xlim([0 1001]);
legend('True Vx', 'True Vy', 'KF Vx', 'KF Vy');
title('Velocity');


