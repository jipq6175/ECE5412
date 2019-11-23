% small project

vix = csvread('vix.csv', 1, 5); 
sp = csvread('gspc.csv', 1, 1); 
m = round(10*vix(:,1));
%%

figure(1); 
subplot(2,1,1);
plot(1:(2517/522):2517, sp(:,4), 'r', 'LineWidth', 2);
xlim([0 2520]);
ylim([min(sp(:,4)) max(sp(:,4))]);
title('S&P 500 Index');
subplot(2,1,2);
plot(vix(:,1), 'b', 'LineWidth', 2); 
xlim([0 2520]);
title('VIX');
ylim([5 max(vix(:,1))]);


%% 430-445, 1970-1985
n = 50000;
x1 = mhvix(m(430:445), 300, n);
x2 = mhvix(m(1970:1985), 100, n);
%%
figure(2); 
subplot(2,4, [1 2 3 4]); 
hold all;
plot(vix(:,1), 'k', 'LineWidth', 1.0);
plot(430:445, vix(430:445, 1), 'b', 'LineWidth', 2.0);
plot(1970:1985, vix(1970:1985, 1), 'r', 'LineWidth', 2.0);
hold off;
xlim([0 2000]);


subplot(2,4,5);
plot(430:445, vix(430:445, 1), 'b', 'LineWidth', 2.0);
hold on;
plot(430:445, mean(x1(:,1)/10)*ones([16 1]), 'c', 'LineWidth', 4.0);
plot(430:445, (mean(x1(:,1)/10)+std(x1(:,1)/10))*ones([16 1]), 'c--', 'LineWidth', 1.0);
plot(430:445, (mean(x1(:,1)/10)-std(x1(:,1)/10))*ones([16 1]), 'c--', 'LineWidth', 1.0);
xlim([430 445]);
ylabel('VIX');

subplot(2,4,6);
histogram(x1(:,1)/10, 30, 'FaceColor', 'b');
xlabel('estimate state x')


subplot(2,4,7);
plot(1970:1985, vix(1970:1985, 1), 'r', 'LineWidth', 2.0);
hold on;
plot(1970:1985, mean(x2(:,1)/10)*ones([16 1]), 'r', 'LineWidth', 4.0);
plot(1970:1985, (mean(x2(:,1)/10)+std(x2(:,1)/10))*ones([16 1]), 'm--', 'LineWidth', 1.0);
plot(1970:1985, (mean(x2(:,1)/10)-std(x2(:,1)/10))*ones([16 1]), 'm--', 'LineWidth', 1.0);
xlim([1970 1985]);
ylabel('VIX');

subplot(2,4,8);
histogram(x2(:,1)/10, 30, 'FaceColor', 'r');
xlabel('estimate state x')





%% 
stat = zeros([2508 2]);
n = 20000;
for i = 1:2508
    x = mhvix(m(i:i+10), m(i), n);
    stat(i, :) = [mean(x(:,1)) std(x(:,1))];
end

%%