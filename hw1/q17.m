% 
addpath(pwd())

x = [];
n = 100000;
for i = 1:n
    x = [x generate()];
end






x_grid = linspace(0, 5.5, 1000);
y = [];
for i = 1:1000
    y = [y CDF(x_grid(i))];
end


[f, z] = hist(x, 100);
f = cumsum(f/n)
figure(1)
bar(z, f)
hold on;
plot(x_grid, y, 'LineWidth', 5.0, 'color', 'r')
xlim([0 5])
title('CDF')