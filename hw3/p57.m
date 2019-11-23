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
w = 10;
stat = zeros([2517-w 2]);
n = 25000;
for i = 1:2517-w
    if i == 1
        x = mhvix(m(i:i+w), mean(m(i:i+w)), n);
    else
        x = mhvix(m(i:i+w), stat(i), n);
    end
    stat(i, :) = [mean(x(:,1))/10 std(x(:,1))/10];
    display(['Time k = ' num2str(i) ': estimate = ' num2str(stat(i, 1)) ' ....']);
end

%%


figure(3);
plot(vix(:,1), 'k', 'LineWidth', 2.0);
hold on; 
errorbar(1:30:2507, stat(1:30:2507, 1), 0.5*stat(1:30:2507, 2), 'ro', 'LineWidth', 2); 
legend('VIX', 'Estimated Volatility State');
xlim([1 2500]);
ylim([5 50])

%%

mc = round(stat(:,1));
mc2 = zeros([length(mc) 1]);
states = unique(mc);
for i = 1:length(mc)
    mc2(i) = find(states == mc(i)); 
end

m = max(mc2);
n = numel(mc2);
y = zeros(m,1);
p = zeros(m,m);
for k=1:n-1
    y(mc2(k)) = y(mc2(k)) + 1;
    p(mc2(k),mc2(k+1)) = p(mc2(k),mc2(k+1)) + 1;
end
p = bsxfun(@rdivide,p,y); p(isnan(p)) = 0;

figure(4); 
subplot(1,2,1);
plot(mc2, 'k-.', 'LineWidth', 2);
ylabel('Volatility State'); 
xlabel('time')
xlim([0 2510])

subplot(1,2,2); 
surf(p); 
xlabel('Previous Volatility');
ylabel('Next Volatility'); 
zlabel('Probability');
xlim([0 17]);
ylim([0 17]);
