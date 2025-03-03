%% Load Simulation Result (mesh for stimulation output)

% Load the mesh file from the correct location (your stimulation output)
head_mesh = mesh_load_gmsh4(...
    fullfile('/Users/benjaminostow/Documents/MATLAB/singlemontage', '204319', '204319_TDCS_1_scalar.msh') ...
);

% Extract only gray matter volume elements (tag 2 in the mesh)
gray_matter = mesh_extract_regions(head_mesh, 'region_idx', 2);

%% Load the .nii.gz file (cleanedoutput500.nii.gz)

% Define the path to the NIfTI file
nii_file = '/Users/benjaminostow/Downloads/Language Network Atlas 1_9_25/cleanedoutput500.nii.gz';

% Load the NIfTI file (use niftiread for MATLAB R2018b and later)
field_data = niftiread(nii_file);  % Read the NIfTI file

%% Define the ROI from the .nii file (you can use a mask if you have one)

% For now, let’s assume that you want to use all the voxels within the language network region
% Optionally, you can load a mask specific to the language network

% Convert the field data into a mask, assuming you want non-zero values in the field
roi_mask = field_data > 0;  % This creates a mask of all the non-zero voxels (you can adjust this logic if needed)

% Get element centers from the mesh
elm_centers = mesh_get_tetrahedron_centers(gray_matter);

%% Calculate the mean electric field in the defined ROI

% Get the field of interest from the stimulation output
field_name = 'magnE';  % Assuming you want the magnetic field or electric field
field_idx = get_field_idx(gray_matter, field_name, 'elements');
field = gray_matter.element_data{field_idx}.tetdata;

% Calculate the mean field in the ROI
% ROI here is defined by the mask in the .nii file (language network)
% Use the mask to select elements that overlap with the ROI
roi = roi_mask(:);  % Flatten the mask into a 1D vector

% Optionally, use a weighted average based on element volume
elm_vols = mesh_get_tetrahedron_sizes(gray_matter);
avg_field_roi = sum(field(roi) .* elm_vols(roi)) / sum(elm_vols(roi));

% Display the result
fprintf('Mean %s in ROI: %f\n', field_name, avg_field_roi);

%% Save the result

save_path = '/Users/benjaminostow/Documents/MATLAB/mean_magnE_language_network.mat';
save(save_path, 'avg_field_roi');

fprintf('Results saved to: %s\n', save_path);
