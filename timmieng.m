%% Chuong trinh cat ra vung mieng, va tinh ra toa do hai diem ngoai cung
% cua mieng.
% Dau vao :
%         Image : Anh goc
%         x1 : Toa do hang cua tam con nguoi ben trai
%         x2 : Toa do hang cua tam con nguoi ben phai
%         y1 : Toa do cot cua tam con nguoi ben trai
%         y2 : Toa do cot cua tam con nguoi ben phai
% Dau ra :
%         point_left: Toa do cua diem ngoai cung ben trai
%         point_right : Toa do cua diem ngoai cung ben phai
%         mouth : Anh mieng duoc cat.
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [mouth_cut,point]=timmieng(Image,x1,y1,x2,y2)
% Tinh khoang cach hai mat.
%distance_eyes = norm([(x2-x1),(y2-y1)]);
[m,n] = size(Image);
distance_col = y2-y1;
if ((x2+distance_col-15)>0) & ((x2+distance_col+20)<m) &((y1-5)>0)&((y2+15)<n)
    mouth = Image((x2+distance_col-15):(x2+distance_col+20),(y1-5):(y2+15),:);
else
    mouth = Image;
end
mouth_cut = mouth;
mouth = rgb2gray(mouth);
%mouth = edge(mouth,'canny');
se = strel('disk',3);
mouth = imclose(mouth,se);
th = graythresh(0.8*mouth);
mouth = edge(mouth,'canny',th);
% Luu anh
Luu = 'Luu_anh\';
file_ext='.jpg';
fodel_luuanh=dir([Luu,'*',file_ext]);
DEBUG = 0;
warning off;
if (DEBUG == 1)
    mkdir (Luu);
end
imwrite(mouth,[Luu,'Dobienmieng','.jpg']);
%mouth = im2bw(mouth);
mouth = bwmorph(mouth,'Skel',Inf);
[mouth,cenline] = maxregion(mouth);
[Xmouth,Ymouth] = find(mouth==1);
[point1,j] = min(Xmouth(:));
point = point1;
%point = [point1,Ymouth(j)];
%mouth(:,1:round(size(mouth,2)/4)) = 0;
%mouth(:,(round(3*size(mouth,2)/4)):size(mouth,2)) = 0;
i = find(Xmouth==(point1+3));
Pout = Ymouth(i);
for k=1:size(i,1)
    kcach(k) = norm([(size(mouth,1)-(point1+3)),(round(size(mouth,2)/2)-Pout(k))]);
end
[point_out,j] = min(kcach(:));
point2 = Pout(j);
point = [(point1+3),point2];


    
