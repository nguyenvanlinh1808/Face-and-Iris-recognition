%% Chuong trinh chay va hien thi cac ket qua cho ve hai mat
% Xac dinh cac goc cac khoang cach cho dau vao cua mang noron.
% By : Nguyen Van Linh
% SipLab_k52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi.
clc
clear all
ketqua = 'ketqua1\';
%% Thiet lap cac tham so cho dong video dau vao.
vid = videoinput('winvideo',1,'YUY2_640x480');
set(vid,'Returnedcolorspace','rgb');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat',Inf);
triggerconfig(vid,'manual');
vid.FrameGrabInterval = 0.5;
preview(vid);
%% Thu nhan anh va bat dau xu ly.
%num_frames = input('\n Dai ca vui long nhap so luong farme :');
pause(2);

%start(vid);
%try
%while(vid.FramesAcquired<=num_frames)
    heso = [];
    %try
    %trigger(vid);
    %Image = getdata(vid,1);
    Image = getsnapshot(vid);
    figure, imshow(Image)
    figure, title(' MINH HOA KET QUA')
    %subplot(2,2,1)
    Ima = imresize(Image,0.25);
    % Tim da vung da nguoi va trung tam cua vung da do
    [face,Center,Yaveg] = tim_vungda(Image);
    % Cat da vung co chua con mat.
    imshow(face), title('Vung da khuan mat')
    [anhtrai,C] = cut_eyeleftregion(Image,face,Center);
    % Resize anh lon de thuc hien template matching cho thoi gian tinh toan
    % nhanh
    %subplot(2,2,2),
    figure, imshow(anhtrai), title('Anhtrai')
    resize_anhtrai = imresize(anhtrai,0.25);
    [xtrai,ytrai] = tim_mattrai(resize_anhtrai);
    xtrai = 4*xtrai+C(1);
    ytrai = 4*ytrai+C(2);
    try
    [boxmattrai,xtranform,ytranform] = catanh(Image,xtrai,ytrai,18,15,40,40);
    size_boxmattrai = size(boxmattrai);
    catch Me
        stop(vid);
        error('Loi cho nay');
        %vid.FramesAcquired = vid.FramesAcquired-1;
        continue;
    end
    %[eL_cL,eL_cR,C1,C2,C3,o_eye_left] = eyeleft_corner(boxmattrai);
    %catch Me
    %    vid.FramesAcquired = vid.FramesAcquired-1;
    %    continue;
    %end
    %% Gio quan tam den mat ben phai
    % Khi da biet mat ben trai, ta dua vao do de trich ra vung mat ben phai
    [anhphai,lech] = cut_eyerightregion(Image,xtrai,ytranform,face,size_boxmattrai);
    resize_anhphai = imresize(anhphai,0.25);
    try
    [xphai1,yphai1] = tim_matphai(resize_anhphai);
    catch Me
        fprintf('Loi o doan nay\n');
        continue;
    end
    xphai = 4*xphai1+lech(1);
    yphai = 4*yphai1+lech(2);
    [boxmatphai,xrigh_transform,yrigh_transform] = catanh(Image,xphai,yphai,18,15,40,40);
    %subplot(2,1,1),imshow(anhphai)
    %hold on
    %plot(C2+ytranform,C1+xtranform,'*r')
    %hold off
    %subplot(2,1,2)
    %imshow(o_eye_left)
    %hold on
    %plot(eL_cL(2),eL_cL(1),'*b')
    %plot(eL_cR(2),eL_cR(1),'*b')
    %plot(C2,C1,'*r')
    %plot(C2+C3,C1,'*b')
    %plot(C2-C3,C1,'*b')
    %plot(C2,C1+C3,'*b')
    %plot(C2,C1-C3,'*b')
    %plot([eL_cL(2) C2],[eL_cL(1) C1],'-','Color','green')
    %plot([eL_cR(2) C2],[eL_cR(1) C1],'-','Color','green')
    %hold off
    %subplot(2,2,3),imshow(anhtrai)
    %subplot(2,2,3), 
    figure, imshow(boxmattrai), title('Ket qua mat trai')
    %subplot(2,2,2),imshow(anhtrai),
    %subplot(2,2,4), 
    figure, imshow(boxmatphai), title('Ket qua mat phai')
    %vid.FramesAcquired
%end
%catch Me
    stop(vid);
%end
stop(vid);
delete(vid);
clear vid;
    
    
    
    