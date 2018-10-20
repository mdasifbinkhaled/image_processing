function output=decreaseBrightness(inputImage,decrement)
[row column channel]=size(inputImage);
output=uint8(zeros(row,column,channel));
for i=1:row
    for j=1:column
        for c=1:channel
            store=inputImage(i,j,c)-decrement;
            if(store<0)
                output(i,j,c)=0;
            else
                output(i,j,c)=store;
            end
        end
    end
end
end