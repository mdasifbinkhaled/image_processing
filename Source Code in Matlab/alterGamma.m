function output=alterGamma(inputImage,alterValue)
[row column channel]=size(inputImage);
output=uint8(zeros(row,column,channel));
for i=1:row
    for j=1:column
        for c=1:channel
            output(i,j,c)=255*((double(inputImage(i,j,c))/255)^(1/alterValue));
        end
    end
end
end