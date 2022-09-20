function [] = Spatial_WM_fmri(subj_ID,run_num)

%%%%% Check if 1 and 2 keys are the same in each keyboard (49 50??)
%%%%%% If not fin da way to put that in exp mat as well


% subj_ID='ozge';
% run_num=1;

ind_drawing_time = 1;
response_period = 3;


% PsychDebugWindowConfiguration(0, 0.5);

clock_time = clock;
rng('default')
rng('shuffle');
% rand('seed',clock_time(end));
rootDir=pwd()
save_path = [rootDir filesep 'Data/'];

KbName('UnifyKeyNames');
esckey = KbName('ESCAPE');

clear Exp

%%% trial list %%%
% 1 = easy
% 2 = hard
% 3 = fixation

switch run_num
    case 1
    trial_list = [3 1 1 1 1 2 2 2 2 2 2 2 2 1 1 1 1 3 2 2 2 2 1 1 1 1 1 1 1 1 2 2 2 2 3 1 1 1 1 2 2 2 2 2 2 2 2 1 1 1 1 3];
    case 2
    trial_list = [3 2 2 2 2 1 1 1 1 1 1 1 1 2 2 2 2 3 1 1 1 1 2 2 2 2 2 2 2 2 1 1 1 1 3 2 2 2 2 1 1 1 1 1 1 1 1 2 2 2 2 3];
    otherwise
    error('input variable run_num must have a value of either 1 for fixEasyHard trial presentations, or 2 for fixHardEasy')
end

% -1 = correct on left, 1 = correct on right
correct_side = [0 Shuffle([ones(1,8) -ones(1,8)]) 0 Shuffle([ones(1,8) -ones(1,8)]) 0 Shuffle([ones(1,8) -ones(1,8)]) 0];

trial_duration = [16 8*ones(1,16) 16 8*ones(1,16) 16 8*ones(1,16) 16]; % how long each trial will take
trial_end = cumsum(trial_duration);

%pair list
pairs = [1 1 2 2 3 3 4 5 5 6 6  7 7  8  9  10 11;
         2 5 3 6 4 7 8 6 9 7 10 8 11 12 10 11 12]';
     
pair_list = zeros(4,length(trial_list));
for trial = 1:length(trial_list)
   
    switch trial_list(trial)
        case 1
            grid = randperm(12);
            pair_list([1 3 5 7],trial) = grid(1:4)';
        case 2
            idx = 1;
            while idx < 5
                pair_sample = pairs(randi(length(pairs)),:);
                if ~sum(ismember(pair_list(:,trial),pair_sample(1))) && ~sum(ismember(pair_list(:,trial),pair_sample(2)))
                    pair_list((2*idx)-1:2*idx,trial) = pair_sample;
                    idx = idx+1;
                end
            end
            pair_list(:,trial) = Shuffle(pair_list(:,trial));
        case 3 %fixation, do nothing  
    end
end
     
incorrect_list = zeros(4,length(trial_list));
for trial = 1:length(trial_list)
    switch trial_list(trial)
       case 1
           x = 1;
       case 2
           x = randi(2);
       case 3
           continue  
    end
    trial_pairs = pair_list(:,trial);
    trial_pairs(trial_pairs==0) = [];
    replace_indx = randperm(length(trial_pairs));
    replace_indx = replace_indx(1:x);
    replace_vals = Shuffle(setdiff(1:12,trial_pairs));
    replace_vals = replace_vals(1:x);
    trial_pairs(replace_indx) = replace_vals;
    incorrect_list(1:length(trial_pairs),trial) = trial_pairs;
    
end

%handle duplicate filename, and other checks

if ischar(subj_ID) == 0
    error('subj_ID must be a string')
end

if exist([save_path  subj_ID '.txt'],'file')
    overwrite = input('A file is already saved with this name. Overwrite? (y/n): ','s');
    if overwrite == 'y' %do nothing
    else %anything besides 'y', input new name
        subj_ID = input('Enter a new run identifier: ','s');
    end   
