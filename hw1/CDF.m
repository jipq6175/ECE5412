function y = CDF(x)

if x <= 1
    y = (1 - exp(-2*x) + 2*x)/3;
elseif x > 1
    y = (3 - exp(-2*x))/3;
else
    y = -1;
end

end