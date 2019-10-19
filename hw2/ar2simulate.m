function result = ar2simulate(y0, y1, a1, a2, n)
    result = [y0; y1; zeros(n, 1)];
    for i = 1:n
        result(i+2) = - a1 * result(i+1) - a2 * result(i) + randn();
    end
    
end
    