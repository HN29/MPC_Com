function BC(i)
% This function is used to move robot 
global Robot hRobots viet_ten G hEdges enablelinks numofrobots thres alpha gamma
thres = 0.9;
for j = 1:1:numofrobots
    if Robot(i).A(j) == 1
        set(hEdges{i}(j),'visible','off');
    end
    if Robot(j).A(i) == 1
        set(hEdges{j}(i),'visible','off');
    end
end

%%%% Va %%%%
distance = norm(Robot(i).x - Robot(i).target);
Robot(i).Va = (-Robot(i).x+Robot(i).target)/distance;

%%%% Vc %%%%
Robot(i).Vc = [0 0];
for j = Robot(i).Neighbor
    if Robot(i).RP(j) <= 0.9
        disp("check1");
        if ~ismember(j, Robot(i).Neighbor_topo(:,1))
            disp("check2");
            Robot(i).Vc = Robot(i).Vc + Robot(j).x - Robot(i).x;
        else
            disp("check3");
            Robot(i).Neighbor = [Robot(i).Neighbor,Robot(i).Neighbor~=j];
%             index = find(Robot(i).Neighbor_topo(:,1) == j);
%             index_robot_b = Robot(i).Neighbor_topo(index,1);
%             index_robot_c = Robot(i).Neighbor_topo(index,2);
%             midpoint = (Robot(index_robot_b).x + Robot(index_robot_c).x)/2;
%             Robot(i).Vc = Robot(i).Vc + midpoint - Robot(i).x;
        end
    end
end
alpha = 10;
Robot(i).V = alpha*Robot(i).Vc; %+ gamma*Robot(i).Va;
if norm(Robot(i).V) > 1
    Robot(i).V = (Robot(i).V/norm(Robot(i).V));
end
Robot(i).x = Robot(i).x+Robot(i).V*0.2;
set(hRobots(i), 'Xdata', Robot(i).x(1), 'Ydata', Robot(i).x(2));
set(hRobots(i),'color','red');
set(viet_ten(i),'position',Robot(i).x);
for j = 1:1:numofrobots
    if Robot(i).A(j) == 1
        hEdges{i}(j) = plot([Robot(i).x(1) Robot(j).x(1)], [Robot(i).x(2) Robot(j).x(2)], 'b-');
    end
end