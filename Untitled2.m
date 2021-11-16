clc;clear all;
%in this section parameter given or assume by myself

SNR=-5:4:30;                      %This SNR is in db given in problem
x=10.^((SNR/10));                  %Linear form of snr
x2=10.^(-(SNR/20));
Nt=2;                              %for MISO 2 tx antenna
Nr1=1;                              %Given in question we take total 2 number of receiving antenna for MIMO
Nr2=2;                            %for MISO system 1 rx antenna

v=1/2;
B=10^6;                            %Number of bit >10^4

% Generate BPSK signal, +1,-1
% Input_bits = round(rand(1,NBits));  % generate 0's and 1's randomly

Input_bits = randi([0 1],1,B);       % generate 0's and 1's randomly
BPSK_signal = 2*Input_bits-1;         % generate BPSK signals
r=reshape(BPSK_signal,2,B/2);
A1= zeros(2,B);
z1=ones(1,2);
y20 = zeros(Nr2,B);
y50 = zeros(Nr2*2,B);
g = zeros(Nr2*2,B);
    
    
for i = 1:length(SNR)
    h1=(sqrt(v))*(randn(1,B)+1i*randn(1,B));   %Given in question consider Rayleigh channel
    z2=reshape(h1,2,B/2);
    %kron(A,B) returns the Kronecker tensor product of matrices A and B. If A is an m-by-n matrix and B is a p-by-q matrix, 
    %then kron(A,B) is an m*p-by-n*q matrix formed by taking all possible products between the elements of A and the matrix B.
     H = kron(z2,z1); 
   
   N_r= sqrt(v)*(randn(1,B));                   %real gaussian noise
   N_i= sqrt(v)*(randn(1,B));                   %Imag gaussian noise
   n = N_r + 1i*N_i;                            %white gaussian noise
   
    A1(:,1:2:end) = sqrt(v)*r;
  %kron(A,B) returns the Kronecker tensor product of matrices A and B
  %flipud(A) returns A with its rows flipped in the up-down direction (that is, about a horizontal axis)
                c=flipud(reshape(conj(BPSK_signal),2,B/2));
                A1(:,2:2:end) = sqrt(v)*(kron(ones(1,B/2),[-1;1]).*c) ;

 %received symbol y at the receiver corresponding to this transmission is given as
    y = sum(H.*A1,1) +x2(i)*n;
    
    y1 = kron(reshape(y,2,B/2),ones(1,2));          
    y1(2,:) = conj(y1(2,:));                     

    A1(:,1:2:end) = z2; 
    A1(:,2:2:end) = kron(ones(1,B/2),[1;-1]).*flipud(z2); 
    A1(1,:) = conj(A1(1,:));
    Power = sum(A1.*conj(A1),1);
    y2 = sum(A1.*y1,1)./Power; 
    y2(2:2:end) = conj(y2(2:2:end));
   
    input_bits_2 = real(y2)>0;                % At receiver  decision Making
    
    total_error1(i) = size(find([Input_bits - input_bits_2]),2); % total  errors
end

simBer1 = total_error1/B; % so simulated Bit error rate


%% Problem-2
for i = 1:length(SNR)

    h2 = sqrt(v)*(randn(Nr2,B) + 1i*randn(Nr2,B));         % Rayleigh channel
    
    N_r= sqrt(v)*(randn(Nr2,B));                            %real gaussian noise
    N_i= sqrt(v)*(randn(Nr2,B));                           %Imag gaussian noise
    n = N_r + 1i*N_i;                                        %white gaussian noise
 %kron(A,B) returns the Kronecker tensor product of matrices A and B. If A is an m-by-n matrix and B is a p-by-q matrix, 
 %then kron(A,B) is an m*p-by-n*q matrix formed by taking all possible products between the elements of A and the matrix B.
    A3 =sqrt(v)*kron(r,z1) ;
    
    for j = 1:Nr2
    
        g = kron(reshape(h2(j,:),2,B/2),z1);
        m = g;
        g(1,2:2:end) = conj(m(2,2:2:end)); 
        g(2,2:2:end) = -conj(m(1,2:2:end));
        y20(j,:) = sum(g.*A3,1) + 10^(-SNR(i)/20)*n(j,:);
        y50([2*j-1:2*j],:) = kron(reshape(y20(j,:),2,B/2),z1);
        h_m([2*j-1:2*j],:) = g;
        h_m(2*j-1,[1:2:end]) = conj(h_m(2*j-1,[1:2:end]));
        h_m(2*j,  [2:2:end]) = conj(h_m(2*j,  [2:2:end]));
    end

    h12 = sum(h_m.*conj(h_m),1);
    yt = sum(h_m.*y50,1)./h12; 
    yt(2:2:end) = conj(yt(2:2:end));
    t = real(yt)>0;
    total_error2(i) = size(find([Input_bits- t]),2);

end

simBer2 = total_error2/B; % simulated ber



semilogy(SNR,simBer1,"-*",'LineWidth',2);
hold on;
semilogy(SNR,simBer2,"-*",'LineWidth',2);
xlabel("SNR(db)");
ylabel("Bit Error Rate");
legend('MISO(*1)','MIMO(2*2)');
grid on;
title("BER versus SNR for MISO(2*1) and MIMO(2*2)system with space-time Alamouti coding under Rayleigh communication channel")








