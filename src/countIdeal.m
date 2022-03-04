function [ft_image, H] = countIdeal(img_pad)
    % count LPF in Ideal
    [P,Q] = size(img_pad);
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
    H = double(D <= DC);
end