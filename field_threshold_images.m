%% open image file, create green/red mask, show masked RGB image, save masked RGB image for use in R. repeat for each genotypeXlight group

path = '/Users/jennaekwealor/Documents/image_analysis/stacked/A/'
files = dir(fullfile(path,'*.jpg')) % repeat for A, B, and C
L = length (files);

for i=1:L
   image{i} = imread(strcat(path,files(i).name));   
   [imgBW,maskedRGBImage] = field_createMask(image{i}); %function that uses hsv to pull out red, green, yellow as plant space and eliminate blues
   imwrite(maskedRGBImage,sprintf('masked/mask_%dA.jpg',i)); % repeat for A, B, and C
end

%% 