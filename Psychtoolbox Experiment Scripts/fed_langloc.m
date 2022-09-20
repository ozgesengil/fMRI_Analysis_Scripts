
% This is a language localizer experiment with two conditions - sentences
% and nonwords. In each trial, 12 words sequences will be displayed one
% word at a time followed by a prompt for the subject to push a button, just to make sure they are paying some
% attention. 
% The subject should be instructed to read each English word or nonword and
% press a button when then image of a hand pressing a button is displayed.
% Emphasis should be placed on paying attention to reading each sequence
% and not to be stressed out if the sequence seems fast. 

% The trial timings are as follows: 100 ms of blank screen, 900 ms *
% 8 words for 5400 ms of stimuli, 800 ms of the button press image, and
% 100 ms of blank screen. The entire trial lasts for ____ ms. The subject's button press for a given trial will
% be recorded if it occurs after the button press image and before the
% same image of the subsequent trial.

% 3 trials of a given condition will be grouped into a block. A run will
% consist of 16 blocks in this sequence: Fix B1 B2 B3 B4 Fix B5 B6 B7 B8
% Fix B9 B10 B11 B12 Fix B13 B14 B15 B16 Fix. Each fixation period will
% last 14000 ms. Each run is ___ s.

% Argument definitions:

% run: The localizer is meant to be run twice. The run is the counter-balance number, and should have the value 1
% or 2 delineating the first or second run of the experiment. The sequence
% of conditions are:
% run = 1 : SNNS - NSNS - SNSN - NSSN
% run = 2 : NSSN - SNSN - NSNS - SNNS
% run = 3 : run1

