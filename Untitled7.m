
k=10^2;                         %given number of bit>10^6

b = randi([-1 1],k,1);
for i=1:k
    if b(i)==0
        x(i)=-1
    else
        x(i)=1
    end
end