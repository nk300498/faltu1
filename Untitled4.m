close all;clear all;clc;
SNRdB=1:1:12;                                       %Signal to Noise Ratio in dB
SNR=10.^(SNRdB/10);  
semilogy(SNRdB,qfunc(sqrt(SNR)),'b-','linewidth',2.0); 