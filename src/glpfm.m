% read input
img = imread("LPF_1.jpg");
% save size
img = im2double(img);
[M, N] = size(img(:,:,1));
disp(M);disp(N);

% padding parameter
P = M + M;
Q = N + N;
disp(P);disp(Q);

% create padding
img_pad = zeros(P, Q);

for i = 1:M
    for j = 1:N
        img_pad(i,j) = img(i,j);
    end
end
imshow(img);title('original image');
figure; imshow(img_pad);title('padded image');

% fourier transform;
ft_image = fft2(double(img_pad));

% set cut off distance
DC = 0.05*P;

% create filter
u = 0:(P-1);
idx = find(u > (P/2));
u(idx) = u(idx) - P;

v = 0:(Q-1);
idy = find(v > (Q/2));
v(idy) = v(idy) - Q;
[V,U] = meshgrid(v,u);

% create LPF
D = sqrt(U.^2 + V.^2);
H = exp(-(D.^2)./(2*(DC^2)));

% convolution between mask and fourier transformed image
LPF = H.*ft_image; 
% invert fourier transform and get real values 
LPF2 = real(ifft2(double(LPF)));
output = LPF2(1:M, 1:N);
figure, imshow(output); title('output image');