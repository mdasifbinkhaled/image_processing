function output=imageRotation(input,angle)
input=double(input);
angleInRadian=deg2rad(angle);
[inputRow inputColumn inputChannel]=size(input);
aspectAngle=rad2deg(atan(inputRow/inputColumn));
aspectAngleInRadian=deg2rad(aspectAngle);

diagonalLength=sqrt(inputRow^2+inputColumn^2);

rowCenter=floor(inputRow/2)+1;
columnCeter=floor(inputColumn/2)+1;

rotationMatrix=[cos(angleInRadian) sin(angleInRadian);-sin(angleInRadian) cos(angleInRadian)];
rowOutput=0;
columnOutput=0;
if(angle>=0 && angle<90)
    rowOutput=round(abs(diagonalLength*rad2deg(sin(angleInRadian+aspectAngleInRadian))));
    columnOutput=round(abs(diagonalLength*rad2deg(cos(angleInRadian-aspectAngleInRadian))));
elseif (angle>=-90 && angle<0)
    rowOutput=round(abs(diagonalLength*sin(angleInRadian-aspectAngleInRadian)));
    columnOutput=round(abs(diagonalLength*cos(angleInRadian+aspectAngleInRadian)));
elseif (angle>=90 && angle<180)
    rowOutput=round(abs(diagonalLength*sin(angleInRadian-deg2rad(90)-aspectAngleInRadian)));
    columnOutput=round(abs(diagonalLength*cos(angleInRadian-deg2rad(90)+aspectAngleInRadian)));
elseif (angle>=-180 && angle<-90)
    rowOutput=round(abs(diagonalLength*sin(angleInRadian+deg2rad(90)+aspectAngleInRadian)));
    columnOutput=round(abs(diagonalLength*cos(angleInRadian+deg2rad(90)-aspectAngleInRadian)));
end
output=zeros(rowOutput,columnOutput,inputChannel);

for i=1:inputRow
    for j=1:inputColumn
        rowColumn=round(rotationMatrix*[i-rowCenter;j-columnCeter]+[rowOutput;columnOutput]);
        output(rowColumn(1),rowColumn(2),:)=input(i,j,:);
    end
end

output=uint8(output);