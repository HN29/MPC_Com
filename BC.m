function BC(i)
% This function is used to move robot 
global Robot hRobots viet_ten G hEdges enablelinks

distance = norm(Robot(i).x - Robot(i).target);
Robot(i).Va = (-Robot(i).x+Robot(i).target)/distance;
if norm(Robot(i).Va) > 1
    Robot(i).Va = (Robot(i).Va/norm(Robot(i).Va));
end
Robot(i).V = Robot(i).Va;
Robot(i).x = Robot(i).x+Robot(i).V*0.1;
set(hRobots(i), 'Xdata', Robot(i).x(1), 'Ydata', Robot(i).x(2));
set(hRobots(i),'color','red');
set(viet_ten(i),'position',Robot(i).x);
drawnow;