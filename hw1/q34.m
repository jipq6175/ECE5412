% q34

op = sp5ydaily(:, 1);
cl = sp5ydaily(:, end);


period = [1, 3, 5, 10, 22, 66, 262, 524]; 
keyset = {'day', 'threedays', 'week', 'twoweeks', 'month', 'season', 'year', 'twoyears'};
rt = containers.Map;

for i = 1:length(period)
    
    rt(char(keyset(i))) = getreturns(op, cl, period(i));
    
end


figure(1);
subplot(2,3,1);
plot(op, 'b-', 'LineWidth', 2);
title('S&P 500 Index')
xlabel('Days from 2014-09-24');
ylabel('Index');
xlim([0 1260]);


for i = 1:4
    subplot(2,3,i+1);
    hold all; 
    ret = 100 * log(rt(char(keyset(i)))+1);
    [counts, bin] = hist(ret, 25); 
    pd = fitdist(ret, 'Normal');
    plot(bin, (counts/max(counts))/sqrt(2*pi*pd.sigma^2), '--', 'LineWidth', 1); 
    x = -20:0.02:20;
    plot(x, pdf(pd, x), 'LineWidth', 2)
    legend(keyset(i), 'fit');
    xlim([-10, 10])
end
%set(gca, 'yaxis', 'log')
%legend(keyset(1:4));

%%
subplot(1,3,3);
hold all; 
for i = 5:8
    [counts, bin] = hist(log(rt(char(keyset(i)))+1), 25); 

    plot(bin, counts/sum(counts), 'LineWidth', 2); 
end
%set(gca, 'yaxis', 'log')
legend(keyset(5:8));