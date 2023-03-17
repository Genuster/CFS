import CFSVM.Experiment.* ...
    CFSVM.Element.Screen.* ...
    CFSVM.Element.Data.* ...
    CFSVM.Element.Evidence.* ...
    CFSVM.Element.Stimulus.*


% Initiate an object, for visual priming CFS use experiment = VPCFS(),
% for breaking CFS use experiment = BCFS()

experiment = BCFS();

experiment.fixation = Fixation();
experiment.frame = CheckFrame();

experiment.masks = Mondrians( ...
    dirpath='./Masks/', ...
    temporal_frequency=10, ...
    duration=5, ...
    blank=0.5, ...
    mondrians_shape=1, ...
    mondrians_color=2, ...
    position="Right", ...
    size=0.45, ...
    padding=0.5, ...
    xy_ratio=1, ...
    contrast=1, ...
    rotation=0);

experiment.addprop('stimulus_1');
experiment.addprop('stimulus_2');
experiment.stimulus_1 = SuppressedStimulus( ...
    './Images', ...
    duration=5, ...
    position="Left", ...
    size=0.4, ...
    padding=0.5, ...
    xy_ratio=1, ...
    contrast=0.3);
experiment.stimulus_2 = SuppressedStimulus( ...
    './Images', ...
    duration=5, ...
    position="Right", ...
    size=0.4, ...
    padding=0.5, ...
    xy_ratio=1, ...
    contrast=0.3);



experiment.breakthrough = BreakResponse();



if ~exist('.temp', 'dir')
    mkdir('.temp')
end
save('.temp\experiment.mat', 'experiment')

n_blocks = 1;
n_trials = [30];
trial_matrix = cell(1, n_blocks);

orientations = [0, 45, 90, 135];
n_images = 2;
block = 1;
for trial = 1:30
    load('.temp\experiment.mat');
    experiment.stimulus_1.index = randi(n_images);
    experiment.stimulus_1.rotation = orientations(randi(length(orientations), 1));
    experiment.stimulus_2.index = randi(n_images);
    experiment.stimulus_2.rotation = orientations(randi(length(orientations), 1));
    if trial >= 20
        experiment.stimulus_2.contrast = 0;
    end
    trial_matrix{block}{trial} = experiment;
end

trial_matrix{1} = trial_matrix{1}(randperm(numel(trial_matrix{1})));

if ~exist('TrialMatrix', 'dir')
    mkdir('TrialMatrix')
end
save('TrialMatrix\experiment.mat', 'trial_matrix')

rmdir('.temp', 's')
