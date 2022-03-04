function output = addBrightnessF(img)
    [M, N, D]= size(img);
    P= 2*M;
    Q= 2*N;

    output = zeros(M, N, 3);
    A = zeros(P,Q);

    for n = 1:3
        fp = im2double(img(:,:,n));
        fp = addPadding(fp);
        [F,H] = countGaussian(fp);

        % Lakukan Highboost filtering 
        for i = 1:P
            for j = 1:Q
                A(i,j)=double(3);
            end
        end
        temp = A-H;
        FHB = temp.*F;
        FHB2 =real(ifft2(FHB));
        output(:,:,n) = FHB2(1:M, 1:N);
    end
end