%assignment-3(Bit Error rate of QPSK vs SNR In AWGN channel)
clc;clear all;
SNR_db=-5:2:25;
snr=10.^(SNR_db/10); %conversion of snr from db to linear
b=10^7; %given number of bit>10^4
Real_power=sqrt(1/2);
Imag_power=sqrt(1/2);
total_power=1;

c = randi([0 1],b,1); % generate 0's and 1's randomly
d = randi([0 1],b,1); % generate 0's and 1's randomly
Q1= 2*c-1;
Q2= 2*d-1;
QPSK_generated_randomly=(Q1+1i*Q2)';

%% When Bit transmitted some noise added in AWGN channel i.e y=x+n;
for i=1:length(snr)
N_v = total_power/snr(i);
N_r= sqrt(N_v/2)*(randn(1,b)); %real gaussian noise
N_i= sqrt(N_v/2)*(randn(1,b)); %Imag gaussian noise
n = N_r + 1i*N_i;
y = QPSK_generated_randomly + n; %passing through AWGN channel
for j=1:b %detection of recived signal
if real(y(j))>0 && imag(y(j))>0
detected(j)=1+1*1i;
elseif real(y(j))<0 && imag(y(j))>0
detected(j)=-1+1*1i;
elseif real(y(j))<0 && imag(y(j))<0

detected(j)=-1-1*1i;

else

detected(j)=1-1*1i;

end
end
E = abs(detected - QPSK_generated_randomly); %number of error calculation
N_E=0;
for k = 1:b
if (E(k)~=0)
N_E=N_E+1;
end
end
BER(i)=N_E/b;
end
%%
semilogy(SNR_db,BER,"->","linewidth",2)
xlabel("SNR(db)");
ylabel("BER");
title("BER versus SNR curve for QPSK in AWGN channel")
axis tight;
grid;