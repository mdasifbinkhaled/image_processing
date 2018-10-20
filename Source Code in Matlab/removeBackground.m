function output=removeBackground(oldImage,newImage)
%subtracting the changed/new image from the old image to get the change in
%the image
output=double(newImage)-double(oldImage);
output=uint8(output);
end