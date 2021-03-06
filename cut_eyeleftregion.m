%% Ham cat ra vung chua mat trai
% Dau vao :
%      Image : Anh dau vao.
%      Center : Trung tam cua vung da khuan mat.
% Dau ra :
%      ima : Anh dau ra la vung chua mat trai.
%      C : Do lech so voi anh goc
%By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [eyeleftregion,C]=cut_eyeleftregion(Image,face,Center)
m = Center(1);
n = Center(2);
nImage = size(Image,1);
mImage = size(Image,2);
cut = 0;
if((m>160) & (n>110) & ((m+10)<mImage) & ((n+20)<nImage))
    eyeleft = face((n-110):(n+20),(m-160):(m+10),:);
    eyeleft_cut = Image((n-110):(n+20),(m-160):(m+10),:);
    cut = 1;
else
    eyeleft = face;
    eyeleft_cut = Image;
    cut = 0;
end
if cut==1
    C1 = n-110;
    C2 = m-160;
else
    C1 = 0;
    C2 = 0;
end
C = [C1,C2];
[p,q] = size(eyeleft);
%eyeleftregion = uint8(cat(3,zeros(p,q),zeros(p,q),zeros(p,q)));
%for i=1:p
%    for j=1:q
%        if(eyeleft(i,j)==1)
%            for k=1:3
%                eyeleftregion(i,j,k) = eyeleft_cut(i,j,k);
%            end
%        end
%    end
%end
eyeleftregion = eyeleft_cut;
%imshow(eyeleftregion), title('eyeleft_cut')
clearvars m n nImage mImage cut
