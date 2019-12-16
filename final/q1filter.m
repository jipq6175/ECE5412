
% optimal filter 
function result = q1filter(y, A, w, p0)

n = length(y); 
p = [p0; zeros(n, 1)]; 
sine = A * sin(w * (1:1:n))';

% filtering at every time point
for i = 1:n
    
    pk = 0.2 + 0.6 * p(i);
    p(i+1) = pk*normpdf(y(i) - 1 - sine(i)) / ...
        (pk*normpdf(y(i) - 1 - sine(i)) + (1-pk)*normpdf(y(i) + 1 - sine(i))); 
end

% The conditional estimate, or the y_hat
result = sine + 2 * p(2:end) - 1;
end

