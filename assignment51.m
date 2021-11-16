%assignment-4(Bit Error rate of QPSK vs SNR In AWGN/Rayleigh channel)
clc;clear all;
SNR_db=-5:4:30;
snr=10.^(SNR_db/10); %conversion of snr from db to linear
b=10^6; %given number of bit>10^4
total_power_QPSK=2;

c = randi([0 1],b,1); % generate 0's and 1's randomly
d = randi([0 1],b,1); % generate 0's and 1's randomly
Q1= 2*c-1;
Q2= 2*d-1;
QPSK_generated_randomly=(Q1+1i*Q2)';

%% When Bit transmitted noise added in Rayleigh channel i.e y=hx+n;

% receving antenna=2


for i1=1:length(snr)
     
    
h1=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));  %complex fadding coefficient
q1=norm(h1)^2;
N_v1 = total_power_QPSK/snr(i1);
N_r1= sqrt(N_v1)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i1= sqrt(N_v1)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n1 = N_r1 + 1i*N_i1;


h2=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));
q2=norm(h2)^2;
N_v2 = total_power_QPSK/snr(i1);

N_r2= sqrt(N_v2)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i2= sqrt(N_v2)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n2 = N_r2 + 1i*N_i2;




y1 =(h1.* QPSK_generated_randomly + n1)./h1;  %after passing through rayleigh channel output
y2 =(h2.* QPSK_generated_randomly + n2)./h2;

r1=q1*y1+q2*y2;
for j=1:b                                  %detection of recived signal
if real(r1(j))>0 && imag(r1(j))>0
detected1(j)=1+1*1i;
elseif real(r1(j))<0 && imag(r1(j))>0
detected1(j)=-1+1*1i;
elseif real(r1(j))<0 && imag(r1(j))<0

detected1(j)=-1-1*1i;

else

detected1(j)=1-1*1i;

end
end
E1 = abs(detected1 - QPSK_generated_randomly);      %number of error calculation

N_E1=0;
for k = 1:b
if (E1(k)~=0)
N_E1=N_E1+1;
end
end
BER1(i1)=N_E1/b;                                     %BER of QPSK in  Rayleigh channel
end


% receving antenna=2


for i1=1:length(snr)
     
    
h100=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));  %complex fadding coefficient
q100=h100/abs(h100);
N_v100 = total_power_QPSK/snr(i1);
N_r100= sqrt(N_v100)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i100= sqrt(N_v100)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n100 = N_r100 + 1i*N_i100;


h200=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));
q200=h200/abs(h200);
N_v200 = total_power_QPSK/snr(i1);

N_r200= sqrt(N_v200)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i200= sqrt(N_v200)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n200 = N_r200 + 1i*N_i200;




y100 =(h100.* QPSK_generated_randomly + n100)./h100;  %after passing through rayleigh channel output
y200 =(h200.* QPSK_generated_randomly + n200)./h200;

r100=q100*y100+q200*y200;
for j=1:b                                  %detection of recived signal
if real(r100(j))>0 && imag(r100(j))>0
detected100(j)=1+1*1i;
elseif real(r100(j))<0 && imag(r100(j))>0
detected100(j)=-1+1*1i;
elseif real(r100(j))<0 && imag(r100(j))<0

detected100(j)=-1-1*1i;

else

detected100(j)=1-1*1i;

end
end
E100 = abs(detected100 - QPSK_generated_randomly);      %number of error calculation

N_E100=0;
for k = 1:b
if (E100(k)~=0)
N_E100=N_E100+1;
end
end
BER100(i1)=N_E100/b;                                     %BER of QPSK in  Rayleigh channel
end

semilogy(SNR_db,BER1,"->","linewidth",2)
hold on;
semilogy(SNR_db,BER100,"->","linewidth",2)

xlabel("SNR(db)");
ylabel("BER");
title("BER versus SNR curve for QPSK in AWGN/Rayleigh channel")
legend('MRC','equal gain')
grid;
hold off;

%if we obserbe the graph we found 