function run(obj)
    % Executes the visual masking experiment.
    %
    % First initiates the experiment, then for every trial update parameters,
    % shows fixation crosses, flashes masks and stimuli, records
    % responses, writes results and shows rest screen.
    %

    obj.initiate();
    obj.instructions.show(obj, 'introduction');

    for block = 1:obj.trials.n_blocks
        obj.trials.block_index = block;
        obj.instructions.show(obj, sprintf('block_introduction_%d', block));

        for trial = 1:width(obj.trials.matrix{block})
            obj.trials.start_time = GetSecs();
            obj.trials.trial_index = trial;
            obj.trials.load_trial_parameters(obj);

            obj.flash();

            obj.pas.show(obj);
            obj.mafc.show(obj);
            obj.trials.end_time = GetSecs();
            obj.instructions.show(obj, 'rest');
        end

    end
    obj.instructions.show(obj, 'farewell');

end
