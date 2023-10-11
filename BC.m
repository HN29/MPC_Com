function BC(i)
% This function is used to move robot 
global Robot hRobots viet_ten x hEdges numofrobots thres alpha gamma time
thres = 0.95;
for j = 1:1:numofrobots
    if Robot(i).A(j) == 1
        set(hEdges{i}(j),'visible','off');
    end
    if Robot(j).A(i) == 1
        set(hEdges{j}(i),'visible','off');
    end
end

%%%% Va %%%%
if  Robot(i).status == "move goal" || Robot(i).status == "Support"
    distance = norm(Robot(i).x - Robot(i).target);
    Robot(i).Va = (-Robot(i).x+Robot(i).target)/distance;
else
    Robot(i).Va = 0;
end

%%%% Vc %%%%
Robot(i).Vc = [0 0];
for j = Robot(i).Neighbor
    if Robot(i).RP(j) <= thres
        if ~ismember(j, Robot(i).Neighbor_topo(:,2))
            Robot(i).Vc = Robot(i).Vc + Robot(j).x - Robot(i).x;
        else
            Robot(i).Neighbor = Robot(i).Neighbor(Robot(i).Neighbor~=j);
        end
    end
end
alpha = 1;
gamma = 1;
time = 0.1;
Robot(i).V = alpha*Robot(i).Vc + gamma*Robot(i).Va;
if norm(Robot(i).V) > 1
    Robot(i).V = (Robot(i).V/norm(Robot(i).V));
end

Robot(i).x = Robot(i).x+Robot(i).V*time;
x(i,:) = Robot(i).x;
Robot(i).x_sample = [Robot(i).x_sample; Robot(i).x];
if size(Robot(i).x_sample,1) >= 25
    Robot(i).x_sample(1,:) = [];
end
set(hRobots(i), 'Xdata', Robot(i).x(1), 'Ydata', Robot(i).x(2));
if Robot(i).status == "move goal"
    set(hRobots(i),'color','green');
elseif Robot(i).status == "Support"
    set(hRobots(i),'color','black');
elseif Robot(i).status == "lanmark"
    set(hRobots(i),'color','cyan');
else
    set(hRobots(i),'color','red');
end
set(viet_ten(i),'position',Robot(i).x);
for j = 1:1:numofrobots
    if Robot(i).A(j) == 1
        hEdges{i}(j) = plot([Robot(i).x(1) Robot(j).x(1)], [Robot(i).x(2) Robot(j).x(2)], 'b-');
    end
end