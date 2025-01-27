
%% P37
x = linspace(-2.5, 2.5, 5001);
l1 = 1.0 * ones(1, 5001);
l2 = 0.25 * x.^2;
l3 = -1.0 - x;
l4 = x - 1.0;

figure(1)
hold all;
plot(x, l1, 'k-', 'LineWidth', 2.0);
plot(x, l2, 'k-', 'LineWidth', 2.0);
plot(x, l3, 'k-', 'LineWidth', 2.0);
plot(x, l4, 'k-', 'LineWidth', 2.0);

fill([x, fliplr(x)], [l1, fliplr(l2)], 'b')
fill([x, fliplr(x)], [l2, fliplr(max([l3;l4]))], 'm')

xlim([-2, 2]);
ylim([-1.5, 1.5]);
axis square
xlabel('a_1');
ylabel('a_2');


%% P38 rls
a1 = -1.2;
a2 = 0.7;
y0 = 0.0;
y1 = 0.0; 
n = 5000; 
y = ar2simulate(y0, y1, a1, a2, n);
estimate = rls(y, 2, 1-0.0001, 1, ones(2,1), 0.5*eye(2)); 

figure(1)
subplot(1,3,1)
plot(y);
xlim([0, n]);
xlabel('k');
ylabel('y_k')

subplot(1,3,2)
plot(1:n+2, -estimate(:, 1))
hold on;
line([0 n+2], [a1 a1], 'Color', 'k', 'LineWidth', 2.0)
plot(1:n+2, movmean(-estimate(:, 1), 1000), 'r-', 'LineWidth', 2.0)
title('a_1')
xlim([0, n]);
ylim([a1-0.1 a1+0.1])
xlabel('k');
legend('a_1 RLS estimate', 'a_1=-1.2', '1000-step MVA')

subplot(1,3,3)
plot(1:n+2, -estimate(:, 2))
hold on;
line([0 n+2], [a2 a2], 'Color', 'k', 'LineWidth', 2.0)
plot(1:n+2, movmean(-estimate(:, 2), 1000), 'r-', 'LineWidth', 2.0)
title('a_2')
xlim([0, n]);
ylim([a2-0.1 a2+0.1])
xlabel('k');
legend('a_1 RLS estimate', 'a_2=0.7', '1000-step MVA')

%% p38 different initializations
% vary r and c

s = [1e-2; 1; 1e2; 1e4];

figure(1)
for i = 1:4
    for j = 1:4
        estimate = rls(y, 2, 1-0.001, 1.0, s(i)*randn(2,1), s(j)*eye(2)); 
        subplot(4,4,i+4*(j-1))
        hold on;
        line([0 n+2], [a1 a1], 'Color', 'k', 'LineWidth', 2.0)
        plot(1:n+2, movmean(-estimate(:, 1), 1000), 'b-', 'LineWidth', 2.0)

        line([0 n+2], [a2 a2], 'Color', 'k', 'LineWidth', 2.0)
        plot(1:n+2, movmean(-estimate(:, 2), 1000), 'g-', 'LineWidth', 2.0)
        title('a_1')
        xlim([0, n]);
        ylim([-2 2])
        xlabel('k');
        %legend('a_1=-1.2', '1000-step MVA', 'a_2=0.7', '1000-step MVA')
        title(['s = ' num2str(s(i)) ', t = ' num2str(s(j))]);
    end
end








%% p39
a1 = -1.2;
a2 = 0.7;
y0 = 0.0;
y1 = 0.0; 
n = 1000; 
y = ar2simulate(y0, y1, a1, a2, n);
%%
figure(1)
subplot(3,2,1)
plot(y)
title('simulated data')
xlim([0 1000]);

subplot(3,2,3)
plot(arestimate(y, 2))
title('AR2 residuals')
xlim([0 1000]);
ylim([-10 10]);
xlabel('step')


subplot(3,2,5)
plot(101:1002, arestimate(y, 100))
title('AR 100 residuals')
xlim([0 1000]);
ylim([-10 10]);
xlabel('step');

aic = zeros(100,1);
bic = zeros(100,1);
v = zeros(100,1);
for k = 1:300
    res = arestimate(y, k);
    v(k) = var(res);
    aic(k) = log(v(k)) + 2*k/(n+2-k);
    bic(k) = log(v(k)) + 2*k * log(n+2-k)/(n+2-k);
end

subplot(3,2,2)
plot(v, 'b.'); 
hold on;
plot([1], v(1), 'bx', 'MarkerSize', 10, 'LineWidth', 5.0)
title('variance of residuals');
xlabel('k');

subplot(3,2,4)
plot(aic, 'r.'); 
hold on;
plot([1], aic(1), 'rx', 'MarkerSize', 10, 'LineWidth', 5.0)
title('AIC');
xlabel('k');

subplot(3,2,6)
plot(v, 'g.'); 
hold on;
plot([1], bic(1), 'gx', 'MarkerSize', 10, 'LineWidth', 5.0)
title('BIC');
xlabel('k');

%% p43
n = size(u2, 1);
a = zeros(n, 3);
P = 1*eye(3);
l = 1-2e-4;
c = 0.1;

a(1, :) = ones(3,1)';

