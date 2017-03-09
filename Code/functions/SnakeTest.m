function x = SnakeTest(weights, dimension, layers, verbose, seed)
    %stream = RandStream('mt19937ar','Seed',seed);
    %prevstream = RandStream.setGlobalStream(stream);



    snake_length = 1;
    snake_init_head = [dimension(1)/2, dimension(2)/2];
    snake = [floor(snake_init_head)];
    direction = [-1, 0];
    alive = true;
    grow = false;
    
    food_eaten = 0;
    moves_made = 0;
    
    starv_th = dimension(1) + dimension(2);
    starvation = starv_th;
    
    food = randi(min(dimension(1), dimension(2)), 1, 2);
    
    function l = render_snake()
        game = zeros(dimension(1), dimension(2));
        
        for ii=1:snake_length
            if ii == 1
                game(snake(ii,1), snake(ii,2)) = 2;
            else
                game(snake(ii,1), snake(ii,2)) = 1;
            end
            
        end
        
        game(food(1), food(2)) = -1;
        %snake
        game
        pause(0.25);
        clc;
    end

    function d = get_ai_direction(rep)
        
        %rep_t = reshape(rep, [1 9]);
        output = NeuralNetwork(rep, weights, layers);
        
        d = [ 0, 0 ];
        
        [m,mi] = max(output);
        %L
        if mi == 1
            d = [ 0, -1];
        end
        %R
        if mi == 2
            d = [ 0, 1];
        end
        %U
        if mi == 3
            d = [ -1, 0];
        end
        %D
        if mi == 4
            d = [ 1, 0];
        end
       
        
        
    end



    function rep = get_representation()
        food_rep = 1;
        snake_rep = 1;
        snake_rep_diagonal = 1/snake_length;
        
        rep = zeros(1,12);
        
        %LRUD
        for k=2:snake_length
            %left
            if (snake(k,1) == snake(1,1)) && (snake(k,2) == snake(1,2)-1)
                rep(1) = snake_rep;
            end
            %right
            if (snake(k,1) == snake(1,1)) && (snake(k,2) == snake(1,2)+1)
                rep(2) = snake_rep;
            end
            %up
            if (snake(k,1) == snake(1,1)-1) && (snake(k,2) == snake(1,2))
                rep(3) = snake_rep;
            end
            %down
            if (snake(k,1) == snake(1,1)+1) && (snake(k,2) == snake(1,2)-1)
                rep(4) = snake_rep;
            end
        end
        
        %wall
        %left
        if snake(1,2) == 1
            rep(1) = snake_rep;
        end
        
        %right
        if snake(1,2) == dimension(2)
            rep(2) = snake_rep;
        end
        
        %up
        if snake(1,1) == 1
            rep(3) = snake_rep;
        end
        
        %right
        if snake(1,1) == dimension(1)
            rep(4) = snake_rep;
        end
        
        
        %QUADRANT
        for k=2:snake_length
            if snake(k,1) <= snake(1,1)
                if snake(k,2) <= snake(1,2)
                    rep(5) = rep(5) + snake_rep_diagonal;
                else
                    rep(6) = rep(6) + snake_rep_diagonal;
                end
            else
                if snake(k,2) <= snake(1,2)
                    rep(7) = rep(7) + snake_rep_diagonal;
                else
                    rep(8) = rep(8) + snake_rep_diagonal;
                end
            end
        end
        
        
        %FOOD
        if food(1) <= snake(1,1)
            if food(2) <= snake(1,2)
                rep(9) = rep(9) + food_rep;
            else
                rep(10) = rep(10) + food_rep;
            end
        else
            if food(2) <= snake(1,2)
                rep(11) = rep(11) + food_rep;
            else
                rep(12) = rep(12) + food_rep;
            end
        end
    end
    
    while alive
        if verbose == true
            render_snake();
        end
        old_direction = direction;
        direction = get_ai_direction(get_representation());
        
        self_invert = false;
        
        if snake_length > 1
            if (direction(1) == -old_direction(1) && direction(2) == old_direction(2) && direction(1) ~= 0) || (direction(2) == -old_direction(2) && direction(1) == old_direction(1) && direction(2) ~= 0)
                %self_invert = true;
                direction = old_direction;
            end
        end
        
        new_head = snake(1,:) + direction;
        if new_head(1) < 1 || new_head(1) > dimension(1) || new_head(2) < 1 || new_head(2) > dimension(2) || self_invert == true
            alive = false;
            %disp('Kill for out-of-bound OR self-inversion');
        else
            for i=2:snake_length
                if snake(i,1) == snake(1,1) && snake(i,2) == snake(1,2)
                    alive = false;
                end
            end
            if grow
                snake = [new_head; snake];
                grow = false;
                snake_length = snake_length + 1;
            else
                if snake_length > 1
                    new_tail = snake(1:snake_length-1,:);
                else
                    new_tail = [];
                end
                snake = [new_head; new_tail];
            end
            if food(1) == snake(1,1) && food(2) == snake(1,2)
                grow = true;
                food_eaten = food_eaten + 1;
                food = randi(10, 1, 2);
                starvation = starvation + starv_th;
            end
            
            moves_made = moves_made + 1;
            starvation = starvation - 1;
        end
        if starvation < 1
            alive = false;
        end
    end
    
    %x = food_eaten^2 + sigmoid(moves_made)-0.5;
    %x = 1/2 * moves_made * food_eaten^2;
    %x = sigmoid(moves_made)-0.5 + sigmoid(food_eaten)-0.5;
    %x = food_eaten^1.25 + sigmoid(moves_made)-0.5;
    x = food_eaten + sigmoid(moves_made);
    %x = max(food_eaten, sigmoid(moves_made)-0.5);
    %x = (sigmoid(moves_made)-0.5) + food_eaten;
    %x = snake_length + snake_length^3/moves_made + sigmoid(moves_made)-0.5;
    
    
    %localstream = RandStream.setGlobalStream(prevstream);
    
end


