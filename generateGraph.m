function G = generateGraph(x,rad,ro)
global enablelinks 
global hEdges TP RP RPsp

%% Initializing required Matrices%%%%%%%%%%%%%%%%%%%%%%%%%
G.NodesN = size(x,1); % Numbers of robots
G.A = zeros(G.NodesN, G.NodesN); % Adjancency Matrix
G.R = zeros(G.NodesN, G.NodesN); % Distance Matrix
% For Case 3: Rician Fading Channel (Noise Only)
G.c3RP = zeros(G.NodesN, G.NodesN);
G.c3TP = zeros(G.NodesN, G.NodesN);
G.c3RPsp = zeros(G.NodesN, G.NodesN);

%% Graph Generation%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case 3: Rician Fading Channel (Noise Only)
 for a=1:G.NodesN,
     for b=1:G.NodesN,
         dist = sqrt((x(a,1)-x(b,1))^2 + (x(a,2)-x(b,2))^2); % norm()
         G.R(a,b)=dist;
         if (a~=b)
             if dist < 5
                G.numberofpaths(a,b) = round(3 + (8-3).*rand(1,1)); %Number of Multipaths_ lam tron ve phia so thap phan,so nguyen gan nhat
                rpnoise_rician = receptionprob_rice(G.R(a,b),G.numberofpaths(a,b));
                G.c3RP(a,b) = rpnoise_rician; 
%                 G.c3TP(a,b) = (transmission_prob*(1 - (transmission_prob)))*(G.c3RP(a,b));
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

