clc;clear all;
s=0;
SNR_db=-5:2:15;
snr=10.^(SNR_db/10);   %conversion of snr from db to linear 
k=10^8;                %given number of bit>10^6
mean=0;                   
varience=1.3;               
std=sqrt(varience); 
                  


%% 
for i=1:length(snr) 
    
    %% 
b = randi([0 1],k,1);      %generation of random bit 0 and 1
%assigning of 0 and 1 to -1 and +1;
for j=1:k
    if b(j)==0
        x(j)=-1;
    else
        x(j)=1;
    end
end

%% 

n= std*randn(1,k)+mean;           %real_gaussian_noise geneartion

y=(sqrt(snr(i))*x)+n;

for t=1:k
    if y(t)>=0
        r(t,1)=1;
    else
        r(t,1)=0;
    
    
    end
end
c=xor(b,r);
d(i)=length(c(c>0));
end
d=d/k;

%% Ploting of grapgh Between SNR(db) and Bit error rate
semilogy(SNR_db,d,"r-o")
hold on
BER_AWGN=0.5*exp(-(snr/2));        %Theretical generation of BER of AWGN 
semilogy(SNR_db,BER_AWGN,"o-")
grid;
xlabel("SNR(db)");
ylabel("BER")
hold off
%% 



        




 
  

        
        
       



