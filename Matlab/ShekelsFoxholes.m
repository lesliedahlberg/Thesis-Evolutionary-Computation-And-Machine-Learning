function y = ShekelsFoxholes(X)
%SHEKELSFOXHOLES optimization test function
    sum = 0;
    
    A = [-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32; -32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32]; 

    for j = 1:25
        subsum = 0;
        for i = 1:2
           subsum = subsum + (X(i) - A(i,j)).^6;
        end
        sum = sum + 1/(j + subsum);
    end
    
    y = ((1/500) + sum).^-1;
end

