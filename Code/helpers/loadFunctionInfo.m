%
%          DATABASE INFORMATION 
%
%  1999 -> 1-13 functions
%
%                 OUTPUTS
%
%  correct = 1 -> The function is correct.
%  correst = 0 -> The function is incorrect.
%

function [correct, upper, lower, optimum, o, A, M, a, alpha, b] = loadFunctionInfo(func, dimension)

    correct  = 1;
    D = dimension;

    if func == 1

		lower = -100;
		upper = 100;
		optimum = 0;
        load sphere_func_data
        A = []; M = []; a = []; alpha = []; b = [];

    end
    
	if func == 2

		lower = -100;
		upper = 100;
		optimum = 0;
        
        load schwefel_102_data
        A = []; M = []; a = []; alpha = []; b = [];

    end
    
	if func == 3

		lower = -100;
		upper = 100;
		optimum = 0;
        
        load high_cond_elliptic_rot_data
        A = []; a = []; alpha = []; b = [];

        if D == 2
            load elliptic_M_D2;
        elseif D == 10
            load elliptic_M_D10;
        elseif D == 30
            load elliptic_M_D30;
        elseif D == 50
            load elliptic_M_D50;
        end
    
    end
    
    if func == 4

		lower = -100;
		upper = 100;
		optimum = 0;
        
        load schwefel_102_data
        A = []; M = []; a = []; alpha = []; b = [];
    
    end

    if func == 5

		lower = -100;
		upper = 100;
		optimum = 0;
        
        load schwefel_206_data
        M = []; a = []; alpha = []; b = [];

    end
    
    if func == 6

		lower = -100;
		upper = 100;
		optimum = 0;
        
        load rosenbrock_func_data
        A = []; M = []; a = []; alpha = []; b = [];

    end
    
    if func == 7

		lower = -600;
		upper = 600;
		optimum = 0;
        
        load griewank_func_data
        A = []; a = []; alpha = []; b = [];

        if D == 2, load griewank_M_D2,
        elseif D == 10, load griewank_M_D10,
        elseif D == 30, load griewank_M_D30,
        elseif D == 50, load griewank_M_D50,
        end

    end
    
    if func == 8

		lower = -32;
		upper = 32;
		optimum = -12569.5*dimension/30;
        
        load ackley_func_data
        A = []; a = []; alpha = []; b = [];

        if D == 2, load ackley_M_D2,
        elseif D == 10, load ackley_M_D10,
        elseif D == 30, load ackley_M_D30,
        elseif D == 50, load ackley_M_D50,
        end

    end
    
    if func == 9

		lower = -5;
		upper = 5;
		optimum = 0;
        
        load rastrigin_func_data
        A = []; M = []; a = []; alpha = []; b = [];

    end
    
    if func == 10

		lower = -5;
		upper = 5;
		optimum = 0;
        
        load rastrigin_func_data
        A = []; a = []; alpha = []; b = [];
        if D == 2, load rastrigin_M_D2,
        elseif D == 10, load rastrigin_M_D10,
        elseif D == 30, load rastrigin_M_D30,
        elseif D == 50, load rastrigin_M_D50,
        end

    end
    
    if func == 11

		lower = -0.5;
		upper = 0.5;
		optimum = 0;
        
        load weierstrass_data
        A = []; a = []; alpha = []; b = [];
        if D == 2, load weierstrass_M_D2, ,
        elseif D == 10, load weierstrass_M_D10,
        elseif D == 30, load weierstrass_M_D30,
        elseif D == 50, load weierstrass_M_D50,
        end

    end
    
    if func == 12

		lower = -pi;
		upper = pi;
		optimum = 0;
        
        load schwefel_213_data
        A = []; M = []; 
        o = [];

    end
    
    if func == 13

		lower = -3;
		upper = 1;
		optimum = 0;
        
        load EF8F2_func_data
        A = []; M = []; a = []; alpha = []; b = [];

    end
    
    if func == 14

		lower = -100;
		upper = 100;
		optimum = 0;
        
        load E_ScafferF6_func_data
        if D == 2, load E_ScafferF6_M_D2,
        elseif D == 10, load E_ScafferF6_M_D10,
        elseif D == 30, load E_ScafferF6_M_D30,
        elseif D == 50, load E_ScafferF6_M_D50,
        end
        A = []; a = []; alpha = []; b = [];

    end
    
    if func > 13 || func < 1
        
        correct = 0;
        
    end

end