% do_rev_order: So that each patient doesn't see the exact same ordering of the stimuli
% do_rev_order can be specified to be 0 (use original order) or 1 (reverse
% the order. If you use 0 for the first run, be sure to keep it 0 for the
% second run.

% A structure 'Exp' is created and saved to the pwd unless otherwise
% specified. It will be saved as a .mat in the format:
% <subj_id>_fmri_run<run#>_data.mat. 

% I've set up this script so that all the stimuli should live in the same
% directory as the script, and the saved subject data will live in a
% sub-directory called 'data'. Of course, feel free to change this however you like. 


% EXP

% BlockMat Rows
% 1 = the block number
% 2 = block type
% 3 = the onset of the block (after the white screen before each block) (before the first trial of a
      % block)
% 4 = end of the block (after white screen of the last trial of the block)
% 5 = block duration (4-3)





%% Initial Preferences 

close all;
clearvars;

PsychDefaultSetup(2);

feature('DefaultCharacterSet','UTF8')
Screen('Preference', 'SkipSyncTests', 1)
screensAll = Screen('Screens');
KbName('UnifyKeyNames');
my_key = '1!'; % What key gives a response.
my_trigger = '6'; % What key triggers the script from the scanner.
do_suppress_warnings = 1; % You don't need to do this but I don't like the warning screen at the beginning.
Screen('Preference','TextEncodingLocale','UTF-8');

%% Stuff to change
screenNum = max(screensAll); % Which screen you want to use. "1" is external monitor, "0" is this screen.
DATA_DIR = [pwd filesep 'data']; % Where the Exp will be saved.
STIM_DIR = [pwd]; % Where all the stimuli are.
stim_font_size = 100; 

run=2;
set=2;
subj_id= 'sub_03_sess2';

imagetime=1; % how long the p666ress a button image will be displayed for
word_display_time=1.200; % how long a word will be displayed for


%% Keyboard Information

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

%% Some checks to perform

file_to_save = ['fed_langloc_' subj_id '_fmri_run' num2str(run) '_set' num2str(set) '_data.mat']; 

% Error message if data file already exists.
if exist([DATA_DIR filesep file_to_save],'file')
    
    cd data/
    p = pwd;
    all_files = dir([p '/' file_to_save]);
    all_files = {all_files.name};
    
    file_to_save = ['fed_langloc_' subj_id '_fmri_run' num2str(run) '_set' num2str(set) '_repeat' num2str(length(all_files)) '_data.mat']; 
    
end

% The second run should have the same value of do_rev_order as the first
% run for that subject and the second run should come after the first.


clear Exp

num_of_trials = 36;
num_of_fix = 2;

%% Start experiment
% word_time = 0.900;
% trial_time = 8*word_time + 1.000; % 800 ms button press image, 100 ms blank screen, 100 ms blank screen

% Choose which stimuli set to use.

    stim = load([STIM_DIR filesep 'langloc_fmri_run' num2str(run) '_stim_set' num2str(set) '.mat']);
    stim = stim.stim;
    
% Load up variables needed later. 

img=imread([STIM_DIR filesep 'hand-press-button-4.jpeg'], 'JPG');
img=flip(img,2);

% create the specifics of the output structure
Exp.PerformanceMat=[];
Exp.BlockDesignMat=[];
Exp.id=subj_id;
Exp.fix_onsets=zeros(num_of_fix,1);
Exp.fix_ends=zeros(num_of_fix,1);
Exp.probe_onset=zeros(num_of_trials,1);
Exp.probe_response = zeros(num_of_trials,1);
Exp.word_display_time=word_display_time;
Exp.image_time=imagetime;


% Save all data to current folder.
save([DATA_DIR filesep file_to_save], 'Exp');

% Screen preferences
PsychDefaultSetup(2);
Screen('CloseAll');
%PsychDebugWindowConfiguration(0,0.6)

% Setting this preference to 1 suppresses the printout of warnings.
oldEnableFlag = Screen('Preference', 'SuppressAllWarnings', do_suppress_warnings);
Screen('Preference', 'TextRenderer', 0);

% Open screen.

[wPtr,~]=Screen('OpenWindow',screenNum,1);
white=WhiteIndex(wPtr);
black = BlackIndex(wPtr);
scrColor = white;
Screen('FillRect',wPtr,scrColor);
Screen(wPtr, 'Flip');

% HideCursor;

KbQueueCreate(); % create the que in the beginning since it will take some time

Screen('TextSize', wPtr , 100);
DrawFormattedText(wPtr,'Hosgeldiniz...','center','center',[],[],1);
Screen(wPtr, 'Flip');

Exp.scannerstarttime = GetSecs;

% Pre-draw button press image
textureIndex=Screen('MakeTexture', wPtr, double(img));

% Get trigger from scanner.

disp('Waiting for scanner trigger ...');
Exp.scannerstarttime = GetSecs;

%ListenChar(2); %Getting keyboard input for only psychtoolbox from now on

KbQueueStart();
trigger=0;
while trigger==0
    [pressed, keyCode] = KbQueueCheck();
    
    if pressed && keyCode(Key.trigger)
        trigger=1;
        break;
    elseif pressed && keyCode(Key.Trigger)
        trigger=1;
        break;
    end
    
end
KbQueueStop();

Exp.experimentstarttime = GetSecs; % get experiment start time


%%
nblocks=12;
conditions=[1 2];
block_list=repmat(conditions, 1, nblocks/length(conditions));
    
%% Runs

%respMat=nan(8,1);
fix_counter=0;
block_counter=0;
iBi= [5 5.5 6 7 7.5 8 9 9.5 10 10.5 11 12 13 13.5 14 15];


for ii=1:(length(block_list))
    
        block_type=block_list(ii);
        blockMat=nan(5,1);

        % Fixation
        if ii==1
            
            Screen('TextSize', wPtr , 100);
            DrawFormattedText(wPtr,'+','center','center',[],[],1);
            Screen(wPtr, 'Flip');
            fix_counter=fix_counter+1;

            Exp.fix_onsets(fix_counter) = GetSecs;

            while GetSecs<14.000+Exp.experimentstarttime
            WaitSecs('YieldSecs', 0.0001);
            end

            Exp.fix_ends(fix_counter) = GetSecs;
            
            fix_counter=fix_counter+1;
            
        end
        


        % Start trials

    for i = ((block_counter*3)+1):((block_counter*3)+3) % 3 sentences/trials at each block
        
        respMat=nan(7,1);
        respMat(1,1)=ii;
        respMat(2,1)=block_type;
        
        blockMat(1,1)=ii;
        blockMat(2,1)=block_type;
        
        
        stim_seq = stim(i,1:8);
    
        % White screen for 100 ms
    
        white=WhiteIndex(wPtr);
        Screen('FillRect',wPtr,scrColor);
        Screen(wPtr, 'Flip');
        %respMat(4,i)=GetSecs;
        WaitSecs(0.100)
        if rem(i,3)==1
          blockMat(3,1)=GetSecs; 
        end
        
        respMat(3,1)=rem(i,3); % if 0: it is the 3rd trial of the block...
        
        
        % Sequence presentation 8 * 900 ms
    
        Screen('TextSize', wPtr , stim_font_size);
    
        for j = 1:8
       
            DrawFormattedText(wPtr,stim_seq{j},'center','center',black,[],1);
            Screen(wPtr, 'Flip');
            if j==1
                respMat(4,1) = GetSecs; % trial onset
            end
            WaitSecs(word_display_time);
        

        end
        
        respMat(5,1)=GetSecs; % end of the trial
    
        % Present image for 800 ms
         
        Screen('DrawTexture', wPtr, textureIndex);
        Screen(wPtr, 'Flip');
        fliptime=GetSecs;
        KbQueueStart();
        Exp.probe_onset(i) = GetSecs;
    
        while GetSecs<imagetime+fliptime
            [pressed, keyCode] = KbQueueCheck();
             secs = keyCode(find(keyCode));
              
             if pressed && (keyCode(escapeKey) || keyCode(KeyEscape) || keyCode(Key.blue) || keyCode(Key.yellow)) % make sure it is not sensitive to TR pulses
                 
                if keyCode(escapeKey)
                    ShowCursor;
                    ListenChar(0);
                    sca;
                    return
            
                elseif keyCode(KeyEscape)
                    ShowCursor;
                    ListenChar(0);
                    sca;
                    return
                
                elseif keyCode(Key.blue)
                    respMat(6,1)=1; % whether a response is made
                    if block_type==1
                       Exp.probe_response(i)=1;
                    elseif block_type==2
                       Exp.probe_response(i)=2;
                    end
                elseif keyCode(Key.yellow)
                    respMat(6,1)=1; % whether a response is made
                    if block_type==1
                       Exp.probe_response(i)=2;
                    elseif block_type==2
                       Exp.probe_response(i)=1;
                    end    
                end
              end
            
        end
        KbQueueStop();
    
        % White screen for 100 ms
    
        Screen('FillRect',wPtr,scrColor);
        Screen(wPtr, 'Flip');
        respMat(7,1)=GetSecs; %onset of white screen at the end of the trial
        WaitSecs(0.100);
        
        if rem(i,3)==0
        blockMat(4,1)=GetSecs; % end of the block after the white screen
        end
        
        if rem(i,3)==0 && i~=36
        curr_iBi=iBi(randi(length(iBi)));
        Screen('TextSize', wPtr , 100);
        DrawFormattedText(wPtr,'+','center','center');
        Screen(wPtr, 'Flip');
        WaitSecs(curr_iBi);
        end
        
        if isempty(iBi)
          iBi= [5 5.5 6 7 7.5 8 9 9.5 10 10.5 11 12 13 13.5 14 15];
        end
       
        if i==36 % Fixation occurs end the end of the block, too
        
            % Fixation
        
            Screen('TextSize', wPtr , 100);
            DrawFormattedText(wPtr,'+','center','center');
            Screen(wPtr, 'Flip');
            WaitSecs(10);
        
            Exp.fix_onsets(fix_counter) = GetSecs;
        
            while GetSecs<14.000+Exp.fix_onsets(fix_counter)
                WaitSecs('YieldSecs', 0.0001);
            end
            
            Exp.fix_ends(fix_counter) = GetSecs;
            
            fix_counter=fix_counter+1;

        end  
        Exp.PerformanceMat = [Exp.PerformanceMat respMat]; % save the behavioral data of block to the matrix
    end
    
    block_counter=block_counter+1;
    blockMat(5,1)=blockMat(4,1)-blockMat(3,1); % block duration
    Exp.BlockDesignMat = [Exp.BlockDesignMat blockMat];
    save([DATA_DIR filesep file_to_save], 'Exp');
end

save([DATA_DIR filesep file_to_save], 'Exp');

Exp.runtime = GetSecs - Exp.experimentstarttime;

% End of experiment screen 
Screen('TextSize', wPtr, 30);
DrawFormattedText(wPtr, 'calisma tamamlandi! Cikmak icin herhangi bir tusa basin',...
    'center', 'center', black, [], 1);
Screen('Flip', wPtr);
KbStrokeWait;

sca;

ListenChar(0); %start taking keyboard input for default programs
KbQueueRelease(); %delete the collected responses from the que

Priority(0); % set priority to default
ShowCursor; % show cursor






Screen('CloseAll');
ShowCursor

% Save all data to current folder.
save([DATA_DIR filesep file_to_save], 'Exp');


% At the end of your code, it is a good idea to restore the old level.
Screen('Preference','SuppressAllWarnings',oldEnableFlag);

