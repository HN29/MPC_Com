function G = reRP(id)
global TP RP RPsp numofrobots

%% Graph Generation%%%%%%%%%%%%%%%%%%%%%%%%%%
 for j=1:numofrobots,
         dist = norm(Robot(id).x - Robot(j).x) % norm()
         if (id~=j)
             if dist < 5
                rpnoise_rician = receptionprob_rice(dist,3);
                G.c3RP(a,b) = rpnoise_rician; 
             end
         end
     end
 end
 
for a=1:G.NodesN,
    for b=1:G.NodesN,
        if (G.c3RP(a,b) > 0.6 & a~=b)
            G.A(a,b) = 1;
        elseif(G.c3RP(a,b) <= 0.6)
            G.A(a,b)=0;
            G.c3RP(a,b) = 0;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%% Communication Models %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
G.c3TP = 0.25*G.c3RP;
G.c3RPsp = -log(G.c3RP);
RP=G.c3RP
TP=G.c3TP;
RPsp = G.c3RPsp;
save('RP1.txt','RP','-ascii');
save var

