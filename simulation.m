for i=-10:2:10
 %for degrees=-45:15:15
 %  pinballSim(i/5, degrees);
 %end
 pinballSim(i/5, -30);
end

line([-0.2 0.2],[0.14 0.14],'LineWidth',5)