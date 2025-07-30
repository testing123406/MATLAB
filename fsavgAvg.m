%% Setup
subjects = {'212116', '213017', '211417', '204521'};
base_dir = '/Users/benjaminostow/Documents/MATLAB';
results_folder = fullfile('custom_montage', 'fsavg_overlays');
fsavg_msh_name = '_TDCS_1_scalar_fsavg.msh';
field_name = 'E_normal';

fields = {};
for i = 1:length(subjects)
    sub = subjects{i};
    % Load mesh with EF results in fsaverage space
    msh_path = fullfile(base_dir, sub, results_folder, [sub fsavg_msh_name]);
    m = mesh_load_gmsh4(msh_path);
    
    % Extract EF normal component field
    fields{i} = m.node_data{get_field_idx(m, field_name, 'node')}.data;
end

%% Calculate mean and std across subjects
fields = cell2mat(fields); % concatenate fields into matrix: nodes x subjects
avg_field = mean(fields, 2);
std_field = std(fields, 0, 2);

% Clear previous node_data and add mean/std
m.node_data = [];
m.node_data{1}.data = avg_field;
m.node_data{1}.name = [field_name '_avg'];
m.node_data{2}.data = std_field;
m.node_data{2}.name = [field_name '_std'];

%% Plot average EF normal
figure; 
mesh_show_surface(m, 'field_idx', [field_name '_avg']);
title('Average Normal Electric Field');

%% Plot std EF normal
figure;
mesh_show_surface(m, 'field_idx', [field_name '_std']);
title('Standard Deviation of Normal Electric Field');

%% Save averaged mesh with mean and std fields
output_dir = fullfile(base_dir, 'average_results');
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

output_file = fullfile(output_dir, ['avg_' field_name '.msh']);
mesh_save_gmsh4(m, output_file);
disp(['Saved averaged mesh to: ', output_file]);
