close all;clear all;clc;
SNRdB=1:1:12;                                       %Signal to Noise Ratio in dB
SNR=10.^(SNRdB/10);                             %Signal to Noise Ratio in Linear Scale
Bit_Length=10^6;
%No. of Bits Transmitted


BER_Simulated=zeros(1,length(SNRdB))