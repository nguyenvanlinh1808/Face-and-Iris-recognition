clc;
clear;
ketqua='ketqua1\';
%% Thiet Lap video:

vid = videoinput('winvideo',1,'YUY2_640x480');
set(vid,'Returnedcolorspace','rgb');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat',Inf);
%set(src,'FrameRate','30');
triggerconfig(vid,'manual');
vid.FrameGrabInterval = 5;
vid_src = getselectedsource(vid);
set(vid_src,'Tag','motion detection setup');

load row_cut
load col_eyes

%% Bat dau
%try
    num_frames = input('\n So luong frame :');
    pause(1);
    start(vid);
    while(vid.FramesAcquired <= num_frames)
        heso = [];
        trigger(vid);
        Image = getdata(vid,1);
        Ima = imresize(Image,0.25);
        %% Tim ra mat trai ( diem giua long den, va cac duong bao long den)
        % Tim ra vung da khuan mat de tang do chinh xac va tang thoi gian
        % xu ly duoc nhan hon
        [face,Centre] = skin_face(Image);
        if (((Centre(1)-150)>1 & (Centre(2)-150)>1))
            Anhtrai=Image((Centre(2)-150):(Centre(2)+10),(Centre(1)-150):(Centre(1)+10),:);
        else
            Anhtrai=Image;
        end
        
        Resize_anhtrai = imresize(Anhtrai,0.25);
        
        % Thuc hien viec tim diem chap lon nhat
        
        [x_trai,y_trai] = tim_mattrai(Resize_anhtrai);
        x_trai = x_trai+Centre(2)-150;
        y_trai = y_trai+Centre(1)-150;
        
        % Cat ra chinh xac vung chua mat trai
        [box_mattrai,x1,y1] = imcut(Image,x_trai,y_trai,23,15,34,31);
        
        % Thuc hien viec tim diem giua long den:
        
        [C_eye1 C_eye2 connguoi_trai] = tim_diemgiualongden(box_mattrai);
        
        %% Tim ra mat phai ( diem giua long den, va duong bao long den)
        % Thuc hien viec tim diem chap lon nhat
        
        [x_phai,y_phai,I_sub] = tim_matphai(Ima,x_trai,y_trai,row_cut,col_eyes);
        
        % Cat ra chinh xac vung chua mat phai
        
        [box_matphai,x3,y3] = imcut(Image,x_phai,y_phai,23,15,34,31);
        
        % Thuc hien viec tim diem giua long den
        
        [C_eye3 C_eye4 connguoi_phai] = tim_diemgiualongden(box_matphai);

        %% Ve cac diem can thiet de kiem tra ket qua
        % Kich thuoc cua hop chua mat
        
        size_r=round(size(box_mattrai,1)/2);size_c=round(size(box_mattrai,2)/2);
        % Anh goc voi cac toa do duoc chap voi mau co gia tri lon nhat
        subplot(331),imshow(Image), hold on
        plot(y_trai,x_trai,'g*');
        plot(y_phai,x_phai,'g*');hold off; title('Anh Goc');
        
        % Hop chua mat trai, bao gom ve ca diem chinh giua long den
        subplot(332),imshow(box_mattrai),hold on
        plot(C_eye1,C_eye2,'r*');
        plot([size_c size_c],[1 size(box_mattrai,1)],'-','Color','green');
        plot([1 size(box_mattrai,2)],[size_r size_r],'-','Color','red');
        hold off; title(' Diem giua con nguoi trai')
        
        % Hop chua mat phai, bao gom ve ca diem chinh giua long den
        subplot(333),imshow(box_matphai),hold on
        plot(C_eye3,C_eye4,'r*');
        plot([size_c size_c],[1 size(box_mattrai,1)],'-','Color','green');
        plot([1 size(box_mattrai,2)],[size_r size_r],'-','Color','red');
        hold off; title('Diem giua con nguoi phai');
        
        % Hop chua mat trai, bao gom ca duong bao long den
        subplot(334),imshow(connguoi_trai)
        hold on 
        plot([size_c size_c],[1 size(box_mattrai,1)],'-','Color','green');
        plot([1 size(box_mattrai,2)],[size_r size_r],'-','Color','red');
        hold off; title(' Long den trai');
        
        % Hop chua mat phai, bao gom ca duong bao long den
        subplot(335),imshow(connguoi_phai)
        hold on
        plot([size_c size_c],[1 size(box_mattrai,1)],'-','Color','green');
        plot([1 size(box_mattrai,2)],[size_r size_r],'-','Color','red');
        hold off; title(' Long den phai');
        
        % Vung mat
        %subplot(337),imshow(f_eyeleft);
        %subplot(338),imshow(f_eyeright);
        % Vung da mat
        subplot(339),imshow(face)
    end
%catch ME
%    stop(vid)
%    fprintf(' \n Loi o phan nhan ra mat trai... \n Mong dai ca xem lai.\n');
%    close all
%end
stop(vid);
delete(vid)
clear vid
%close all
