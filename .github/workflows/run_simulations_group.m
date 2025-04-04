% Add SimNIBS to the MATLAB path
addpath('/Users/benjaminostow/Applications/SimNIBS-4.1/matlab');

% Optional: Save the path for future sessions
savepath;

% Set the subjects
subjects = {'sub01', 'sub09', 'sub10', 'sub12', 'sub15'};

% Define the montages (electrode setups)
montages = {
    % Montage 1
    struct('electrode1', struct('centre', 'C3', 'pos_ydir', 'C1', 'dimensions', [50, 50]), ...
           'electrode2', struct('centre', 'AF4', 'pos_ydir', 'F6', 'dimensions', [50, 70]), ...
           'currents', [1, -1]),  % Current intensity for Montage 1
    
    % Montage 2
    struct('electrode1', struct('centre', 'F3', 'pos_ydir', 'Fz', 'dimensions', [60, 60]), ...
           'electrode2', struct('centre', 'P4', 'pos_ydir', 'Pz', 'dimensions', [60, 80]), ...
           'currents', [0.8, -0.8]),  % Current intensity for Montage 2
    
    % Montage 3
    struct('electrode1', struct('centre', 'Cz', 'pos_ydir', 'Fz', 'dimensions', [50, 60]), ...
           'electrode2', struct('centre', 'Pz', 'pos_ydir', 'O1', 'dimensions', [60, 70]), ...
           'currents', [1.2, -1.2]),  % Current intensity for Montage 3
    
    % Montage 4
    struct('electrode1', struct('centre', 'C1', 'pos_ydir', 'C2', 'dimensions', [55, 55]), ...
           'electrode2', struct('centre', 'AF3', 'pos_ydir', 'F3', 'dimensions', [60, 75]), ...
           'currents', [0.9, -0.9]),
    
    % Montage 5
    struct('electrode1', struct('centre', 'C4', 'pos_ydir', 'C3', 'dimensions', [50, 50]), ...
           'electrode2', struct('centre', 'AF4', 'pos_ydir', 'F4', 'dimensions', [50, 70]), ...
           'currents', [1.1, -1.1]),
    
    % Montage 6
    struct('electrode1', struct('centre', 'Fz', 'pos_ydir', 'F3', 'dimensions', [60, 60]), ...
           'electrode2', struct('centre', 'Pz', 'pos_ydir', 'P4', 'dimensions', [60, 80]), ...
           'currents', [0.7, -0.7]),
    
    % Montage 7
    struct('electrode1', struct('centre', 'F1', 'pos_ydir', 'Fz', 'dimensions', [55, 55]), ...
           'electrode2', struct('centre', 'P3', 'pos_ydir', 'Pz', 'dimensions', [55, 75]), ...
           'currents', [1, -1]),
    
    % Montage 8
    struct('electrode1', struct('centre', 'T7', 'pos_ydir', 'C3', 'dimensions', [60, 60]), ...
           'electrode2', struct('centre', 'P3', 'pos_ydir', 'Pz', 'dimensions', [60, 80]), ...
           'currents', [0.8, -0.8]),
    
    % Montage 9
    struct('electrode1', struct('centre', 'T8', 'pos_ydir', 'C4', 'dimensions', [50, 50]), ...
           'electrode2', struct('centre', 'P4', 'pos_ydir', 'Pz', 'dimensions', [60, 70]), ...
           'currents', [1.0, -1.0]),
    
    % Montage 10
    struct('electrode1', struct('centre', 'C3', 'pos_ydir', 'Cz', 'dimensions', [60, 70]), ...
           'electrode2', struct('centre', 'AF4', 'pos_ydir', 'Fz', 'dimensions', [70, 80]), ...
           'currents', [1.2, -1.2]),
    
    % Montage 11
    struct('electrode1', struct('centre', 'F3', 'pos_ydir', 'Fz', 'dimensions', [55, 65]), ...
           'electrode2', struct('centre', 'AF4', 'pos_ydir', 'F6', 'dimensions', [50, 60]), ...
           'currents', [1.3, -1.3]),
    
    % Montage 12
    struct('electrode1', struct('centre', 'C1', 'pos_ydir', 'Cz', 'dimensions', [60, 60]), ...
           'electrode2', struct('centre', 'P4', 'pos_ydir', 'Pz', 'dimensions', [60, 80]), ...
           'currents', [1.0, -1.0]),
    
    % Montage 13
    struct('electrode1', struct('centre', 'T7', 'pos_ydir', 'F3', 'dimensions', [55, 55]), ...
           'electrode2', struct('centre', 'Pz', 'pos_ydir', 'O1', 'dimensions', [55, 70]), ...
           'currents', [0.9, -0.9]),
    
    % Montage 14
    struct('electrode1', struct('centre', 'T8', 'pos_ydir', 'C4', 'dimensions', [60, 60]), ...
           'electrode2', struct('centre', 'AF3', 'pos_ydir', 'Fz', 'dimensions', [50, 70]), ...
           'currents', [0.8, -0.8]),
    
    % Montage 15
    struct('electrode1', struct('centre', 'Fz', 'pos_ydir', 'F1', 'dimensions', [50, 50]), ...
           'electrode2', struct('centre', 'Pz', 'pos_ydir', 'P3', 'dimensions', [55, 60]), ...
           'currents', [1.2, -1.2]),
    
    % Montage 16
    struct('electrode1', struct('centre', 'AF4', 'pos_ydir', 'F6', 'dimensions', [60, 70]), ...
           'electrode2', struct('centre', 'Cz', 'pos_ydir', 'Pz', 'dimensions', [50, 75]), ...
           'currents', [1.0, -1.0]),
    
    % Montage 17
    struct('electrode1', struct('centre', 'C3', 'pos_ydir', 'P4', 'dimensions', [50, 60]), ...
           'electrode2', struct('centre', 'AF4', 'pos_ydir', 'Fz', 'dimensions', [55, 65]), ...
           'currents', [0.7, -0.7]),
    
    % Montage 18
    struct('electrode1', struct('centre', 'F1', 'pos_ydir', 'Fz', 'dimensions', [50, 60]), ...
           'electrode2', struct('centre', 'C4', 'pos_ydir', 'C3', 'dimensions', [60, 70]), ...
           'currents', [1.1, -1.1]),
    
    % Montage 19
    struct('electrode1', struct('centre', 'T7', 'pos_ydir', 'P3', 'dimensions', [60, 80]), ...
           'electrode2', struct('centre', 'C3', 'pos_ydir', 'Cz', 'dimensions', [60, 75]), ...
           'currents', [0.8, -0.8]),
    
    % Montage 20
    struct('electrode1', struct('centre', 'AF3', 'pos_ydir', 'Fz', 'dimensions', [55, 55]), ...
           'electrode2', struct('centre', 'P4', 'pos_ydir', 'Pz', 'dimensions', [55, 65]), ...
           'currents', [1.2, -1.2]),
    
    % Montage 21
    struct('electrode1', struct('centre', 'C1', 'pos_ydir', 'C2', 'dimensions', [50, 60]), ...
           'electrode2', struct('centre', 'AF4', 'pos_ydir', 'Fz', 'dimensions', [60, 75]), ...
           'currents', [1.1, -1.1]),
    
    % Montage 22
    struct('electrode1', struct('centre', 'Fz', 'pos_ydir', 'F3', 'dimensions', [55, 55]), ...
           'electrode2', struct('centre', 'AF3', 'pos_ydir', 'Fz', 'dimensions', [50, 60]), ...
           'currents', [1.0, -1.0]),
    
    % Montage 23
    struct('electrode1', struct('centre', 'Cz', 'pos_ydir', 'Fz', 'dimensions', [50, 50]), ...
           'electrode2', struct('centre', 'P3', 'pos_ydir', 'Pz', 'dimensions', [55, 70]), ...
           'currents', [0.9, -0.9]),
    
    % Montage 24
    struct('electrode1', struct('centre', 'T7', 'pos_ydir', 'F3', 'dimensions', [55, 55]), ...
           'electrode2', struct('centre', 'AF3', 'pos_ydir', 'Fz', 'dimensions', [60, 75]), ...
           'currents', [1.0, -1.0])

   % Montage 25
    struct('electrode1', struct('centre', 'T7', 'pos_ydir', 'F3', 'dimensions', [55, 55]), ...
           'electrode2', struct('centre', 'AF3', 'pos_ydir', 'Fz', 'dimensions', [60, 75]), ...
           'currents', [1.0, -1.0])
};

