% Example of a SimNIBS tDCS optimization with a distributed target in Python
%
%  Copyright (c) 2020 SimNIBS developers. Licensed under the GPL v3.

% Initialize structure
opt = opt_struct('TDCSDistributedOptimize');
% Select the leadfield file
opt.leadfield_hdf = 'leadfield/ernie_leadfield_EEG10-10_UI_Jurak_2007.hdf5';
% Subject path
opt.subpath = 'm2m_ernie/';
% Select a name for the optimization
opt.name = 'optimization/distributed';

% Select a maximum total current (in A)
opt.max_total_current = 4e-3;
% Select a maximum current at each electrodes (in A)
opt.max_individual_current = 1e-3;
% Select a maximum number of active electrodes (optional)
opt.max_active_electrodes = 10;

% Image with the field we want
opt.target_image = 'ID03_MOTOR_ICA.nii.gz';
opt.mni_space = true; % set to false if target_image is in subject space
% Target electric field intensity
opt.intensity = 0.1;


% Run optimization
run_simnibs(opt)
