% Demo of Time Domain ICA with Natural Gradient Algorithm
% with dummy signal (sin).

close all; clear all;  clc;

t=0:pi/100:10*pi;
s1=sin(0.2*t);
s2=sin(2*t);

figure(1)
subplot(211); plot(s1);
subplot(212); plot(s2);

x1=0.1*s1+0.9*s2;
x2=0.1*s2+0.9*s1;

mic_1=x1;   %Reading file from microphone #1.
mic_2=x2;   %Reading file from microphone #2.

%menyamakan dan memperkecil ukuran byte file
% mic_1=mic_1(1:50000);           
% mic_2=mic_2(1:50000);
% mic_3=mic_3(1:50000);

% Plot sinyal input TDICA
figure(2)
subplot(211); plot(mic_1);
subplot(212); plot(mic_2);


mix=[mic_1;mic_2];             %mencampur file suara

[N,P]=size(mix);               %P=sampled time=50000;N=number of input=3
permute=randperm(N);           %generate a permutation vector
s=mix(permute,:);              %time-scrambled inputs for stationarity

x=s;

mx=mean(mix');
c=cov(mix');
x=x-mx'*ones(1,P);
wz=2*inv(sqrtm(c));
x=wz*x;

w=eye(N);                         
M=size(w,2);                      
sweep=0; oldw=w; olddelta=ones(1,N*N);
Id=eye(M);

L=0.0001; B=30; for I=1:100, sep; end;          %ITERASI TDICA

% Pemisahan sinyal suara
uu=w*wz*mix;         % make unmixed sources
uu11=uu(1,:);
uu12=uu(2,:);

% Plot sinyal estimasi TDICA/input FDICA
figure(3);
subplot(211); plot(uu11);
subplot(212); plot(uu12);
