% Add the SimNIBS MATLAB tools path (adjusting to the original folder)
addpath('/Users/benjaminostow/Applications/SimNIBS-4.1/matlab_tools');
savepath;

% Define subjects and file details
subjects = {'204319', '204521'};
results_folder = 'mni_volumes';
field_name = 'magnE';

mni_image_suffix = ['_TDCS_1_scalar_MNI_' field_name '.nii.gz'];

% Load the mask (binary .nii file, where 1 indicates the desired voxels)
mask_image = nifti_load('/Users/benjaminostow/Downloads/Language Network Atlas 1_9_25/cleanedoutput500.nii.gz');
mask = mask_image.vol;  % Extract the mask volume

% Load the first subject's image to get dimensions and initialize field_avg
template_image = nifti_load(fullfile('/Users/benjaminostow/Documents/MATLAB/singlemontage', subjects{1}, results_folder, [subjects{1} mni_image_suffix]));
field_avg = zeros(size(template_image.vol));
field_count = zeros(size(template_image.vol));  % To count non-zero voxels for averaging

% Loop through subjects
for i = 1:length(subjects)
    sub = subjects{i};
    
    % Construct the file path for the subject's magE image
    file_path = fullfile('/Users/benjaminostow/Documents/MATLAB/singlemontage', sub, results_folder, [sub mni_image_suffix]);

    % Check if the file is a .gz file and unzip it if necessary
    if endsWith(file_path, '.gz')
        gunzip(file_path);  % Unzips the file in the same directory
        file_path = strrep(file_path, '.gz', '');  % Update the path to the unzipped file
    end

    % Now load the nifti image (after unzipping if needed)
    img = nifti_load(file_path);
    
    % Apply the mask: Only accumulate field values where the mask is 1
    field_avg(mask == 1) = field_avg(mask == 1) + img.vol(mask == 1);
    field_count(mask == 1) = field_count(mask == 1) + 1;  % Count non-zero voxels for averaging
end

% Calculate the mean for only the masked voxels
field_avg = field_avg ./ field_count;

% Create an output image for the averaged field
avg_image = template_image;
avg_image.vol = field_avg;

% Save the averaged image in MATLAB folder inside Documents
nifti_save(avg_image, '/Users/benjaminostow/Documents/MATLAB/mean_' field_name '_masked.nii.gz');

