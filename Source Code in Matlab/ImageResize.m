
function Output_Image_Matrix=ImageResize(Image_Matrix, Resize_Amount)
%algorithm
%nearest neighbor - nn
%bilinear interpolation - bli
algorithm='bli';
%
%start of error handling*************************
%getting the size of the input matrix
[inputRow,inputColumn]=size(Image_Matrix);
%getting the length of the input matrix
sizeLength=length(size(Image_Matrix));
%getting the class of the input matrix
class=isa(Image_Matrix,'uint8');
%getting the length of the third dimension
channel=length(Image_Matrix(1,1,:));
%checking whether the input matrix is 2 Dimensional or not
if(sizeLength~=2)
    error('Input Matrix is not a 2 Dimensional Matrix');
end
%checking whether the input matrix is of type uint8 or not
if(class~=1)
    error('Input Matrix is not ot type uint8');
end
%checking whether the length of the third dimension is 1 or not
if(channel~=1)
    error('Channel size is not 1');
end
%end of error handling*************************
%Calculating the size of the new matrix
outputRow=ceil(inputRow*Resize_Amount);
outputColumn=ceil(inputColumn*Resize_Amount);
%Generating the new matrix with dummy values.
Output_Image_Matrix=uint8(zeros(outputRow,outputColumn));
%*************************************
%Using the Nearest Neighbor algorithm
%*************************************
if strcmp(algorithm,'nn')
    %outer loop starting from 0 to 1 less than the row size of the desired
    %matrix
    for i= 0:outputRow-1
        %inner loop starting from 0 to 1 less than the column size of the
        %desired matrix
        for j= 0:outputColumn-1
            x = floor(i/Resize_Amount);
            y = floor(j/Resize_Amount);
            Output_Image_Matrix(i+1, j+1) = Image_Matrix(x+1, y+1);
        end
    end
end
%*******************************************
%Using the Bilinear Interpolation algorithm
%*******************************************
%calculating input and output row and column ratio
if strcmp(algorithm,'bli')
    rowRatio=inputRow/outputRow;
    columnRatio=inputColumn/outputColumn;
    %
    [columnMid,rowMid] = meshgrid(1 : outputColumn , 1 :outputRow );
    %
    rowMid=rowMid*rowRatio;
    columnMid=columnMid*columnRatio;
    %
    baseRow=floor(rowMid);
    baseColumn=floor(columnMid);
    %
    baseRow(baseRow<1)=1;
    baseColumn(baseColumn<1)=1;
    baseRow(baseRow>inputRow-1)=inputRow-1;
    baseColumn(baseColumn>inputColumn-1)=inputColumn-1;
    %
    deltaRow=rowMid-baseRow;
    deltaColumn=columnMid-baseColumn;
    %
    linearIndex1 = sub2ind([inputRow, inputColumn], baseRow, baseColumn);
    linearIndex2 = sub2ind([inputRow, inputColumn], baseRow+1,baseColumn);
    linearIndex3 = sub2ind([inputRow, inputColumn], baseRow, baseColumn+1);
    linearIndex4 = sub2ind([inputRow, inputColumn], baseRow+1, baseColumn+1);
    %
    
    intensity=double(Image_Matrix(:,:,1));
    temporary = intensity(linearIndex1).*(1 - deltaRow).*(1 - deltaColumn) + ...
        intensity(linearIndex2).*(deltaRow).*(1 - deltaColumn) + ...
        intensity(linearIndex3).*(1 - deltaRow).*(deltaColumn) + ...
        intensity(linearIndex4).*(deltaRow).*(deltaColumn);
    
    Output_Image_Matrix(:,:)=temporary;
end
end
