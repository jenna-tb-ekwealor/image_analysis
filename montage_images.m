% This script is a work in progress and needs to be further modified to be generalizable. In it's current state it is specific to my files and organization but it still may be useful.

%%% %%field plants UV reduced (A) %%%
addpath('/Users/jennaekwealor/Documents/image_analysis/', '-end')
cd '/Users/jennaekwealor/Documents/image_analysis/stacked/A/';
   dirOutput = dir(fullfile('*.jpg')); % *.jpg indicates 
          %only jpg files. this can be changed to anything you like.
   fileNames = {dirOutput.name};
    montage_img_A = montage(fileNames, 'Size', [2 7]);
    montage_IM_img_A = montage_img_A.CData;

  
%%% %%field plants UV transmitted (B) %%%
cd '/Users/jennaekwealor/Documents/image_analysis/stacked/B/';
   dirOutput = dir(fullfile('*.jpg')); % *.jpg indicates 
          %only jpg files. this can be changed to anything you like.
   fileNames = {dirOutput.name};
    montage_img_B = montage(fileNames, 'ThumbnailSize', [2 7]);
    imshow(montage_img_B);

