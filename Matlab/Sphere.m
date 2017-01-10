function y = Sphere(X)
%SPHERE optimization test function
    sum = 0;
    n = length(X);

    for i = 1:n
        sum = sum + X(i).^2;
    end
    
    y = sum;
end

