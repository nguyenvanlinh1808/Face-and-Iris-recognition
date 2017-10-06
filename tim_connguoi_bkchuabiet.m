%% Ham tim ra con nguoi voi ban kinh chua biet.
% Dau vao :
%       img : Anh dau vao( hop anh co chua mat).
% Dau ra  :
%       [out] : Mot mang voi.
%          out.si : Kich thuoc cua anh tren.
%          out.o : Anh da tim ra va da ve vong tron.
%          out.pic : Cat ra anh chi chua con nguoi.
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi.
function [out]=tim_connguoi_bkchuabiet(img,r)
s = size(img);
out.si = s;
if nargin==1
    [ci,o] = timconnguoi(img,s(2)*0.1,s(2)*0.2);
else
    [ci,o] = timconnguoi(img,r-0.5,r+0.5);
end
ci = round(ci);
out.ci = ci;
out.o = o;
xx1 = ci(1)-ci(3);
xx2 = ci(1)+ci(3);
yy1 = ci(2)-ci(3);
yy2 = ci(2)+ci(3);
if xx1<=0
    x1 = 1;
else
    x1 = xx1;
end
if xx2>s(1);
    x2 = s(1);
else
    x2 = xx2;
end
if yy1<=0
    y1 = 1;
else
    y1 = yy1;
end
if yy2>s(2)
    y2 = s(2);
else
    y2 = yy2;
end
out.pic = img(x1:x2,y1:y2,:);
%if (((ci(1)-ci(3))>=1) & (ci(1)+ci(3)<=s(1)) & (ci(2)-ci(3)>=1)&(ci(2)+ci(3)<=s(2)))
%    out.pic = img((ci(1)-ci(3)):(ci(1)+ci(3)),(ci(2)-ci(3)):(ci(2)+ci(3)),:);
%else
%    out.pic = img;
%end
