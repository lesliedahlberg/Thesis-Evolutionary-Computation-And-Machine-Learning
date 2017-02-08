%
%        DATABASE INFORMATION 
%
%  1999 -> 1-13 functions
%


function res = calculateFitness(func, x, o, A, M, a, alpha, b)

    dimension = size(x,2);

    if func == 1
    
        res = f1(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 2
    
        res = f2(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 3
    
        res = f3(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 4
    
        res = f4(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 5
    
        res = f5(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 6
    
        res = f6(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 7
    
        res = f7(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 8
    
        res = f8(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 9
    
        res = f9(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 10
    
        res = f10(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 11
    
        res = f11(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 12
    
        res = f12(x, o, A, M, a, alpha, b);
        
    end
    
    if func == 13
    
        res = f13(x, o, A, M, a, alpha, b);
        
    end


end