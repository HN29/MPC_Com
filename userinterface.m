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
global  hRobots hEdges viet_ten  thres hTargets Target Robot
enablelinks=[];
thres = 0.9;
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
viet_ten = showid(x,1);
numofrobots=size(x,1);
% setup for figure windowwidthstr
fh=handles.figure;  % Generating the global graph
hold on;
grid off;
for a=1:size(x,1),
    RobotInit(a);
end
for a=1:size(x,1),
    targetInit(a);
    hRobots(a) = plot(x(a,1), x(a,2), 'ro'); %draw robots
    hTargets(a) = plot(Target(a).x(1), Target(a).x(2), 'r.'); %draw robots
    find_neighbor(a);
end
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
global x G numofrobots enablelinks Robot Target banchor RP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
banchor = [];
while(1)
    Robot(4).target = Target(4).x;
    find_neighbor(4);
    BC(4);
%     predict(4);
%    disp("end");
    pause(0);
end
