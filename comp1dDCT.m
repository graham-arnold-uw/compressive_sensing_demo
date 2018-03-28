lena = imread('lena512.bmp');
figure
imshow(lena)
title('original image');
%lena = imresize(lena,[256 256]);
N = 512;
K = 150;
lena = im2double(lena);
% lenaVec = lena(:);
% lenaMask = lenaVec;
% %b = zeros(K,1);
% mask = rand(N*N,1);
% vals = N*N;
% for i = 1:N*N
%     if mask(i) > 0.5
%         lenaMask(i) = 0;
%         vals = vals - 1;
%     end 
% end
% b = zeros(vals, 1);
% bidx = 1;
% count = 0;
% for i = 1:N*N
%     if lenaMask(i) > 0.01
%         %disp(lenaMask(i));
%         b(bidx,1) = lenaMask(i);
%         bidx = bidx + 1;
%         %count = count + 1;
%     end 
% end
%%
        
% randIdx = randperm(N);
% 
% block = 16;
 result = zeros(N,N);
% blockRes = zeros(block,block);
% phi = randn(vals,N*N);
randMat = randn(K,N);
%lenaDCT = dct(lena);
%%y = randMat*lenaDCT;
idx = 1;
A = randn(K,N);
%A = orth(A')';


%%
    for i = 1:N
        %imblock = lena(i*block+1:i*block+block, j*block+1:j*block+block);
        %imblockVec = imblock(:);
        imdct1 = dct(lena(i,:))';
        %imdct2 = dct2(imblock);
        %imdct2 = imdct2(:);
         y = A*imdct1;
         %y = A*imdct2;
         x0 = A'*y;
         xp = l1eq_pd(x0, A, [], y, 1e-3);
         imrow = idct(xp);
%          for k = 0:block-1
%              blockRes(k+1,:) = imrow(k*block+1:k*block+block)';
%          end
         %result(i*block+1:i*block+block,j*block+1:j*block+block) = blockRes;
         %idx = idx+1;
         result(i,:) = imrow;
    end
figure
imshow(result);
title('recovered image');