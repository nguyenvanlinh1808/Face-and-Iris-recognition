function varargout = Guitest_dem_9_10(varargin)
% GUITEST_DEM_9_10 M-file for Guitest_dem_9_10.fig
%      GUITEST_DEM_9_10, by itself, creates a new GUITEST_DEM_9_10 or raises the existing
%      singleton*.
%
%      H = GUITEST_DEM_9_10 returns the handle to a new GUITEST_DEM_9_10 or the handle to
%      the existing singleton*.
%
%      GUITEST_DEM_9_10('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEST_DEM_9_10.M with the given input arguments.
%
%      GUITEST_DEM_9_10('Property','Value',...) creates a new GUITEST_DEM_9_10 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Guitest_dem_9_10_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Guitest_dem_9_10_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Guitest_dem_9_10

% Last Modified by GUIDE v2.5 11-Jan-2011 14:01:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Guitest_dem_9_10_OpeningFcn, ...
                   'gui_OutputFcn',  @Guitest_dem_9_10_OutputFcn, ...
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


% --- Executes just before Guitest_dem_9_10 is made visible.
function Guitest_dem_9_10_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Guitest_dem_9_10 (see VARARGIN)

% Choose default command line output for Guitest_dem_9_10
clc;
% Thiet lap mac dinh cac thong so cho luong video
% Hien thi video
axes(handles.axes1);
handles.vid = videoinput('winvideo',1,'YUY2_640x480');
set(handles.vid,'Returnedcolorspace','rgb');
set(handles.vid,'FramesPerTrigger',1);
set(handles.vid,'TriggerRepeat',Inf);
triggerconfig(handles.vid,'manual');
handles.vid.FrameGrabInterval = 0.5;
vidRes = get(handles.vid,'VideoResolution');
nBands = get(handles.vid,'NumberOfBands');
hImage = image(zeros(vidRes(2),vidRes(1),nBands));
preview(handles.vid,hImage);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Guitest_dem_9_10 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Guitest_dem_9_10_OutputFcn(hObject, eventdata, handles) 
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
clc
axes(handles.axes1);
handles.vid = videoinput('winvideo',1,'YUY2_640x480');
set(handles.vid,'Returnedcolorspace','rgb');
set(handles.vid,'FramesPerTrigger',1);
set(handles.vid,'TriggerRepeat',Inf);
triggerconfig(handles.vid,'manual');
handles.vid.FrameGrabInterval = 0.5;
vidRes = get(handles.vid,'VideoResolution');
nBands = get(handles.vid,'NumberOfBands');
hImage = image(zeros(vidRes(2),vidRes(1),nBands));
preview(handles.vid,hImage);
guidata(hObject,handles);
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Chup anh va tinh toan cac khoang cach can thiet
global vid
global vidRes
handles.I = getsnapshot(handles.vid);
%% Lam viec voi vung mat trai
% Tim da vung da
[face,Center,Yaveg,Sskin] = tim_vungda(handles.I);
% Ve da vung da trong anh chinh
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
% Cat ra vung co chua mat trai
[anhtrai,C_trai] = cut_eyeleftregion(handles.I,face,Center);
%imwrite(anhtrai,'D:\Cac thu nghiem\Thu nghiem 12\anhtrai.jpg');
% Resize anh trai de giam thoi gian tinh toan
resize_anhtrai = imresize(anhtrai,0.25);
% Tim ra diem co he so chap voi mau la lon nhat
[xtrai,ytrai] = tim_mattrai(resize_anhtrai);
xtrai = 4*xtrai + C_trai(1);
ytrai = 4*ytrai + C_trai(2);
% Cat ra chinh xac vung mat trai
[boxmattrai,xlefttransform,ylefttransform] = catanh(handles.I,xtrai,ytrai,15,15,35,27);
sizeboxmattrai = size(boxmattrai);
% Tim ra vi tri tam con nguoi va cac goc mat
[eyeleft_cornerleft,eyeleft_cornerright,C1_left,C2_left,C3_left,o_eye_left] = eyeleft_corner(boxmattrai);
%% Lam viec voi vung mat ben phai
% Bat dau lam viec voi mat ben phai, khi da biet mat ben trai
[anhphai,C_phai] = cut_eyerightregion(handles.I,xtrai,ylefttransform,face,sizeboxmattrai);
% Resize anh phai de giam thoi gian tinh toan
resize_anhphai = imresize(anhphai,0.25);
[xphai,yphai] = tim_matphai(resize_anhphai);
xphai = 4*xphai + C_phai(1);
yphai = 4*yphai + C_phai(2);
% Cat ra chinh xac vung mat phai
[boxmatphai,xrighttransform,yrighttransform] = catanh(handles.I,xphai,yphai,15,15,27,35);
% Tim ra vi tri tam con nguoi va cac goc mat
[eyeright_cornerleft,eyeright_cornerright,C1_right,C2_right,C3_right,o_eye_right] = eyeright_corner(boxmatphai,C3_left);
%% Cho nay lay ra cac diem con nguoi ben trai va ben phai
% Cho con nguoi ben trai
[connguoitrai,anphaleft,area1left,area2left] = uoctinhtrongconnguoi(o_eye_left,C1_left,C2_left,C3_left);
%anpha1 = strcat('Anpha1 = ', num2str(anphaleft),' (Do)');
%set(handles.text2,'string',anpha1);
axes(handles.axes6)
imshow(connguoitrai)
% Cho con nguoi ben phai
[connguoiphai,anpharight,area1right,area2right] = uoctinhtrongconnguoi(o_eye_right,C1_right,C2_right,C3_right);
%anpha2 = strcat('Anpha2 = ', num2str(anpharight),' (Do)');
%set(handles.text8,'string',anpha2);
axes(handles.axes7)
imshow(connguoiphai)
%% Tim ra mieng :
[mieng,point] = timmieng(handles.I,C1_left+xlefttransform,C2_left+ylefttransform,C1_right+xrighttransform,C2_right+yrighttransform);
imwrite(mieng,'D:\Mieng.jpg');
axes(handles.axes5)
imshow(mieng)
hold on
plot(point(2),point(1),'*r');
hold off

%% Bat dau ve cac diem can thiet cho hien thi
%% Ve cac diem cho mat trai
axes(handles.axes2)
imshow(o_eye_left)
hold on
plot(eyeleft_cornerleft(2),eyeleft_cornerleft(1),'*g');
plot(eyeleft_cornerright(2),eyeleft_cornerright(1),'*g');
plot(C2_left,C1_left,'*r');
plot(C2_left+C3_left,C1_left,'*b');
plot(C2_left-C3_left,C1_left,'*b');
plot(C2_left,C1_left+C3_left,'*b');
plot(C2_left,C1_left-C3_left,'*b');
plot([eyeleft_cornerleft(2),C2_left],[eyeleft_cornerleft(1),C1_left],'-','Color','red');
plot([eyeleft_cornerright(2),C2_left],[eyeleft_cornerright(1),C1_left],'-','Color','red');
plot([C2_left,C2_left],[1,size(o_eye_left,1)],'-','Color','blue');
plot([1,size(o_eye_left,2)],[C1_left,C1_left],'-','Color','blue');
hold off
%% Ve cac diem cho mat phai
axes(handles.axes3)
imshow(o_eye_right)
hold on
plot(eyeright_cornerleft(2),eyeright_cornerleft(1),'*g');
plot(eyeright_cornerright(2),eyeright_cornerright(1),'*g');
plot(C2_right,C1_right,'*r');
plot(C2_right+C3_right,C1_right,'*b');
plot(C2_right-C3_right,C1_right,'*b');
plot(C2_right,C1_right+C3_right,'*b');
plot(C2_right,C1_right-C3_right,'*b');
plot([eyeright_cornerleft(2),C2_right],[eyeright_cornerleft(1),C1_right],'-','Color','red');
plot([eyeright_cornerright(2),C2_right],[eyeright_cornerright(1),C1_right],'-','Color','red');
plot([C2_right,C2_right],[1,size(o_eye_right,1)],'-','Color','blue');
plot([1,size(o_eye_right,2)],[C1_right,C1_right],'-','Color','blue');
hold off
%% Hien thi face
axes(handles.axes4)
imshow(face)
hold on
plot(yphai,xphai,'*r');
hold off
guidata(hObject,handles);
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Chuong trinh chay chinh:
clc;
global vid
start(handles.vid);
while(handles.vid.FramesAcquired<=20)
    try
        heso = [];
        trigger(handles.vid);
        handles.I = getdata(handles.vid,1);
        %% Lam viec voi vung mat trai
        % Tim da vung da
        [face,Center,Yaveg] = tim_vungda(handles.I);
        % Cat ra vung co chua mat trai
        [anhtrai,C_trai] = cut_eyeleftregion(handles.I,face,Center);
        % Resize anh trai de giam thoi gian tinh toan
        resize_anhtrai = imresize(anhtrai,0.25);
        % Tim ra diem co he so chap voi mau la lon nhat
        [xtrai,ytrai] = tim_mattrai(resize_anhtrai);
        xtrai = 4*xtrai + C_trai(1);
        ytrai = 4*ytrai + C_trai(2);
        % Cat ra chinh xac vung mat trai
        [boxmattrai,xlefttrasform,ylefttransform] = catanh(handles.I,xtrai,ytrai,18,18,35,30);
        sizeboxmattrai = size(boxmattrai);
        % Tim ra vi tri tam con nguoi va cac goc mat
        [eyeleft_cornerleft,eyeleft_cornerright,C1_left,C2_left,C3_left,o_eye_left] = eyeleft_corner(boxmattrai);
        %% Lam viec voi vung mat ben phai
        % Bat dau lam viec voi mat ben phai, khi da biet mat ben trai
        [anhphai,C_phai] = cut_eyerightregion(handles.I,xtrai,ylefttransform,face,sizeboxmattrai);
        % Resize anh phai de giam thoi gian tinh toan
        resize_anhphai = imresize(anhphai,0.25);
        [xphai,yphai] = tim_matphai(resize_anhphai);
        xphai = 4*xphai + C_phai(1);
        yphai = 4*yphai + C_phai(2);
        % Cat ra chinh xac vung mat phai
        [boxmatphai,xrighttransform,yrighttransform] = catanh(handles.I,xphai,yphai,18,18,30,35);
        % Tim ra vi tri tam con nguoi va cac goc mat
        [eyeright_cornerleft,eyeright_cornerright,C1_right,C2_right,C3_right,o_eye_right] = eyeright_corner(boxmatphai,C3_left);
        %% Bat dau ve cac diem can thiet cho hien thi
        %% Ve cac diem cho mat trai
        axes(handles.axes2)
        imshow(o_eye_left)
        hold on
        plot(eyeleft_cornerleft(2),eyeleft_cornerleft(1),'*g');
        plot(eyeleft_cornerright(2),eyeleft_cornerright(1),'*g');
        plot(C2_left,C1_left,'*r');
        plot(C2_left+C3_left,C1_left,'*b');
        plot(C2_left-C3_left,C1_left,'*b');
        plot(C2_left,C1_left+C3_left,'*b');
        plot(C2_left,C1_left-C3_left,'*b');
        plot([eyeleft_cornerleft(2),C2_left],[eyeleft_cornerleft(1),C1_left],'-','Color','red');
        plot([eyeleft_cornerright(2),C2_left],[eyeleft_cornerright(1),C1_left],'-','Color','red');
        plot([C2_left,C2_left],[1,size(o_eye_left,1)],'-','Color','blue');
        plot([1,size(o_eye_left,2)],[C1_left,C1_left],'-','Color','blue');
        hold off
        %% Ve cac diem cho mat phai
        axes(handles.axes3)
        imshow(o_eye_right)
        hold on
        plot(eyeright_cornerleft(2),eyeright_cornerleft(1),'*g');
        plot(eyeright_cornerright(2),eyeright_cornerright(1),'*g');
        plot(C2_right,C1_right,'*r');
        plot(C2_right+C3_right,C1_right,'*b');
        plot(C2_right-C3_right,C1_right,'*b');
        plot(C2_right,C1_right+C3_right,'*b');
        plot(C2_right,C1_right-C3_right,'*b');
        plot([eyeright_cornerleft(2),C2_right],[eyeright_cornerleft(1),C1_right],'-','Color','red');
        plot([eyeright_cornerright(2),C2_right],[eyeright_cornerright(1),C1_right],'-','Color','red');
        plot([C2_right,C2_right],[1,size(o_eye_right,1)],'-','Color','blue');
        plot([1,size(o_eye_right,2)],[C1_right,C1_right],'-','Color','blue');
        hold off
        %% Hien thi face
        %axes(handles.axes4)
        %imshow(face)
    catch ME
        continue;
    end
    %flushdata(handles.vid,'triggers');
    %guidata(hObject,handles);
end
stop(handles.vid);
guidata(hObject,handles);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg('Dai ca co muon tiep tuc khong a?','Question','Co','Thoi di','Thoi di');
switch selection
    case 'Thoi di'
        clc;
        pause(0.5);
        clear handles.vid;
        close(Guitest_dem_9_10);
        close all;
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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
