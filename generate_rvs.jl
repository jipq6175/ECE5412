# generate gaussian random variables by inverse method

using Plots

# gaussian x, y
function gaussianrv(n::Signed)
    u1, u2 = rand(n), rand(n);
    d, θ = -2.0 * log.(u1), 2*pi*u2;
    x, y = sqrt.(d) .* cos.(θ), sqrt.(d) .* sin.(θ);
    return x, y;
end


# using the acceptance - rejection method
function arv(n::Signed)
    x = zeros(n);
    c = 5;
    for i = 1:n
        while true
            u = rand(2);
            if u[1] < u[2]^(c - 1)
                x[i] = u[2];
                break;
            end
        end
    end
    return x;
end


@time x, y = gaussianrv(100000);
@time z = arv(100000);

histogram(x)

histogram(y)

histogram(z, normalize=true)
v = collect(0.0:0.001:1.0);
plot!(v, 5*v.^4, lw=3.0)
