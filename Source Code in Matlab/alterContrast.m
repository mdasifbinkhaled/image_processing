function output=alterContrast(inputImage,alterValue)
[row column channel]=size(inputImage);
output=uint8(zeros(row,column,channel));
for i=1:row
    for j=1:column
        for c=1:channel
            store=alterValue*(double(inputImage(i,j,c))-127)+127;
            if(store>255)
                output(i,j,c)=255;
            elseif(store<0)
                output(i,j,c)=0;
            else
                output(i,j,c)=store;
            end
        end
    end
end
end