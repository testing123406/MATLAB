% Define subject IDs to iterate over
subject_ids = [204319, 204320, 204321];  % Replace with your actual subject numbers

% Define path to ROI mask (same for all subjects and montages)
network_file = "/Users/benjaminostow/Downloads/Language_Network_Atlas_1_9_25/network_roi_resampled.nii.gz";  % Binary mask

% Load the network-based ROI NIfTI file
network_image = nifti_load(network_file);
network_roi = network_image.vol > 0;  % Binary mask (1 for ROI)

% Outer loop through subjects
for subj = 1:length(subject_ids)
    subject_id = subject_ids(subj);
    fprintf('\nSubject %d:\n', subject_id);

    % Inner loop through montage1 to montage25
    for montage_num = 1:25
        fprintf('  Processing montage %d...\n', montage_num);

        % Construct the file path using string interpolation
        subject_file = "/Users/benjaminostow/Documents/MATLAB/preliminary(!!!!!!)/25 Montage Script/" + ...
                       "montage" + montage_num + "/mni_volumes/" + subject_id + "_TDCS_1_scalar_MNI_magnE.nii.gz";

        % Check if the file exists
        if ~isfile(subject_file)
            fprintf('    File not found: %s\n', subject_file);
            continue;
        end

        % Load the subject's EF NIfTI file
        EF_image = nifti_load(subject_file);
        EF_intensity = EF_image.vol;

        % Convert from mV/m to V/m
        EF_intensity = EF_intensity / 1000;

        % Ensure the dimensions match
        if ~isequal(size(EF_intensity), size(network_roi))
            warning('    Dimension mismatch for subject %d, montage %d. Skipping.', subject_id, montage_num);
            continue;
        end

        % Extract EF values inside the network ROI
        EF_in_network = EF_intensity(network_roi);

        % Compute the mean EF value
        mean_EF_network = mean(EF_in_network(:));

        % Display result
        fprintf('    Montage %d - Mean EF in network ROI: %f V/m\n', montage_num, mean_EF_network);
    end
end
