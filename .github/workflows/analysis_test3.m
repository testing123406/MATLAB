% List of head mesh numbers
mesh_numbers = {'204319', '204521', '211417', '212116', '213017'};

% Define the folder containing the multimontage directory
base_folder = '/Users/benjaminostow/Documents/MATLAB/multimontage';

% Define the path to the NIfTI file
nii_file = '/Users/benjaminostow/Downloads/Language Network Atlas 1_9_25/cleanedoutput500.nii.gz';

% Load the NIfTI file
field_data = niftiread(nii_file);

% Create an ROI mask from the NIfTI file
roi_mask = field_data > 0;

% Initialize results storage
results = struct();

% Iterate over each mesh number
for i = 1:length(mesh_numbers)
    % Define the subfolder for the current mesh number
    mesh_folder = fullfile(base_folder, mesh_numbers{i});
    
    % Iterate over both montage1 and montage2
    for j = 1:2
        % Define the path for the current montage
        montage_folder = fullfile(mesh_folder, ['montage', num2str(j)]);
        
        % Load the corresponding mesh file
        mesh_file = fullfile(montage_folder, [mesh_numbers{i}, '_TDCS_1_scalar.msh']);
        
        % Load the mesh
        head_mesh = mesh_load_gmsh4(mesh_file);
        
        % Extract only gray matter volume elements (tag 2 in the mesh)
        gray_matter = mesh_extract_regions(head_mesh, 'region_idx', 2);

        % Get element centers from the mesh
        elm_centers = mesh_get_tetrahedron_centers(gray_matter);

        % Get the field of interest from the stimulation output
        field_name = 'magnE';
        field_idx = get_field_idx(gray_matter, field_name, 'elements');
        field = gray_matter.element_data{field_idx}.tetdata;

        % Calculate the mean field in the ROI
        roi = roi_mask(:); % Flatten the mask into a 1D vector

        % Use a weighted average based on element volume
        elm_vols = mesh_get_tetrahedron_sizes(gray_matter);
        avg_field_roi = sum(field(roi) .* elm_vols(roi)) / sum(elm_vols(roi));

        % Adjust the field name to ensure valid struct field naming
        result_field = ['mesh_' mesh_numbers{i} '_montage_' num2str(j)];

        % Store the result in the struct
        results.(result_field) = avg_field_roi;

        % Display progress
        fprintf('Mean %s for %s, Montage %d: %f\n', field_name, mesh_numbers{i}, j, avg_field_roi);
    end
end

% Save the results
save_path = '/Users/benjaminostow/Documents/MATLAB/mean_magnE_language_network.mat';
save(save_path, 'results');

fprintf('Results saved to: %s\n', save_path);
