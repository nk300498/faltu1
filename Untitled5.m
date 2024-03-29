close all;clear all;clc;
SNRdB=1:1:12;                                       %Signal to Noise Ratio in dB
SNR=10.^(SNRdB/10);                             %Signal to Noise Ratio in Linear Scale
Bit_Length=10^6;
%No. of Bits Transmitted


BER_Simulated=zeros(1,length(SNRdB));      %Simulated Bit Error Rate
%Detection Scheme:(Soft Detection)
%+1 if o/p >=0
%-1 if o/p<0
%Error if input and output are of different signs
%% BPSK Transmission over AWGN channel
parfor k=1:length(SNR);
    x=(2*floor(2*rand(1,Bit_Length)))-1;
    y=(sqrt(SNR(k))*x)+randn(1,Bit_Length);
                                                                
    BER_Simulated(k)=length(find((y.*x)<0));                  %Total number of bits in error
end
BER_Simulated=BER_Simulated/Bit_Length;