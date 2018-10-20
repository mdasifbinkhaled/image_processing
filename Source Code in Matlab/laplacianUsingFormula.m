function output=laplacianUsingFormula(input)
[row column channel]=size(input);
paddedInput=double(padarray(double(input),[1 1],0,'both'));
[paddedRow paddedColumn dummy]=size(paddedInput);
output=double(zeros(row,column,channel));

for i=2:(paddedRow-1)
    for j=2:(paddedColumn-1)
        for c=1:channel
            output(i-1,j-1,c)=paddedInput(i+1,j,c)+paddedInput(i-1,j,c)+paddedInput(i,j+1,c)+paddedInput(i,j-1,c)-4*paddedInput(i,j,c);
        end
    end
end

output=uint8(output);

end