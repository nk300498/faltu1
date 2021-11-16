clc;clear all;
SNR_db=-5:2:15;
snr=10.^(SNR_db/10);            %conversion of snr from db to linear 

k=10^2;                    %given number of bit>10^6

x = randi([0 1],k,1)
for i=1:k
    if x==1
        y=1
    else
        y=-1
    end
end
