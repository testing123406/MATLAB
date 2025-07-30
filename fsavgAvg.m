%% Setup
addpath('/Users/benjaminostow/Applications/SimNIBS-4.1/simnibs_env/lib/python3.9/site-packages/simnibs/matlab_tools');

subjects = {'212116', '213017', '211417', '204521'};
base_dir = '/Users/benjaminostow/Documents/MATLAB';
results_folder = fullfile('custom_montage', 'fsavg_overlays');
fsavg_msh_suffix = '_TDCS_1_scalar_fsavg.msh';
fields = {'E_normal', 'E_magn'};

% Load template mesh for geometry
m_out = mesh_load_gmsh4(fullfile(base_dir, subjects{1}, results_folder, [subjects{1} fsavg_msh_suffix]));
m_out.node_data = {};

for f = 1:numel(fields)
    vals = [];
    for s = 1:numel(subjects)
        msh_path = fullfile(base_dir, subjects{s}, results_folder, [subjects{s} fsavg_msh_suffix]);
        if ~isfile(msh_path)
            warning('Missing: %s', msh_path);
            continue;
        end
        m = mesh_load_gmsh4(msh_path);
        try
            idx = get_field_idx(m, fields{f}, 'node');
            vals(:, end+1) = m.node_data{idx}.data;
        catch
            warning('Field %s missing for %s', fields{f}, subjects{s});
        end
    end
    if isempty(vals)
        warning('No data for field %s, skipping.', fields{f});
        continue;
    end
    m_out.node_data{2*f-1} = struct('data', mean(vals, 2), 'name', [fields{f} '_avg'], 'type', 'node data');
    m_out.node_data{2*f} = struct('data', std(vals, 0, 2), 'name', [fields{f} '_std'], 'type', 'node data');
end

out_dir = fullfile(base_dir, 'average_results');
if ~exist(out_dir, 'dir')
    mkdir(out_dir);
end
mesh_save_gmsh4(m_out, fullfile(out_dir, 'avg_fields.msh'));
disp('Saved averaged mesh.');

% Plot only average of E_magn field with jet colormap
figure;
mesh_show_surface(m_out, 'field_idx', [fields{2} '_avg']);  % E_magn avg
title(['Average ' fields{2}]);
view(-125, 10);
axis off;
camlight headlight;
lighting gouraud;

colormap(jet(256));  % Classic blue to red colormap
colorbar;

caxis([min(m_out.node_data{3}.data), max(m_out.node_data{3}.data)]);  % Node data 3 is E_magn_avg

exportgraphics(gcf, fullfile(out_dir, ['avg_' fields{2} '_jet.png']), 'Resolution', 300);
disp('Saved average E_magn figure with jet colormap.');

