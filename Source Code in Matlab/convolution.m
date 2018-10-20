function output=convolution(input,mask)
[row column channel]=size(input);
[maskRow maskColumn]=size(mask);
alteredMask=rot90(rot90(mask));
%applying 2k+1==>k=(m-1)/2 to get span of m and 2l+1==>l=(n-1)/2 to get
%span of n
m=(maskRow-1)/2;
n=(maskColumn-1)/2;
paddedInput=double(padarray(input,[m n],0,'both'));
[paddedRow paddedColumn dummy]=size(paddedInput);
output=zeros(row,column,channel);

for i=1:(paddedRow-(maskRow-1))
    for j=1:(paddedColumn-(maskColumn-1))
        for c=1:channel
            store=paddedInput(i:i+(maskRow-1),j:j+(maskColumn-1),c).*alteredMask;
            output(i,j,c)=sum(store(:));
        end
    end 
end
output=uint8(output);
end