end

save_file = fopen([save_path subj_ID '.txt'],'w');
para_file= fopen([save_path subj_ID '.para'],'w');



file_to_save = ['SpatialWM_' subj_ID '_fmri_run_' num2str(run_num) '_data.mat']; 

% Error message if data file already exists.
if exist([save_path filesep file_to_save],'file')
    
    cd data/
    p = pwd;
    all_files = dir([p '/' file_to_save]);
    all_files = {all_files.name};
    
    file_to_save = ['SpatialWM_' subj_ID '_fmri_run_' num2str(run_num) '_repeat' num2str(length(all_files)) '_data.mat']; 
    
end


%% set up experiment
%PsychDebugWindowConfiguration(0, 0.5);
Screen('Preference', 'SkipSyncTests', 1);
AssertOpenGL;
%KbReleaseWait; % Wait until user releases keys on keyboard
screenNumber = min(Screen('Screens'));
Screen('Preference', 'SuppressAllWarnings', 1);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
blue = [0 0 255];
[w, screenRect]=Screen('OpenWindow',screenNumber, white);



% rects
box_size = round(screenRect(3)/12);
test_distance = round(2.5*box_size);
rect_locations_x = [-1.5 -.5 .5 1.5 -1.5 -.5 .5 1.5 -1.5 -.5 .5 1.5];
rect_locations_y = [-1 -1 -1 -1 0 0 0 0 1 1 1 1];

for rect_num = 1:12
    box_rects(rect_num,:) = CenterRect([0 0 box_size-5 box_size-5], screenRect) + box_size*[rect_locations_x(rect_num) rect_locations_y(rect_num) rect_locations_x(rect_num) rect_locations_y(rect_num)];
end

background_rect = CenterRect([0 0 4*box_size+5 3*box_size+5], screenRect);


%fixation texture
fix_image = white*ones(31,31);fix_image(:,14:18) = 0;fix_image(14:18,:) = 0;
fix_image = uint8(cat(3,fix_image,fix_image,fix_image));
fixation_tex = Screen('MakeTexture', w, fix_image);


%% Keyboard Information

PsychHID('KbQueueCreate');
PsychHID('KbQueueStart');

% Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
KeyEscape = KbName('escape');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
firstkey = KbName('1!');
secondkey = KbName('2@');

Key.Trigger = KbName ('6^'); %windows
Key.trigger = KbName('6'); %mac

%Response keys for fMRI button boxes
Key.blue = KbName('1!');
Key.yellow = KbName('2@');
Key.green = KbName ('3#');
Key.red = KbName('4$');

%% Define output structure
Exp.PerformanceMat=[];
Exp.BlockDesignMat=[];
Exp.id=subj_ID;
Exp.run_num=run_num;
Exp.ind_drawing_time = ind_drawing_time;
Exp.response_period = response_period;
Exp.KbName_1_left = KbName('1!');
Exp.KbName_2_right = KbName('2@');


% Save all data to current folder.
save([save_path filesep file_to_save], 'Exp');

%% start experiment
priorityLevel = MaxPriority(w); 
Priority(priorityLevel);

%display run ready message
Screen(w, 'TextSize',50);
Screen(w,'DrawText','Ready...',10,10,10);
Screen('DrawTexture', w, fixation_tex); %fixation cross
Screen('Flip', w);

%fixation ready for post-trigger flip
Screen('DrawTexture', w, fixation_tex); %fixation cross

Exp.scannerstarttime = GetSecs;
% % % wait for trigger
while 1
    [~, ~, keyCode] = KbCheck(-3);
    if  keyCode(KbName('6^')) || keyCode(KbName('6'))
        break
    end
end



run_start_time = Screen('Flip', w);
Exp.experimentstarttime = run_start_time; % get experiment start time


