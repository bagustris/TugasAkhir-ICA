% fp_fdica.m : a program for sound separation (have the mixed sounds, estimate the source sounds)
% bagustris@yahoo.com
% modified from ftp://ftp.cnl.salk.edu/pub/tony/sep96.public

clear all; close all; clc; format compact;

% the real implementation used recorded machineries sound

% reading soundsignals
mic_1=wavread('x11.wav'); 
mic_2=wavread('x12.wav');

% make coloumn matrix
mic_1=mic_1';
mic_2=mic_2';

% equalize the matrix's size
mic_1=mic_1(1:50000);
mic_2=mic_2(1:50000);

figure(1)
subplot(211); plot(mic_1);
subplot(212); plot(mic_2);

mix=[mic_1;mic_2];
[N,P]=size(mix);
permute=randperm(N);
s=mix(permute,:);
x=s;
mx=mean(mix');
c=cov(mix');
x=x-mx'*ones(1,P);
wz=2*inv(sqrtm(c));
x=wz*x;


% initiation of random mixed matrix
w=[1 1;1 2];
M=size(w,2);
sweep=0; oldw=w; olddelta=ones(1,N*N);
Id=eye(M);


% tdica iteration
L=0.000001; B=30; for I=1:100, sep; end;
uu=w*wz*mix;
uu11=uu(1,:);
uu12=uu(2,:);

figure(2);
subplot(211); plot(uu11);
subplot(212); plot(uu12);


