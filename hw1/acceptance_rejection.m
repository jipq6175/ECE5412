
function result = acceptance_rejection(a, b)

p = [a, b-a, 1-b];
c = 3 * max(p);

while true
    x = int64(floor(3 * rand()))+1;
    if rand() < p(x)/(c/3)
        result = x;
        break;
    end
end

end

