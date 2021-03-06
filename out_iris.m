%% Ham tinh dau ra cho mat voi cac thong so can thiet
% Ham la tong hop cua cac ham sau:
% [ci,out] = timconnguoi(I,rmin,rmax);
% [out] =  tim_connguoi_bkchuabiet(img);
% [Ceye1 Ceye2] = tim_chinhxactrungtammat(img,out);
% Dau vao :
%      I_subeye : Anh dau vao co chua mat
% Dau ra :
%       eye_center1 : Toa do tam theo truc x
%       eye_center2 : Toa do tam theo truc y
%       connguoi : Anh co chua con nguoi
% By : Nguyen Van Linh
% SipLab_k52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi.
function [eye_center1 eye_center2 r connguoi] = out_iris(I_subeye,r)
if nargin==1
    [out_ra] = tim_connguoi_bkchuabiet(I_subeye);
else 
    [out_ra] = tim_connguoi_bkchuabiet(I_subeye,r);
end
connguoi = out_ra.o;
bk = out_ra.ci;
r = bk(3);
%eye_center1 = out_ra.ci(2);
%eye_center2 = out_ra.ci(1);
[eye_center1 eye_center2] = tim_chinhxactrungtammat(I_subeye,out_ra);
clearvars out_ra*
clearvars bk*
%clearvars -regexp out_ra.ci