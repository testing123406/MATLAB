% Example of SimNIBS tDCS optimization with a distributed target in MATLAB
% Looping through multiple subjects

% List of subject IDs
subject_ids = {'204521', '212116', '213017', '211417'};  % Add all your subjects here

for i = 1:length(subject_ids)
    
    subj = subject_ids{i};
    fprintf('Running optimization for subject %s...\n', subj);
    
    % Initialize structure
    opt = opt_struct('TDCSDistributedOptimize');
    
    % Select the leadfield file
    opt.leadfield_hdf = fullfile(['leadfield_' subj], ...
        [subj '_leadfield__-_Jurak_2007.hdf5']);
    
    % Subject path
    opt.subpath = ['m2m_' subj '/']; 
    % Select a name for the optimization
    opt.name = ['optimization_' subj '/distributed'];
    
    % Select a maximum total current (in A)
    opt.max_total_current = 4e-3;
    % Select a maximum current at each electrode (in A)
    opt.max_individual_current = 2e-3;
    % Select a maximum number of active electrodes (optional)
    opt.max_active_electrodes = 8;
    
    % Image with the field we want
    opt.target_image = 'cleanedoutput500 copy.nii.gz';
    % Set to false if target_image is in subject space
    opt.mni_space = true;
    % Target electric field intensity
    opt.intensity = 0.3;
    
    % Run optimization
    run_simnibs(opt);
end
