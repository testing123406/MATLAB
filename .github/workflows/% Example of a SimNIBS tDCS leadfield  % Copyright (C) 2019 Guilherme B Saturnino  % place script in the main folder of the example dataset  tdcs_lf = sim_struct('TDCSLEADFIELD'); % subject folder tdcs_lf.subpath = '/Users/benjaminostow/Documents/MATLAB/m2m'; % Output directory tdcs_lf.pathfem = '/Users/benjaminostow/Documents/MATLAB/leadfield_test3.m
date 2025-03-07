% Example of a SimNIBS tDCS leadfield loop
% Copyright (C) 2019 Guilherme B Saturnino

% Define subject numbers
subject_numbers = [102715, 103212, 103414, 106319, 110613, 114621, 115219, 118730, 121618, 123420, 204319, 204521, 211417, 212116, 213017, 239944, 274542, 341834, 352738, 385450, 387959, 461743, 481042, 500222, 519647, 592455, 635245, 677766, 723141, 886674]; % Add more numbers as needed

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
