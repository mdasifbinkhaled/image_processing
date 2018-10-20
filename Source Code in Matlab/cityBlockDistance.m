function output=cityBlockDistance(m,n)
output=zeros(m,n);
xCenter=floor(m/2)+1;
yCenter=floor(n/2)+1;
for i=1:m
    for j=1:n
        output(i,j)=abs(xCenter-i)+abs(yCenter-j);
    end
end
end
