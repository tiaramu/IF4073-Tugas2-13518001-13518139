function img_pad = addPadding(img)
% add padding into image sized M * N into P * Q where P = 2M and Q = 2N
% img must be already seperated into 2 dimention
    % save size
    [M, N] = size(img);
    
    % padding parameter
    P = M + M;
    Q = N + N;
    
    % create padding
    img_pad = zeros(P, Q);

    for i = 1:M
        for j = 1:N
            img_pad(i,j) = img(i,j);
        end
    end
end