n = (1/8);
sampleRate = 40000;
N = 256;
K = 80;
Ts = 1/sampleRate;
samples = sampleRate*n;
%f = zeros(sampleRate*n, 1);
sampVec = linspace(0,1/8, N);
f = sin(1394*pi*sampVec) + sin(3266*pi*sampVec)+ sin(5266*pi*sampVec);
coef = dct(f)';
%%
A=randn(K, N);
A=orth(A')';

% observations
b=A*coef;


c0 = A'*b;

[c1] = l1eq_pd(c0, A, [], b, 1e-4);

f1 = idct(c1, N);
%%
figure
plot(1:N, f1, 'r', 1:N, f, 'b');
xlim([0 N]); title('L1 recovery versus original signal');
legend('L1 recovery', 'original signal');

figure
plot(coef, 'b');
hold on
plot(c1,'r');
title('Recovered versus original DCT coefficients');
legend('original signal','L1 recovery');