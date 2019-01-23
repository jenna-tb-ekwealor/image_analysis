%%% %%BR m UV %%%
   
cd '/Users/jennabaughman/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/final/bow_river/-UV/';
mkdir montage
   dirOutput = dir(fullfile('*.jpg')); % *.jpg indicates 
          %only jpg files. this can be changed to anything you like.
   fileNames = {dirOutput.name};
    BRmUV = montage(fileNames, 'ThumbnailSize', []);
export_fig(['montage/' 'BRmUV'], '-jpeg', '-a1', '-native');
%%% %%BR p UV %%%

   cd '/Users/jennabaughman/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/final/bow_river/+UV/';
mkdir mont age
   dirOutput = dir(fullfile('*.jpg')); % *.jpg indicates 
          %only jpg files. this can be changed to anything you like.
   fileNames = {dirOutput.name};
   BRpUV = montage(fileNames, 'ThumbnailSize', []);
export_fig(['montage/' 'BRpUV'], '-jpeg', '-a1', '-native');
   
   
   %%% %%SC m UV %%%
   
cd '/Users/jennabaughman/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/final/s_caninervis/-UV/';
mkdir montage
   dirOutput = dir(fullfile('*.jpg')); % *.jpg indicates 
          %only jpg files. this can be changed to anything you like.
   fileNames = {dirOutput.name};
   SCmUV = montage(fileNames, 'ThumbnailSize', []);
export_fig(['montage/' 'SCmUV'], '-jpeg', '-a1', '-native');

%%% %%sc p UV %%%

   cd '/Users/jennabaughman/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/final/s_caninervis/+UV/';
mkdir montage
   dirOutput = dir(fullfile('*.jpg')); % *.jpg indicates 
          %only jpg files. this can be changed to anything you like.
   fileNames = {dirOutput.name};
   SCpUV = montage(fileNames, 'ThumbnailSize', []);
export_fig(['montage/' 'SCpUV'], '-jpeg', '-a1', '-native');
   
   
%%%%   super montage %%%
   cd '/Users/jennabaughman/Documents/berkeley/dissertation/chamber_pics/01_15_19/corrected/top_view/cropped/final/';
copyfile 's_caninervis/+UV/montage/SCpUV.jpg' .
 copyfile  's_caninervis/-UV/montage/SCmUV.jpg' .
 copyfile 'bow_river/+UV/montage/BRpUV.jpg' .
 copyfile 'bow_river/-UV/montage/BRmUV.jpg' . 
 
  
 montages = dir(fullfile('*.jpg'));
   fileNames_mon = {montages.name};
   montage_meta = montage(fileNames_mon, 'ThumbnailSize', []);
   mkdir montage_meta
   export_fig(['montage_meta/' 'montage_meta'], '-jpeg', '-a1', '-native');
