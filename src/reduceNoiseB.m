function [oldImage, newImage] = reduceNoiseB()
    path = [pwd filesep '..' filesep 'img' filesep];
    oldImage = imread([path,'Noise_2.jpg']);
    [specFourier, F1] = getFourier(oldImage );
    X1 = [20 80 150 350 410 470;];
    X2 = [40 100 170 370 430 490;];
     
    for j = 1 : 20
        for i = 150 : 170
            F1(i,j) = 0;
        end
        for i = 350 : 270
            F1(i,j) = 0;
        end
    end
    
    for j = 50 : 70
        for x = 1 : 6
            for i = X1(x) : X2(x)
                F1(i,j) = 0;
            end
        end
    end
    
    for j = 130 : 150
        for x = 1 : 6
            for i = X1(x) : X2(x)
                F1(i,j) = 0;
            end
        end
    end
    
    for j = 380 : 400
        for x = 1 : 6
            for i = X1(x) : X2(x)
                F1(i,j) = 0;
            end
        end
    end
    
    for j = 450 : 470
        for x = 1 : 6
            for i = X1(x) : X2(x)
                F1(i,j) = 0;
            end
        end
    end
    
    for j = 500 : 525
        for i = 150 : 170
            F1(i,j) = 0;
        end
        for i = 350 : 270
            F1(i,j) = 0;
        end
    end
    
    newImage = real(ifft2(ifftshift(F1)));
end