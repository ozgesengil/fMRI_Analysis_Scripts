
% Clear the workspace
close all;
clear;
% Setup PTB with some default values
PsychDefaultSetup(2);
Screen('CloseAll');

filename = 'sub00_restingstate';

FileName = fullfile(pwd, [filename, '.mat']); 
if exist(FileName, 'file')
    % Get number of files:1
    
    newNum   =  1;
    filename = fullfile(pwd, [filename, sprintf('%d', newNum), '.mat']);
end



%%


% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
rand('seed', sum(100 * clock));
% rng('shuffle');
% Set the svcreen number to the external secondary monitor if there is one
% connected
screenNumber = max(Screen('Screens'));

% Define black, white and grey
white = WhiteIndex(screenNumber);
grey = white / 2;
black = BlackIndex(screenNumber);
PsychDebugWindowConfiguration(0, 0.6);

% Open the screen
% [window, windowRect] = PsychImaging('OpenWindow', 1, grey, [], 32, 1);
% [window, windowRect] = Screen('OpenWindow', screenNumber, grey, [], 32, 2);
% [window,windowRect]=Screen('OpenWindow', screenNumber, white,[10 20 1200 700]);
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey, [0 10 1900 1000], 32, 2);

% Flip to clear
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set the text size
Screen('TextSize', window, 100);

% Query the maximum priority level
topPriorityLevel = MaxPriority(window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
% Screen('TextSize', window, 60);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);


%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------
%%
% Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
leftKey = KbName('LeftArrow');
rightKey = KbName('DownArrow');
downKey = KbName('DownArrow');
Key.blue = KbName('1!');
Key.yellow = KbName('2@');
Key.green = KbName ('3#');
Key.red = KbName('4$');
Key.trigger = KbName ('6^');
Key.Escape = KbName('escape');

Key.Z = KbName ('Z');
Key.X = KbName('X');
Key.C = KbName ('C');
Key.V = KbName('V');

%%
red = [1 0 0];
green = [0 1 0];
allcolor = [1 1 1 0.2]';

%%


% Get time

Exp.scanstarttime = GetSecs;


KbQueueCreate();

%Trigger
disp('Waiting for trigger ...');

textSize=60;
Screen('TextSize',window,textSize);
DrawFormattedText(window,'Please relax the scanner is about to start','center','center', [0 0 0], [],1);
Screen('Flip',window);

KbQueueStart();
curTR=0;
while curTR==0
    [pressed, Keycode] = KbQueueCheck();
    timeSecs = Keycode(find(Keycode));
    if pressed && Keycode(Key.trigger)
        CurrTR=1;
        break;
    end
end
KbQueueStop();


RestrictKeysForKbCheck([]);

Exp.expstarttime = GetSecs;

Exp.Rest_onset(1,1)=GetSecs;

DrawFormattedText(window, 'dinlenin', 'center', 'center',[0 0 0],[], 1);
Screen('Flip', window);
WaitSecs(5);

Exp.Rest_end(1,1)=GetSecs;



save(filename,'Exp');
DrawFormattedText(window, 'Session Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;
sca;

ShowCursor;







