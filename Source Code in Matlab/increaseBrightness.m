function output=increaseBrightness(inputImage,increment)
[row column channel]=size(inputImage);
output=uint8(zeros(row,column,channel));
for i=1:row
    for j=1:column
        for c=1:channel
            store=inputImage(i,j,c)+increment;
            if(store>255)
                output(i,j,c)=255;
            else
                output(i,j,c)=store;
            end
        end
    end
end
end