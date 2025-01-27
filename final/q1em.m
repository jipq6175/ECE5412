
% The EM algorithm
function result = q1em(y, A0, w, maxiter, tol)

n = length(y); 
sine = sin(w * (1:1:n))'; % precompute the sine wave

A = A0; 

% container for A and likelihood trace
result = zeros(maxiter, 2); 

% the EM algorithm
display(sprintf('-------  EM Algorithm: A0 = %0.4f  -------', A));
display('=================================================');
i = 1; 
v = Inf;
mva = round(maxiter * 0.1);
while ((i <= maxiter) && (v > tol))
    
    % E-Step on E(x|Y_N)
    est = q1smoother(y, A, w) - A * sine;
    
    % M-Step
    A = (y-est)' * sine / sum(sine.^2);
    
    % save the trace
    result(i, 1) = A; 
    result(i, 2) = sum(log(normpdf(y - est - A * sine)));
    
    % Calculate the stopping criterion
    if i > mva
        v = var(result((i-mva):i, 2));
    end
    
    % Display the iterations
    display(sprintf('--- Iteration %3d: A = %0.3f, LL = %0.3f, v = %0.3f ...', i, A, result(i, 2), v));
    
    i = i + 1; 
end
display('=================================================');

% if early stopping, organize the output
if v < tol
    result(i:maxiter, :) = [];
end

end

