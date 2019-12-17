
% The EM algorithm
function result = q1em(y, A0, w, maxiter)

n = length(y); 
sine = sin(w * (1:1:n))';

A = A0; 

% container for A and likelihood trace
result = zeros(maxiter, 2); 

% the EM algorithm
display(sprintf('-------  EM Algorithm: A0 = %0.4f  -------', A));
display('=================================================');
i = 1; 
while (i <= maxiter)
    
    % E-Step on E(x|Y_N)
    est = q1smoother(y, A, w) - A * sine;
    
    % M-Step
    A = (y-est)' * sine / sum(sine.^2);
    
    % save the trace
    result(i, 1) = A; 
    result(i, 2) = sum(log(normpdf(y - est - A * sine)));
    
    % Display the iterations
    display(sprintf('--- Iteration %4d: A = %0.4f, LL = %0.4f ...', i, A, result(i, 2)));
    
    i = i + 1; 
end
display('=================================================');
end

