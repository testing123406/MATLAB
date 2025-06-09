% Add SimNIBS MATLAB tools to path (adjust path as needed)
addpath('/Users/benjaminostow/Applications/SimNIBS-4.1/matlab_tools');
savepath;

% Define 4 subject IDs
subjects = {'211417', '213017', '212116', '204521'};

for i = 1:length(subjects)
    sub = subjects{i};
    fprintf('Running simulation for subject %s\n', sub);
    
    % Build path to the CSV file for this subject
    csv_filename = fullfile(sprintf('optimization_%s', sub), 'distributed.csv');
    
    % Check if file exists
    if ~isfile(csv_filename)
        error('CSV file not found: %s', csv_filename);
    end
    
    % Read CSV without headers (2 columns: electrode label, current in amperes)
    T = readtable(csv_filename, 'ReadVariableNames', false);
    electrodes_raw = table2cell(T(:,1));
    currents_raw = table2array(T(:,2));
    
    % Filter rows with non-zero currents
    nonzero_idx = find(currents_raw ~= 0);
    electrodes = electrodes_raw(nonzero_idx);
    currents = currents_raw(nonzero_idx);
    
    % Convert currents from Amperes to milliamperes (multiply by 1000)
    currents = currents * 1000;
    
    % Check that sum of currents is zero (within tolerance)
    if abs(sum(currents)) > 1e-6
        error('Sum of currents is not zero for subject %s (sum=%.6f)', sub, sum(currents));
    end
    
    % Create SimNIBS session struct
    S = sim_struct('SESSION');
    S.map_to_fsavg = true;
    S.map_to_MNI = true;
    S.fields = 'eEjJ';
    S.poslist{1} = sim_struct('TDCSLIST');
    
    % Subject head mesh folder
    S.subpath = fullfile(['m2m_' sub]);
    
    % Output directory (in MATLAB folder, no preliminary)
    output_dir = fullfile(pwd, sub, 'custom_montage');
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    S.pathfem = output_dir;
    
    % Assign currents
    S.poslist{1}.currents = currents';
    
    % Assign electrode info
    nElectrodes = length(electrodes);
    S.poslist{1}.electrode = repmat(struct(), 1, nElectrodes);
    for e = 1:nElectrodes
        S.poslist{1}.electrode(e).channelnr = e;
        S.poslist{1}.electrode(e).centre = electrodes{e};
        S.poslist{1}.electrode(e).shape = 'rect';
        S.poslist{1}.electrode(e).dimensions = [50, 70];
        S.poslist{1}.electrode(e).thickness = 4;
    end
    
    % Run the simulation
    run_simnibs(S);
end