for i = 2:n
    psi = [u2(i-1, 2); u2(i-1, 2)^2; y(i-1, 2)];
    ppsi = P * psi;
    denom = l/c + psi' * ppsi;
    a(i, :) = (a(i-1, :)' + ppsi * (y(i, 2) - psi' * a(i-1, :)') / denom)';
    P = (P - ppsi * ppsi' / denom) / l;
end

%
figure(1)
subplot(4,2,1)
plot(u2(:,1), u2(:,2), 'b-', 'LineWidth', 2.0);
title('u: Input pulses');

subplot(4,2,[3 5 7])
plot(y(:,1), y(:,2), 'm-', 'LineWidth', 2.0);
title('y: engine response');
xlabel('t (s)');


subplot(4,2,[2 4 6 8]);
plot(u2(:,1), 3*a(:,1)+0.32, 'b-', 'LineWidth', 1.0); 
hold on; 
plot(u2(:,1), movmean(3*a(:,1)+0.32, 2000), 'c--', 'LineWidth', 3.0); 
plot(a1(:,1), a1(:,2), 'r-', 'LineWidth', 1.0);
plot(a1_avg(:,1), a1_avg(:,2), 'r--', 'LineWidth', 3.0);

ylim([-0.05 0.15]); 
legend('Online RLS', 'Online RLS MVA', 'Simulink RLS', 'Simulink RLS MVA', 'Location', 'southeast')
title('RLS estimator of a_1')
xlabel('t (s)');




%% p46
est = zeros(101, 1);
esterr = zeros(101, 1);
est2 = zeros(101, 1);
esterr2 = zeros(101, 1);
N = 500;
n = 10;
th = (1:n)' .* sign(randn(n, 1));

% r = 0
stat = zeros(1000, 1);
for i = 1:1000
X = 10.0 * rand(N, n) .* sign(randn(N, n)); 
Y = X * th + randn(N, 1);
r = Y - X * inv(X' * X) * (X' * Y); 
stat(i) = sum(r.^2)/(N-n);
end

figure(1);
subplot(4,2,[1 3 5])
plot(stat, 1:1000, 'b.'); 
title('\sigma^2 of 1000 simulations');
xlim([0.8 1.2]);
subplot(4,2,7)
hist(stat);
xlabel('\sigma^2');
xlim([0.8 1.2]);


est(1) = mean(stat);
esterr(1) = std(stat);
est2(1) = mean(stat);
esterr2(1) = std(stat);

stat2 = zeros(1000, 1);
for rk = 1:100
    A = 10 * rand(rk, n) .* sign(randn(rk, n));
    for i = 1:1000
    X = 10.0 * rand(N, n) .* sign(randn(N, n)); 
    Y = X * th + randn(N, 1);
    M = inv(X' * X + A' * A);
    r = Y - X * M * (X' * Y); 
    %r2 = - A * M * (X' * Y); 
    stat(i) = sum(r.^2)/(N-n);
    %stat2(i) = sum(r2.^2)/(N-n)/rk;
    end

est(rk+1) = mean(stat);
esterr(rk+1) = std(stat);
%est2(rk+1) = mean(stat2);
%esterr2(rk+1) = std(stat2);
end

subplot(4,2,[2 4 6 8]);
errorbar(0:100, est, esterr, 'r.');
xlim([-5 100]);
ylim([0, 500]); 
xlabel('r');
ylabel('\sigma^2'); 
set(gca, 'yscale', 'log')
grid on;




%% p48

% store the images
path = 'C:\Users\yc225\Desktop\Courses\07 Fall 2019\ECE 5412 Bayesian Inference and Stochastic Optimization\rawdata';
cd(path);
people = dir();
x = {};
A = zeros(250*250, 150);
for i = 1:15
    x = [x; people(i+2).name];
    imgs = dir(x{end});
    for j = 1:10
        img = imread(fullfile(x{end}, imgs(j+2).name));
        A(:, 10*(i-1)+j) = reshape(double(rgb2gray(img)), [250*250, 1]);
    end
end

eigenmean = mean(mean(A));
A = A - eigenmean;

%% plot sample faces

id = datasample(1:150, 40);
figure(1);
for i = 1:40
    subplot(4, 10, i);
    imagesc(reshape(A(:, id(i)), [250, 250])); 
    colormap(gray);
    set(gca,'xtick',[]);
    set(gca,'xticklabel',[]);
    set(gca,'ytick',[]);
    set(gca,'yticklabel',[]);
    axis square
end

%% pca
[paxis, D, V] = svd(A, 'econ');
fvector = D * V';

%% Do a leave-one-out cross validation
B = A; 
recograte = zeros(15, 5); 
testrank = [10; 30; 50; 100; 125]; 
for k = 1:5
    r = testrank(k);
    display(['======    Rank = ' num2str(r)]);
    for i = 1:15
        cv = zeros(10,1);
        for j = 1:10
            B = A; 
            anew = B(:,10*(i-1)+j);
            B(:,10*(i-1)+j) = []; % remove one image
            [paxis, D, V] = svd(B, 'econ');
            fvector = D(1:r, 1:r) * V(:, 1:r)';
            t = fvector - repmat(paxis(:, 1:r)' * anew, [1, 149]);
            l = sqrt(sum(t.^2, 1));
            id = find(l == min(l));
            if (id >= 10*(i-1)) && (id <= 10*i)
                cv(j) = 1.0;
            else 
                cv(j) = 0.0; 
            end
        end
        display(['-- Cross Validating on ' x{i}]);
        recograte(i, k) = mean(cv); 
    end
end
        
%%
[paxis, D, V] = svd(A, 'econ');
fvector = D * V';

figure(1);
subplot(1,2,1)
plot(diag(D), 'LineWidth', 2.0);
xlabel('rank');
ylabel('Error'); 
title('PCA Approx Error');

subplot(1,2,2)
bar(categorical(x), recograte); 
legend('10', '30', '50', '100', '125');
set(gca,'xticklabel',strrep(x,'_',' ')); 
ax = gca;
ax.XTickLabelRotation = 45;
title('Recognization Rate'); 
ylim([0 1.0])

