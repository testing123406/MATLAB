% Paths
ef_path = '/Users/benjaminostow/Documents/MATLAB/preliminary/204319/custom_montage/mni_volumes/204319_TDCS_1_scalar_MNI_magnE.nii.gz';
roi_path = '/Users/benjaminostow/Downloads/Language_Network_Atlas_1_9_25/cleanedoutput500.nii.gz';
output_resampled_roi_path = '/Users/benjaminostow/Downloads/Language_Network_Atlas_1_9_25/cleanedoutput500_resampled.nii.gz';

% Load EF magnitude image
ef_img = nifti_load(ef_path);
EF_vol = ef_img.vol;  % size ~ [182 218 182]

% Load network ROI mask
roi_img = nifti_load(roi_path);
ROI_vol = roi_img.vol;  % size ~ [91 109 91]

% Get sizes
sizeEF = size(EF_vol);
sizeROI = size(ROI_vol);

% Resample ROI to EF image size
% Use imresize3 (MATLAB Image Processing Toolbox) for 3D resizing
ROI_resampled = imresize3(ROI_vol, sizeEF, 'nearest');  % 'nearest' keeps it binary

% Update nifti header info for ROI to match EF spatial info
roi_img.vol = ROI_resampled;
roi_img.dim = [sizeEF 1 1];  % update dim fields accordingly
% (Adjust header fields carefully if needed)

% Save resampled ROI mask
nifti_save(roi_img, output_resampled_roi_path);

disp('Resampling done.');
disp('New ROI size:');
disp(size(ROI_resampled));
