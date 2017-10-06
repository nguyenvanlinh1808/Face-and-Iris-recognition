%% Ve phac thao duong tron
% Dau vao :
%       I : Anh dau vao.
%       C : Tam duong tron.
%       r : Ban kinh duong tron.
%       n : So canh xap xi.
% Dau ra :
%       [o] : Anh duoc ve duong tron.
% By : Nguyen Van Linh
% SipLab_K52, Dien tu vien thong, Dai hoc Bach Khoa Ha noi
function [out]=veduongtron(I,C,r,n)
if (nargin==3)
    n = 600;
end
theta = (2*pi)/n;
rows = size(I,1);
cols = size(I,2);
% Goc duoc chia
angle = theta:theta:(2*pi);
% Tinh toan cac toa do theo goc.
x = C(1)-r*sin(angle);
y = C(2)+r*cos(angle);
if any(x>=rows)|any(y>=cols)|any(x<=1)|any(y<=1)
    out = I;
    return
end
for i=1:n
I(round(x(i)),round(y(i))) = 1;
end
out = I; 