
function result = mhvix(y, x0, n)


x = [[x0 1]; zeros([n, 2])];


for i = 1:n
    
    % the proposed distribution
    t0 = x(i, :);
%     while 1
%         t1 = mvnrnd(t0, 0.01*eye(2));
%         if t1(1) > 0; 
%             break;
%         end
%     end
    
    t1 = mvnrnd(t0, 0.01*eye(2));
    
    r1 = prod(poisspdf(y, t0(1)) ./ poisspdf(y, t1(1)));
    r2 = normpdf(t0(1), x0, t0(1)^2) / normpdf(t1(1), x0, t1(1)^2);
    r3 = (t1(1) / t0(1))^2; 
    
    % alpha = min(1, ratio)
    alpha = min(1, 1/(r1*r2*r3));
    if rand() < alpha
        x(i+1, :) = t1;
    else
        x(i+1, :) = t0;
    end
    
end

result = x;
end
    
    
    
