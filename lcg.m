function [p, mean, var, oneperiod]=lcg(a, c, m, x)
% Linear Congruential Generators
% x the initial seed, 0 <= c < m
% a the multiplier, 0 <= a < m, normally greater than 1
% c the increment 0 <= c < m
% m the modulus, prime numbers are best
xseq=x;
for j=1:m+5  % generate m+5 integers
  x= rem((a*x+c),m);   % (a*x + c) mod m;
  xseq=[xseq;x];  % concatenate numbers, in a cloumn
  row=xseq';  % transpose to a row
end

% find out the period
i=1;
j=2;
while row(i) ~= row(j)
  if j > m  % integer row(i) doesn’t repeat in the sequence
    i=i+1;  % see if the next integer repeats or not
    j=i;
  end;
  j=j+1;
end;
p=j-i;
% one period of random integer number
oneperiod=row(i:i+p+2);   % one period and three integers

% calculate the real number of a period p
 r=row(i:i+p-1)/m;  % divide by m, so distributed in [0,1)
 mean = sum(r)/p; % average
 diff=mean-r;
 square=diff.*diff;
 var=sum(square)/p; % variance