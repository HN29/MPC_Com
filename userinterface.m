function varargout = userinterface(varargin)
% USERINTERFACE MATLAB code for userinterface.fig
%      USERINTERFACE, by itself, creates a new USERINTERFACE or raises the existing
%      singleton*.
%
%      H = USERINTERFACE returns the handle to a new USERINTERFACE or the
%      handle to
%      the existing singleton*.
%
%      USERINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USERINTERFACE.M with the given input arguments.
%
%      USERINTERFACE('Property','Value',...) creates a new USERINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before userinterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to userinterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help userinterface

% Last Modified by GUIDE v2.5 22-Jun-2023 14:14:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @userinterface_OpeningFcn, ...
                   'gui_OutputFcn',  @userinterface_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before userinterface is made visible.
function userinterface_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to userinterface (see VARARGIN)

% Choose default command line output for userinterface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes userinterface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = userinterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonscenario.
function pushbuttonscenario_Callback(hObject, eventdata, handles)
global x G CriticalRadius ro numofrobots enablelinks
global  hRobots hEdges viet_ten  thres hTargets Target Robot RP
enablelinks=[];
thres = 0.9;
RP = zeros(numofrobots,numofrobots);
cla(handles.figure);
alpha=[-pi:pi/10:pi];  
comrangeobj=findobj('Tag','comrange');
comrangestr=get(comrangeobj,'string');
CriticalRadius=str2num(comrangestr);
ro=0.8*CriticalRadius;
x=createrandomscenario1(); % goi ham createrandomscenario1
% fileID = fopen('scenarioX.txt','r');
% formatSpec = '%f';
% A = fscanf(fileID,formatSpec);
% fclose(fileID);
% fileID = fopen('scenarioY.txt','r');
% formatSpec = '%f';
% B = fscanf(fileID,formatSpec);
% fclose(fileID);
% x = [A,B];
% G=generateGraph(x,CriticalRadius,ro);

numofrobots=size(x,1);
% setup for figure windowwidthstr
fh=handles.figure;  % Generating the global graph
hold on;
grid off;
% Robot(1).x  = [15, 17];
% Robot(2).x  = [17.4642568162135,19.1507837665802];
% Robot(3).x  = [20.4638161167498,19.0844000304649];
% Robot(4).x  = [22.3056384222507,20.8366994405982];
% Robot(5).x  = [24.8375965968732,22.1482174797537];
% Robot(7).x  = [21.1332941170788,26.0857240533298];
% Robot(8).x  = [22.7885399259971,28.5602161262768];
% Robot(6).x  = [22.1267811755082,23.6042020669595];
% Robot(9).x  = [17.1799899423913,22.8767018979164];
% Robot(10).x  = [18.6288634007536,25.5637069768154];
% Robot(11).x  = [17.6084891516628,28.1551209078760];
% Robot(12).x  = [15.2698965599490,29.5745082737879];
% Robot(13).x  = [19.8346228135871,29.6149185828548];
% Robot(14).x  = [21.1878429237510,28.8507725530829];
% Robot(15).x  = [24.1795783927349,30.1381347073212];
% x(1,:) = Robot(1).x;
% x(2,:) = Robot(2).x;
% x(3,:) = Robot(3).x;
% x(4,:) = Robot(4).x;
% x(5,:) = Robot(5).x;
% x(6,:) = Robot(6).x;
% x(7,:) = Robot(7).x;
% x(8,:) = Robot(8).x;
% x(9,:) = Robot(9).x;
% x(10,:) = Robot(10).x;
% x(11,:) = Robot(11).x;
% x(12,:) = Robot(12).x;
% x(13,:) = Robot(13).x;
% x(14,:) = Robot(14).x;
% x(15,:) = Robot(15).x;
viet_ten = showid(x,1);
for a=1:size(x,1),
    RobotInit(a);
end
for a=1:numofrobots,
    targetInit(a);
    hRobots(a) = plot(x(a,1), x(a,2), 'ro'); %draw robots
    if a <= 15
        hTargets(a) = plot(Target(a).x(1), Target(a).x(2), 'r.'); %draw robots
    end
