%----determine the SNR---------
snr = 10*log10(sum(clean.^2) ./ sum(noise.^2))
% sigal_freq=fft(aa,1024);
% noise_freq=fft(nn,1024);
% 
% signal_tot=0;
% noise_tot=0;
% 
% for t=1;
%     signal_tot=signal_tot+(signal_freq[t]^2);
%     noise_tot=noise_tot+(noise_freq[t]^2);
% end;

% powers=signal_tot/1024;
% powern=noise_tot/1024;
% 
% SNR=powers/powern;
% dB_SNR=log10(SNR)
