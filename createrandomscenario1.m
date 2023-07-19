function [x]=createrandomscenario1()

numofrobotobj=findobj('Tag','numofrobots');
numofrobotstr=get(numofrobotobj,'string');
numofrobots=str2num(numofrobotstr); %number of robots

numofrobotsubareaobj=findobj('Tag','numofrobotsubarea');
numofrobotsubareastr=get(numofrobotsubareaobj,'string');
numofrobotsubarea=str2num(numofrobotsubareastr); %number of robots in subarea

comrangeobj=findobj('Tag','comrange');
comrangestr=get(comrangeobj,'string');
CriticalRadius=str2num(comrangestr); %communication range of robot

Radius1=CriticalRadius*(1-1/sqrt(2));

widthobj=findobj('Tag','width');
widthstr=get(widthobj,'string');
width=str2num(widthstr); %width of area

heightobj=findobj('Tag','height');
heightstr=get(heightobj,'string');
height=str2num(heightstr); %heigth of area

%xcenter=[4.5,4.5]; %center of swarm
xcenter=[9, 9]; %center of swarm
numofsubarea=fix(numofrobots/(numofrobotsubarea+1));%number of subarea (integer part)
redundanceofrobot=mod(numofrobots,numofrobotsubarea+1);%redundance of robots
if redundanceofrobot~=0
    numofsubarea=numofsubarea+1;
end

numofsubareay=fix(sqrt(numofsubarea*height/width)); %number of subarea in coordinate y
numofsubareax=fix(numofsubarea/numofsubareay);%number of subarea in coordinate x
redundanceofarea=numofsubarea-numofsubareax*numofsubareay;%redundance of subarea
if redundanceofarea~=0
    if width>=height
        numofsubareax=numofsubareax+1;
    else
        numofsubareay=numofsubareay+1;
    end
end

theta0 = rand(numofsubarea,1)*(2*pi);
r0 = abs(Radius1*rand(numofsubarea,1)); 
xc=[r0.*cos(theta0),r0.*sin(theta0)]; % center for subarea

theta = rand(numofrobots-numofsubarea,1)*(2*pi);
R2 = CriticalRadius;
R1= Radius1;
R = sqrt((R2^2-R1^2)*rand(numofrobots-numofsubarea,1)+R1^2);
xr = [R.*cos(theta),R.*sin(theta)];

if width/2>numofsubareax/2
    xmin=xcenter(1,1)-numofsubareax/2;
else
    xmin=xcenter(1,1)-width/2;
end
if height/2>numofsubareay/2
    ymin=xcenter(1,2)-numofsubareay/2;
else
    ymin=xcenter(1,2)-height/2;
end

xd=[];
xdx=xmin;
count=1;
for i=1:numofsubareax,
    xdx=xdx+CriticalRadius;
    xdy=ymin;
    for j=1:numofsubareay,
        if count<=numofsubarea
            xdy=xdy+CriticalRadius;
            xd=[xd;[xdx,xdy]];
        else
            break;
        end
        count=count+1;
    end
end
x=xc+xd;

count=size(x,1);
for i=1:numofsubarea,
    for j=1:numofrobotsubarea,
        if count<numofrobots
            x=[x;xr((i-1)*numofrobotsubarea+j,:)+xd(i,:)];
        else
            break;
        end
        count=count+1;
    end
end