end
Init_network();
% insert obstacles with single click, robots with double click
set(fh,'ButtonDownFcn',@clickcallback);

function pushbuttonclear_Callback(hObject, eventdata, handles)
cla(handles.figure);
clear global
clear all;
clc;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x numofrobots Robot Target banchor RP RPsp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
banchor = [];
idx = 1;
stt = "No";
step =1;
while(1)
    Robot(idx).target = Target(idx).x;
    Robot(idx).status = "move goal";
    if norm(Robot(idx).x-Target(idx).x) < 0.1
        Robot(idx).status = "lanmark";
        Robot(idx).V = [0 0];
        idx = idx + 1;
        Robot(idx).status = "move goal";
    end
    N_f =[];
    N_a =[];
    for temp = 1:numofrobots
        find_neighbor(temp);
    end
    for temp = 1:numofrobots
        find_triangle(temp);
        if (Robot(temp).status == "free" || Robot(temp).status == "anchor" || Robot(temp).status == "Support")
            Robot(temp).status = "free";
            if size(Robot(temp).Neighbor,2) ~= 1
                for neighbor_idx = Robot(temp).Neighbor
                    if ~ismember(neighbor_idx, Robot(temp).Neighbor_topo(:,2))
                        Robot(temp).status = "anchor";
                    end
                end
            end
        end
        Robot(temp).status;
        if Robot(temp).status == "free"
            N_f = [N_f, temp];
        else
            N_a = [N_a, temp];
        end
    end
    for id = 1:numofrobots
        if id == idx
            Robot(id).status = "move goal";
        end
        if Robot(id).status == "move goal"
            find_triangle(id);
            dis_min = 999;
            id_min = id;
            for id_temp = 1:numofrobots
                distance = norm(Robot(id_temp).x - Target(id).x);
                if dis_min > distance
                    dis_min = distance;
                    id_min = id_temp;
                end
            end
            path = [];
            path = dijkstra(RP,id,id_min);
            path = path(path~=id);
            if size(path,2) > 0
                Robot(id).target = Robot(path(size(path,2))).x;
            else
                Robot(id).target = Target(id).x;
                distance_sample = norm(Robot(id).x_sample(1)-Robot(id).x_sample(size(Robot(id).x_sample,1)));
                if distance_sample < 1
                        Robot(id).help = "Help";
                        dis_min = 999;
                        if size(N_f,2) > 0
                            sp = N_f(1);
                            for sp_temp = N_f
                                distance = norm(Robot(sp_temp).x - Robot(id).x);
                                if dis_min > distance
                                    dis_min = distance;
                                    sp = sp_temp;
                                end
                            end
                            if sp ~= 0 
                                if Robot(id).support ~= 0
                                    Robot(Robot(id).support).status = "free";
                                    Robot(Robot(id).support).minimize = 0;
                                end
                                Robot(id).support = sp;
                                Robot(Robot(id).support).status = "Support";
                                Robot(Robot(id).support).minimize = id;
                            end
                        end
                else
                    Robot(id).help = "No";
                    if Robot(id).support ~= 0
                        Robot(Robot(id).support).status = "free";
                        Robot(Robot(id).support).minimize = 0;
                    end
                end
            end
            BC(id);
        elseif Robot(id).status == "lanmark"
            if Robot(id).support ~= 0
                Robot(Robot(id).support).status = "free";
                Robot(Robot(id).support).minimize = 0;
            end
            find_triangle(id);
        elseif Robot(id).status == "Support"
%             step = step + 1
%             id
            find_triangle(id);
            path = [];
            path = dijkstra(RP,id,Robot(id).minimize);
            path = path(path~=id);
            if size(path,2) > 0
                Robot(id).target = Robot(path(size(path,2))).x;
            else
                Robot(id).target = Robot(Robot(id).minimize).x;
            end        
            BC(id);
        else
            find_triangle(id);
            BC(id);
        end
    end
    pause(0);
end


