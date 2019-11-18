

function result = gibbs(t, censored, x0, n)

t_uncensored = t(censored==0);
n_uc = length(t_uncensored);
t_censored = t(censored==1);
n_c = length(t_censored); 

% need to augment n_c data for this 
result = zeros([n, 1]);
y = zeros([n_c, 1]);
for k = 1:n
   % sample from Poissons to fill up y vector (using importance sampling?)
   
   
   % sample from un-normalized likelihood given y
   result(i) = 

end
end