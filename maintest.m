%%
clc
clear all
ketqua = 'ketqua1\';
%% Thiet lap cac tham so cho dong video dau vao.
vid = videoinput('winvideo',1,'YUY2_320x240');
set(vid,'Returnedcolorspace','rgb');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat',Inf);
triggerconfig(vid,'manual');
vid.FrameGrabInterval = 0.5;
preview(vid);
pause(3);
Image = getsnapshot(vid);
%num_frames = input('\n Dai ca vui long nhap so luong farme :');

%start(vid);
%while(vid.FramesAcquired<=num_frames)
%    heso = [];
%    trigger(vid);
%    Image = getdata(vid,1);

%%---------------------------------------------------
% Ima = imresize(Image,0.25);
    % Tim da vung da nguoi va trung tam cua vung da do
    [face,Center,Yaveg] = tim_vungda(Image);
    % Cat da vung co chua con mat.
    %Center = 4*Center;
    [anhtrai,C] = cut_eyeleftregion(Image,face,Center);
    % Resize anh lon de thuc hien template matching cho thoi gian tinh toan
    % nhanh
    resize_anhtrai = imresize(anhtrai,0.25);
    [xtrai,ytrai] = tim_mattrai(resize_anhtrai);
    xtrai = 4*xtrai+C(1);
    ytrai = 4*ytrai+C(2);
    %try
    [boxmattrai,xtransform,ytransform] = catanh(Image,xtrai,ytrai,18,18,35,30);
    size_boxmattrai = size(boxmattrai);
    
    [eL_cL,eL_cR,C1,C2,C3,o_eye_left] = eyeleft_corner(boxmattrai);
    %% Gio sang cho mat ben phai
    [anhphai,lech] = cut_eyerightregion(Image,xtrai,ytransform,face,size_boxmattrai);
    resize_anhphai = imresize(anhphai,0.25);
    try
    [xphai1,yphai1] = tim_matphai(resize_anhphai);
    catch Me
        fprintf('Loi o doan nay\n');
        continue;
    end
    xphai = 4*xphai1+lech(1);
    yphai = 4*yphai1+lech(2);
    [boxmatphai,xrigh_transform,yrigh_transform] = catanh(Image,xphai,yphai,18,18,30,35);
    [eR_cL,eR_cR,C12,C22,C32,o_eye_right] = eyeright_corner(boxmatphai);
    [anhmieng,point1,point2] = timmieng(Image,C1+xtransform,C2+ytransform,C12+xrigh_transform,C22+yrigh_transform);
    figure,imshow(anhmieng)
    %% Ve ra cac diem can thiet
    %catch Me
    %    stop(vid);
    %    error('Loi cho nay');
    %end
    figure,
    subplot(1,2,1),
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
    hold off
    %% Ve cac diem can thiet
    subplot(1,2,2),imshow(o_eye_right)
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
    hold off
%end
%stop(vid);
%closepreview(vid);
    