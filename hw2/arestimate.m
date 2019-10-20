
function residuals = arestimate(y, k)

n = length(y);
d = n - k;

Y = y(k+1:n);
X = zeros(d, k);
for i = k:-1:1
    X(:,i) = y(k-i+1:n-i);
end

estimate = -inv(X' * X) * (X' * Y);
%display(estimate(1));
%display(estimate(2));

residuals = Y - X * estimate;
end
