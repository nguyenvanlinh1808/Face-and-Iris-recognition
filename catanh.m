%% Ham cut ra vung xung quanh diem trung tam, khi biet them ca cac canh
% Dau vao :
%      I_root : Anh ban dau.
%      x,y : Toa do.
%      m1 : Khoang cat theo truc x ve ben trai
%      m2 : Khoang cat theo truc x ve ben phai
%      n1 : Khoang cat theo truc y o phia tren
%      n2 : Khoang cat theo truc y o phia duoi
% Dau ra :
%      I_sub : Anh duoc cat.
%      x1, y1 : Cac toa do lech khi chuyen ve anh goc.
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi.
function [I_sub,x1,y1] = catanh(I_root,x,y,m1,m2,n1,n2)
% Cat theo truc x ve ben trai
x1 = x-m1;
% Cat theo truc x ve ben phai
x2 = x+m2;
% Cat theo truc y len tren
y1 = y-n1;
% Cat theo truc y xuong duoi
y2 = y+n2;
cut_image = 0;
[m,n] = size(I_root);
if ((0 < x1 < m)&(0 < x2 < m)&(0 < y1 < n)&(0 < y2 <n))
    I_sub = I_root(x1:x2,y1:y2,:);
    cut_image = 1;
else
    I_sub = I_root;
    cut_image = 0;
end
if cut_image==1
    x1 = x-m1;
    y1 = y-n1;
else
    x1 = 0;
    y1 = 0;
end



