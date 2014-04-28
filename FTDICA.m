%--------------------------------FTDICA----------------------------------
% msica2, frequency-then-time domain ICA
clear, clf, format compact;
%Input sinyal dari Mic Array

mic_1=wavread('2mic21');               %memperkecil dan menyamakan sinyal
mic_2=wavread('2mic22');

% a=wavread('normal');
% aa=(a./0.001);
% n=randn(size(aa));
% nn=(n./5);
% 
% vv1=0.1*aa+0.9*nn;
% vv2=0.9*aa+0.1*nn;

mic_1=mic_1'; 
mic_2=mic_2';

mic_1=mic_1(1:50000);               %memperkecil dan menyamakan sinyal
mic_2=mic_2(1:50000);


size(mic_1)                         % mengetahui ukuran/dimensi sinyal 
size(mic_2)


% Plot waveform sinyal input dlm domain waktu
figure(1)
subplot(211);plot(mic_1);
title('Waveform Sinyal Microphone 1')
ylabel('Amplitude');
subplot(212);plot(mic_2);
title('Waveform Sinyal Microphone 2')
ylabel('Amplitude');

Fs=11025;                           % Sampling frequency 
f=[1:Fs/2]; 

% Mencampur dan merubah sinyal input ke dalam domain frekuensi
mixfrek=[real(fft(mic_1));real(fft(mic_2))];  

%Plot sinyal input dalam domain frekuensi
figure(2) 
subplot(211);plot(f,mixfrek(1,f));  
title('Spektra Frekuensi Sinyal Microphone 1'); 
ylabel('Amplitude');
subplot(212);plot(f,mixfrek(2,f));
title('Spektra Frekuensi Sinyal Microphone 3');  
ylabel('Amplitude');


[N,P]=size(mixfrek);                % P=50000, N=3, in this case. 
permute=randperm(P);                % Generate a permutation vector. 
x=mixfrek(:,permute);               % Time-scrambled inputs for stationarity.                        
 
% Pre-Processing: Spheres the data (normalisation). 
mx=mean(mixfrek');  
c=cov(mixfrek'); 
x=x-mx'*ones(1,P);                  % Subtract means from mixes. 
wz=2*inv(sqrtm(c));                 % Get decorrelating matrix. 
x=wz*x;                             % Decorrelate mixes so cov(x')=4*eye(N); 
 
% w=pi^2*rand(N);                     % Initialise unmixing matrix. 
w=[1 1;1 2];
M=size(w,2);                        % M=N usually 
sweep=0; oldw=w; olddelta=ones(1,N*N); 
Id=eye(M); 

% Iterasi Filter Pemisah W FDICA (For details see sep.m)
L=0.000001; B=30; for I=1:100 sep;    end; 
 
uu=w*wz*mixfrek;                    % make unmixed sources 
uu11=uu(1,f);
uu12=uu(2,f);

% Plot sinyal estimasi FDICA dlm domain frekuensi 
figure(3)
subplot(211);plot(f,uu11);
title('Spektra Frekuensi Sinyal Estimasi FDICA 1')
ylabel('Amplitude');
subplot(212);plot(f,uu12);
ylabel('Amplitude');
title('Spektra Frekuensi Sinyal Estimasi FDICA 2') 
ylabel('Amplitude');

% Transform sinyal menjadi domain waktu. 
uu11=real(ifft(uu(1,:)));
uu12=real(ifft(uu(2,:))); 


%Plot wavevorm ouput FDICA/input TDICA
figure(4);
subplot(211);plot(uu11);
title('Waveform Sinyal Input TDICA 1')
ylabel('Amplitude');
subplot(212);plot(uu12)
title('Waveform Sinyal Input TDICA 2')
ylabel('Amplitude');


%---------------------------------TDICA------------------------------------
mix=[uu11;uu12];                  %mencampur file suara domain waktu
[N,P]=size(mix);                    %P=sampled time=50000;N=number of input=3
permute=randperm(N);                %generate a permutation vector
s=mix(permute,:);                   %time-scrambled inputs for stationarity

x=s;


mx=mean(mix');
c=cov(mix');
x=x-mx'*ones(1,P);
wz=2*inv(sqrtm(c));
x=wz*x;

w=eye(N);                           % init. unmixing matrix                       
% w=[1 1;1 2];
M=size(w,2);                      
sweep=0; oldw=w; olddelta=ones(1,N*N);
Id=eye(M);

L=0.000001; B=30; for I=1:100, sep; end;          %ITERASI TDICA

% Pemisahan sinyal suara TDICA
yy=w*wz*mix;                        % make unmixed sources
yy11=yy(1,:);
yy12=yy(2,:);


% Plot sinyal estimasi TDICA
figure(5);
subplot(211); plot(yy11);
title('Sinyal Estimasi Output TDICA 1');
ylabel('Amplitude');
subplot(212); plot(yy12);
title('Sinyal Estimasi Output TDICA 2');
ylabel('Amplitude');

%---------------------------THE END----------------------------------------

% Menyimpan file output dalam bentuk .wav
% wavwrite(yy11,Fs,'y11.wav');
% wavwrite(yy12,Fs,'y12.wav');
% wavwrite(yy13,Fs,'y13.wav');
