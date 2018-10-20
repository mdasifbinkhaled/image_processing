function lookUpTableInput=luminanceHistogram(input)
input=double(input);
[inputRow inputColumn inputChannel]=size(input);
lookUpTableInput=zeros(1,256);
for i=1:inputRow
    for j=1:inputColumn
        value=ceil((1/3)*(.299*input(i,j,1)+.587*input(i,j,2)+.114*input(i,j,3)));
        lookUpTableInput(1,value)=lookUpTableInput(1,value)+1;
    end
end
end