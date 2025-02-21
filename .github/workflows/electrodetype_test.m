% Add SimNIBS to the MATLAB path
addpath('/Users/benjaminostow/Applications/SimNIBS-4.1/matlab_tools');

% Optional: Save the path for future sessions
savepath;

% Set the subjects
subjects = {'204319', '204521', '211417', '212116', '213017'};

% Define the montages (electrode setups)
montages = {
    % Montage 1
    struct('electrode1', struct('centre', 'C3', 'pos_ydir', 'C1', 'dimensions', [50,70],'thickness',[4]), ...
           'electrode2', struct('centre', 'AF4', 'pos_ydir', 'F6', 'dimensions', [50,70],'thickness',[4]), ...
           'currents', [1, -1]),  % Current intensity for Montage 1
    
    % Montage 2
    struct('electrode1', struct('centre', 'F3', 'pos_ydir', 'Fz', 'dimensions', [60, 60],'thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'P4', 'pos_ydir', 'Pz', 'dimensions', [60, 80],'thickness',[4,1,4]), ...
           'currents', [2, -2]),  % Current intensity for Montage 2
};

% Start a SESSION
S = sim_struct('SESSION');
S.map_to_fsavg = true;
S.map_to_MNI = true;
S.fields = 'eEjJ';

% Set up the TDCSLIST with the simulation setup
S.poslist{1} = sim_struct('TDCSLIST');

% Create main results folder
if ~exist('type', 'dir')
    mkdir('type');
end

% Run the simulation for each subject
for i = 1:length(subjects)
    sub = subjects{i};
    S.subpath = fullfile(['m2m_' sub]);  % head mesh

    % Iterate over different montages
    for j = 1:length(montages)
        % Define the output directory
        output_dir = fullfile('type', sub, sprintf('montage%d', j));

        % Ensure the directory exists before running SimNIBS
        if ~exist(output_dir, 'dir')
            mkdir(output_dir);
        end

        % Set the output directory for the montage
        S.pathfem = output_dir; 

        % Set up electrodes for the current montage
        S.poslist{1}.currents = montages{j}.currents;
        
        % Ensure electrode struct arrays exist
        S.poslist{1}.electrode = repmat(struct(), 1, 2);

        % Electrode 1 setup
        S.poslist{1}.electrode(1).channelnr = 1;
        S.poslist{1}.electrode(1).centre = montages{j}.electrode1.centre;
        S.poslist{1}.electrode(1).pos_ydir = montages{j}.electrode1.pos_ydir;
        S.poslist{1}.electrode(1).shape = 'rect'
        S.poslist{1}.electrode(1).dimensions = montages{j}.electrode1.dimensions;
        S.poslist{1}.electrode(1).thickness = montages{j}.electrode1.thickness;

        % Electrode 2 setup
        S.poslist{1}.electrode(2).channelnr = 2;
        S.poslist{1}.electrode(2).centre = montages{j}.electrode2.centre;
        S.poslist{1}.electrode(2).pos_ydir = montages{j}.electrode2.pos_ydir;
        S.poslist{1}.electrode(2).shape = 'rect'
        S.poslist{1}.electrode(2).dimensions = montages{j}.electrode2.dimensions;
        S.poslist{1}.electrode(2).thickness = montages{j}.electrode2.thickness;

        % Run the simulation for the current subject and montage
        run_simnibs(S);
    end
end
