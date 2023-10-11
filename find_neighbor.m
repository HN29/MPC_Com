function find_neighbor(a)
% This function is used to initialize pos and draw the robot's body
global hEdges Robot x numofrobots RP RPsp
minRP =999;
for j = 1:1:numofrobots
    if Robot(a).A(j) == 1
        set(hEdges{a}(j),'visible','off');
    end
    if Robot(j).A(a) == 1
        set(hEdges{j}(a),'visible','off');
    end
end

for b=1:numofrobots
    Robot(a).RP(b) = 0;
    dist = sqrt((x(a,1)-x(b,1))^2 + (x(a,2)-x(b,2))^2); %
    if (a~=b)
        if dist < 5
            numberofpaths = round(3 + (8-3).*rand(1,1));
            rpnoise_rician = receptionprob_rice(dist,numberofpaths);
            Robot(a).RP(b) = rpnoise_rician;
            if (Robot(a).RP(b) > 0.85)
                Robot(a).A(b) = 1;
                RP(a,b) = dist;
            elseif(Robot(a).RP(b) <= 0.85)
                Robot(a).A(b)=0;
                Robot(a).RP(b) = 0;
                RP(a,b) = 0;
            end
        end
    else
        RP(a,b) = 0;
    end
end

Robot(a).Neighbor = [];
Robot(a).Neighbor_topo = [];
for b=1:numofrobots
    if a~=b
        if Robot(a).A(b) == 1    % drow communication links
            hEdges{a}(b) = plot([x(a,1) x(b,1)], [x(a,2) x(b,2)], 'b-');
            Robot(a).Neighbor = [Robot(a).Neighbor, b];
        end
    end
end
RPsp = -log(RP);
end

