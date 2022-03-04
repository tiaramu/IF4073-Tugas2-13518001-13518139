function [oldImage, newImage] = reduceNoiseC()
    path = [pwd filesep '..' filesep 'img' filesep];
    oldImage = imread([path,'Noise_3.jpg']);
    [specFourier, F1] = getFourier(oldImage);
    startj=1;
    starti=280;
    
    while startj<280
        for j= startj : startj+15
            for i = starti-15 : starti
                F1(i,j) = 0;
            end
        end
        starti=starti-20;
        startj=startj+20;
    end
    
    newImage = real(ifft2(ifftshift(F1)));
end