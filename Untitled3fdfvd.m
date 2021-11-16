%Capacity plot for fixed single-input multiple-output (SIMO) channel.
%if you get only 4 graph that means 2 graph coincides so please run program
%again
clc;
%in this section parameter given or assume by myself
SNR=-10:2:40;%This SNR is in db given in problem
Nr=5;%Given in question we take total 5 number of receiving antenna
v=12.5;% we take variance as it from problem-2

%evaluating the formula
x=10.^((SNR/10)); %But in Capacity formula SNR is not in db,
%so conversion from db to absolute value;
h=1/(sqrt(v))*(randn(1,Nr)+1i*randn(1,Nr)); %in question given take
%complex Normal distribution
n=(abs(h).^2)'; %in capacity formula it is given square of normalization of h
C=log2(1+n*x);

%plotting of graph and marking the parameter
plot(SNR,C,"linewidth",1.5);
grid;
xlabel("SNR(db)");
ylabel("Capacity(bit/sec)");
title("Capacity plot for fixed single-input multiple-output (SIMO) channel")
legend("M=1","M=2","M=3","M=4","m=5","location","northwest")
%if we run this program multiple time we get different graphs,because we take
%Random Normal distribution function which is generated by Matlab due to
%this we get different graphs but shape of all graphs are same.and sometimes
%two graph coincides