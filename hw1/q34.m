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
subplot(3,3,1);
plot(op, 'b-', 'LineWidth', 2);
title('S&P 500 Index')
xlabel('Days from 2014-09-24');
ylabel('Index');
xlim([0 1260]);
ylim([min(op)-20 max(op)+20])

for i = 1:8
    subplot(3,3,i+1);
    hold all; 
    ret = 100 * log(rt(char(keyset(i)))+1);
    [counts, bin] = hist(ret, 25); 
    pd = fitdist(ret, 'Normal');
    plot(bin, (counts/sum(counts)/mean(diff(bin))), '--', 'LineWidth', 3); 
    x = -20:0.02:40;
    plot(x, pdf(pd, x), 'LineWidth', 4)
    legend(keyset(i), 'fit');
    [h, dp] = kstest(ret);
    ann = [char(keyset(i)) ' K^2 = ' num2str(dp)];
    title(ann);
    xlim([bin(1)-2, bin(end)+2])
end
%set(gca, 'yaxis', 'log')
%legend(keyset(1:4));

