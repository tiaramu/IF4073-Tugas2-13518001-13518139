function output = addBrightnessF(img)
    [M, N, D]= size(img);
    output = zeros(M, N, 3);

    P= 2*M;
    Q= 2*N;
    A = zeros(P,Q);

    for n = 1:3
        fp = addPadding(img(:,:,n));
        [F,H] = countGaussian(fp);

        % Lakukan Highboost filtering 
        for i = 1:P
            for j = 1:Q
                A(i,j)=double(1);
            end
        end
        temp = A-H;
        FHB = temp.*F;
        FHB2 =real(ifft2(FHB));
        output(:,:,n) = FHB2(1:M, 1:N);
    end
    imshow(output);
end