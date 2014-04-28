% Frequency Domain ICA (FDICA) with Natural Gradient Algorithm
clear all; close all; format compact; clf;

a=wavread('normal');
aa=(a./0.001);
n=rand(size(aa));
nn=(n./5);

vv1=0.1*aa+0.9*nn;
vv2=0.9*aa+0.1*nn;

mic_1=vv1';
mic_2=vv2';

figure(1)
subplot(211); plot(mic_1);
subplot(212); plot(mic_2);

mic_1=mic_1(1:50000);               %memperkecil dan menyamakan sinyal
mic_2=mic_2(1:50000);

Fs=11025;
f=[1:Fs/2];

mixfrek=[real(fft(mic_1));real(fft(mic_2))];


%plot frekuensi spektra sinyal input FDICA
figure(2);
subplot(2,1,1) 
plot(f,mixfrek(1,f));  
title('Frequency spectra of the microphone #1') 
xlabel('Frequency (Hz)'); 
  
subplot(2,1,2) 
plot(f,mixfrek(2,f));  
title('Frequency spectra of the microphone #2') 
xlabel('Frequency (Hz)'); 
  
[N,P]=size(mixfrek)             % P=50000, N=2, in this case. 
permute=randperm(P);            % Generate a permutation vector. 
x=mixfrek(:,permute);           % Time-scrambled inputs for stationarity. 

% Spheres the data (normalisation). 
mx=mean(mixfrek');  
c=cov(mixfrek'); 
x=x-mx'*ones(1,P);              % Subtract means from mixes. 
wz=2*inv(sqrtm(c));             % Get decorrelating matrix. 
x=wz*x;                         % Decorrelate mixes so cov(x')=4*eye(N); 
 
w=pi^2*rand(N);                 % Initialise unmixing matrix. 
M=size(w,2);                    % M=N usually 
sweep=0; oldw=w; olddelta=ones(1,N*N); 
Id=eye(M); 

L=0.00001; B=30; for I=1:100, sep; end;          %ITERASI FDICA

yy=w*wz*mixfrek;                      % memisahkan sinyal dalam domain frekuensi
yy11=yy(1,f);
yy12=yy(2,f);

% plot frekuensi spektra sinyal estimasi
figure(3)                           
subplot(211); plot(yy11);
subplot(212); plot(yy12);

% Transform signals back to time domain. 
yy11=real(ifft(yy(1,:)));
yy12=real(ifft(yy(2,:))); 

% Plot time domain sinyal estimasi akhir
figure(4)
subplot(211); plot(yy11);
subplot(212); plot(yy12);
%---------------END OF PROGRAM--------------------------------------------