function res = pinballSim()
    fieldSlope = 6.5; %in degrees
    m = 0.08; %kg, mass of pinball
    initYPos = 0;
    initYVelo = 20; %m/s
    g = 9.8;
    
    function res = sim(~,P)
        x = P(1); %x pos
        vx = P(2); %x velocity
        y = P(3); %y pos
        vy = P(4); %y velocity
        
        yForce = -g*sind(fieldSlope); %Force in y direction
        %disp(yForce)
        
        dxdt = 0;
        dvxdt = 0;
        dydt = vy;
        dvydt = yForce/m;
        
        res = [dxdt; dvxdt; dydt; dvydt];
        
    end

    options = odeset('Events',@events);
    function [value, isterminal, direction] = events (t, X)
        value = X(3);
        isterminal = 1;
        direction = -1;
    end

    [T, R] = ode45(@sim, [0:0.1:10], [0, 0, initYPos, initYVelo],options);
    
    X = R(:,1); %a sequence of x position of pinball
    Y = R(:,3); %y position
    
    minmax = [min(X)-10, max(X)+10, min(Y)-10, max(y)+20];
    
    for i=1:length(T)
        clf;
        axis(minmax);
        hold on;
        draw_func(X(i), Y(i));
        drawnow;
        pause(0.1);
    end
    
    function draw_func(x, y)
        plot(x, y, 'r.', 'MarkerSize', 20);
    end
    
end