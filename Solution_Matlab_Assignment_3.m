% ECN519: Digital Communication Laboratory ECE Dept. IITR
% Matlab Assignment 3
% BER versus SNR simulation for QPSK under AWGN channel, Aug. 2021

clc; clear all; close all; clf;

%% Problem-1
SNR_DB    = -5:1:25;           % SNR in dB.
SNR       = 10.^(0.1*SNR_DB);  % linear SNR.
NSym      = 1e6;               
Pow_QPSK  = 1;

% Generate QPSK signal
% Input_bits = round(rand(1,NBits));
Input_integer = randi([0 3],1,NSym);

Bits          = rem(floor(Input_integer(:)./pow2(1:-1:0)),2);

ModSym(:,1) = 1*(Bits(:,1)==0)+(-1)*(Bits(:,1)==1); % Generating the QPSK symbols
ModSym(:,2) = 1*(Bits(:,2)==0)+(-1)*(Bits(:,2)==1); % Generating the QPSK symbols
QPSK_signal = sqrt(1/2)*ModSym(:,1) + sqrt(1/2)*sqrt(-1)*ModSym(:,2);
    
%% AWGN Channel
for snr = 1:length(SNR_DB)
    Noise_var = Pow_QPSK/SNR(snr);
    Noise = sqrt(Noise_var)*sqrt(1/2)*(randn(1,NSym)+sqrt(-1)*randn(1,NSym));
    Received_signal_AWGN  = (QPSK_signal.') + Noise;
   
    Det_integer = zeros(NSym,2);
    for b=1:NSym
        if (real(Received_signal_AWGN(b)) > 0 && imag(Received_signal_AWGN(b)) > 0)  
            Det_bits(b,:) = [0 0];
        elseif (real(Received_signal_AWGN(b)) > 0 && imag(Received_signal_AWGN(b)) < 0)  
            Det_bits(b,:) = [0 1];
        elseif (real(Received_signal_AWGN(b)) < 0 && imag(Received_signal_AWGN(b)) > 0)  
            Det_bits(b,:) = [1 0];
        elseif (real(Received_signal_AWGN(b)) < 0 && imag(Received_signal_AWGN(b)) < 0)  
            Det_bits(b,:) = [1 1];
        end
    end
    Error_symbols = Det_bits(:)-Bits(:);
    Err_count=0;
    for b = 1:length(Error_symbols)
        if (Error_symbols(b)~=0)
            Err_count=Err_count+1;
        end
    end
    BER_QPSK(snr)= (Err_count/(NSym*2));
end

%%
figure(1);
title('BER of QPSK under AWGN channel');
semilogy(SNR_DB,BER_QPSK,'r','LineWidth',2);
hold on;
grid on;
