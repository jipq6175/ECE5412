function y = PDF(x)

if x <= 1
    y = 2 * (exp(-2*x) + 2) / 3;
elseif x > 1
    y = 2 * exp(-2*x)/3;
else
    y = -1;
end

end