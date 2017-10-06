function varargout = Guiexam1(varargin)
% GUIEXAM1 M-file for Guiexam1.fig
%      GUIEXAM1, by itself, creates a new GUIEXAM1 or raises the existing
%      singleton*.
%
%      H = GUIEXAM1 returns the handle to a new GUIEXAM1 or the handle to
%      the existing singleton*.
%
%      GUIEXAM1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIEXAM1.M with the given input arguments.
%
%      GUIEXAM1('Property','Value',...) creates a new GUIEXAM1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Guiexam1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Guiexam1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Guiexam1

% Last Modified by GUIDE v2.5 08-Jan-2011 21:56:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Guiexam1_OpeningFcn, ...
                   'gui_OutputFcn',  @Guiexam1_OutputFcn, ...
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


% --- Executes just before Guiexam1 is made visible.
function Guiexam1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Guiexam1 (see VARARGIN)
clc
axes(handles.axes1)
handles.vid = videoinput('winvideo',1,'YUY2_640x480');
set(handles.vid,'Returnedcolorspace','rgb');
set(handles.vid,'FramesPerTrigger',2);
set(handles.vid,'TriggerRepeat',Inf);
triggerconfig(handles.vid,'manual');
handles.vid.FrameGrabInterval = 0.5;
vidRes = get(handles.vid,'VideoResolution');
nBands = get(handles.vid,'NumberOfBands');
hImage = image(zeros(vidRes(2),vidRes(1),nBands));
preview(handles.vid,hImage)
set(handles.text1,'string','Loading...');
axes(handles.axes2)
imshow(zeros(480,640))
axes(handles.axes3)
imshow(zeros(37,66))
axes(handles.axes4)
imshow(zeros(37,66))
%guidata(hObject,handles);
% Choose default command line output for Guiexam1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Guiexam1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Guiexam1_OutputFcn(hObject, eventdata, handles) 
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
%clear all
clc
global vid
global vidRes
%axes handles.axes1;
axes(handles.axes1)
handles.vid = videoinput('winvideo',1,'YUY2_640x480');
set(handles.vid,'Returnedcolorspace','rgb');
set(handles.vid,'FramesPerTrigger',1);
set(handles.vid,'TriggerRepeat',Inf);
triggerconfig(handles.vid,'manual');
handles.vid.FrameGrabInterval = 0.5;
vidRes = get(handles.vid,'VideoResolution');
nBands = get(handles.vid,'NumberOfBands');
hImage = image(zeros(vidRes(2),vidRes(1),nBands));
preview(handles.vid,hImage)
axes(handles.axes2)
imshow(zeros(480,640))
axes(handles.axes3)
imshow(zeros(37,66))
axes(handles.axes4)
imshow(zeros(37,66))
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
global vidRes
handles.I = getsnapshot(handles.vid);
[face,Center,Yaveg] = tim_vungda(handles.I);
axes(handles.axes2)
skinface = uint8(cat(3,zeros(480,640),zeros(480,640),zeros(480,640)));
for i=1:480
    for j=1:640
        if(face(i,j)==1)
            for k=1:3
                skinface(i,j,k) = handles.I(i,j,k);
            end
        end
    end
end
[anhtrai,C] = cut_eyeleftregion(handles.I,face,Center);

resize_anhtrai = imresize(anhtrai,0.25);
[xtrai,ytrai] = tim_mattrai(resize_anhtrai);
xtrai = 4*xtrai+C(1);
ytrai = 4*ytrai+C(2);
[boxmattrai,xtransform,ytransform] = catanh(handles.I,xtrai,ytrai,18,18,35,30);
    
