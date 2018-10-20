function output=histogramMatching(idealImage,input)
idealImage=double(idealImage);
input=double(input);
[idealImageRow idealImageColumn idealImageChannel]=size(idealImage);
[inputRow inputColumn inputChannel]=size(input);

lookUpTableIdealImage=zeros(idealImageChannel,256);
lookUpTableInput=zeros(inputChannel,256);
lookUpTableOutput=zeros(inputChannel,256);

output=zeros(size(input));


for i=1:idealImageRow
    for j=1:idealImageColumn
        for c=1:idealImageChannel
            lookUpTableIdealImage(c,idealImage(i,j,c)+1)=lookUpTableIdealImage(c,idealImage(i,j,c)+1)+1;
        end
    end
end

for i=1:256
    for c=1:idealImageChannel
        lookUpTableIdealImage(c,i)=lookUpTableIdealImage(c,i)/(idealImageRow*idealImageColumn);
    end
end

for i=2:256
    for c=1:idealImageChannel
        lookUpTableIdealImage(c,i)=lookUpTableIdealImage(c,i)+lookUpTableIdealImage(c,i-1);
    end
end

for i=1:inputRow
    for j=1:inputColumn
        for c=1:inputChannel
            lookUpTableInput(c,input(i,j,c)+1)=lookUpTableInput(c,input(i,j,c)+1)+1;
        end
    end
end

for i=1:256
    for c=1:inputChannel
        lookUpTableInput(c,i)=lookUpTableInput(c,i)/(inputRow*inputColumn);
    end
end

for i=2:256
    for c=1:inputChannel
        lookUpTableInput(c,i)=lookUpTableInput(c,i)+lookUpTableInput(c,i-1);
    end
end

for c=1:inputChannel    
    for i=1:256
        idealCounter=1;
        while (idealCounter<=256) & lookUpTableIdealImage(c,idealCounter)<(lookUpTableInput(c,i))
            idealCounter=idealCounter+1;
            if(idealCounter>256)
                break
            end
        end
        
        lookUpTableOutput(c,i)=idealCounter-1;
    end
end

for i=1:inputRow
    for j=1:inputColumn
        for c=1:inputChannel
            output(i,j,c)=lookUpTableOutput(c,input(i,j,c)+1);
        end
    end
end


%output=uint8(output);

end
