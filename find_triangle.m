function find_triangle(a)
% This function is used to initialize pos and draw the robot's body
global Robot numofrobots
Robot(a).Neighbor_topo = [];
for b=1:numofrobots
    if a~=b
        for c=1:numofrobots
            if c~=a && c~=b
                if Robot(a).A(c) == 1 && Robot(c).A(b) == 1
                    Robot(a).Neighbor_topo = [Robot(a).Neighbor_topo; c, b];
                end
            end
        end
    end
end
end