[eL_cL,eL_cR,C1,C2,C3,o_eye_left] = eyeleft_corner(boxmattrai);
size_boxmattrai = size(boxmattrai);
[anhphai,lech] = cut_eyerightregion(handles.I,xtrai,ytransform,face,size_boxmattrai);
resize_anhphai = imresize(anhphai,0.25);
[xphai1,yphai1] = tim_matphai(resize_anhphai);
xphai = 4*xphai1+lech(1);
yphai = 4*yphai1+lech(2);
[boxmatphai,xrigh_transform,yrigh_transform] = catanh(handles.I,xphai,yphai,18,18,30,35);
[eR_cL,eR_cR,C12,C22,C32,o_eye_right] = eyeright_corner(boxmatphai);
connguoiphai = boxmatphai((C12-C32):(C12+C32),(C22-C32):(C22+C32),:);
connguoiphai = im2bw(connguoiphai,graythresh(connguoiphai));
kcach = [(C12-C1),(C22-C2)];
khoangcachhaimat = C22+yrigh_transform-C2-ytransform;
col_common = round((C22-C2)/2);
rol_common = round((C12+C1)/2);
mouth = handles.I;

eyelid_down = boxmatphai(C12:size(boxmatphai,1),(C22-C32):(C22+C32),:);
eyelid_down = edge(rgb2gray(eyelid_down),'sobel','horizontal');
[P,Q] = find(eyelid_down==1);
[x_eyelid,t] = max(P);
x_eyelid = P(t)+C12;
y_eyelid = C22;
text = strcat('Khoang cach 1 = ',num2str(x_eyelid-C12-C3),' (pixels)');
set(handles.text1,'string',text);
[anhmieng,point1,point2] = timmieng(handles.I,C1+xtransform,C2+ytransform,C12+xrigh_transform,C22+yrigh_transform);
axes(handles.axes6),imshow(anhmieng)
hold on
plot(point1(2),point1(1),'*r')
plot(point2(2),point2(1),'*r')
hold off
axes(handles.axes7)
imshow(connguoiphai)
axes(handles.axes2)
imshow(skinface)
hold on
plot(C2+ytransform,C1+xtransform,'*g');
plot(C22+yrigh_transform,C12+xrigh_transform,'*g')
line([C2+ytransform,C22+yrigh_transform],[C1+xtransform,C12+xrigh_transform],'Color','r','LineWidth',1)
hold off
axes(handles.axes3);
imshow(o_eye_left)
hold on
plot(eL_cL(2),eL_cL(1),'*b')
    plot(eL_cR(2),eL_cR(1),'*b')
    plot(C2,C1,'*r')
    plot(C2+C3,C1,'*b')
    plot(C2-C3,C1,'*b')
    plot(C2,C1+C3,'*b')
    plot(C2,C1-C3,'*b')
    plot([eL_cL(2) C2],[eL_cL(1) C1],'-','Color','red')
    plot([eL_cR(2) C2],[eL_cR(1) C1],'-','Color','red')
plot(C(1),C(2),'or');
plot(ytrai,xtrai,'*r')
plot([C2,C2],[1,size(o_eye_left,1)],'-','Color','blue')
plot([1,size(o_eye_left,2)],[C1,C1],'-','Color','blue')
hold off
axes(handles.axes4);
imshow(o_eye_right)
hold on
    plot(eR_cL(2),eR_cL(1),'*b')
    plot(eR_cR(2),eR_cR(1),'*b')
    plot(C22,C12,'*r')
    plot(C22+C32,C12,'*b')
    plot(C22-C32,C12,'*b')
    plot(C22,C12+C32,'*b')
    plot(C22,C12-C32,'*b')
    plot([eR_cL(2) C22],[eR_cL(1) C12],'-','Color','red')
    plot([eR_cR(2) C22],[eR_cR(1) C12],'-','Color','red')
    plot(y_eyelid,x_eyelid,'*g')
    plot([C22,C22],[1,size(o_eye_right,1)],'-','Color','blue')
    plot([1,size(o_eye_right,2)],[C12,C12],'-','Color','blue')
    hold off
guidata(hObject,handles);
% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[face,C] = tim_vungda(handles.I);
global vid
%I = getsnapshot(vid);
start(handles.vid);
while(handles.vid.FramesAcquired<=20)
    try
    heso = [];
    trigger(handles.vid);
    handles.I = getdata(handles.vid,1);
[face,Center,Yaveg] = tim_vungda(handles.I);
axes(handles.axes2)

[anhtrai,C] = cut_eyeleftregion(handles.I,face,Center);

