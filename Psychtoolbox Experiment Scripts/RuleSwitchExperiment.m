
%----------------------------------------------------------------------
%                       RULE-SWITCH EXPERIMENT
%----------------------------------------------------------------------

% Experiment's description:
    % Relevant stimuli is numbers (the letters are irrelevant for this
    % specific task, in further modification, they can be removed if
    % wanted.)

    % Rules are determined by the frame color of the trial:
    % When the frame color is green categorize the number as even or odd
    % When the frame color is blue categorize the number as less/more than
    % 10

    % The responses regarding the numbers are collected with left hand keyboard presses.

    % In this block, there are repeat trials and switch trials. 

    % The following is how I coded the rules and accurate key presses:
         % Green Frame:
              % If even: Left arrow key
              % If odd: Right arrow key
         % Blue Frame:
              % If less than 10: Left arrow key
              % If more than 10: Right arrow key


% Here are the responding rows of performance matrices (in total it has 8):
    % 1. Block number
    % 2. Background color (NaN)
    % 3. Color conditions (1 for Green Frame, 2 for Blue Frame)
    % 4. Number showed in the trial
    % 5. Letter showed in the trial (its place in the table)
    % 6. Location toss (1: Number is on the left, letter is on the right,
    % 2: Number is on the right, letter is on the left)
    % 7. Accuracy of the response (0:error, 1:correct)
    % 8. Reaction Time (secs)

             %%%%% These should be collected in this program as well (ADD
             %%%%% THESE!!)
                     % The timing of each trial onset
                     % The timing of the response
                     % 'Press any key to continue' screen onset timing
                     % 'Press any key to continue' screen response time or
                     % RT to this screen
                     % Whether the trial is rule switch or repeat
                     % trial (optional, can be found from condition information, as well)



             

             %%%%% THE THINGS TO CHECK AND CHANGE:

                  % Letters are irrelavent for sole purposes of this
                  % experiment. If wanted so, they can be removed. If done
                  % so, the left right positioning should also be changed,
                  % and the number stimulus should be centered.

                  % adjust the episode and trial numbers.

                  % Check the frequency/randomization of rule switch and
                  % repeat trials, and modify to your liking.




%%
% Clear the workspace
close all;
clearvars;
% Setup PTB with some default values
PsychDefaultSetup(2);
Screen('CloseAll');
PsychDebugWindowConfiguration(0,0.6)
%Screen('Preference', 'SkipSyncTests', 1); %skip synchronization test, for
%just debugging purposes

filename='sub_xx'; % .mat file with behavioral data that will be saved
% prevent overwriting on the same file 
FileName = fullfile(pwd, [filename, '.mat']);
if exist(FileName, 'file')
    % Get number of files:
    newNum   =  1;
    FileName = fullfile(pwd, [filename, sprintf('%d', newNum), '.mat']);
end

%% Setting Some Screen Parameters
% Seed the random number generator
rand('seed', sum(100 * clock));

screenNumber = min(Screen('Screens')); % for default monitor
%screenNumber = max(Screen('Screens')); % for fMRI monitor

% Define black, white and grey
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open the screen and create offscreenwindow for a different background
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white, [], 32, 2);
background1=Screen('OpenOffscreenWindow', window, black); 

% Flip to clear
Screen('Flip', window);

% Query the frame duration
FlipInterval=Screen('GetFlipInterval', window);
slack=FlipInterval/2;
when=0;

% Set the text size
Screen('TextSize', window, 100);

% Query the maximum priority level
Priority(MaxPriority(window));

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set the blend function for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
Screen('TextSize', window, 40);

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
% Key.blue = KbName('1!');
% Key.yellow = KbName('2@');
% Key.green = KbName ('3#');
% Key.red = KbName('4$');


%% Defining Some Display Parameters

theColor = [0 0 0]; % color of stimuli (letter or number)
lineWidth = 20; %linewidth of stimuli (letter or number)

% Make the matrices which will determine our color (condition) combinations
rectColor(1,:) = [0 1 0];
rectColor(2,:) = [0 0 1];

% X and Y coordinates of the points defining out rectangle/frame, centred on the
% centre of the screen
rectpos=[xCenter/2, yCenter/2, 3*xCenter/2, 3*yCenter/2];

color=black; % color of the fixation dots
 

%% Defining Stimuli Matrices

%define original number and letters
numbers=[1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19];

cons_lower={'b','c','d','f','g','j','k','l','m','n','p','r','s','t','v','y','z','x',...
    'w','q','h'};
cons_upper={'B','C','D','F','G','J','K','L','M','N','P','R','S','T','V','Y','Z','X',...
    'W','Q','H'};

vowel_lower={'a','e','i','o','u'};
vowel_upper={'A','E','I','O','U'};

%choose 5 consonants (same letter, upper and lower cases) to be used for this participant randomly
a=randperm(length(cons_lower),5);
consonant_lower=cons_lower(a);
consonant_upper=cons_upper(a);

consonants=[consonant_lower, consonant_upper];
vowels=[vowel_lower, vowel_upper];

lowers= [vowel_lower, consonant_lower];
uppers= [vowel_upper, consonant_upper];

letters=[consonants, vowels];
%% Define Conditions (Rules)

conditions_a=[1 2]; % 1: green frame, 2: blue frame
conditions_b=[1 2 3 4]; % 1: black-green, 2: black-blue, 3:white-green, 4:white-blue

%% Define Performance Matrices

Exp.PerformanceMat_A=[]; % for block A behavioral data 
Exp.PerformanceMat_B=[]; % for block B behavioral data

%% Starting the Experiment With the Trigger

%TRIGGER : '6'

KbQueueCreate(); % create the que in the beginning since it will take some time

HideCursor;

disp('Waiting for scanner trigger ...');

