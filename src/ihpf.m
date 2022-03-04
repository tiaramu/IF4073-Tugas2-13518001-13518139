function output = ihpf(img)
    img = im2double(img);
    
    % save size
    [M, N] = size(img(:,:,1));
    output = zeros(M, N, 3);

    for n = 1:3
        % create padding
        img_pad = addPadding(img(:,:,n));
        
        [ft_image, H] = countIdeal(img_pad);
        H = 1- H;

        % convolution between mask and fourier transformed image
        LPF = H.*ft_image; 
        % invert fourier transform and get real values 
        LPF2 = real(ifft2(double(LPF)));
        output(:,:,n) = LPF2(1:M, 1:N);
    end
end