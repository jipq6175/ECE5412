
% Question 2


%% 2 (a)
n = 10000; 
x = zeros(n+1, 1); 
x(1) = randn();
i = 2;

while i <= n+1
    
    % sample new x from N(x_old, 1) (random walk MH)
    tmp = randn() + x(i-1);
    
    % calculate the acceptance rate 
    r = (cos(tmp)^2 * sin(2*tmp)^2 * normpdf(tmp))/(cos(x(i-1))^2 * sin(2*x(i-1))^2 * normpdf(x(i-1)));
    
    if rand() < r
        x(i) = tmp;
        i = i + 1;
    end
end


% For plotting the pdf and cdf
t = -5:0.01:5; 
p = cos(t).^2 .* sin(2*t).^2 .* normpdf(t); 
[f, xtick] = hist(x, 100);
figure(1); 
subplot(1,2,1);
hold all
bar(xtick, f / trapz(xtick, f))
plot(t, p / trapz(t, p), 'r-', 'LineWidth', 1.5)
hold off
legend('MH Simulation', 'True PDF');
title('PDF');

subplot(1,2,2);
hold all; 
ecdf(x); 
plot(t, cumsum(p / trapz(t, p)) * 0.01)
hold off;
legend('MH Simulation', 'True CDF');
title('CDF');

%%
    