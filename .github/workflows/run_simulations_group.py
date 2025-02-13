import os
from simnibs import run_simnibs, sim_struct

# Set the subjects
subjects = ['sub01', 'sub09', 'sub10', 'sub12', 'sub15']

# Define the montages (electrode setups)
montages = [
    # Montage 1
    {
        'electrode1': {'centre': 'C3', 'pos_ydir': 'C1', 'dimensions': [50, 50]},
        'electrode2': {'centre': 'AF4', 'pos_ydir': 'F6', 'dimensions': [50, 70]},
        'currents': [1, -1]
    },
    # Montage 2
    {
        'electrode1': {'centre': 'F3', 'pos_ydir': 'Fz', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'P4', 'pos_ydir': 'Pz', 'dimensions': [60, 80]},
        'currents': [0.8, -0.8]
    },
    # Montage 3
    {
        'electrode1': {'centre': 'F7', 'pos_ydir': 'F3', 'dimensions': [50, 50]},
        'electrode2': {'centre': 'C4', 'pos_ydir': 'C3', 'dimensions': [50, 70]},
        'currents': [1, -1]
    },
    # Montage 4
    {
        'electrode1': {'centre': 'Fz', 'pos_ydir': 'F3', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'Pz', 'pos_ydir': 'P3', 'dimensions': [60, 80]},
        'currents': [0.9, -0.9]
    },
    # Montage 5
    {
        'electrode1': {'centre': 'AF3', 'pos_ydir': 'F3', 'dimensions': [50, 50]},
        'electrode2': {'centre': 'P4', 'pos_ydir': 'Pz', 'dimensions': [60, 70]},
        'currents': [1, -1]
    },
    # Montage 6
    {
        'electrode1': {'centre': 'F4', 'pos_ydir': 'Cz', 'dimensions': [50, 50]},
        'electrode2': {'centre': 'O1', 'pos_ydir': 'Pz', 'dimensions': [50, 60]},
        'currents': [0.8, -0.8]
    },
    # Montage 7
    {
        'electrode1': {'centre': 'Cz', 'pos_ydir': 'Pz', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'O2', 'pos_ydir': 'Pz', 'dimensions': [60, 70]},
        'currents': [1, -1]
    },
    # Montage 8
    {
        'electrode1': {'centre': 'AF4', 'pos_ydir': 'Fz', 'dimensions': [60, 50]},
        'electrode2': {'centre': 'P4', 'pos_ydir': 'Pz', 'dimensions': [60, 80]},
        'currents': [0.9, -0.9]
    },
    # Montage 9
    {
        'electrode1': {'centre': 'C3', 'pos_ydir': 'Cz', 'dimensions': [50, 50]},
        'electrode2': {'centre': 'P3', 'pos_ydir': 'Pz', 'dimensions': [50, 70]},
        'currents': [1, -1]
    },
    # Montage 10
    {
        'electrode1': {'centre': 'Fz', 'pos_ydir': 'F4', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'Pz', 'pos_ydir': 'P4', 'dimensions': [60, 80]},
        'currents': [0.8, -0.8]
    },
    # Montage 11
    {
        'electrode1': {'centre': 'F7', 'pos_ydir': 'Fz', 'dimensions': [55, 55]},
        'electrode2': {'centre': 'T8', 'pos_ydir': 'C4', 'dimensions': [60, 75]},
        'currents': [1, -1]
    },
    # Montage 12
    {
        'electrode1': {'centre': 'C4', 'pos_ydir': 'Cz', 'dimensions': [60, 50]},
        'electrode2': {'centre': 'P3', 'pos_ydir': 'Pz', 'dimensions': [50, 60]},
        'currents': [1, -1]
    },
    # Montage 13
    {
        'electrode1': {'centre': 'AF3', 'pos_ydir': 'F4', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'P4', 'pos_ydir': 'Pz', 'dimensions': [70, 80]},
        'currents': [0.7, -0.7]
    },
    # Montage 14
    {
        'electrode1': {'centre': 'P3', 'pos_ydir': 'Pz', 'dimensions': [50, 60]},
        'electrode2': {'centre': 'AF4', 'pos_ydir': 'Fz', 'dimensions': [60, 70]},
        'currents': [0.8, -0.8]
    },
    # Montage 15
    {
        'electrode1': {'centre': 'F3', 'pos_ydir': 'Fz', 'dimensions': [60, 50]},
        'electrode2': {'centre': 'Pz', 'pos_ydir': 'P3', 'dimensions': [60, 70]},
        'currents': [1.1, -1.1]
    },
    # Montage 16
    {
        'electrode1': {'centre': 'Fz', 'pos_ydir': 'Cz', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'O1', 'pos_ydir': 'Pz', 'dimensions': [70, 80]},
        'currents': [0.9, -0.9]
    },
    # Montage 17
    {
        'electrode1': {'centre': 'C1', 'pos_ydir': 'Cz', 'dimensions': [60, 50]},
        'electrode2': {'centre': 'AF3', 'pos_ydir': 'Fz', 'dimensions': [60, 60]},
        'currents': [1.1, -1.1]
    },
    # Montage 18
    {
        'electrode1': {'centre': 'Pz', 'pos_ydir': 'P3', 'dimensions': [60, 70]},
        'electrode2': {'centre': 'AF4', 'pos_ydir': 'F4', 'dimensions': [60, 70]},
        'currents': [0.8, -0.8]
    },
    # Montage 19
    {
        'electrode1': {'centre': 'Cz', 'pos_ydir': 'C3', 'dimensions': [50, 50]},
        'electrode2': {'centre': 'P4', 'pos_ydir': 'Pz', 'dimensions': [60, 60]},
        'currents': [1, -1]
    },
    # Montage 20
    {
        'electrode1': {'centre': 'AF3', 'pos_ydir': 'Fz', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'Pz', 'pos_ydir': 'P4', 'dimensions': [60, 80]},
        'currents': [0.9, -0.9]
    },
    # Montage 21
    {
        'electrode1': {'centre': 'F3', 'pos_ydir': 'Cz', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'Pz', 'pos_ydir': 'P4', 'dimensions': [70, 70]},
        'currents': [1, -1]
    },
    # Montage 22
    {
        'electrode1': {'centre': 'C3', 'pos_ydir': 'Pz', 'dimensions': [50, 50]},
        'electrode2': {'centre': 'AF4', 'pos_ydir': 'F3', 'dimensions': [50, 70]},
        'currents': [1, -1]
    },
    # Montage 23
    {
        'electrode1': {'centre': 'AF4', 'pos_ydir': 'Fz', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'Pz', 'pos_ydir': 'P4', 'dimensions': [60, 80]},
        'currents': [1.0, -1.0]
    },
    # Montage 24
    {
        'electrode1': {'centre': 'Fz', 'pos_ydir': 'F4', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'P3', 'pos_ydir': 'Pz', 'dimensions': [60, 70]},
        'currents': [0.9, -0.9]
    },
    # Montage 25
    {
        'electrode1': {'centre': 'C4', 'pos_ydir': 'C3', 'dimensions': [60, 60]},
        'electrode2': {'centre': 'Pz', 'pos_ydir': 'P3', 'dimensions': [60, 80]},
        'currents': [1, -1]
    }
]

