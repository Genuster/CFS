function show_targets(obj)
%show_targets Presents target for the provided-as-parameter duration.
%   Detailed explanation goes here

    % If multiple target images were in the folder - randomise.
    target = obj.choose_texture(obj.target_textures);

    Screen('DrawTexture', obj.window, target, [], obj.stimulus_rect, 0, 1, obj.stimulus_contrast);

    Screen('DrawTexture', obj.window, target, [], obj.masks_rect, 0, 1, obj.stimulus_contrast);
    
    Screen('Flip', obj.window);

    WaitSecs(obj.target_presentation_duration);
end

