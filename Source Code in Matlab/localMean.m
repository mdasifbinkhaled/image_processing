function output=localMean(input,m,n)
%m is the neighbor span in across the row
%n is the neighbor span across the column
%getting the row, column and channel length of the input image
[row,column,channel]=size(input);
%converting the input image into double
input=double(input);
%creating the empty output image array
output=uint8(zeros(row,column,channel));
%applying 2k+1==>k=(m-1)/2 to get span of m and 2l+1==>l=(n-1)/2 to get
%span of n
k=int16((m-1)/2);
l=int16((n-1)/2);
%looping through the input image 
for i=1:row
    for j=1:column
        for c=1:channel
            %variables to execute the operation
            temporarySum=0;
            divider=0;
            %looping through all the neighbors including the pixel itself
            for rowOffset=-k:k
                for columnOffset=-l:l
                    %checking whether the indices are valid
                    if (((rowOffset+i)>=1 && (columnOffset+j)>=1)&&((rowOffset+i)<=row && (columnOffset+j)<=column))
                        %summing up all the neighboring pixels including
                        %itself
                        temporarySum=temporarySum+input(i+rowOffset,j+columnOffset,c);
                        %calculating the number of valid pixels among the
                        %neighbors including itself
                        divider=divider+1;
                    end
                end
            end
            %outputting the average of the sum into the output matrix
            output(i,j,c)=round(temporarySum/divider);
        end
    end
end
end