function output=convolution2D(input,mask)
[row column]=size(input);
[maskRow maskColumn]=size(mask);
%applying 2k+1==>k=(m-1)/2 to get span of m and 2l+1==>l=(n-1)/2 to get
%span of n
m=(maskRow-1)/2;
n=(maskColumn-1)/2;
paddedInput=double(padarray(input,[m n]));
[paddedRow paddedColumn]=size(paddedInput);
alteredMask=rot90(rot90(mask));
output=zeros(row,column);
for i=1:(paddedRow-(maskRow-1))
    for j=1:(paddedColumn-(maskColumn-1))
        store=paddedInput(i:i+(maskRow-1),j:j+(maskColumn-1)).*alteredMask;
        output(i,j)=sum(store(:));
    end 
end
output=uint8(output);
end
