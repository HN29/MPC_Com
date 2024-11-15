function Init_network()
% This function is used to initialize pos and draw the robot's body
global hEdges Robot x numofrobots RP
for a = 1:1:numofrobots
    for b = 1:1:numofrobots
        if Robot(a).A(b) == 1
            set(hEdges{a}(b),'visible','off');
        end
        Robot(a).RP(b) = 0;
        dist = sqrt((x(a,1)-x(b,1))^2 + (x(a,2)-x(b,2))^2); %
        if (a~=b)
            if dist < 5
                numberofpaths = round(3 + (8-3).*rand(1,1));
                rpnoise_rician = receptionprob_rice(dist,numberofpaths);
                Robot(a).RP(b) = rpnoise_rician;
                RP(a,b) = dist;
            end
        else
            RP(a,b) = 0;
        end
        if (Robot(a).RP(b) > 0.88 & a~=b)
            Robot(a).A(b) = 1;
        elseif(Robot(a).RP(b) <= 0.88)
            Robot(a).A(b)=0;
            Robot(a).RP(b) = 0;
            RP(a,b) = 0;
        end
    end
end

Robot(a).Neighbor = [];
Robot(a).Neighbor_topo = [];
for a = 1:numofrobots
    for b=1:numofrobots
        if a~=b
            if Robot(a).A(b) == 1    % drow communication links
                hEdges{a}(b) = plot([x(a,1) x(b,1)], [x(a,2) x(b,2)], 'b-');
                Robot(a).Neighbor = [Robot(a).Neighbor, b];
            end
        end
    end
end
RPsp = -log(RP);
end

