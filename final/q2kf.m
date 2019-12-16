
% Kalman Filter for state model in question 2
function result = q2kf(y, variance)

n = length(y); 
result = zeros(n, 1); 
result(1) = y(1); 

s = 1.0;

for i = 2:n
    result(i) = result(i-1) + (1+s)*(y(i)-result(i-1))/(1+s+variance);
    s = (1+s) - (1+s)^2/(1+s+variance);
end
end