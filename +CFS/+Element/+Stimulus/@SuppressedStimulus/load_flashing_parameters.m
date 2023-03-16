function load_flashing_parameters(obj, screen, masks)
% Calculates contrasts arrays for flashing.
%
% Args:
%   screen: :class:`~+CFS.+Element.+Screen.@CustomScreen` object.
%   masks: :class:`~+CFS.+Element.+Stimulus.@Masks` object.
%
    
    obj.image_name = obj.textures.images_names(obj.index);
    
    % Calculate indiced for appearance
    cumul = [ ...
        false(1, obj.appearance_delay*screen.frame_rate), ...
        true(1, obj.fade_in_duration*screen.frame_rate), ...
        true(1, obj.duration*screen.frame_rate), ...
        true(1, obj.fade_out_duration*screen.frame_rate)];
    obj.indices = [cumul, false(1, masks.duration*screen.frame_rate-length(cumul))];
    
    % Calculate indices for contrasts
    cumul = [ ...
        zeros(1, obj.appearance_delay*screen.frame_rate), ...
        obj.contrast/(obj.fade_in_duration*screen.frame_rate): ...
        obj.contrast/(obj.fade_in_duration*screen.frame_rate): ...
        obj.contrast, ...
        obj.contrast+zeros(1, obj.duration*screen.frame_rate), ...
        obj.contrast: ...
        -obj.contrast/(obj.fade_out_duration*screen.frame_rate+1): ...
        obj.contrast/(obj.fade_out_duration*screen.frame_rate+1)];
    obj.contrasts = [cumul, zeros(1, masks.duration*screen.frame_rate-length(cumul))];

end