for trial = 1:length(trial_list)
    respMat(1,1)=trial_list(trial); % the type of the trial, 1:easy, 2:hard, 3:fixation/rest
    response = 0;
    
      if trial_list(trial) == 3
         respMat(2,1)=GetSecs; % the beginning of the trial for rest/fixation trial
      end

    if trial_list(trial) < 3
        
        box_counter = 1;

        %initial fixation time
        WaitSecs(.5);
        respMat(2,1)=GetSecs; % the beginning of the trial after the initial fixation time

        %four flashes, 1s each
        for flash_num = 1:4
            drawgrid;
            blue_box(pair_list(box_counter,trial),0);
            blue_box(pair_list(box_counter+1,trial),0);
            Screen('Flip', w);
            respMat(flash_num+2,1) = GetSecs; % the onset of each cell being painted, there should be 'ind_drawing_time' in between
            box_counter = box_counter + 2;
            WaitSecs(ind_drawing_time);
        end

        %choice, 3s
        draw_response_grids;

        %correct arrangement
        for box_num = 1:8
            blue_box(pair_list(box_num,trial),correct_side(trial));        
        end

        %incorrect arrangement
        for box_num = 1:8
            blue_box(incorrect_list(box_num,trial),-correct_side(trial));        
        end    
        
        respMat(7,1) = correct_side(trial);   % whether the correct arrangement is on the left or right, -1 = correct on left, 1 = correct on right
        


        response_period_start = Screen('Flip', w);
        respMat(8,1) = GetSecs; % Response period start 

        while GetSecs < response_period_start+response_period
            [~, ~, keyCode] = KbCheck(-1);
            if keyCode(Key.blue) || keyCode(Key.yellow) %if 1 or 2 is pressed
                response = find(keyCode,1);
                respMat(9,1) = response;
            end
        end

        Screen('DrawTexture', w, fixation_tex); %fixation cross
        Screen('Flip', w);
        respMat(10,1) = GetSecs; % response period end, also, the end of the trial for type 1 and 2
    
    end
    
    %record save file data
    trial_start=trial_end(trial)-trial_duration(trial);
    fprintf(save_file,'%i\t%i\t%i\n',trial_list(trial),correct_side(trial),response); %add trial to save file
    fprintf(para_file,'%i\t%i\t%i\n',trial_start,trial_list(trial),trial_duration(trial)); %add trial to para file
    
    %wait for end of trial
    while GetSecs < run_start_time + trial_end(trial);end
    respMat(11,1) = GetSecs; % the end of the trial for all types of trials, especially imp for rest/fixation trials
    
    %Abort if escape is pressed
    [~,~,keyCode] = KbCheck(-1);
    if keyCode(esckey)
        break;
    end
    
Exp.PerformanceMat = [Exp.PerformanceMat respMat];
% Save all data to current folder.
save([save_path filesep file_to_save], 'Exp');

end %end all trials


disp('total run time:')
disp(GetSecs - run_start_time)

Priority(0);
Screen('CloseAll');

fclose(save_file);
fclose(para_file);

% FlushEvents;
% Save all data to current folder.
save([save_path filesep file_to_save], 'Exp');




%%%%%%% functions %%%%%%%

function [] = drawgrid()
    Screen('FillRect', w, black, background_rect);
    for rect_number = 1:12
        Screen('FillRect', w, white, box_rects(rect_number,:));
    end
end

function [] = draw_response_grids()
    Screen('FillRect', w, black, background_rect + [test_distance 0 test_distance 0]);
    for rect_number = 1:12
        Screen('FillRect', w, white, box_rects(rect_number,:) + [test_distance 0 test_distance 0]);
    end
    
    Screen('FillRect', w, black, background_rect - [test_distance 0 test_distance 0]);
    for rect_number = 1:12
        Screen('FillRect', w, white, box_rects(rect_number,:) - [test_distance 0 test_distance 0]);
    end
end

function [] = blue_box(box_position,side)
    if box_position > 0
        Screen('FillRect', w, blue, box_rects(box_position,:) + side*[test_distance 0 test_distance 0]);
    end
end



end %end main function     
       
                
