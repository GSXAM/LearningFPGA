I = imread('kodim19.png');
i = rgb2gray(I);%chuyen thanh anh xam
s = fft2(double(i)); %bien doi F roi rac 2 chieu

% %ve spectre
% figure
% imagesc(log(abs(fftshift(s)))); 
% %abs la ham lay do lon cua 1 so phuc de ve do thi
% %fftshift la keo ve trung tam
% title('Spectre');

%Tao bo loc 
F = zeros(size(s)); %tao 1 ma tran 0 voi kich thuoc cua anh
[M, N] = size(s); % tao 1 ma tran vs 2 chieu M la chieu dai anh N là chieu rong anh 
% r va c de the vao tinh radius 
% r = (M+1)/2; 
% c = (N+1)/2;
% [X, Y] = meshgrid((1:N),(1:M)); % luoi vs X quet tu 1 den N, Y quet tu 1 den M
% radius = sqrt((X-c).^2 + (Y-r).^2); %radius (hay Duv) la khoang canh diem (u,v) den tam
D0 = min(N/8,M/8); % D0 = 1/8 chieu ngang anh, D0 = 64 
F(radius < D0) = 1; %dap ung tan so bo loc ly tuong H(u,v)

%Ap bo loc da tao vao anh
S1 = fftshift(s).*F;
S1 = ifftshift(S1);%tra lai vi tri cua thanh phan DC bi keo boi fftshift
I1 = ifft2(S1); %bien doi F nguoc 2 chieu

figure
subplot(131)
imshow(I);
title('Anh Goc');
subplot(132)
imshow(real(I1),[]);
title('anh sau khi ap filter');
subplot(133)
imshow(F,[]);
title('Filter');