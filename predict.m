function predict(i)
% This function is used to move robot 
global Robot hRobots viet_ten G hEdges enablelinks numofrobots thres
time_est = 0.2;
time_step = 1;
Robot(i).x_estimate = [];
Robot(i).x_estimate = [Robot(i).x_estimate; Robot(i).x];
for time_t = 0.2:time_est:time_step
    Robot(i).x_estimate = [Robot(i).x_estimate;Robot(i).x_estimate+Robot(i).V*time_t];
end

disp(size(Robot(i).x_estimate));