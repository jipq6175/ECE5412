function result = inverse_transform(a, b)

u = rand();
if u < a
    result = 1;
elseif (u < b) && (u >= a)
    result = 2; 
else
    result = 3; 
end

end