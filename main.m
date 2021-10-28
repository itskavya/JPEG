clc;
clear all;
close all;
A11=imread('peppers.png');
figure ;
imshow(A11);
A1=int16(A11);
A=rgb2gray(A1);
[r,c]=size(A);
p=ceil(r/8)*8;
q=ceil(c/8)*8;
I=int16(zeros(p,q));
out=(zeros(p,q));
res=int16(zeros(p,q));
I(1:r,1:c)=A;
I1=I;
I=I-128;
Q1 = [ 16 11 10 16 24 40 51 61;
12 12 14 19 26 58 60 55;
14 13 16 24 40 57 69 56;
14 17 22 29 51 87 80 62;
18 22 37 56 68 109 103 77;
24 35 55 64 81 104 113 92;
49 64 78 87 103 121 120 101;
72 92 95 98 112 100 103 99];
Q2= [17 18 24 47 99 99 99 99;
18 21 26 66 99 99 99 99;
24 26 56 99 99 99 99 99;
47 66 99 99 99 99 99 99;
99 99 99 99 99 99 99 99;
99 99 99 99 99 99 99 99;
99 99 99 99 99 99 99 99;
99 99 99 99 99 99 99 99];
Q3=[16 11 10 16 255 255 255 255
12 12 14 255 255 255 255 255
255 255 255 255 255 255 255 255
255 255 255 255 255 255 255 255
255 255 255 255 255 255 255 255
255 255 255 255 255 255 255 255
255 255 255 255 255 255 255 255
255 255 255 255 255 255 255 255];
fori=1:8:p
for j=1:8:q
B=I(i:i+7,j:j+7);
B1=dct2(B);
B1=round(B1./Q1);
out(i:i+7,j:j+7)=B1;
end
end
fori=1:8:p
for j=1:8:q
C=out(i:i+7,j:j+7);
C=round(C.*Q1);
C1=idct2(C);
res(i:i+7,j:j+7)=C1;
end
end
res=res+128;
figure ;
op=res(1:r,1:c);
imshow(uint8(op));
[peaksnr, snr] = psnr(A, op);
imshow(uint8(res));
fprintf('The peaksnr value for the image is %d\n',peaksnr);
fprintf('The SNR value for the image is %d\n',snr);
rmse=sqrt(mse(I1,res));
fprintf('The MSE value for the image is %d\n',rmse);