% Start a SESSION
S = sim_struct('SESSION');
S.map_to_fsavg = true;
S.map_to_MNI = true;
S.fields = 'eEjJ';

% Set up the TDCSLIST with the simulation set-up
S.poslist{1} = sim_struct('TDCSLIST');

% Create main results folder
if ~exist('bipolar', 'dir')
    mkdir('bipolar');
end

% Run the simulation for each subject
for i = 1:length(subjects)
    sub = subjects{i};
    S.subpath = fullfile(['m2m_' sub]);  % head mesh

    % Iterate over different montages
    for j = 1:length(montages)

        S.pathfem = fullfile(sub, sprintf('montage%d', j)); % Output directory

        % Set up electrodes for the current montage
        S.poslist{1}.currents = montage.currents;
        S.poslist{1}.electrode(1).channelnr = 1;
        S.poslist{1}.electrode(1).centre = montages{j}.electrode1.centre;
        S.poslist{1}.electrode(1).pos_ydir = montages{j}.electrode1.pos_ydir;
        S.poslist{1}.electrode(1).shape = 'rect';
        S.poslist{1}.electrode(1).dimensions = montages{j}.electrode1.dimensions;
        S.poslist{1}.electrode(1).thickness = 4;

        S.poslist{1}.electrode(2).channelnr = 2;
        S.poslist{1}.electrode(2).centre = montages{j}.electrode2.centre;
        S.poslist{1}.electrode(2).pos_ydir = montages{j}.electrode2.pos_ydir;
        S.poslist{1}.electrode(2).shape = 'rect';
        S.poslist{1}.electrode(2).dimensions = montages{j}.electrode2.dimensions;
        S.poslist{1}.electrode(2).thickness = 4;

        % Run the simulation for the current subject and montage
        S.pathfem = fullfile('bipolar', sub, sprintf('montage%d', j));  % Output directory for each montage
        run_simnibs(S);
    end
end

