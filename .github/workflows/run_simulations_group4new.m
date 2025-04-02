% Add SimNIBS to the MATLAB path
addpath('/Users/benjaminostow/Applications/SimNIBS-4.1/matlab_tools');

% Optional: Save the path for future sessions
savepath;

% Set the subjects
subjects = {'102715','103212','103414','106319','110613','114621','115219','118730','121618','123420','204319','204521','211417','212116','213017','239944','274542','341834','352738','385450','387959','461743','481042','500222','519647','592455','635245','677766','723141','886674'};

% Define the montages (electrode setups)
montages = [
    struct('electrode1', struct('centre', 'CP5', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50,70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', 'CP5', 'dimensions', [50,70],'shape','rect','thickness',[4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50,70],'shape','rect','thickness',[4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', 'F3', 'dimensions', [46, 45],'shape','ellipse','thickness',[4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50, 60],'shape','rect','thickness',[4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', 'F4', 'dimensions', [46, 45],'shape','ellipse','thickness',[4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50, 60],'shape','rect','thickness',[4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre',[-42.58, 45.79, 41.22], 'dimensions', [70, 50],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [70,50],'shape','rect','thickness',[4,1,4]), ...
           'currents', [2, -2]),  

    struct('electrode1', struct('centre', 'F8', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP1', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [2, -2]),  

    struct('electrode1', struct('centre', 'F3', 'dimensions', [52,52],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'Cz', 'dimensions', [52,52],'shape','rect','thickness',[4,1,4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', [-59.45, 49.58, 34.91], 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [10, 10],'shape','rect','thickness',[4,1,4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', [-55.90, 75.02, 33.94], 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [10, 10],'shape','rect','thickness',[4,1,4]), ...
           'currents', [1, -1]),  
    
    struct('electrode1', struct('centre', [-42.58, 45.79, 41.22], 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [2, -2]),  
           
    struct('electrode1', struct('centre', [-59.45, 49.58, 34.91], 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [2, -2]), 
           
    struct('electrode1', struct('centre', [-59.45, 49.58, 34.91], 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'contralateral', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [2, -2]), 
           
    struct('electrode1', struct('centre', [-59.45, 49.58, 34.91], 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [100, 100],'shape','rect','thickness',[4,1,4]), ...
           'currents', [2, -2]), 

    struct('electrode1', struct('centre', 'F5', 'dimensions', [30, 30],'shape','rect','thickness',[4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [70, 50],'shape','rect','thickness',[4]), ...
           'currents', [0.75, -0.75]), 

    struct('electrode1', struct('centre', 'CP5', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'CP4', 'dimensions', [50,70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [2, -2]),  
           
    struct('electrode1', struct('centre', 'CP5', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'F10', 'dimensions', [50,70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [2, -2]),  

    struct('electrode1', struct('centre', 'F7', 'dimensions', [30, 30],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50,70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', [-65,-30,15], 'dimensions', [50, 50],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'cheek', 'dimensions', [50,70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [1.5, -1.5]),  
           
    struct('electrode1', struct('centre', 'F7', 'dimensions', [50, 50],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50,70],'shape','rect','thickness',[4,1,4]), ...
           'currents', [1.5, -1.5]),  

    struct('electrode1', struct('centre', [64, -29, -135], 'dimensions', [70, 50],'shape','rect','thickness',[4]), ...
           'electrode2', struct('centre', 'CP5', 'dimensions', [70,50],'shape','rect','thickness',[4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', 'CP5', 'dimensions', [70, 50],'shape','rect','thickness',[4]), ...
           'electrode2', struct('centre', [64,-29,-135], 'dimensions', [70,50],'shape','rect','thickness',[4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', 'FC5', 'dimensions', [50, 70],'shape','rect','thickness',[4,1,4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50,70],'shape','rect',thickness',[4,1,4]), ...
           'currents', [1, -1]),  

    struct('electrode1', struct('centre', 'CP5', 'dimensions', [40, 40],'shape','rect','thickness',[4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [40,40],'shape','rect','thickness',[4]), ...
           'currents', [1.5, -1.5]),  

    struct('electrode1', struct('centre', 'FC5', 'dimensions', [50, 70],'shape','rect','thickness',[4]), ...
           'electrode2', struct('centre', 'FP2', 'dimensions', [50,70],'shape','rect','thickness',[4]), ...
           'currents', [2, -2]),  

    struct('electrode1', struct('centre', 'FC6', 'dimensions', [50, 70],'shape','rect','thickness',[4]), ...
           'electrode2', struct('centre', 'FP1', 'dimensions', [50,70],'shape','rect','thickness',[4]), ...
           'currents', [2, -2])  
];


% Start a SESSION
S = sim_struct('SESSION');
S.map_to_fsavg = true;
S.map_to_MNI = true;
S.fields = 'eEjJ';

% Set up the TDCSLIST with the simulation setup
S.poslist{1} = sim_struct('TDCSLIST');

% Create main results folder
if ~exist('scripts', 'dir')
    mkdir('scripts');
end

% Run the simulation for each subject
for i = 1:length(subjects)
    sub = subjects{i};
    S.subpath = fullfile(['m2m_' sub]);  % head mesh

    % Iterate over different montages
    for j = 1:length(montages)
        % Define the output directory
        output_dir = fullfile('scripts', sub, sprintf('montage%d', j));

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
        S.poslist{1}.electrode(1).pos_ydir = [1, 1, 0] / sqrt(2);
        S.poslist{1}.electrode(1).shape = montages{j}.electrode1.shape;
        S.poslist{1}.electrode(1).dimensions = montages{j}.electrode1.dimensions;
        S.poslist{1}.electrode(1).thickness = montages{j}.electrode2.thickness;

        % Electrode 2 setup
        S.poslist{1}.electrode(2).channelnr = 2;
        S.poslist{1}.electrode(2).centre = montages{j}.electrode2.centre;
        S.poslist{1}.electrode(2).pos_ydir = [1, 1, 0] / sqrt(2);
        S.poslist{1}.electrode(2).shape = montages{j}.electrode1.shape;
        S.poslist{1}.electrode(2).dimensions = montages{j}.electrode2.dimensions;
        S.poslist{1}.electrode(2).thickness = montages{j}.electrode2.thickness;

        % Run the simulation for the current subject and montage
        run_simnibs(S);
    end
end
