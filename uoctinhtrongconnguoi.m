%% Chuong trinh nay lam viec voi cac con nguoi
% Tinh ra dien tich cua bon vung duoc chia tu tam cua con nguoi
% Tinh ra vec to giua tam cua con nguoi va dom sang trong con nguoi
% Dau vao :
%        box : Anh co chua mat
%        C1_iris : Toa do hang cua tam con nguoi
%        C2_iris : Toa do cot cua tam con nguoi
%        C3_iris : Ban kinh cua tam con nguoi
% Dau ra :
%        connguoi : Anh con nguoi duoc cat
%        anpha : Goc hop boi tam con nguoi va dom sang
%        area1,area2,area3,area4 : Dien tich bon vung duoc noi o tren
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi.
function [connguoi1,anpha,area1,area2] = uoctinhtrongconnguoi(box,C1_iris,C2_iris,C3_iris)
% Dau tien cat ra vung con nguoi
connguoi = box((C1_iris-C3_iris):(C1_iris+C3_iris),(C2_iris-C3_iris):(C2_iris+C3_iris),:);
connguoi = im2double(rgb2gray(connguoi));
connguoi1 = connguoi;
sizeconnguoi = size(connguoi);
square = (-1)*connguoi;
square(round(sizeconnguoi(1)/4):round(3*sizeconnguoi(1)/4),round(sizeconnguoi(1)/4):round(3*sizeconnguoi(1)/4)) = 0;
connguoi = connguoi + square;
connguoi = im2bw(connguoi,graythresh(connguoi));
[connguoi,domsang] = maxregion(connguoi);
anpha = atan2(round(sizeconnguoi(1)/2)-domsang(1),domsang(2)-round(sizeconnguoi(1)/2));
area1 = connguoi1(1:round(sizeconnguoi(1)/2),1:sizeconnguoi(1));
area2 = connguoi1(round(sizeconnguoi(1)/2):sizeconnguoi(1),1:sizeconnguoi(1));
area1 = mean(mean(area1(:)));
area2 = mean(mean(area2(:)));
anpha = anpha*180/pi;