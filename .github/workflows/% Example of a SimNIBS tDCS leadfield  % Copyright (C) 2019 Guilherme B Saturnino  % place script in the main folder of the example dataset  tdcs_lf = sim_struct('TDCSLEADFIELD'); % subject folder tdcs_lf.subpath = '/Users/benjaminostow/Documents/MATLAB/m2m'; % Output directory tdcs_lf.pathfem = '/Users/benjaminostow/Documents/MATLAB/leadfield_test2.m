% Example of a SimNIBS tDCS leadfield loop
% Copyright (C) 2019 Guilherme B Saturnino

% Define subject numbers
subject_numbers = [204319, 204320, 204321, 204322]; % Add more numbers as needed

% Iterate over each subject
for i = 1:length(subject_numbers)
    % Create leadfield structure
    tdcs_lf = sim_struct('TDCSLEADFIELD');
    
    % Subject folder
    tdcs_lf.subpath = ['/Users/benjaminostow/Documents/MATLAB/m2m_' num2str(subject_numbers(i))];
    
    % Output directory
    tdcs_lf.pathfem = ['/Users/benjaminostow/Documents/MATLAB/leadfield_' num2str(subject_numbers(i))];
    
    % Uncomment to use the pardiso solver
    % tdcs_lf.solver_options = 'pardiso';
    
    % Run SimNIBS simulation
    run_simnibs(tdcs_lf);
end
