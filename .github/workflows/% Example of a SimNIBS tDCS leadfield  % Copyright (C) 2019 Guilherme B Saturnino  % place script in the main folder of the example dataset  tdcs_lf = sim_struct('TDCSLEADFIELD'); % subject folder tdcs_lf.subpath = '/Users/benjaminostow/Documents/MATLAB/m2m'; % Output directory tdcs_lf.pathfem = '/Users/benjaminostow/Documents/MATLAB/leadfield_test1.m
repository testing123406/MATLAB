% Example of a SimNIBS tDCS leadfield 
% Copyright (C) 2019 Guilherme B Saturnino

% place script in the main folder of the example dataset

tdcs_lf = sim_struct('TDCSLEADFIELD');
% subject folder
tdcs_lf.subpath = '/Users/benjaminostow/Documents/MATLAB/m2m_204319';
% Output directory
tdcs_lf.pathfem = '/Users/benjaminostow/Documents/MATLAB/leadfield';

% Uncomment to use the pardiso solver
%tdcs_lf.solver_options = 'pardiso';
% This solver is much faster than the default. However, it requires much more
% memory (~12 GB)

run_simnibs(tdcs_lf)
