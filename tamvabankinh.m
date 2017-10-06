%% Ham nay tim tam va ban kinh, dua vao phuong trinh cua Daugman.
% Ham se tim ra ban kinh trong khoang rmin-->rmax,
% bang cach lai cho tam chay trong 100(10*10) diem lan can xung quanh.
% Dau vao :
%       im : Anh dau vao.
%       rmin, rmax : Ban kinh lon nhat nho nhat.
%       x,y : Cac toa do trung tam.
% Dau ra :
%       [cp] : La mot vecto chua toa do trung tam va ban kinh.
% By : Nguyen Van Linh
% SipLab_k52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [cp]=tamvabankinh(im,rmin,rmax,x,y)
% Kich thuoc cua anh vao.
rows = size(im,1);
cols = size(im,2);
%sigma = 0.5;
%R = rmin:rmax;
maxrad = zeros(rows,cols);
maxb = zeros(rows,cols);
if ((0<x<=5)|(0<y<=5))
    for i=x:(x+5)
        for j=y:(y+5)
            [b,r,blur] = partiald(im,[i j],rmin,rmax,0.5,600);
            maxrad(i,j) = r;
            maxb(i,j) = b;
        end
    end
elseif (((x+5)>=rows)|((y+5)>=cols))
    for i=(x-5):x
        for j=(y-5):y
            [b,r,blur] = partiald(im,[i j],rmin,rmax,0.5,600);
            maxrad(i,j) = r;
            maxb(i,j) = b;
        end
    end
else
    for i=(x-5):(x+5)
        for j=(y-5):(y+5)
            [b,r,blur] = partiald(im,[i,j],rmin,rmax,0.5,600);
            maxrad(i,j) = r;
            maxb(i,j) = b;
        end
    end
end
B = max(max(maxb));
[X,Y] = find(maxb==B);
radius = maxrad(X,Y);
cp = [X,Y,radius];