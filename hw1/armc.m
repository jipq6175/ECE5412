function result = armc(n)

A = [.3 .3 .4; .1 .9 .0; .1 .1 .8];
pi0 = [.1; .9; .0];

x = [acceptance_rejection(pi0(1), pi0(1)+pi0(2))];

for i = 1:n
    s = x(end);
    x = [x acceptance_rejection(A(s, 1), A(s, 1)+A(s, 2))];
end

result = x;
end

