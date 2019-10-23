
function results = rls(y, k, r, c, th1, p1)

n = length(y);
results = zeros(n, k);
P = p1;

results(k+1, :) = th1';
for i = k+2:n
    psi = flip(y(i-k:i-1));
    ppsi = P * psi;
    denom = r/c + psi' * ppsi;
    results(i, :) = (results(i-1, :)' + ppsi * (y(i) - psi' * results(i-1, :)') / denom)';
    P = (P - ppsi * ppsi' / denom) / r; 
end

end
    