% LISTING PROGRAM of INSTANTANEOUS FREKUQUENCY
% CALCULATE SPECTROGRAM AND INSTANTANEOUS FREQUENCY 
% FINAL PROJECT BY BAGUS TRIS ATMAJA - 2405 100 019
% TITLE : MACHINE SOUNDS SEPARATION USING INDEPENDEN COMPONENT ANALYSIS
% FROM MICROPHONE ARRAY FOR FAULT DETECTION
% LISTING ADAPTED FROM http://labrosa.ee.columbia.edu
% -------------------------------------------------------------------------

% close all
% clear all
% clc
%r=11025;
%d=bearing

[d,r]=wavread('x11.wav');
[I,S]=ifgram(d,256,256,128,r);
[R,M]=extractrax(abs(S));
a=size(R);
F=colinterpvals(R,I);
P=-colinterpvals(R,unwrap(angle(S)));
size(F);

tt=[1:a(2)]*128/r;                     % default spectogram step is NFFT/2 i.e 128
size(tt);

specgram(d,256,r); ylim([0 5000]);
hold on;
figure; 
plot(tt,F','r'); ylim([0 5000]);