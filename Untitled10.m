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

for i1=1:length(snr)
    
    
 %single receving antenna  L=1; 
N_v = total_power_QPSK/snr(i1);
N_r= sqrt(N_v)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i= sqrt(N_v)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n = N_r + 1i*N_i;




h=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));  %complex fadding coefficient
y =(h.* QPSK_generated_randomly + n)./h;  %after passing through rayleigh channel output
 
for j=1:b                                  %detection of recived signal
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
E = abs(detected - QPSK_generated_randomly);      %number of error calculation

N_E=0;
for k = 1:b
if (E(k)~=0)
N_E=N_E+1;
end
end
BER(i1)=N_E/b;                                     %BER of QPSK in  Rayleigh channel
end
%%





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

%%when L=3
for i1=1:length(snr)
     
    
h10=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));  %complex fadding coefficient
q10=norm(h10)^2;
N_v10 = total_power_QPSK/snr(i1);
N_r10= sqrt(N_v10)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i10= sqrt(N_v10)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n10 = N_r10 + 1i*N_i10;


h20=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));
q20=norm(h20)^2;
N_v20 = total_power_QPSK/snr(i1);
N_r20= sqrt(N_v20)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i20= sqrt(N_v20)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n20= N_r20 + 1i*N_i20;


h30=sqrt(1/2)*(randn(1,b)+1i*randn(1,b));
q30=norm(h30)^2;
N_v30 = total_power_QPSK/snr(i1);
N_r30= sqrt(N_v30)*sqrt(1/2)*(randn(1,b));   %real gaussian noise
N_i30= sqrt(N_v30)*sqrt(1/2)*(randn(1,b));   %Imag gaussian noise
n30= N_r30 + 1i*N_i30;



y1 =(h10.* QPSK_generated_randomly + n10)./h10;  %after passing through rayleigh channel output
y2 =(h20.* QPSK_generated_randomly + n20)./h20;
y3 =(h30.* QPSK_generated_randomly + n30)./h30;



r2=q10*y1+q20*y2+q30*y3;
for j=1:b                                  %detection of recived signal
if real(r2(j))>0 && imag(r2(j))>0
detected2(j)=1+1*1i;
elseif real(r2(j))<0 && imag(r2(j))>0
detected2(j)=-1+1*1i;
elseif real(r2(j))<0 && imag(r2(j))<0

detected2(j)=-1-1*1i;

else

detected2(j)=1-1*1i;

end
end
E2 = abs(detected2 - QPSK_generated_randomly);      %number of error calculation

N_E2=0;
for k = 1:b
if (E2(k)~=0)
N_E2=N_E2+1;
end
end
BER2(i1)=N_E2/b;                                     %BER of QPSK in  Rayleigh channel
end





%%
%%plotting of graph between BER and SNR
semilogy(SNR_db,BER,"-*","linewidth",2)

hold on;

semilogy(SNR_db,BER1,"->","linewidth",2)
semilogy(SNR_db,BER2,"->","linewidth",2)
hold off;
xlabel("SNR(db)");
ylabel("BER");
title("BER versus SNR curve for QPSK in AWGN/Rayleigh channel")
legend('L=1','L=2','L=3')
grid;


%if we obserbe the graph we found 