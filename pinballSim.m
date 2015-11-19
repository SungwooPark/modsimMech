function res = pinballSim()
    fieldSlope = 6.5; %in degrees
    m = 0.08; %kg, mass of pinball
    initYPos = 0;
    initYVelo = 20; %m/s
    g = 9.8;
    
    function res = sim(~,P)
        y = P(1); %y pos
        vy = P(2); %y velocity
        
        yForce = -g*sind(fieldSlope); %Force in y direction
        disp(yForce)
        
        dydt = vy;
        dvydt = yForce/m;
        
        res = [dydt; dvydt];
        
    end

    options = odeset('Events',@events);
    function [value, isterminal, direction] = events (t, X)
        value = X(1);
        isterminal = 1;
        direction = -1;
    end

    [T, R] = ode45(@sim, [0, 10], [initYPos, initYVelo],options);
    plot(T, R(:,1));
end