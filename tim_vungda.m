%% Ham nay tim ra vung da tren khuan mat nguoi va tra ve trung tam cua vung
function [skinface,Center_skinface,Yaveg,Sskin] = tim_vungda(Image)
% Dau vao:
%       Image : Anh RGB dau vao.
% Dau ra:
%        skinface : Anh nhi phan, vung trang la vung mau da
%        Center_skinface : Toa do trung tam cua vung mau da tren
% Author : Linh Van Nguyen
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
% Bai viet dua vao bai bao: A SIMPLE AND ACCURATE COLOR FACE DETECTION 
% ALGORITHM IN COMPLEX BACKGROUND
% Yu-Ting Pai, Shanq-Jang Ruan, Mon-Chau Shie, Yi-Chi Liu
% Da chinh sua cua tac gia
%Image = imread('D:\Cac thu nghiem\Thu nghiem 2\data\1.jpg');
%Image = imread('D:\Cac thu nghiem\Thu nghiem 2\data\5.jpg');
%Image = imread('D:\Cac thu nghiem\Thu nghiem 5\data\Picture 014.jpg');
%Image = imread('D:\Cac thu nghiem\Thu nghiem 2\data\8.jpg');
%Image = imread('D:\Cac thu nghiem\Thu nghiem 5\data\Picture 014.jpg');
%Image = imread('C:\Documents and Settings\Nguyen Van Linh\My Documents\Downloads\Integrodifferential operator\Integrodifferential operator\Picture 017.jpg');
%Image = imread('C:\Documents and Settings\Nguyen Van Linh\My Documents\Downloads\Integrodifferential operator\Integrodifferential operator\Picture 015.jpg');
Image = double(Image);
H = size(Image,1);
W = size(Image,2);
R = Image(:,:,1);
G = Image(:,:,2);
B = Image(:,:,3);

% Thuc hien bu sang:
Ycbcr = rgb2ycbcr(Image);
Y = Ycbcr(:,:,1);
  % Chuan hoa cho Y:
  minY = min(min(Y(:)));
  maxY = max(max(Y(:)));
  Y1 = 255.0*(Y-minY)./(maxY-minY);
  Yaveg = sum(sum(Y1))/(W*H);
  % Bu sang:
  T = 1;
  if (Yaveg<64)
      T = 1.4;
  elseif (Yaveg>192)
      T = 0.6;
  end
  if (T~=1)
      RI = R.^T;
      GI = G.^T;
  else
      RI = R;
      GI = G;
  end
% Thuc hien bu:
C = zeros(H,W,3);
C(:,:,1) = RI;
C(:,:,2) = GI;
C(:,:,3) = B;
Ycbcr = rgb2ycbcr(C);
Cr = Ycbcr(:,:,3);
S = zeros(H,W);
[SkinIndexrows SkinIndexcols] = find(8<Cr & Cr<65); % Khoang nay co the thay doi
for i=1:length(SkinIndexrows)
    S(SkinIndexrows(i),SkinIndexcols(i)) = Image(SkinIndexrows(i),SkinIndexcols(i));
end
Sskin = S;
Luu = 'Luu_anh\';
file_ext='.jpg';
fodel_luuanh=dir([Luu,'*',file_ext]);
DEBUG = 0;
warning off;
delete ([Luu,'*.*']);
if (DEBUG == 1)
    mkdir (Luu);
end
imwrite(S,[Luu,'Vungdanhieu','.jpg']);
%S = bwareaopen(S,200);
S = imfill(S,'holes');
se = strel('square',15);
S = imerode(S,se);
%S = bwmorph(S,'thin',2);
%S = imclearborder(S);
% Loc da vung da la vung co vung trang lon nhat tra ve toa do trung tam:
[skinface,Center_skinface] = maxregion(S);
%figure,imshow(skinface)
%hold on
%plot(Center_skinface(1),Center_skinface(2),'*r')
%hold off
clearvars C R G B H W RI GI T S se
      
  