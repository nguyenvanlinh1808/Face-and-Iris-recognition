%% Ham cat ra vung anh co chua mat phai,
% Ham dua vao khi da biet mat trai,va trung tam cua vung da
% Dau vao :
%       Image : Anh goc dau vao de cat
%       xtrai : Toa do hang cua mat trai trong anh goc lon
%       Center : Toa do cot cua trung tam vung da
% Dau ra :
%       eyerightregion : Anh dau ra da duoc cat
%       C : Do lech so voi anh goc
% By : Nguyen Van Linh
% SipLab_k52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [eyerightregion,C]=cut_eyerightregion(Image,xtrai,ytranform,face,size_boxmattrai)
m = size(Image,1);
n = size(Image,2);
cut = 0;
se = strel('disk',15);
ycut1 = ytranform+round((size_boxmattrai(2)));
ycut2 = ytranform+round(3*size_boxmattrai(2));
if (((xtrai-40)>0)&((xtrai+40)<m)&((ycut2)<n))
    eyeright = face((xtrai-40):(xtrai+40),ycut1:ycut2);
    eyeright = imdilate(eyeright,se);
    eyeright_cut = Image((xtrai-40):(xtrai+40),ycut1:ycut2,:);
    cut = 1;
else
    eyeright = face;
    eyeright = imdilate(eyeright,se);
    eyeright_cut = Image;
    cut = 0;
end
if(cut==1)
    C1 = xtrai-40;
    C2 = ycut1;
else
    C1 = 0;
    C2 = 0;
end
C = [C1,C2];
%[p,q] = size(eyeright);
%eyerightregion = uint8(cat(3,zeros(p,q),zeros(p,q),zeros(p,q)));
%for i=1:p
%    for j=1:q
%        if(eyeright(i,j)==1)
%            for k=1:3
%                eyerightregion(i,j,k) = eyeright_cut(i,j,k);
%            end
%        end
%    end
%end
eyerightregion = eyeright_cut;
clearvars m n cut ycut1 ycut2