textSize=60;
Screen('TextSize',window,textSize);
%DrawFormattedText(window,'The experiment is about to
%start...','center','center', [0 0 0],[],1); % to make it mirror-image
%in FMRI
DrawFormattedText(window,'The experiment is about to start...','center','center', [0 0 0],[]);
Screen('Flip',window);

Exp.scannerstarttime = GetSecs;

ListenChar(2); %Getting keyboard input for only psychtoolbox from now on

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

%% Experimental Loop

nblocks=2;
for blocks = 1:2
        numtrials=2; % I have collected data with 20 trials per block
        respMatA = nan(8, numtrials); %generate the response matrix that will be saved
        iTi = [1 1.5 2 2.5 3 4 5 7 8 1 1.5 2 2.5 3 4 5 7 8]; %inter-trial interval array
        conditions_A=repmat(conditions_a, 1, numtrials/length(conditions_a));
        for i = 1:numtrials
            
            currenttask_index=randi(length(conditions_A));
            curr_task=conditions_A(currenttask_index);
            curr_color = rectColor(curr_task,:);
            stimuli{1} = numbers(randi(18)); % selecting a number
            stimuli{2} = letters(randi(20)); % selecting a letter
            location_toss = randi(2); %whether the number or letter will be displayed in the right corner
            resp_magnitude=(stimuli{1}>10); %checking whether more or less than 10
            resp_even=rem(stimuli{1},2)==0; %checking whether even or odd
            respMatA(1,i)=blocks;
            respMatA(3,i)=curr_task;
            respMatA(4,i)=stimuli{1};            % saving those variables to performance matrix
            respMatA(5,i)=KbName(stimuli{2});
            respMatA(6,i)=location_toss;
            stimuli1 = num2str(stimuli{1}); %preparing for screen display
            stimuli2 = char(stimuli{2}); %preparing for screen display
            Screen('FrameRect', window, curr_color, rectpos, lineWidth); % frame for the selected condition/color
            Screen('TextSize', window, 40);
           
          
                if location_toss==1 % whether the letter or number will be on the right/left side
                   
                        Screen('TextSize', window, 80);
                        DrawFormattedText(window, stimuli1, xCenter-100, 'center', theColor);
                        Screen('TextSize', window, 80);
                        DrawFormattedText(window, stimuli2, xCenter+100, 'center', theColor);
                else
                        Screen('TextSize', window, 80);
                        DrawFormattedText(window, stimuli2, xCenter-100, 'center', theColor);
                        Screen('TextSize', window, 80);
                        DrawFormattedText(window, stimuli1, xCenter+100, 'center', theColor);
                end
                
            Screen('Flip', window, when);
            tStart = GetSecs;
            KbQueueStart();
            press=0;
            
            while press==0
              [pressed, keyCode] = KbQueueCheck();
              secs = keyCode(find(keyCode));
              
             if pressed 
                 
              if curr_task==1 %task: categorize the number as even or odd
            
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
                
                elseif keyCode(leftKey) && resp_even == 1 % even and left 
                    respMatA(7, i) = 1;
                    respMatA(8, i) = secs(1) - tStart;
                    press=1;
                    
                elseif keyCode(rightKey) && resp_even == 0 % odd and right
                    respMatA(7, i) = 1;
                    respMatA(8, i) = secs(1) - tStart;
                    press=1;
                    
                else
                    respMatA(7, i) = 0;
                    respMatA(8, i) = secs(1) - tStart;
                    press=1;
                   
                end
            
             else %if curr_task==2 (categorize the number as more or less than 10)  
                 
                if   keyCode(escapeKey)
                     ShowCursor;
                     ListenChar(0);
                     sca;
                     return
            
                elseif keyCode(KeyEscape)
                    ShowCursor;
                    ListenChar(0);
                    sca;
                    return
                
                elseif keyCode(leftKey) && resp_magnitude == 0 % less than 10 and left 
                    respMatA(7, i) = 1;
                    respMatA(8, i) = secs(1) - tStart;
                    press=1;
                    
                elseif keyCode(rightKey) && resp_magnitude == 1 %  more than 10 and right
                    respMatA(7, i) = 1;
                    respMatA(8, i) = secs(1) - tStart;
                    press=1;
                    
                else 
                    respMatA(7, i) = 0;
                    respMatA(8, i) = secs(1) - tStart;
                    press=1;
                    
                end
              end
             end
            end
            KbQueueStop();
            
       
                    % Fixation point in between trials
                    Screen('DrawDots', window, [xCenter; yCenter], 15, color, [], 2);
                    % Flip to the screen
                    [VBLTimestamp] = Screen('Flip', window, when);
            
                    toss = randi(length(iTi));
                    currITI = iTi(toss);
                    iTi(toss)=[];
                    
                    if isempty(iTi)
                    iTi = [1 1.5 2 2.5 3 4 5 7 8 1 1.5 2 2.5 3 4 5 7 8];
                    end
                    
                    if i<numtrials
                    Screen('Flip', window, VBLTimestamp-slack+currITI);
                    end
        
           conditions_A(currenttask_index)=[];
            
        end
        
        Exp.PerformanceMat_A = [Exp.PerformanceMat_A respMatA]; % save the behavioral data of block to the matrix
        save(FileName,'Exp');
        
         if blocks<nblocks
         Screen('TextSize', window, 30);
         DrawFormattedText(window, 'Press Any Key To Continue',...
            'center', 'center', black);
         Screen('Flip', window);
         KbStrokeWait;
         end

end


% End of experiment screen 
DrawFormattedText(window, 'Experiment Is Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

sca;

ListenChar(0); %start taking keyboard input for default programs
KbQueueRelease(); %delete the collected responses from the que

Priority(0); % set priority to default
ShowCursor; % show cursor

