function lookUpTableInput=valueHistogram(input)
input=double(input);
[inputRow inputColumn inputChannel]=size(input);
lookUpTableInput=zeros(1,256);
for i=1:inputRow
    for j=1:inputColumn
        value=ceil((1/inputChannel)*(sum(input(i,j,:))));
        lookUpTableInput(1,value)=lookUpTableInput(1,value)+1;
    end
end
end