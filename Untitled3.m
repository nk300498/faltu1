clc;clear all;
N = 10^3;                                  % number of bits or symbols
SNR_db = -5:4:35;                           % multiple Eb/N0 values
snr=10.^(SNR_db/10);                         %conversion of snr from db to linear
total_power_BPSK=1;

c = randi([0 1],N,1); % generate 0's and 1's randomly
Q1= (2*c-1)';


Number_of_Rx =  [1 2];


for k = 1:length(Number_of_Rx)

    for i = 1:length(SNR_db)

        n = 1/sqrt(2)*[randn(Number_of_Rx(k),N) + 1i*randn(Number_of_Rx(k),N)]; % white gaussian noise, 0dB variance
        h = 1/sqrt(2)*[randn(Number_of_Rx(k),N) + 1i*randn(Number_of_Rx(k),N)]; % Rayleigh channel

        % Channel and noise Noise addition
       
        y = h.*Q1 + 10^(-SNR_db(i)/20)*n;

        % equalization maximal ratio combining 
        yHat =  sum(conj(h).*y,1)./sum(h.*conj(h),1); 

        % receiver - hard decision decoding
        ipHat = real(yHat)>0;

        % counting the errors
        nErr(k,i) = size(find([c- ipHat]),2);

    end

end

simBer = nErr/N; % simulated ber

 




figure

hold on
semilogy(SNR_db,simBer(1,:),'mo-','LineWidth',2);

semilogy(SNR_db,simBer(2,:),'ks-','LineWidth',2);

grid on
legend( 'nRx=1 (sim)',  'nRx=2 (sim)');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for BPSK modulation with Maximal Ratio Combining in Rayleigh channel');


