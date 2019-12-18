
% smoother 
function result = q1smoother(y, A, w)

n = length(y);
p = zeros(n, 1);
sine = A * sin(w * (1:1:n))'; % precompute the sine wave

for i = 1:n
    
    % forward filter
    pf0 = rand();
    pf1 = 0.0; 
    for j = 1:i
        pk = 0.2 + 0.6 * pf0;
        pf1 = pk*normpdf(y(i) - 1 - sine(i)) / ...
            (pk*normpdf(y(i) - 1 - sine(i)) + (1-pk)*normpdf(y(i) + 1 - sine(i))); 
        pf0 = pf1; 
    end
    
    % backward filter
    pb0 = 1.0; 
    pb1 = 0.0;
    for j = n:-1:i
        pb1 = 0.2 + pb0 * (0.8*normpdf(y(i) - 1 - sine(i)) - 0.2*normpdf(y(i) + 1 - sine(i)));
        pb0 = pb1; 
    end
    
    % Smoother 
    p(i) = pf1 * pb1 / (pf1 * pb1 + (1-pf1)*(1-pb1));
end

% the y_hat, the smoother estimate of the measurement.
% if one wants to get the state estimate, subtract the known sine wave
result = sine + 2 * p - 1;
end