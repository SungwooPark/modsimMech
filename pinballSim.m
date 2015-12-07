function res = pinballSim(xvel)
    fieldSlope = 6.5; %in degrees
    m = 0.08; %kg, mass of pinball
    initXPos = 0;
    initXVelo = xvel;
    initYPos = 0;
    initYVelo = 2; %m/s
    g = 9.8;
    
    function res = sim(~,P)
        x = P(1); %x pos
        vx = P(2); %x velocity
        y = P(3); %y pos
        vy = P(4); %y velocity
        
        yForce = -g*sind(fieldSlope); %Force in y direction
        disp(yForce)
        %disp(yForce)
        
        dxdt = vx;
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

    [T, R] = ode45(@sim, [0:0.01:10], [initXPos, initXVelo, initYPos, initYVelo],options);
    
    X = R(:,1); %a sequence of x position of pinball
    Y = R(:,3); %y position
    
    hold on
    plot(X,Y)
    
end