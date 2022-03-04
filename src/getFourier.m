function [specFourier, F1] = getFourier(im)
    F = fft2(im(:,:,1));
    F1 = fftshift(F);
    F2 = abs(F1);
    specFourier = log(F2+1);
%     figure, imagesc(specFourier); colormap("gray");
end