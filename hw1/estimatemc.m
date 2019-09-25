function result = estimatemc(x)

% work for 3x3 mc
p = zeros(3);

for i = 1:3
    n = length(strfind(x, [i]));
    if x(end) == i
        n = n - 1;
    end
    for j = 1:3
        p(i, j) = length(strfind(x, [i, j]))/n;
    end
end


result = p;
end