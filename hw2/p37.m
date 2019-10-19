
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


%% P38
a1 = -1.2;
a2 = 0.7;
y0 = 0.0;
y1 = 100.0; 
n = 1000; 
y = ar2simulate(y0, y1, a1, a2, n);

figure(1)
subplot(1,3,1)
plot(y);
xlim([0, n]);
xlabel('k');
ylabel('y_k')

a1e = zeros(100,1);
a2e = zeros(100,1);
for i = 1:100
y = ar2simulate(y0, y1, a1, a2, n);
X = [y(2:n-1) y(1:n-2)]; 
Y = y(3:n);
estimate = inv(X' * X) * X' * Y;
a1e(i) = -estimate(1);
a2e(i) = -estimate(2);
end

display(mean(a1e));
display(mean(a2e));

subplot(1,3,2)
hist(a1e);
hold on
line([a1 a1], [0 25], 'LineWidth', 3.0, 'Color', 'r')
xlabel('a_1')

subplot(1,3,3)
hist(a2e);
hold on
line([a2 a2], [0 25], 'LineWidth', 3.0, 'Color', 'r')
xlabel('a_2')

%% p38
figure(1)

n = 1000; 
subplot(4,2,[1 3])
plot(ar2simulate(y0, 300, a1, a2, n));
title(['y0 = 0, y1 = ' num2str(300)]);
ylim([-10 10]);
xlim([0 1000])

subplot(4,2,[2 4])
plot(ar2simulate(y0, 600, a1, a2, n));
title(['y0 = 0, y1 = ' num2str(600)]);
ylim([-10 10]);
xlim([0 1000])

subplot(4,2,[5 7])
plot(ar2simulate(y0, 900, a1, a2, n));
title(['y0 = 0, y1 = ' num2str(900)]);
ylim([-10 10]);
xlim([0 1000])

a1i = zeros(1000,1);
a2i = zeros(1000,1);
for y1 = 1:1000
a1 = -1.2;
a2 = 0.7;
y0 = 0.0;

a1e = zeros(100,1);
a2e = zeros(100,1);
for i = 1:100
y = ar2simulate(y0, y1, a1, a2, n);
X = [y(2:n-1) y(1:n-2)]; 
Y = y(3:n);
estimate = inv(X' * X) * X' * Y;
a1e(i) = -estimate(1);
a2e(i) = -estimate(2);
end

a1i(y1) = mean(a1e);
a2i(y1) = mean(a2e);
end

subplot(4,2,6)
plot(a1i, 'r.');
xlabel('y_1')
ylabel('a_1')

subplot(4,2,8)
plot(a2i, 'b.');
xlabel('y_1')
ylabel('a_2')



