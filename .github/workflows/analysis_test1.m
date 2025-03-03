% Simple ROI analysis of the electric field from a simulation.
% We will calculate the mean electric field in a gray matter ROI
% The ROI is defined using an MNI coordinate.

%% Load Simulation Result

% Load the mesh file from the correct location
head_mesh = mesh_load_gmsh4(...
    fullfile('/Users/benjaminostow/Documents/MATLAB/singlemontage', '204319', '204319_TDCS_1_scalar.msh') ...
);

% Extract only gray matter volume elements (tag 2 in the mesh)
gray_matter = mesh_extract_regions(head_mesh, 'region_idx', 2);

%% Define the ROI

% Define the M1 coordinate in MNI space (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2034289/)
mni_coords = [-37, -21, 58];  % Example M1 coordinate
subject_folder = '/Users/benjaminostow/Documents/MATLAB';  % Main MATLAB folder

% Convert MNI coordinate to subject space
subject_coords = mni2subject_coords(mni_coords, fullfile(subject_folder, 'm2m_204319'));

% Define a spherical ROI with a 10 mm radius
r = 10;  % Radius in mm

% Get tetrahedron centers from the mesh
elm_centers = mesh_get_tetrahedron_centers(gray_matter);

% Find the elements inside the ROI
roi = sqrt(sum(bsxfun(@minus, elm_centers, subject_coords).^2, 2)) < r;

% Get element volumes (used for weighted averaging)
elm_vols = mesh_get_tetrahedron_sizes(gray_matter);

%% Get field and calculate the mean
% Get the field of interest
field_name = 'magnE';
field_idx = get_field_idx(gray_matter, field_name, 'elements');
field = gray_matter.element_data{field_idx}.tetdata;

% Calculate the mean electric field in the ROI (volume-weighted)
avg_field_roi = sum(field(roi) .* elm_vols(roi)) / sum(elm_vols(roi));

% Display the result
fprintf('Mean %s in ROI: %f\n', field_name, avg_field_roi);

%% Save the result
save_path = fullfile(subject_folder, 'mean_magnE_ROI.mat');
save(save_path, 'avg_field_roi');

fprintf('Results saved to: %s\n', save_path);
