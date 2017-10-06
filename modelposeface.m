%% Chuong trinh ve hinh tam giac mo phong khuan mat nguoi
% Dau vao : 
%  
% Dau ra : 
%        imageout : Anh dau ra.
% By : Nguyen Van Linh
% SipLab K52, Dien tu vien thong, Dai hoc Bach Khoa Ha Noi
function imageout = modelposeface()
imageout = cat(3,zeros(480,640),zeros(480,640),zeros(480,640));
imagesc(imageout);
axis image;
line([30,100],[300 400],'Color','red','linewidth','2');
