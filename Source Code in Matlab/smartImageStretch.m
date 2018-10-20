function output=smartImageStretch(input,minCumulativeProbability,maxCumulativeProbability)
%input image dimension
[row column channel]=size(input);

%declaring the look-up table for Probability Density Function
lookUpTablePDFRed=double(zeros(256,1));
lookUpTablePDFGreen=double(zeros(256,1));
lookUpTablePDFBlue=double(zeros(256,1));
%calculating the histogram
for i=1:row
    for j=1:column
        lookUpTablePDFRed(input(i,j,1)+1)=lookUpTablePDFRed(input(i,j,1)+1)+1;
        lookUpTablePDFGreen(input(i,j,2)+1)=lookUpTablePDFGreen(input(i,j,2)+1)+1;
        lookUpTablePDFBlue(input(i,j,3)+1)=lookUpTablePDFBlue(input(i,j,3)+1)+1;
    end
end
lookUpTablePDFRed(:)=lookUpTablePDFRed(:)/(row*column);
lookUpTablePDFGreen(:)=lookUpTablePDFGreen(:)/(row*column);
lookUpTablePDFBlue(:)=lookUpTablePDFBlue(:)/(row*column);

%identifying max and min intensity values from the input
%*******************************************************************
%declaring the minimum value of the red channel from the input image
minInputRed=0;
%declaring the minimum value of the green channel from the input image
minInputGreen=0;
%declaring the minimum value of the blue channel from the input image
minInputBlue=0;
%declaring the maximum value of the red channel from the input image
maxInputRed=0;
%declaring the maximum value of the green channel from the input image
maxInputGreen=0;
%declaring the maximum value of the blue channel from the input image
maxInputBlue=0;
%sum variables
minSumRed=0;
minSumGreen=0;
minSumBlue=0;
maxSumRed=0;
maxSumGreen=0;
maxSumBlue=0;
%finding the minimum intensity value
for i=1:256
    if(minSumRed<=minCumulativeProbability)
        minSumRed=minSumRed+lookUpTablePDFRed(i);
        minInputRed=i;
    end
    if(minSumGreen<=minCumulativeProbability)
        minSumGreen=minSumGreen+lookUpTablePDFGreen(i);
        minInputGreen=i;
    end
    if(minSumBlue<=minCumulativeProbability)
        minSumBlue=minSumBlue+lookUpTablePDFBlue(i);
        minInputBlue=i;
    end
end
%finding the minimum intensity value
for i=256:-1:1
    if(maxSumRed<=maxCumulativeProbability)
        maxSumRed=maxSumRed+lookUpTablePDFRed(i);
        maxInputRed=i;
        
    end
    if(maxSumGreen<=maxCumulativeProbability)
        maxSumGreen=maxSumGreen+lookUpTablePDFGreen(i);
        maxInputGreen=i;
    end
    if(maxSumBlue<=maxCumulativeProbability)
        maxSumBlue=maxSumBlue+lookUpTablePDFBlue(i);
        maxInputBlue=i;
    end
end

%*******************************************************************
%setting max and min intensity values of output
%*******************************************************************
%setting the minimum value of the red channel of the Output image
minOutputRed=0;
%setting the minimum value of the green channel of the Output image
minOutputGreen=0;
%setting the minimum value of the blue channel of the Output image
minOutputBlue=0;
%setting the maximum value of the red channel of the Output image
maxOutputRed=255;
%setting the maximum value of the green channel of the Output image
maxOutputGreen=255;
%setting the maximum value of the blue channel of the Output image
maxOutputBlue=255;
%*******************************************************************

%declaring the look-up table for the output intensity values of the red
%channel
lookUpTableRed=double(zeros(256,1));
%declaring the look-up table for the output intensity values of the green
%channel
lookUpTableGreen=double(zeros(256,1));
%declaring the look-up table for the output intensity values of the blue
%channel
lookUpTableBlue=double(zeros(256,1));

%generating the values of the output image and storing them in the lookup
%tables
for i=1:256
    lookUpTableRed(i)=round(double((maxOutputRed-minOutputRed))*(double((i-1)-minInputRed)/double(maxInputRed-minInputRed))+double(minOutputRed));
    lookUpTableGreen(i)=round(double((maxOutputGreen-minOutputGreen))*(double((i-1)-minInputGreen)/double(maxInputGreen-minInputGreen))+double(minOutputGreen));
    lookUpTableBlue(i)=round(double((maxOutputBlue-minOutputBlue))*(double((i-1)-minInputBlue)/double(maxInputBlue-minInputBlue))+double(minOutputBlue));
end

%generating the output image from the look-up table

output=uint8(zeros(row,column,channel));

for i=1:row
    for j=1:column
        output(i,j,1)=lookUpTableRed(input(i,j,1)+1);
        output(i,j,2)=lookUpTableGreen(input(i,j,2)+1);
        output(i,j,3)=lookUpTableBlue(input(i,j,3)+1);
    end
end

end