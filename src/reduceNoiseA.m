function [oldImage, newImage] = reduceNoiseA()
    path = [pwd filesep '..' filesep 'img' filesep];
    oldImage = imread([path,'Noise_1.jpg']);
    [specFourier, F1] = getFourier(oldImage);

    for j = 50 : 70
        for i = 170 : 190
            F1(i,j) = 0;
        end
    end
    
    for j = 70 : 90
        for i = 190 : 210
            F1(i,j) = 0;
        end
    end
     
    for j = 170 : 190
        for i = 40 : 60
            F1(i,j) = 0;
        end
        for i = 170 : 190
            F1(i,j) = 0;
        end
        for i = 300 : 320
            F1(i,j) = 0;
        end
    end
    
    for j = 190 : 210
        for i = 60 : 80
            F1(i,j) = 0;
        end
        for i = 190 : 210
            F1(i,j) = 0;
        end
        for i = 320 : 340
            F1(i,j) = 0;
        end
    end
    
    for j = 300 : 320
        for i = 170 : 190
            F1(i,j) = 0;
        end
    end
    
    for j = 320 : 340
        for i = 190 : 210
            F1(i,j) = 0;
        end
    end
    
    newImage = real(ifft2(ifftshift(F1)));
end