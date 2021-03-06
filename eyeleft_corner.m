%% Ham tim ra vi tri goc trai va goc phai cua con mat trai.
% Dau vao :
%       Imag : Anh dau vao.
% Dau ra :
%       eR_cL : Toa do goc trai cua mat trai.
%       eR_cR : Toa do goc phao cua mat trai.
%       o_eye : Duong tron bao quanh con nguoi.
%       C1 : Toa do hang cua tam con nguoi
%       C2 : Toa do cot cua tam con nguoi
%       C3 : Ban kinh cua con nguoi.
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [eL_cL,eL_cR,C1,C2,C3,o_eye]=eyeleft_corner(Imag)
[C2,C1,C3,o_eye] = out_iris(Imag);
[m,n,p] = size(Imag);
% Cat tu tam con nguoi ra hai phia trai, phai
reg_left = Imag(1:m,1:(C2-C3),:);
reg_right = Imag(1:m,(C2+C3):n,:);
reg_left = im2double(reg_left);
reg_right = im2double(reg_right);
% Bat dau lam viec voi ben trai:
eye1 = rgb2gray(reg_left);
se1 = [-1 -1 -1 1 1 1;-1 -1 -1 -1 1 1;-1 -1 -1 -1 -1 1;1 1 1 1 1 1];
f1 = imfilter(eye1,se1);
[mf1,nf1] = size(f1);
Tmax = max(max(abs(f1)));
if(Tmax==0)
    Tmax = 1;
end
scale_T1 = linspace((0.2*Tmax),(0.04*Tmax),4);
for l=1:size(scale_T1,2)
    T1 = scale_T1(l);
    %Cho nay dat lam mac dinh de tranh loi xay ra o duoi
    if (round((5*C3/4))<nf1)
        f1(C1,nf1-round(5*C3/4)) = T1;
    elseif ((nf1-C3)>0)
        f1(C1,nf1-C3) = T1; % Cho nay co van de
    end
    f1 = f1>=T1;
    for i=1:mf1
        for j=1:nf1
            if (j<=(round(nf1/5)))
                f1(i,j) = 0;
            end
            if (i<(C1-(2*C3)/3)| (i>(C1+(2*C3/3))))
                f1(i,j) = 0;
            end
        end
    end
    f1 = imfill(f1,'holes');
    [f1 cf1] = maxregion(f1);
    f1 = imfill(f1,'holes');
    [X1,Y1] = find(f1==1);
    [cood1 k1] = min(Y1(:));
    x1 = mean(X1(k1))+1;
    if (max(Y1(k1)+1<=nf1))
        y1 = max(Y1(k1))+1;
    else
        y1 = max(Y1(k1));
    end
    eL_cL = [x1,y1];
    if(isempty(eL_cL)==0)
        break;
    end
end
% Bat dau lam viec voi ben phai.
% Dau tien cho cong viec duoc de chinh xac hon,
% ta di tinh khoag cach tu tam den goc ben trai de
% gio han goc ben phai
khoangcach = abs(C2-y1);
khoangcach = round(khoangcach);
eye2 = rgb2gray(reg_right);
%eye2 = colorgrad(reg_right);
se2 = [1 1 1 -1 -1 -1;1 1 -1 -1 -1 -1;1 -1 -1 -1 -1 -1;1 1 1 1 1 1];
f2 = imfilter(eye2,se2);
[mf2,nf2] = size(f2);
Tmax = max(max((f2)));
if(Tmax==0)
    Tmax = 1;
end
scale_T2 = linspace((0.08*Tmax),(0.02*Tmax),4);
for l=1:size(scale_T2,2)
    T2 = scale_T2(l); 
    % Cho nay dat lam mac dinh de tranh loi xay ra o duoi
    %if ((C1-3>0)& round(khoangcach)<(nf2))
    %    f2(C1-3,round(khoangcach)) = T2;
    %else
    if ((C1-3>0)&(C3+4<=nf2))
        f2(C1-3,C3+4) = T2;
    elseif (C3<=nf2)
        f2(C1,C3) = T2;
    end
    f2 = f2>=T2;
    for i=1:mf2
        for j=1:nf2
            if (j>=round(5*nf2/7))
                f2(i,j) = 0;
            end
            if (j>=(round(4*C3/3)))
                f2(i,j) = 0;
            end
            if (i<(C1+(C3/5))|(i>(C1+C3)))
                f2(i,j) = 0;
            end
        end
    end
    % Tiep tuc:
    f2 = imfill(f2,'holes');
    [f2 cf2] = maxregion(f2);
    f2 = imfill(f2,'holes');
    [X2,Y2] = find(f2==1);
    [cood2 k2] = max(Y2(:));
    if ((max(X2(k2))+1)<=mf2)
        x2 = max(X2(k2))+1;
    else
        x2 = max(X2(k2));
    end
    if (max(Y2(k2))+2<=nf2)
        y2 = max(Y2(k2))+2;
    else
        y2 = max(Y2(k2));
    end
    root_x2 = x2;
    root_y2 = y2+C2+C3;
    eL_cR = [root_x2,root_y2];
    if(isempty(eL_cR)==0)
        break;
    end
end
if(isempty(eL_cL)==1)
    eL_cL = [C1,round(nf1/2)];
end
if(isempty(eL_cR)==1)
    eL_cR = [C1,(C2+C3+round(nf2/2))];
end
        
        
