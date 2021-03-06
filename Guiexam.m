function varargout = Guiexam(varargin)
% GUIEXAM M-file for Guiexam.fig
%      GUIEXAM, by itself, creates a new GUIEXAM or raises the existing
%      singleton*.
%
%      H = GUIEXAM returns the handle to a new GUIEXAM or the handle to
%      the existing singleton*.
%
%      GUIEXAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIEXAM.M with the given input arguments.
%
%      GUIEXAM('Property','Value',...) creates a new GUIEXAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Guiexam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Guiexam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Guiexam

% Last Modified by GUIDE v2.5 06-Jan-2011 02:56:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Guiexam_OpeningFcn, ...
                   'gui_OutputFcn',  @Guiexam_OutputFcn, ...
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


% --- Executes just before Guiexam is made visible.
function Guiexam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Guiexam (see VARARGIN)

% Choose default command line output for Guiexam
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Guiexam wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Guiexam_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
clc
global vid
global vidRes
%axes handles.axes1;
vid = videoinput('winvideo',1,'YUY2_640x480');
set(vid,'Returnedcolorspace','rgb');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat',Inf);
triggerconfig(vid,'manual');
vid.FrameGrabInterval = 0.5;
vidRes = get(vid,'VideoResolution');
nBands = get(vid,'NumberOfBands');
hImage = image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage)
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
global vid
closepreview(vid);
global vidRes
%axes2(imshow(zeros(vidRes(2),vidRes(1))))
set(axes1,'CurrentAxes',imshow(zeros(vidRes(2),vidRes(1))))
clear vid;
pause(3);
close(Guiexam);
