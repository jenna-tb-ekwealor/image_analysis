
%% open image file, create green/red mask, show masked RGB image, save masked RGB image for use in R. repeat for each genotypeXlight group

path = '/Users/jennaekwealor/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/final/s_caninervis/-UV/'
files = dir(fullfile(path,'*.jpg'))
L = length (files);

for i=1:L
   image{i} = imread(strcat(path,files(i).name));   
   [imgBW,maskedRGBImage] = createMask_montage_meta(image{i}); %function that uses hsv to pull out red, green, yellow as plant space and eliminate blues
   figure, imshow(maskedRGBImage)
   export_fig(['/Users/jennaekwealor/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/mask/scmUV_mask_' num2str(i) ], '-jpeg', '-a1', '-native');
end

%% 