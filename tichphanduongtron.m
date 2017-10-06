%% Ham tinh tich phan duong cua duong tron voi tam va ban kinh da biet
% Chuong trinh su dung phuong trinh cua Daugman dua ra
% Dau vao :
%     I : Anh dau vao da duoc xu ly.
%     C : Toa do trung tam.
%     r : Ban kinh cua duong tron.
%     n : So diem tren duong tron ma ta dinh ra.
% Dau ra :
%     L : Gia tri tich phan dau ra duoc chia cho chu vi.
% By : Nguyen Van Linh
% Siplab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [L]=tichphanduongtron(I,C,r,n)
% Goc theta duoc chia boi n canh.
theta = 2*pi/n;
% Kich thuoc cua anh I
rows = size(I,1);
cols = size(I,2);
angle = theta:theta:(2*pi);
x = C(1)-r*sin(angle);
y = C(2)+r*cos(angle);
if (any(x>=rows)|(y>=cols)|any(x<=1)|any(y<=1))
    L = 0;
    return;
end

s = 0;
%for i=1:round(n/8)
%    s = s+I(round(x(i)),round(y(i)));
%end
%for i=(round((3*n)/8)+1):round(5*n/8)
%    s = s+I(round(x(i)),round(y(i)));
%end
%for i=(round((7*n)/8)+1):n
%    s = s+I(round(x(i)),round(y(i)));
%end
%L = (2*s)/n;
for i=1:n
    s = s+I(round(x(i)),round(y(i)));
end
L = s/n;
