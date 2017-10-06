%% Ham tim ra toa do diem chap lon nhat cua anh mau va anh chinh
% Dau vao :
%        Ima : Anh dau vao ( da duoc resize tu anh to)
% Dau ra :
%       x_matphai : Toa do hang cua diem duoc chap co gia tri max
%       y_matphai : Toa do cot cua diem duoc chap co gia tri max
% Chu y : Toa do nay chua duoc resize ve anh chinh
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function [x_matphai,y_matphai]= tim_matphai(Ima)
heso = [];
tem_matphai = 'mau_mat_phai\';
file_ext = '.jpg';
fodel_matphai = dir([tem_matphai,'*',file_ext]);
soluong_matphai = size(fodel_matphai,1);
for i = 1:soluong_matphai
    string_matphai = [tem_matphai,fodel_matphai(i,1).name];
    mau = imread(string_matphai);
    [I_ssd2{i},I_ncc] = template_matching_1(mau,Ima);
    heso_matphai = max(I_ssd2{i}(:));
    heso = [heso heso_matphai];
end
 j = find(heso==max(max(heso(:))));
if(size(j,2)>=2)
    j = max(j);
end
[x_matphai,y_matphai] = find(I_ssd2{j}==heso(j));