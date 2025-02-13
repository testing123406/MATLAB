% I didn't sub in subject specific info yet for leadfields and subjects 
subjects = {'ernie', 'subject2', 'subject3'};
leadfields = {'leadfield/ernie_leadfield.hdf5', ...
              'leadfield/subject2_leadfield.hdf5', ...
              'leadfield/subject3_leadfield.hdf5'};

target_image = 'cleanedoutput500. nii . gz'; % Same target for all subjects

for i = 1:length(subjects)
    opt = opt_struct('TDCSDistributedOptimize');
    
    % Assign subject-specific parameters
    opt.leadfield_hdf = leadfields{i};
    opt.subpath = ['m2m_' subjects{i} '/'];
    opt.name = ['optimization/' subjects{i} '_distributed'];

    % Stimulation constraints
    opt.max_total_current = 4e-3;
    opt.max_individual_current = 1e-3;
    opt.max_active_electrodes = 10;

    % Target electric field (same for all)
    opt.target_image = target_image;
    opt.mni_space = true; 
    opt.intensity = 0.2; % Adjust if needed

    % Run optimization
    run_optimization(opt);
end
