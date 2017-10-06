%% Ham tim ra chinh xac trung tam cua con nguoi
% Dau vao :
%      img : Hop anh cho chua mat.
%      out : Mot mang voi
%          out.si = Kich thuoc cua anh.
%          out.pic = Anh chi chua con nguoi, day la anh vuong.
% Dau ra :
%        Ceye1 : Toa do theo truc x
%        Ceye2 : Toa do theo truc y
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi.
function [Ceye1 Ceye2] = tim_chinhxactrungtammat(img,out)
sizeOrig=out.si; % Kich thuoc cua anh img
Pupil=out.pic ;
[xP yP zP]=size(Pupil);

[xImg,yImg,zImg] = size(img);
img = double(img);
minAbs = -1;

h = fspecial('gaussian',4,5);
img =  imfilter(img,h,'replicate');

xImgP = int16( xP*xImg / sizeOrig(1) );
yImgP = int16( yP*yImg / sizeOrig(2) );

imPupil = imresize(Pupil,[xImgP, yImgP]);
imPupil = double(imPupil);
choice = 0;
for jj = int16(1):int16((yImg-yImgP))
    for ii =int16(1):int16((xImg-xImgP))
        absImg = abs(img(ii:(ii-1+xImgP),jj:(jj-1+yImgP),:) - ...
            imPupil(1:xImgP,1:yImgP,:));
        
        sumAbsImg = sum(sum(sum(absImg)))/(xImgP*yImgP);
        if (sumAbsImg < minAbs || minAbs == -1 )
            posY = ii;
            posX = jj;
            minAbs = sumAbsImg;
            choice = 1;
        else
            choice = 0;
        end
    end
end
if (choice==1)
    Ceye1 = posX+xImgP/2;
    Ceye2 = posY+yImgP/2;
else
    Ceye1 = out.ci(2);
    Ceye2 = out.ci(1);
end