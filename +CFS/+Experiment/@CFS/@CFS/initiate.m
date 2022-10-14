function initiate(obj)
    %initiate Initiates Psychtoolbox window, generates mondrians and runs other basic functions.
    % See also get_subject_info, initiate_window, read_trial_matrices, 
    % initiate_checkerboard_frame, make_mondrian_masks, introduction,
    % get_rect, import_images, initiate_records_table
    
    KbName('UnifyKeyNames');

    % Initiate PTB window and keep the data from it.
    obj.screen.background_color = hex2rgb(obj.screen.background_color);
    obj.initiate_window();


    obj.frame.initiate(obj.screen.left.rect, obj.screen.right.rect)


    obj.screen.adjust(obj.frame);
    
    DrawFormattedText(obj.screen.window, 'Preparing the experiment, please wait', 'center', 'center');
    Screen('Flip', obj.screen.window);
    
    % Set screens rects inside the checkframe
    obj.screen.left.rect(1:2) = obj.screen.left.rect(1:2) + obj.frame.checker_width;
    obj.screen.left.rect(3:4) = obj.screen.left.rect(3:4) - obj.frame.checker_width;
    obj.screen.right.rect(1:2) = obj.screen.right.rect(1:2) + obj.frame.checker_width;
    obj.screen.right.rect(3:4) = obj.screen.right.rect(3:4) - obj.frame.checker_width;
    % Calculate screen parameters.
    obj.screen.initiate();

    % Warm GetSecs() and WaitSecs() functions;
    GetSecs();
    WaitSecs(0.00001);

    % Import images from the provided directory and make their PTB textures.
    obj.stimulus.import_images(obj.screen.window);
    
    if class(obj) == "VPCFS" || class(obj) == "VACFS"
        obj.target.import_images(obj.screen.window);
    end
    
    if class(obj) == "BCFS" || class(obj) == "VACFS"
        obj.stimulus_break.create_kbqueue();
    end
    

    obj.trials.import(obj);

    obj.masks.initiate(obj.trials.blocks)
    
    % If load-pregenerated-masks-from-folder set to true, then load the mask images,
    % create textures and run the introductory screen. 
    % If set to false, then generate mondrians with provided parameters,
    % run the introductory screen and create textures.
    if ~isfolder(obj.masks.dirpath)
        % Start mondrian masks generation.
        % The function takes two arguments: shape and color.
        % Shape: 1 - squares, 2 - circles, 3 - diamonds.
        % Color: 1 - BRGBYCMW, 2 - grayscale, 3 - all colors,
        % for 4...15 see 'help CFS.asynchronously_generate_mondrians'.
        if obj.subject_info.is_left_suppression == true
            x = obj.screen.left.x_pixels;
            y = obj.screen.left.y_pixels;
        else
            x = obj.screen.right.x_pixels;
            y = obj.screen.right.y_pixels;
        end
        obj.masks.make_mondrian_masks(x,y);
    end

    % Create PTB textures of mondrians
    obj.masks.import_images(obj.screen.window, images_number=obj.masks.n_max);

    % Show introduction screen.
    obj.show_introduction_screen();
end

function rgb = hex2rgb(hex)
            %hex2rgb Transforms hexadecimal color code to MATLAB RGB color code.
            rgb = sscanf(hex(2:end),'%2x%2x%2x',[1 3])/255;
end