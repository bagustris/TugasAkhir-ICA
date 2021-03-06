% Frequency Domain ICA (FDICA) with Natural Gradient Algorithm
clear all; close all; format compact; clf;

[mic_1, Fs]=wavread('x11.wav');         % baca file wav sensor1
mic_2=wavread('x12.wav');               % baca file wav sensor2

f=[1:Fs/2];                             % f = 1 sampai dg Fs/2 utk sb-x

mixfrek=[real(fft(mic_1'));real(fft(mic_2'))];  % menggabung dlm 1 matrik

figure(1)
subplot(211); plot(mic_1);
subplot(212); plot(mic_2);

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
  
[N,P]=size(mixfrek);             % P=50000, N=2, in this case. 
x=mixfrek;

% Spheres the data (normalisation). 
mx=mean(mixfrek');  
c=cov(mixfrek'); 
x=x-mx'*ones(1,P);              % Subtract means from mixes. 
wz=2*inv(sqrtm(c));             % Get decorrelating matrix. 
x=wz*x;                         % Decorrelate mixes so cov(x')=4*eye(N); 

%w=[1 1; 1 2];
w=pi^2*rand(N);                 % Initialise unmixing matrix. 
M=size(w,2);                    % M=N usually, determined 
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