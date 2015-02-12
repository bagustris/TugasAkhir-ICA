% Frequency Domain ICA (FDICA) with Natural Gradient Algorithm
clear all; clc;

t=0:pi/100:10*pi;

s1=sin(2*t);
s2=sign(sin(3*t));

% x1=0.2*s1+0.7*s2;
% x2=0.6*s2+0.3*s1;

figure(1);
subplot(211); plot(s1);
subplot(212); plot(s2);

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

yy=w*wz*mixes;                  % memisahkan sinyal dalam domain frekuensi
yy11=yy(1,f);
yy12=yy(2,f);

% plot frekuensi spektra sinyal estimasi
figure(4);                          
subplot(211); plot(yy11);
subplot(212); plot(yy12);

% Transform signals back to time domain. 
yy11=real(ifft(yy(1,:)));
yy12=real(ifft(yy(2,:))); 

% Plot time domain sinyal estimasi akhir
figure(5);
subplot(211); plot(yy11);
subplot(212); plot(yy12);