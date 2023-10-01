function RobotInit(id)
% This function is used to initialize pos and draw robot's body.
global Robot x alpha gamma numofrobots
% Init robot
Robot(id).x=[x(id,1), x(id,2)];
Robot(id).x_estimate=[];
Robot(id).x_sample=[];
Robot(id).RP=zeros(1,numofrobots,'double');
Robot(id).RP_estimate=[];
Robot(id).A=zeros(1,numofrobots,'uint32');

% status robot
Robot(id).help = "No";
Robot(id).status = "free";
Robot(id).statusBanchor = "None";
% BC
Robot(id).Neighbor = [];
Robot(id).Neighbor_topo = [];
alpha = 1;
Robot(id).Vc = [0 0];
gamma = 1;
Robot(id).Va= [0 0];
Robot(id).target = [0 0];
Robot(id).IDtarget = 0;


end