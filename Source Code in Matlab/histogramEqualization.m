function output=histogramEqualization(inputImage)

[row column channel]=size(inputImage);
lookUpTable=zeros(channel,256);
output=zeros(size(inputImage));
for i=1:row
    for j=1:column
        for c=1:channel
            lookUpTable(c,inputImage(i,j,c)+1)=lookUpTable(c,inputImage(i,j,c)+1)+1;
        end
    end
end

for i=1:256
    for c=1:channel
        lookUpTable(c,i)=lookUpTable(c,i)/(row*column);
    end
end

for i=2:256
    for c=1:channel
        lookUpTable(c,i)=lookUpTable(c,i)+lookUpTable(c,i-1);
    end
end

for i=1:row
    for j=1:column
        for c=1:channel
            output(i,j,c)=255*lookUpTable(c,inputImage(i,j,c)+1);
        end
    end
end

output=uint8(output);

end