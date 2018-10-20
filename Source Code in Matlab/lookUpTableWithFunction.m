function lookUpTable=lookUpTableWithFunction(inputImage)
[row column channel]=size(inputImage);
lookUpTable=zeros(channel,256);
for i=1:row
    for j=1:column
        for c=1:channel
            lookUpTable(c,inputImage(i,j,c)+1)=functionImplementation(inputImage(i,j,c));
        end
    end
end
end
function output=functionImplementation(inputValue)
a=2;
output=255/(1+exp(-a*(double(inputValue)-127)/32));
end