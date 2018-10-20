function errorValue=checkLoss(originalMatrix,convertedMatrix)
%select the way of calculating error
%mean error - me
%mean square error - mse
%root mean square error - rmse
way='rmse';
%check whether the row and the column of the originalMatrix match with the row
%and the column of the secondMatrix
if(size(originalMatrix,1)~=size(convertedMatrix,1)||size(originalMatrix,2)~=size(convertedMatrix,2))
    fprintf('First Matrix Dimension is %d x %d',size(originalMatrix,1),size(originalMatrix,2));
    fprintf('Second Matrix Dimension is %d x %d',size(convertedMatrix,1),size(convertedMatrix,2));
    error('First and Second matrix dimension does not match');
end
%calculating error
%mean error
if strcmp(way,'me')
    disp('Calculating Mean Error');
    errorValue=mean(originalMatrix - convertedMatrix);
end
%mean square error
if strcmp(way,'mse')
    disp('Calculating Mean Square Error');
    errorValue=mean((originalMatrix - convertedMatrix).^2);
end
%root mean square error
if strcmp(way,'rmse')
    disp('Calculating Root Mean Square Error');
    errorValue=sqrt(mean((originalMatrix - convertedMatrix).^2));
end
errorValue=sum(errorValue);
end