function [row_cut col_eyes]=taomau3()
%% Xoa man hinh, xoa workspace
clc
clear
%% Khai bao cac fodel cho viec thuc hien chuong trinh:
tem_mattrai='mau_mat_trai\';
tem_matphai='mau_mat_phai\';
tem_mieng1='mau_mieng_1\';
tem_mieng2='mau_mieng_2\';
mat_trai='mattrai\';
mat_phai='matphai\';
ketqua='ketqua\';
file_ext='.jpg';
% Duong dan den cac fodel:
fodel_mattrai=dir([tem_mattrai,'*',file_ext]);
fodel_matphai=dir([tem_matphai,'*',file_ext]);
fodel_mieng1=dir([tem_mieng1,'*',file_ext]);
fodel_mieng2=dir([tem_mieng2,'*',file_ext]);
% So luong mau trong cac fodel:
%soluong_mattrai=size(fodel_mattrai,1);
%soluong_matphai=size(fodel_matphai,1);
%soluong_mieng1=size(fodel_mieng1,1);
%soluong_mieng2=size(fodel_mieng2,1);
%% Thiet lap cho thu nhan anh:
vid=videoinput('winvideo',1,'YUY2_160x120');
set(vid,'Returnedcolorspace','rgb');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat',Inf);
triggerconfig(vid,'manual');
vid.FrameGrabInterval = 5;
vid_src = getselectedsource(vid);
set(vid_src,'Tag','motion detection setup');

%% Thuc hien lap cac thong so mau:
MAU=cell(4,[]);out_MAU=cell(1,[]);
out_0=0;out_30=30;out_45=45;
preview(vid);
pause(3);
DEBUG = 0;
warning off;
delete ([tem_mattrai,'*.*']);
delete ([tem_matphai,'*.*']);
delete ([tem_mieng1,'*.*']);
delete ([tem_mieng2,'*.*']);
if (DEBUG == 1)
    mkdir (tem_mattrai);
    mkdir (tem_matphai);
    mkdir (tem_mieng1);
    mkdir (tem_mieng2);
end
row_eyes=[];
row_mouth=[];
col_eyes=[];
num=input('So luong mau:')
for i=1:num
    %Chup mot buc anh:
    Imag=getsnapshot(vid);
    Image=im2double(Imag);
    %Lay mau mat trai:
    figure,imshow(Image),title('CLICK CHUOT VAO CON NGUOI MAT TRAI');
    p_select=impoint(gca,[]);
    tam_mattrai=round(getPosition(p_select));
    mattrai=Image((tam_mattrai(2)-5):(tam_mattrai(2)+4),(tam_mattrai(1)-7):(tam_mattrai(1)+8),1:3);
    imwrite(mattrai,[tem_mattrai,'Mat_trai',int2str(i),'.jpg']);
    pause(0.5);
    %% Lay mau mat phai:
    title('CLICK CHUOT VAO CON NGUOI MAT PHAI');
    p_select=impoint(gca,[]);
    tam_matphai=round(getPosition(p_select));
    matphai=Image((tam_matphai(2)-5):(tam_matphai(2)+4),(tam_matphai(1)-7):(tam_matphai(1)+8),1:3);
    imwrite(matphai,[tem_matphai,'Mat_phai',int2str(i),'.jpg']);
     %% Tinh cac khoang cach can thiet:
         row=round((tam_mattrai(2)+tam_matphai(2))/2);
         row_eyes=[row_eyes row]; % Hang trung binh cua hai mat
         col=round((tam_matphai(1)-tam_mattrai(1))/2);
         col_eyes=[col_eyes col];
         pause(0.5);
    
    %% Lay mau mieng 1:
    title('CLICK CHUOT VAO MIENG BEN TRAI');
    p_select=impoint(gca,[]);
    tam_mieng1=round(getPosition(p_select));
    mieng1=Image((tam_mieng1(2)-5):(tam_mieng1(2)+4),(tam_mieng1(1)-7):(tam_mieng1(1)+8),1:3);
    imwrite(mieng1,[tem_mieng1,'Mieng1',int2str(i),'.jpg']);
    pause(0.5);
    %% Lay mau mieng 2:
    title('CLICK CHUOT VAO MIENG BEN PHAI');
    p_select=impoint(gca,[]);
    tam_mieng2=round(getPosition(p_select));
    mieng2=Image((tam_mieng2(2)-5):(tam_mieng2(2)+4),(tam_mieng2(1)-7):(tam_mieng2(1)+8),1:3);
    imwrite(mieng2,[tem_mieng2,'Mieng2',int2str(i),'.jpg']);
    %% Tinh cac khoang cach can thiet:
         row=round((tam_mieng1(2)+tam_mieng2(2))/2);
         row_mouth=[row_mouth row];
         row_cut=row_mouth-row_eyes;
         pause(0.5);
         close all
         point1 = find_angle([tam_mattrai(1) tam_mattrai(2)],[tam_matphai(1) tam_matphai(2)],0);
         point2 = find_angle([tam_mattrai(1) tam_mattrai(2)],[tam_mieng1(1) tam_mieng1(2)],0);
         point3 = find_angle([tam_matphai(1) tam_matphai(2)],[tam_mieng2(1) tam_mieng2(2)],0);
         point4 = find_angle([tam_mieng1(1) tam_mieng1(2)],[tam_mieng2(1) tam_mieng2(2)],0);
         point5 = find_angle([tam_mattrai(1) tam_mattrai(2)],[tam_matphai(1) tam_matphai(2)],1);
         point6 = find_angle([tam_mattrai(1) tam_mattrai(2)],[tam_mieng1(1) tam_mieng1(2)],1);
         point7 = find_angle([tam_matphai(1) tam_matphai(2)],[tam_mieng2(1) tam_mieng2(2)],1);
         point8 = find_angle([tam_mieng1(1) tam_mieng1(2)],[tam_mieng2(1) tam_mieng2(2)],1);
    MAU{1,end+1}=point1; MAU{2,end}=point2;
    MAU{3,end}=point3;   MAU{4,end}=point4;
    MAU{5,end}=point5;   MAU{6,end}=point6;
    MAU{7,end}=point7;   MAU{8,end}=point8;
   
end
row_cut=max(row_cut(:));
col_eyes=max(col_eyes(:));
closepreview(vid);
matrix_mau=cell2mat(MAU);
save row_cut row_cut;
save matrix_mau matrix_mau;
save col_eyes col_eyes
%matrix_out_mau=cell2mat(out_MAU)
%delete(vid);
%clear vid;
