%% Ham nay tinh toan su thay doi ma co su thay doi mau sac lon nhat
% Dau vao :
%        I : Anh dau vao.
%        C : Toa do trung tam
%        rmin, rmax : Ban kinh lon nhat nho nhat co the.
%        sigma : Do lech chuan cua bo loc Gaussian.
%        n : So luong canh cua da giac xap xi.
% Dau ra :
%        blur : Cac vec to khac biet. 
%        r : Ban kinh tai gia tri lon nhat cua 'blur'.
%        b : Gia tri lon nhat cua 'blur'.
% By : Nguyen Van Linh
% Siplab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [b,r,blur]=partiald(I,C,rmin,rmax,sigma,n)
R = rmin:rmax;
Count = size(R,2);
% Tinh tich phan duong tron cho moi ban kinh.
for k=1:Count
    [L(k)] = tichphanduongtron(I,C,R(k),n);
    if (L(k)==0)
        L(k) = [];
        break;
    end
end
% Cho ra su sai khac giua cac ban kinh.
D = diff(L);
D = [0 D];
if (strcmp(sigma,'inf')==1)
    f=ones(1,7)/7;
else
    % Lam muot cac gia tri thu duoc.
    f = fspecial('gaussian',[1,5],sigma);
end
blur = convn(D,f,'same');
blur = abs(blur);
[b,i] = max(blur);
r = R(i);
b = blur(i);
