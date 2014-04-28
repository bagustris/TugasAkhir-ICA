%MSICA 1= TDICA + FDICA with Natural Gradient
%-------------------------TDICA------------------------------------------
close all, clear all, clc;
% Time Domain ICA with Natural Gradient Algorithm

mic_1=wavread('2mic11');
mic_2=wavread('2mic12');

% a=wavread('normal');
% aa=(a./0.001);
% n=randn(size(aa));
% nn=(n./5);
% 
% vv1=0.1*aa+0.9*nn;
% vv2=0.9*aa+0.1*nn;

mic_1=mic_1';   %Reading file from microphone #1.
mic_2=mic_2';   %Reading file from microphone #2.


%menyamakan dan memperkecil ukuran byte file
mic_1=mic_1(1:50000);           
mic_2=mic_2(1:50000);


% Plot sinyal input TDICA
figure(1)
subplot(211); plot(mic_1);
subplot(212); plot(mic_2);


mix=[mic_1;mic_2];             %mencampur file suara

[N,P]=size(mix);               %P=sampled time=50000;N=number of input=3
permute=randperm(N);            %generate a permutation vector
s=mix(permute,:);              %time-scrambled inputs for stationarity

x=s;
mix=mix;

mx=mean(mix');
c=cov(mix');
x=x-mx'*ones(1,P);
wz=2*inv(sqrtm(c));
x=wz*x;

% w=eye(N);
w=[1 1;1 2];
M=size(w,2);                      
sweep=0; oldw=w; olddelta=ones(1,N*N);
Id=eye(M);

L=0.0001; B=30; for I=1:100, sep; end;          %ITERASI TDICA

% Pemisahan sinyal suara
uu=w*wz*mix;         % make unmixed sources
uu11=uu(1,:);
uu12=uu(2,:);

% Plot sinyal estimasi TDICA/input FDICA
figure(2);
subplot(211); plot(uu11);
subplot(212); plot(uu12);

%--------------------------------------------------------------------------
% Frequency Domain ICA (FDICA) with Natural Gradient Algorithm
Fs=11025;
f=[1:Fs/2];

mixfrek=[real(fft(uu11')),real(fft(uu12'))];
mixfrek=mixfrek';

%plot frekuensi spektra sinyal input FDICA
figure(3);
subplot(2,1,1) 
plot(f,mixfrek(1,f));  
title('Frequency spectra of the microphone #1') 
xlabel('Frequency (Hz)'); 
  
subplot(2,1,2) 
plot(f,mixfrek(2,f));  
title('Frequency spectra of the microphone #2') 
xlabel('Frequency (Hz)'); 
  
[N,P]=size(mixfrek)             % P=50000, N=3, in this case. 
permute=randperm(P);            % Generate a permutation vector. 
s=mixfrek(:,permute);           % Time-scrambled inputs for stationarity. 

x=s;                            % mix input signals
mixes=mixfrek;  
 
% Spheres the data (normalisation). 
mx=mean(mixes');  
c=cov(mixes'); 
x=x-mx'*ones(1,P);              % Subtract means from mixes. 
wz=2*inv(sqrtm(c));             % Get decorrelating matrix. 
x=wz*x;                         % Decorrelate mixes so cov(x')=4*eye(N); 
 
w=pi^2*rand(N);                 % Initialise unmixing matrix. 
M=size(w,2);                    % M=N usually 
sweep=0; oldw=w; olddelta=ones(1,N*N); 
Id=eye(M); 

L=0.00001; B=30; for I=1:100, sep; end;          %ITERASI FDICA

yy=w*wz*mixes;                      % memisahkan sinyal dalam domain frekuensi
yy11=yy(1,f);
yy12=yy(2,f);

% plot frekuensi spektra sinyal estimasi
figure(4)                           
subplot(211); plot(yy11);
subplot(212); plot(yy12);

% Transform signals back to time domain. 
yy11=real(ifft(yy(1,:)));
yy12=real(ifft(yy(2,:))); 

% Plot time domain sinyal estimasi akhir
figure(5)
subplot(211); plot(yy11);
subplot(212); plot(yy12);
%---------------END OF PROGRAM--------------------------------------------- 