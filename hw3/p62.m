% problem 62
s = [0; 10; 20];
rng('default');
p = rand(3); 
p = p ./ repmat(sum(p, 2), [1,3]); % normalize transition prob

x = armc(p, 1000);
x = s(x(2:end));

y1 = sqrt(1).*randn(1000,1) + x;
y2 = sqrt(2).*randn(1000,1) + x;
y3 = sqrt(5).*randn(1000,1) + x;

d1 = [ones([1,3])/3 ;zeros([1000, 3])];
d2 = [ones([1,3])/3 ;zeros([1000, 3])];
d3 = [ones([1,3])/3 ;zeros([1000, 3])];

for i = 1:1000
    
    t = diag([normpdf(y1(i), s(1), sqrt(1)); normpdf(y1(i), s(2), sqrt(1)); normpdf(y1(i), s(3), sqrt(1))]) * ...
        p' * d1(i, :)';
    d1(i+1, :) = t' / sum(t); 
    
    t = diag([normpdf(y2(i), s(1), sqrt(2)); normpdf(y2(i), s(2), sqrt(2)); normpdf(y2(i), s(3), sqrt(2))]) * ...
        p' * d2(i, :)';
    d2(i+1, :) = t' / sum(t);
    
    t = diag([normpdf(y3(i), s(1), sqrt(5)); normpdf(y3(i), s(2), sqrt(5)); normpdf(y3(i), s(3), sqrt(5))]) * ...
        p' * d3(i, :)';
    d3(i+1, :) = t' / sum(t);
    
end

display('error rate (%) hmm1: ');
display(100 - sum((round(d1(2:end, :) * s) - x) == 0)/10);
display('error rate (%) hmm2: ');
display(100 - sum((round(d2(2:end, :) * s) - x) == 0)/10);
display('error rate (%) hmm3: ');
display(100 - sum((round(d3(2:end, :) * s) - x) == 0)/10);

%% plot
k = 1:1000;
figure(1); 
subplot(3,1,1);
hold all; 
plot(y1, 'LineWidth', 2.0);
plot(x, 'k', 'LineWidth', 3.0);
est = d1(2:end, :) * s; 
plot(est, 'r--', 'LineWidth', 1.0);
ylim([-5 25]);
hold off;
title('\sigma^2 = 1');

subplot(3,1,2);
hold all; 
plot(y2, 'LineWidth', 2.0);
plot(x, 'k', 'LineWidth', 3.0);
est = d2(2:end, :) * s;
plot(est, 'r--', 'LineWidth', 1.0);
plot(k((round(est)-x)~=0), est((round(est)-x~=0)), 'm.', 'MarkerSize', 20)
ylim([-5 25]);
hold off;
title('\sigma^2 = 2');

subplot(3,1,3);
hold all; 
plot(y3, 'LineWidth', 2.0);
plot(x, 'k', 'LineWidth', 3.0);
est = d3(2:end, :) * s;
plot(est, 'r--', 'LineWidth', 1.0);
plot(k((round(est)-x)~=0), est((round(est)-x)~=0), 'm.', 'MarkerSize', 20)
ylim([-5 25]);
hold off;
title('\sigma^2 = 5');



%% smoother function Viterbi
figure(2); 
subplot(3,1,1);
hold all; 
plot(y1, 'LineWidth', 2.0);
plot(x, 'k', 'LineWidth', 3.0);
idx = round(y1/10)+1;
plot(s(idx), 'r--', 'LineWidth', 1.0);
ylim([-5 25]);
hold off;
title('\sigma^2 = 1');

subplot(3,1,2);
hold all; 
plot(y2, 'LineWidth', 2.0);
plot(x, 'k', 'LineWidth', 3.0);
idx = round(y2/10)+1;
idx(idx==0) = 1;
plot(s(idx), 'r--', 'LineWidth', 1.0);
plot(k((s(idx)-x)~=0), est((s(idx)-x~=0)), 'm.', 'MarkerSize', 20)
ylim([-5 25]);
hold off;
title('\sigma^2 = 2');

subplot(3,1,3);
hold all; 
plot(y3, 'LineWidth', 2.0);
plot(x, 'k', 'LineWidth', 3.0);
idx = round(y3/10)+1;
idx(idx==0) = 1;
idx(idx>3) = 3;
plot(s(idx), 'r--', 'LineWidth', 1.0);
plot(k((s(idx)-x)~=0), est((s(idx)-x)~=0), 'm.', 'MarkerSize', 20)
ylim([-5 25]);
hold off;
title('\sigma^2 = 5');


%%
display(100 - sum((s(round(y1/10)+1) - x) == 0)/10)
idx = round(y2/10)+1;
idx(idx==0) = 1;
display(100 - sum((s(idx) - x) == 0)/10)
idx = round(y3/10)+1;
idx(idx==0) = 1;
idx(idx>3) = 3;
display(100 - sum((s(idx) - x) == 0)/10)
