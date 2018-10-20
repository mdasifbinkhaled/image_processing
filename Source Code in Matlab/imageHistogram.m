function []=imageHistogram(imageMatrix)
scriptInfo=matlab.desktop.editor.getActive;
targetDirectory=strcat(fileparts(scriptInfo.Filename),'\imageHistogramDirectory')

[row column]=size(imageMatrix);
histogram=ones(row,column,256);

for i=1:row
    for j=1:column
        histogram(i,j,imageMatrix(i,j)+1)=0;
    end
end

if exist(targetDirectory,'dir')==0
    mkdir(targetDirectory);
end

for i=1:256
    
    imwrite(histogram(:,:,i),strcat(strcat(targetDirectory,'\'),strcat(int2str(i),'.jpg')));
end
end
