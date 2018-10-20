function quantizedMatrix=ImageQuantize (Image_Matrix, Quantization_Bit)
%Select a way to Quantize
%Select the Lower bound - lb
%Select the Upper bound - ub
%Average all the intensities between the upper bound and the lower bound -
%aulb
way='ub';
%start of error handling*************************
%checking whether the input Quantization bit is less than 1 or not
if (Quantization_Bit < 1)
    error('Input Quantization bit is less than 1');
end
%checking whether the input Quantization bit is more than 8 or not
if (Quantization_Bit > 8)
    error('Input Quantization bit is more than 8');
end
%end of error handling*************************
%calculating target
targetLevel=2 ^Quantization_Bit;
%
intensityBlock= linspace(0,256,targetLevel + 1);
%
quantizedMatrix = uint8(zeros(size(Image_Matrix)));
%
if strcmp(way,'lb')
    for i = 1:targetLevel
        %lower bound of a block
        lowerLimit = intensityBlock(i);
        %upper bound of a block
        upperLimit = intensityBlock(i+1);
        %binary mask of values between the range
        temporaryMask = uint8((Image_Matrix >= lowerLimit) & (Image_Matrix < upperLimit));
        
        %getting the intensities where the value is true (meaning 1)
        intensitiesInRange = lowerLimit .* temporaryMask;
        
        %replacing all pixels in the range with the average value of
        %intensities
        quantizedMatrix = quantizedMatrix +intensitiesInRange;
    end
end
if strcmp(way,'ub')
    for i = 1:targetLevel
        %lower bound of a block
        lowerLimit = intensityBlock(i);
        %upper bound of a block
        upperLimit = intensityBlock(i+1);
        
        %binary mask of values between the range
        temporaryMask = uint8((Image_Matrix >= lowerLimit) & (Image_Matrix < upperLimit));
        
        %getting the intensities where the value is true (meaning 1)
        intensitiesInRange = temporaryMask .* upperLimit;
        
        
        %replacing all pixels in the range with the average value of
        %intensities
        quantizedMatrix = quantizedMatrix +intensitiesInRange;
    end
end
    if strcmp(way,'aulb')
        for i = 1:targetLevel
            %lower bound of a block
            lowerLimit = intensityBlock(i);
            %upper bound of a block
            upperLimit = intensityBlock(i+1);
            
            %binary mask of values between the range
            temporaryMask = uint8((Image_Matrix >= lowerLimit) & (Image_Matrix < upperLimit));
            
            %getting the intensities where the value is true (meaning 1)
            intensitiesInRange = temporaryMask .* Image_Matrix;
            
            %calculating the average of the non-zero elements
            averageOfIntensitiesInRange = round(mean(intensitiesInRange(intensitiesInRange~=0)));
            
            %replacing all pixels in the range with the average value of
            %intensities
            quantizedMatrix = quantizedMatrix +(averageOfIntensitiesInRange * temporaryMask);
        end
    end
end
