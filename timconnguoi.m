%% Ham nay se tinh ra chinh xac ban kinh cua con nguoi trong dai ban kinh
% No cung chi ra toa do tam ma no tim thay.
% Dau vao :
%       I : Anh dau vao.
%       rmin,rmax : Khoang ban kinh cho phep.
% Dau ra :
%       ci : Toa do tam cua con nguoi.
%       out : Ket qua duoc ve bang duong tron mau do, imshow de the hien
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [ci out]=timconnguoi(I,rmin,rmax)
% Ta de thang de con dieu chinh cho phu hop, mac dinh la 1.
scale = 1;
% Cac ban kinh chia cho thang.
rmin = rmin*scale;
rmax = rmax*scale;

I = im2double(I);
pimage = I;
I=imresize(I,scale);
I=imcomplement(imfill(imcomplement(I),'holes'));
% Kich thuoc cua anh,
rows = size(I,1);
cols = size(I,2);
% Tim ra vung co gia tri nguong toi nho hon 0.5
% Thuc te la dang tim cac vung mau gan den.
[X,Y] = find(I<0.6);
s = size(X,1);
% Tim tong nho nhat cac diem lan can cua cac diem co nguong duoi 0,5 o tren
for k=1:s %
    if (X(k)>rmin)&(Y(k)>rmin)&(X(k)<=(rows-rmin))&(Y(k)<(cols-rmin))
            A = I((X(k)-1):(X(k)+1),(Y(k)-1):(Y(k)+1));
            M = min(min(A));
           if (I(X(k),Y(k))~=M)
              X(k) = NaN;
              Y(k) = NaN;
           end
    end
end
% Loai di tat ca cac pixel ma co tong lan can xung quanh khong nho nhat.
v = find(isnan(X));
X(v) = [];
Y(v) = [];
% Loai di cac ung cu khong the la la vung co dai ban kinh tren.
index = find((X<=rmin)|(Y<=rmin)|(X>(rows-rmin))|(Y>(cols-rmin)));
X(index) = [];
Y(index) = []; 
N = size(X,1);
% Tao hai mang de chua cac gia trij blur cho moi ung cu trung tam va ban
% kinh tuong ung.
maxb = zeros(rows,cols);
maxrad = zeros(rows,cols);

for j=1:N
    [b,r,blur] = partiald(I,[X(j) Y(j)],rmin,rmax,'inf',600);
    maxb(X(j),Y(j)) = b;
    maxrad(X(j),Y(j)) = r;
end
[x,y] = find(maxb==max(max(maxb)));
ci = tamvabankinh(I,rmin,rmax,x,y);
% Tra ve toa do thang chia.
ci = ci/scale;
out = veduongtron(pimage,[ci(1) ci(2)],ci(3),600);