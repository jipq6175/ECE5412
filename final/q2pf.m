
% particle filter 
function result = q2pf(y, N)

n = length(y);
result = zeros(n, 2); 

% initialize the particles, weights
x = randn(N, 1);
w = ones(N, 1); 

% particle filter recursion, use vectorization on particles
for i = 1:n
    
    % sample from p(x_{k+1}|x_k)
    x = x + randn(N, 1);
    
    % Sampling Importance Resampling
    t = x - y(i);
    w = cos(t).^2 .* sin(2*t).^2 .* normpdf(t); 
    % conditional mean
    result(i, 2) = w' * x / sum(w);
    idx = randsample(N, N, true, w); 
    x = x(idx); 
    
    % Use unconditional mean 
    result(i, 1) = mean(x);
end
end


    