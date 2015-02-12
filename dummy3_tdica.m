% Demo of Time Domain ICA with Natural Gradient Algorithm
% with dummy signal (sin).

close all; clear all;  clc;

load gong; x1=y(1:10000);
load chirp; x2=y(1:10000);

figure(1)
subplot(211); plot(x1);
subplot(212); plot(x2);

mix=[x1;x2];                    %mencampur file suara

%P=number of data points, NxP matrix
[N,P]=size(mix);               %P=sampled time=50000;N=number of input=3

% for manualy mixing sources
permute=randperm(N);           %generate a permutation vector
x=mix(permute,:);              %time-scrambled inputs for stationarity

%x=mix;
%% pre processing (whitening/sphering)
mx=mean(mix');                  %menghitung rata2
c=cov(mix');                    %menghitung kovarian/simpangan baku 
x=x-mx'*ones(1,P);              %campuran-rata2
wz=2*inv(sqrtm(c));             %untuk mendapatkan matrix dekorelasi
x=wz*x;                         %dekorelasi campuran shg cov(x')=4*eye(N)

%inisiasi matriks pemisah
w=eye(N);                       %matriks identitas square dg dimensi N  
M=size(w,2);                    %mencari dimensi matriks w          
sweep=0; oldw=w; olddelta=ones(1,N*N);
Id=eye(M);

% proses pemisahan
L=0.0001; B=30; for I=1:100, sep; end;          %ITERASI TDICA

% Pemisahan sinyal suara
uu=w^-1/wz*mix;         % make unmixed sources
uu11=uu(1,:);
uu12=uu(2,:);

% Plot sinyal estimasi TDICA/input FDICA
figure(3);
subplot(211); plot(uu11);
subplot(212); plot(uu12);
