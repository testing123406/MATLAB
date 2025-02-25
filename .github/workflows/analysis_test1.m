subjects = {'sub01', 'sub09', 'sub10', 'sub12', 'sub15'};
results_folder = 'mni_volumes';
field_name = 'magnE';

mni_image_suffix = ['_TDCS_1_scalar_MNI_' field_name '.nii.gz'];

% Load mask (binary .nii file, where 1 indicates the desired voxels)
mask_image = nifti_load('/Users/benjaminostow/Downloads/Language Network Atlas 1_9_25/cleanedoutput500.nii.gz');
mask = mask_image.vol;  % Extract the mask volume

% Load the first subject's image to get dimensions and initialize the field_avg
template_image = nifti_load(fullfile('bipolar', subjects{1}, results_folder, [subjects{1} mni_image_suffix]));
field_avg = zeros(size(template_image.vol));
field_count = zeros(size(template_image.vol));  % To count non-zero voxels for averaging

for i = 1:length(subjects)
    sub = subjects{i};
    % Load the nifti image
    img = nifti_load(fullfile(pwd, 'bipolar', sub, results_folder, [sub mni_image_suffix]));
    
    % Apply the mask to the image (select only voxels where the mask is 1)
    field_avg(mask == 1) = field_avg(mask == 1) + img.vol(mask == 1);
    field_count(mask == 1) = field_count(mask == 1) + 1;  % Count non-zero voxels
end

% Calculate the mean for only the masked voxels
field_avg = field_avg ./ field_count;

% Save the averaged image
avg_image = template_image;
avg_image.vol = field_avg;
nifti_save(avg_image, ['mean_' field_name '_masked.nii.gz']);