# Create main results folder
if not os.path.exists('bipolar'):
    os.makedirs('bipolar')

# Start a SESSION
S = sim_struct('SESSION')
S.map_to_fsavg = True
S.map_to_MNI = True
S.fields = 'eEjJ'

# Set up the TDCSLIST with the simulation set-up
S.poslist = [sim_struct('TDCSLIST')]

# Run the simulation for each subject
for subject in subjects:
    S.subpath = f"m2m_{subject}"  # head mesh

    # Iterate over different montages
    for j, montage in enumerate(montages):

        S.pathfem = os.path.join(subject, f"montage{j+1}")  # Output directory

        # Set up electrodes for the current montage
        S.poslist[0].currents = montage['currents']
        S.poslist[0].electrode[0].channelnr = 1
        S.poslist[0].electrode[0].centre = montage['electrode1']['centre']
        S.poslist[0].electrode[0].pos_ydir = montage['electrode1']['pos_ydir']
        S.poslist[0].electrode[0].shape = 'rect'
        S.poslist[0].electrode[0].dimensions = montage['electrode1']['dimensions']
        S.poslist[0].electrode[0].thickness = 4

        S.poslist[0].electrode[1].channelnr = 2
        S.poslist[0].electrode[1].centre = montage['electrode2']['centre']
        S.poslist[0].electrode[1].pos_ydir = montage['electrode2']['pos_ydir']
        S.poslist[0].electrode[1].shape = 'rect'
        S.poslist[0].electrode[1].dimensions = montage['electrode2']['dimensions']
        S.poslist[0].electrode[1].thickness = 4

        # Run the simulation for the current subject and montage
        S.pathfem = os.path.join('bipolar', subject, f"montage{j+1}")  # Output directory for each montage
        run_simnibs(S)
