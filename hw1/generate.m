function result = generate()

c = 4*sqrt(2)/3;
while 1
    
    y = -log(rand(1));
    if rand() < (1-exp(-1)) * PDF(y)/(c * exp(-y))
        result = y;
        break;
    end
end

end