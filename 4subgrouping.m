% This example will go through simulations and calculate
% the average of the electric field magnitude in MNI space

% List of subject IDs as separate strings (not one big string)
subjects = {'211417', '204521', '212116', '213017'};

results_folder = 'custom_montage/mni_volumes';  % full relative path from base MATLAB folder
field_name = 'magnE';

mni_image_suffix = ['_TDCS_1_scalar_MNI_' field_name '.nii.gz'];

% Load template image from the first subject
template_image = nifti_load(fullfile(subjects{1}, results_folder, [subjects{1} mni_image_suffix]));

field_avg = zeros(size(template_image.vol));

for i = 1:length(subjects)
    sub = subjects{i};
    % Build the full relative path to each NIfTI file
    nifti_path = fullfile(sub, results_folder, [sub mni_image_suffix]);
    
    % Load the nifti image
    img = nifti_load(nifti_path);
    
    % Accumulate volume data
    field_avg = field_avg + img.vol;
end

% Calculate the mean across subjects
field_avg = field_avg / length(subjects);

% Save the mean image using the metadata from the template image
avg_image = template_image;
avg_image.vol = field_avg;

% Save output in the base MATLAB folder
nifti_save(avg_image, ['mean_' field_name '.nii.gz']);
