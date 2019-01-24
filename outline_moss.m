% this script will loop through already masked jpg images in the path and outline individual mosses/moss patches in the image in order to get some spatial data on them (such as area). this particular script focus on area and percent cover but can be modified to do other things, like perimeter etc.


%% loop%%%
path = '/Users/jennaekwealor/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/mask/';
files = dir(fullfile(path,'*.jpg'));
L = length (files);
array_of_means = zeros(L,1); 
for i=1:L
    imgRGB{i} = imread(strcat(path,files(i).name));   % load image
    imgBW = im2bw(imgRGB{i},.1);  % converts image to binary image, by replacing all pixels in the input image with luminance greater than level with the value 1 (white) and replacing all other pixels with the value 0 (black). 
    regionprops(imgBW); % define objects on array
    [labeled,numPlants] = bwlabel(imgBW); % label each ridge (1s). The parameter 4, passed to the bwlabel function, means that pixels must touch along an edge to be considered connected.
    plantData = regionprops(labeled,'area', 'centroid', 'perimeter'); % to calculate thee areas from that image = structure type
    Area_list = [plantData.Area].'; % area column for that image
    Area_sum = sum(Area_list); % total moss area for each image
    array_of_sums(i,:) = [Area_sum];
end 

out = [{files.name}.',num2cell(array_of_sums)]; % convert array of sums to cell so that it can be combined with names list, then combine. filenames are transposed with " .' ", curly brackets allow it to be a whole list. 

out_data = dataset({out, 'img', 'area_sum'}) % add column headers and create a dataset 

[sz1 sz2 sz3] = size(imgBW) % get three dimensions of image (all same size); use sz1 and sz2 for total area and percent cover

total_area = (sz1 * sz2);



out_data.cover = 100*[(cell2mat(out_data.area_sum))/total_area];



export(out_data, 'File', '/Users/jennaekwealor/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/mask/array_of_sums.csv', 'Delimiter',',')

%%
% %% load image and convert to logical array (binary image)
% 
% imgRGB = imread('/Users/jennaekwealor/Documents/berkeley/dissertation/chamber_pics/07_23_18/long-term/mask/brmUV_mask_13.jpg');
% 
% imgBW = im2bw(imgRGB,.1); % converts image to binary image, by replacing all pixels in the input image with luminance greater than level with the value 1 (white) and replacing all other pixels with the value 0 (black).
% 
% figure, imshow(imgBW)
% 
% %% define objects on array
% regionprops(imgBW)
% 
% [labeled,numPlants] = bwlabel(imgBW); % label each ridge (1s)  % The parameter 4, passed to the bwlabel function, means that pixels must touch along an edge to be considered connected.
% 
% plantData = regionprops(labeled,'area', 'centroid', 'perimeter')%to calculate their areas = structure type
% perim = bwperim(labeled); % outlines perimeter of objects
% 
% %figure, imshow(perim)
% %% analyze objects on array 
% Area_list = [plantData.Area].';
% Area_sum = sum(Area_list)
% Perimeter = [plantData.Perimeter].';
% 
% %figure, imshowpair(imrotate(imgBW,90),imrotate(perim,90),'montage')
% %showplottool('on','propertyeditor')
% %title('Plate Binary Image and Plants Outlined','FontSize',18,'FontWeight','Bold');
% 
% %  ['/Users/jennaekwealor/Documents/berkeley/dissertation/chamber_pics/07_23_18/long-term/mask/Area_BR_UV' num2str(i) ], 'csv')
% filename = 'brmUV_mask_4.csv'; 
% 


