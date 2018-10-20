function output=imageAveraging(directory)
listOfContent=dir(strcat(directory,'\*.jpg'));
imageSummation=0;
insideTheDirectory=strcat(directory,'\');
for i=1:size(listOfContent,1)
    fileLocation=strcat(insideTheDirectory,listOfContent(i).name);
    imageSummation=imageSummation+imread(fileLocation);
end
output=uint8(imageSummation/size(listOfContent,1));
end