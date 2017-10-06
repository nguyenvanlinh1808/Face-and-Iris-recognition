function f = outmat(im,dec,T)
% Ham co nhiem vu tim ra toan bo mat
% va chuyen nhung cai thuoc ve mat thanh mau trang
% nhung cai khong thuoc ve mat cho thanh den cho anh
[VG,a,ppm] = colorgrad(im,dec,T);
bwVG = im2bw(VG,T);
bwVG = imfill(bwVG,'holes');
f = bwVG;
f = bwareaopen(f,300);