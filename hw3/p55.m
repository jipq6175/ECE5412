load fisheriris.mat

% truncate to only binary classification
X = meas(1:100, :);
Y = [zeros([50 1]); ones([50 1])]; 

mu0 = mean(X(1:50, :))';
mu1 = mean(X(51:100, :))';
X2 = [X(1:50, :) - repmat(mu0', [50, 1]); X(51:100, :) - repmat(mu1', [50, 1])];
S = inv(cov(X2));
p = 2 * (mu0 - mu1)' * S;
c = mu0' * S * mu0 - mu1' * S * mu1;

figure(2);
k = 1;
for i = 1:4
    for j = (i+1):4
        subplot(2,3,k);
        hold all; 
        scatter(X(1:50, i), X(1:50, j), 'b.');
        scatter(X(51:100, i), X(51:100, j), 'gx');
        u = min(X(:, i)):0.01:max(X(:, i));
        plot(u, (c-p(i)*u)/p(j), 'r');
        xlim([min(X(:, i)), max(X(:, i))]);
        ylim([min(X(:, j)), max(X(:, j))]);
        title(['X' num2str(i) '; X' num2str(j)]);
        hold off;
        xlabel(['X' num2str(i)]);
        ylabel(['X' num2str(j)]);
        k = k + 1;
    end
end





%%
figure(1)
k = 1;
for i = 1:4
    for j = (i+1):4
        X = meas(1:100, [i j]);
        mu0 = mean(X(1:50, :))';
        mu1 = mean(X(51:100, :))';
        S = inv(cov(X));
        p = 2 * (mu0 - mu1)' * S;
        %display(p);
        c = mu0' * S * mu0 - mu1' * S * mu1;
        %display(c);
        f = @(x1, x2) -c + p(1)*x1 + p(2)*x2;
        
        q = fitclinear(X,Y, 'Learner', 'logistic');
        
        f2 = @(x1, x2) q.Bias + q.Beta(1)*x1 + q.Beta(2)*x2;
        
        subplot(2,3,k);
        hold all; 
        scatter(X(1:50, 1), X(1:50, 2), 'b.');
        scatter(X(51:100, 1), X(51:100, 2), 'go');
        h = ezplot(f);
        h.LineWidth = 2.0;
        h.Color='r';
        g = ezplot(f2);
        g.LineWidth = 2.0;
        g.Color='m';
        xlim([min(X(:, 1)), max(X(:, 1))]);
        ylim([min(X(:, 2)), max(X(:, 2))]);
        title(['X' num2str(i) '; X' num2str(j)]);
        %legend('', '', 'Parametric', 'Logistic')
        hold off;
        xlabel(['X' num2str(i)]);
        ylabel(['X' num2str(j)]);
        k = k + 1;
    end
end

