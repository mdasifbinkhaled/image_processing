function lookUpTable=histogramOfImage(inputImage)
[row column channel]=size(inputImage);
lookUpTable=zeros(channel,256);
for i=1:row
    for j=1:column
        for c=1:channel
            lookUpTable(c,inputImage(i,j,c)+1)=lookUpTable(c,inputImage(i,j,c)+1)+1;
        end
    end
end
end