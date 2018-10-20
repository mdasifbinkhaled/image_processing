function output=medianFiltering(input,m,n)
%m is the neighbor span in across the row
%n is the neighbor span across the column
%getting the row, column and channel length of the input image
[row,column,channel]=size(input);
%creating the empty output image array
output=uint8(zeros(row,column,channel));
%applying 2k+1==>k=(m-1)/2 to get span of m and 2l+1==>l=(n-1)/2 to get
%span of n
k=int16((m-1)/2);
l=int16((n-1)/2);
%looping through the input image
for i=1:row
    for j=1:column
        linearized=uint8(zeros(channel,m*n));
        for c=1:channel
            linearizedCount=1;
            for rowOffset=-k:k
                for columnOffset=-l:l
                    if (((rowOffset+i)>=1 && (columnOffset+j)>=1)&&((rowOffset+i)<=row && (columnOffset+j)<=column))
                        linearized(c,linearizedCount)=input((rowOffset+i),(columnOffset+j),c);
                    end
                    linearizedCount=linearizedCount+1;
                end
            end
            temporaryLinearized=linearized(c,:);
            temporaryLinearized=sort(temporaryLinearized);
            output(i,j,c)=temporaryLinearized(ceil((m*n)/2));
        end
    end
end
end