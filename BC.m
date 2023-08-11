function BC(i)
% This function is used to move robot 
global Robot hRobots viet_ten G hEdges enablelinks numofrobots thres
for j = 1:1:numofrobots
    if G.A(i,j) == 1
        set(hEdges{i}(j),'visible','off');
    end
    if G.A(j,i) == 1
        set(hEdges{j}(i),'visible','off');
    end
end

%%%% Va %%%%
distance = norm(Robot(i).x - Robot(i).target);
Robot(i).Va = (-Robot(i).x+Robot(i).target)/distance;

%%%% Vc %%%%
Robot(i).Vc = [0 0];
for j = Robot(i).Neighbor
    if Robot(i).RP(j) <= thres
        Robot(i).Vc = Robot(i).Vc + Robot(j).x - Robot(i).x;
    else
        if ismember(j, Robot(i).Neighbor_topo(:,1))
            index = find(Robot(i).Neighbor_topo(:,1) == j);
            index_robot_b = Robot(i).Neighbor_topo(index,1);
            index_robot_c = Robot(i).Neighbor_topo(index,2);
            midpoint = (Robot(index_robot_b).x + Robot(index_robot_c).x)/2;
            Robot(i).Vc = Robot(i).Vc + midpoint - Robot(i).x;
        end
    end
end


Robot(i).V = Robot(i).Va + Robot(i).Vc;
if norm(Robot(i).V) > 1
    Robot(i).V = (Robot(i).V/norm(Robot(i).V));
end
Robot(i).x = Robot(i).x+Robot(i).V*0.2;
set(hRobots(i), 'Xdata', Robot(i).x(1), 'Ydata', Robot(i).x(2));
set(hRobots(i),'color','red');
set(viet_ten(i),'position',Robot(i).x);
for j = 1:1:numofrobots
    if G.A(i,j) == 1
        hEdges{i}(j) = plot([Robot(i).x(1) Robot(j).x(1)], [Robot(i).x(2) Robot(j).x(2)], 'b-');
    end
end