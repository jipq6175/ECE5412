
% Generate the sensor measurement 
function result = q1generate(A, w, n)

% the state space
state = [1; -1];

% Try to use the written functions in the homework to generate s[k]
P = [0.8 0.2 0.0; 0.2 0.8 0.0; 0.0 0.0 1.0];
s = armc(P, n); % armc was written in hw1 and I keep using it

result = state(s(2:end)) + A * sin(w * (1:1:n))' + randn(n, 1);
end