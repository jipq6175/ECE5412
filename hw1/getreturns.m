function result = getreturns(op, cl, period)

n = length(op);
m = n - period + 1;
modified_open = zeros(m, 1);
modified_close = zeros(m, 1);

for i = 1:m
    modified_open(i) = op(i);
    modified_close(i) = cl(i + period - 1); 
end

result = (modified_close - modified_open) ./ modified_open;
end
