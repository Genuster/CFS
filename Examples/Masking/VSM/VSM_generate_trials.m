import CFSVM.Experiment.* ...
    CFSVM.Element.Screen.* ...
    CFSVM.Element.Data.* ...
    CFSVM.Element.Evidence.* ...
    CFSVM.Element.Stimulus.*


% Initiate an object, for visual priming CFS use experiment = VPCFS(),
% for breaking CFS use experiment = BCFS()

experiment = VSM();

experiment.fixation = Fixation();

experiment.f_mask = Mask( ...
    dirpath='./Masks/', ...
    duration=0.1, ...
    soa=0.1, ...
    position="Center", ...
    size=0.1, ...
    padding=0, ...
    xy_ratio=1, ...
    contrast=1, ...
    rotation=0);

experiment.addprop('stimulus');
experiment.stimulus = SuppressedStimulus( ...
    './Images', ...
    duration=0.05, ...
    position="Center", ...
    size=0.1, ...
    padding=0.5, ...
    xy_ratio=1, ...
    contrast=1);

experiment.b_mask = Mask( ...
    dirpath='./Masks/', ...
    duration=0.1, ...
    soa=0.1, ...
    blank=0.5, ...
    position="Center", ...
    size=0.1, ...
    padding=0, ...
    xy_ratio=1, ...
    contrast=1, ...
    rotation=0);


experiment.pas = PAS();
experiment.mafc = ImgMAFC();

if ~exist('.temp', 'dir')
    mkdir('.temp')
end
save('.temp\vsm.mat', 'experiment')

n_blocks = 1;
n_trials = [30];
trial_matrix = cell(1, n_blocks);

orientations = [0, 45, 90, 135];
mask_durations = 0.1:0.1:0.3;
soas = 0.05:0.01:0.1;
n_images = 2;
block = 1;
for trial = 1:30
    load('.temp\vsm.mat');
    experiment.stimulus.index = randi(n_images);
    experiment.stimulus.rotation = orientations(randi(length(orientations), 1));
    experiment.f_mask.duration = mask_durations(randperm(numel(mask_durations),1));
    experiment.f_mask.soa = soas(randperm(numel(soas),1));
    trial_matrix{block}{trial} = experiment;
end

trial_matrix{1} = trial_matrix{1}(randperm(numel(trial_matrix{1})));

if ~exist('TrialMatrix', 'dir')
    mkdir('TrialMatrix')
end
save('TrialMatrix\vsm.mat', 'trial_matrix')

rmdir('.temp', 's')
