function RobotInit(id)
% This function is used to initialize pos and draw robot's body.
global Robot x
global RP
% Init robot
Robot(id).x=[x(id,1), x(id,2)];
Robot(id).RP=RP(id,:);
% status robot
Robot(id).status = "free";
% BC
Robot(id).Va= [0 0];
Robot(id).target = [0 0];


end