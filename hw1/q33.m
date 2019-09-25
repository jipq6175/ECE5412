% q33


N = 1000; 
A = rand(N);
A = bsxfun(@rdivide, A, sum(A, 2)); 
pik = rand(N, 1); 
pik = pik / sum(pik); 


tic();
pik1 = A' * pik;
t = toc();


m = linspace(100, 10000, 100); 
tm = [];
var = [];

for i = 1:100
    M = m(i);
    im = zeros(M, 1);
    
    % generate random variables
    for j = 1:M
        im(j) = acc_rej(pik);
    end
    
    B = A';
    
    tic();
    estimator = mean(B(im, :), 1);
    tmp = toc();
    
    tm = [tm tmp]; 
    
    var = [var norm(estimator' - pik1, 1)];
    
end

%%

figure(1); 
subplot(1,2,1);
plot(m, var, 'b-', 'LineWidth', 4);
title('Variance');
ylabel('||\pi*_{k+1} - \pi_{k+1}||_1');
xlabel('m'); 

subplot(1,2,2);
plot(m, tm, 'g-', 'LineWidth', 4);
title('time');
ylabel('time (sec)');
xlabel('m')