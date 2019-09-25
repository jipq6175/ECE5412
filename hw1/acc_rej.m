
function result = acc_rej(pik)

n = length(pik);
c = n * max(pik);

while true
    x = int64(floor(n * rand()))+1;
    if rand() < pik(x)/(c/n)
        result = x;
        break;
    end
end

end

