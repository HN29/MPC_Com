function G = reRP(id)
global TP RP RPsp numofrobots Robot G

%% Graph Generation%%%%%%%%%%%%%%%%%%%%%%%%%%
 for j=1:numofrobots,
     if ismember(j, Robot(id).Neighbor)
         dist = norm(Robot(id).x - Robot(j).x) % norm()
         if dist < 5
            rpnoise_rician = receptionprob_rice(dist,3);
            G.c3RP(id,j) = rpnoise_rician; 
         end
     end
end
%%%%%%%%%%%%%%%%%%%%%%%%% Communication Models %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
RP=G.c3RP
TP=G.c3TP;
RPsp = G.c3RPsp;

