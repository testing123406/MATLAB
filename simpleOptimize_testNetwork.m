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

% Define the target using a .nii mask
opt.target.mask = '/Users/benjaminostow/Downloads/Language Network Atlas 1_9_25/cleanedoutput500.nii.gz';

% Define the desired intensity of the electric field (in V/m)
opt.target.intensity = 0.3;  % Increase EF strength for optimization

% Prevent opening .gmsh file
opt.visible = false;

% Run optimization
run_simnibs(opt);
