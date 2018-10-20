function output=imageWrapping(input,angle)
input=double(input);
angleInRadian=deg2rad(angle);
[inputRow inputColumn inputChannel]=size(input);
aspectAngle=rad2deg(atan(inputRow/inputColumn));
aspectAngleInRadian=deg2rad(aspectAngle);



rowCenter=floor(inputRow/2)+1;
columnCeter=floor(inputColumn/2)+1;

diagonalLength=.5*max(rowCenter,columnCeter);


output=zeros(inputRow, inputColumn ,inputChannel);

rooNot=.5*min(rowCenter,columnCeter);

for i=1:inputRow
    for j=1:inputColumn
        roo=sqrt(i*i+j*j);
        thetaCalculate=atan(i/j);
        phi=asin(roo/rooNot);
        diagonal=(2/pi)*diagonalLength*phi;
        r=diagonal*sin(thetaCalculate);
        c=diagonal*cos(thetaCalculate);
        output(ceil(abs(r)),ceil(abs(c)),:)=input(i,j,:);
    end
end

output=uint8(output);