resize_anhtrai = imresize(anhtrai,0.25);
[xtrai,ytrai] = tim_mattrai(resize_anhtrai);
xtrai = 4*xtrai+C(1);
ytrai = 4*ytrai+C(2);
[boxmattrai,xtransform,ytransform] = catanh(handles.I,xtrai,ytrai,18,18,35,30);
    
[eL_cL,eL_cR,C1,C2,C3,o_eye_left] = eyeleft_corner(boxmattrai);
size_boxmattrai = size(boxmattrai);
[anhphai,lech] = cut_eyerightregion(handles.I,xtrai,ytransform,face,size_boxmattrai);
resize_anhphai = imresize(anhphai,0.25);
[xphai1,yphai1] = tim_matphai(resize_anhphai);
xphai = 4*xphai1+lech(1);
yphai = 4*yphai1+lech(2);
[boxmatphai,xrigh_transform,yrigh_transform] = catanh(handles.I,xphai,yphai,18,18,30,35);
[eR_cL,eR_cR,C12,C22,C32,o_eye_right] = eyeright_corner(boxmatphai);
kcach = [(C12-C1),(C22-C2)];
khoangcachhaimat = norm(kcach);
col_common = round((C22-C2)/2);
rol_common = round((C12+C1)/2);
eyelid_down = boxmatphai(C12:size(boxmatphai,1),(C22-C32):(C22+C32),:);
eyelid_down = edge(rgb2gray(eyelid_down),'canny');
[P,Q] = find(eyelid_down==1);
[x_eyelid,t] = max(P);
x_eyelid = P(t)+C12;
y_eyelid = C22;
text = strcat('Khoang cach 1 = ',num2str(x_eyelid-C12-C3),' (pixels)');
set(handles.text1,'string',text);
axes(handles.axes5)
imshow(eyelid_down)
axes(handles.axes2)
imshow(handles.I)
hold on
plot(C2+ytransform,C1+xtransform,'*g');
plot(C22+yrigh_transform,C12+xrigh_transform,'*g')
line([C2+ytransform,C22+yrigh_transform],[C1+xtransform,C12+xrigh_transform],'Color','r','LineWidth',1)
hold off
axes(handles.axes3);
imshow(o_eye_left)
hold on
plot(eL_cL(2),eL_cL(1),'*b')
    plot(eL_cR(2),eL_cR(1),'*b')
    plot(C2,C1,'*r')
    plot(C2+C3,C1,'*b')
    plot(C2-C3,C1,'*b')
    plot(C2,C1+C3,'*b')
    plot(C2,C1-C3,'*b')
    plot([eL_cL(2) C2],[eL_cL(1) C1],'-','Color','green')
    plot([eL_cR(2) C2],[eL_cR(1) C1],'-','Color','green')
plot(C(1),C(2),'or');
plot(ytrai,xtrai,'*r')
hold off
axes(handles.axes4);
imshow(o_eye_right)
hold on
    plot(eR_cL(2),eR_cL(1),'*b')
    plot(eR_cR(2),eR_cR(1),'*b')
    plot(C22,C12,'*r')
    plot(C22+C32,C12,'*b')
    plot(C22-C32,C12,'*b')
    plot(C22,C12+C32,'*b')
    plot(C22,C12-C32,'*b')
    plot([eR_cL(2) C22],[eR_cL(1) C12],'-','Color','green')
    plot([eR_cR(2) C22],[eR_cR(1) C12],'-','Color','green')
    plot(y_eyelid,x_eyelid,'*g')
    hold off
    catch Me
        continue;
    end
    guidata(hObject,handles);
    flushdata(handles.vid,'triggers');
end
stop(handles.vid);    
guidata(hObject,handles);
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes3);
imshow(handles.I);
guidata(hObject,handles);
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
stop(vid);
clear vid;
delete(vid);
close(Guiexam1);
clear all;
close all;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        popupmenu1
str = get(hObject,'String'); 
val = get(hObject,'Value'); 
if(str2cmp(str(val),'Skin face'))
    axes(handles.axes2)
    imshow(handles.I)
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
