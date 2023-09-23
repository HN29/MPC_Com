function find_neighbor(a)
% This function is used to initialize pos and draw the robot's body
global hEdges Robot x numofrobots

for j = 1:1:numofrobots
    if Robot(a).A(j) == 1
        set(hEdges{a}(j),'visible','off');
    end
    if Robot(j).A(a) == 1
        set(hEdges{j}(a),'visible','off');
    end
end

for b=1:numofrobots,
    dist = sqrt((x(a,1)-x(b,1))^2 + (x(a,2)-x(b,2))^2); %
    if (a~=b)
        if dist < 5
            numberofpaths = round(3 + (8-3).*rand(1,1));
            rpnoise_rician = receptionprob_rice(dist,numberofpaths);
            Robot(a).RP(b) = rpnoise_rician; 
        end
    end
end

for b=1:numofrobots
    if (Robot(a).RP(b) > 0.85 & a~=b)
        Robot(a).A(b) = 1;
    elseif(Robot(a).RP(b) <= 0.85)
        Robot(a).A(b)=0;
        Robot(a).RP(b) = 0;
    end
end

for b=1:size(x,1),
    if a~=b
        if Robot(a).A(b) == 1    % drow communication links
            hEdges{a}(b) = plot([x(a,1) x(b,1)], [x(a,2) x(b,2)], 'b-');
            Robot(a).Neighbor = [Robot(a).Neighbor, b];
        end
        for c=1:size(x,1)
            if c~=a && c~=b
                if Robot(a).A(c) == 1 && Robot(c).A(b) == 1
                    Robot(a).Neighbor_topo = [Robot(a).Neighbor_topo; c, b];
                    break;
                end
            end
        end
    end
end
end
