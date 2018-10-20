function output=imageStretch(input)
%identifying max and min intensity values from the input
%*******************************************************************
%getting the minimum value of the red channel from the input image
minInputRed=min(min(input(:,:,1)));
%getting the minimum value of the green channel from the input image
minInputGreen=min(min(input(:,:,2)));
%getting the minimum value of the blue channel from the input image
minInputBlue=min(min(input(:,:,3)));
%getting the maximum value of the red channel from the input image
maxInputRed=max(max(input(:,:,1)));
%getting the maximum value of the green channel from the input image
maxInputGreen=max(max(input(:,:,2)));
%getting the maximum value of the blue channel from the input image
maxInputBlue=max(max(input(:,:,3)));
%*******************************************************************
%setting max and min intensity values of output
%*******************************************************************
%setting the minimum value of the red channel of the Output image
minOutputRed=50;
%setting the minimum value of the green channel of the Output image
minOutputGreen=50;
%setting the minimum value of the blue channel of the Output image
minOutputBlue=50;
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
[row column channel]=size(input);
output=uint8(zeros(row,column,channel));

for i=1:row
    for j=1:column
        output(i,j,1)=lookUpTableRed(input(i,j,1)+1);
        output(i,j,2)=lookUpTableGreen(input(i,j,2)+1);
        output(i,j,3)=lookUpTableBlue(input(i,j,3)+1);
    end
end

end