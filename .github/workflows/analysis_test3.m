% List of head mesh numbers
mesh_numbers = {'204319', '204521', '211417', '212116', '213017'};

% Define the folder containing the multimontage directory
base_folder = '/Users/benjaminostow/Documents/MATLAB/multimontage';

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
        
        % Process the mesh (you can add further processing here if needed)
        
        % Display progress
        fprintf('Processed mesh: %s, Montage: montage%d\n', mesh_numbers{i}, j);
    end
end
