% read input
img = imread("HPF_1.jpg");
img = im2double(img);
imshow(img);title('original image');

% save size
[M, N] = size(img(:,:,1));
output = zeros(M, N, 3);

% padding parameter
P = M + M;
Q = N + N;

% create padding
img_pad = zeros(P, Q);

for n = 1:3
    for i = 1:M
        for j = 1:N
            img_pad(i,j) = img(i,j,n);
        end
    end
    
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
    
    % create HPF
    D = sqrt(U.^2 + V.^2);
    H = double(D <= DC);
    H = 1 - H;
    
    % convolution between mask and fourier transformed image
    LPF = H.*ft_image; 
    % invert fourier transform and get real values 
    LPF2 = real(ifft2(double(LPF)));
    output(:,:,n) = LPF2(1:M, 1:N);
end
figure, imshow(output); title('output image');