lena = imread('lena512.bmp');
lena = im2double(lena);
lena = imresize(lena,[256 256]);
lenagrad = imgradient(lena,'sobel');
%imshow(lenagrad);

n = size(lena,1);
N = n*n;

L = 22;

[M, Mh, mh, mhi] = LineMask(L, n);
OMEGA = mhi;        % mhi is the non-zero index in Mh (half plane)
K = length(OMEGA);  % it is the linear index of the radial lines in Mh
% K = 3000;
% OMEGA = randperm(N);
% OMEGA = OMEGA(1:K)';

% Returns the observation taken on z using fourier samples OMEGA
A = @(z) A_fhp(z, OMEGA);

% Reconstruct image given the observations z using fourier samples OMEGA
At = @(z) At_fhp(z, OMEGA, n);

% observations
y = A(lena(:));

xbp = At(y);
Xbp = reshape(xbp,n,n);
Xbp = mat2gray(Xbp);
% imshow(Xbp);

xp = tveq_logbarrier(xbp, A, At, y, 1e-1, 2, 1e-8, 600);
Xtv = reshape(xp, n, n);
Xtv = mat2gray(Xtv);
%%
imshow(Xtv);