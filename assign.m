%assignment-4(Bit Error rate of QPSK vs SNR In AWGN/Rayleigh channel)
clc;clear all;
SNR_db=-5:4:30;
snr=10.^(SNR_db/10); %conversion of snr from db to linear
b=10; %given number of bit>10^4
total_power_BPSK=1;

c = randi([0 1],b,1); % generate 0's and 1's randomly
Q1= (2*c-1)';


%% When Bit transmitted noise added in Rayleigh channel i.e y=hx+n;

for i1=1:length(snr)
    
    
 %single receving antenna  L=1; 
h=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));  %complex fadding coefficient
h1=norm(h)^2;
N_v =h1* total_power_BPSK/snr(i1);
N_r= sqrt(N_v)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i= sqrt(N_v)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n = N_r + 1i*N_i;


y =h.*Q1 + n;                           %after passing through rayleigh channel output
r =h1*y+n
detected=real(r)>0

E(i1) =  size(find([detected + Q1]>1),2);            %number of error calculation


end
BER=E/b;                                     %BER of QPSK in  Rayleigh channel

%%










%%
%%plotting of graph between BER and SNR
semilogy(SNR_db,BER,"-*","linewidth",2)

hold on;


hold off;
xlabel("SNR(db)");
ylabel("BER");
title("BER versus SNR curve for QPSK in AWGN/Rayleigh channel")
legend('L=1')
grid;


%if we obserbe the graph we found 