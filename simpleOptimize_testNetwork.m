% Load the .nii file to get the data
nii_data = niftiread('/Users/benjaminostow/Downloads/Language_Network_Atlas_1_9_25/cleanedoutput500.nii');

% Create a mask for non-zero regions (your target area)
target_mask = nii_data > 0;  % Change condition based on your target regions

% Find the linear indexes of the target regions
target_indexes = find(target_mask);

% Initialize structure
opt = opt_struct('TDCSoptimize');

% Select the leadfield file
opt.leadfield_hdf = '/Users/benjaminostow/Documents/MATLAB/leadfield_204319/204319_leadfield_EEG10-10_UI_Jurak_2007.hdf5';

% Select a name for the optimization
opt.name = 'optimization/network_target';

% Select a maximum total current (in A)
opt.max_total_current = 2e-3;

% Select a maximum current at each electrode (in A)
opt.max_individual_current = 1e-3;

% Select a maximum number of active electrodes (optional)
opt.max_active_electrodes = 8;

% Define the target using the .nii file
opt.target.nii_file = '/Users/benjaminostow/Downloads/Language_Network_Atlas_1_9_25/cleanedoutput500.nii';

% Set the indexes of the target regions
opt.target.indexes = target_indexes;  % Using the extracted target indexes

% Define the desired intensity of the electric field (in V/m)
opt.target.intensity = 0.3;  % Increase EF strength for optimization

% Prevent opening .gmsh file
opt.visible = false;

% Run optimization
run_simnibs(opt);
