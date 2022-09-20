% Event File Code, Number 7

% Events: episodes consisting of trials:1
%         interepisode intervals: 2 (from the end of the response (then
%         comes press a button to cont screen, and then the response to
%         that screen) till the onset of the first picture
%         rests: 3


clear all
subs = dir(fullfile(pwd,'*sess*.mat'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));

trialnum=6;

ev = nan(400,4);
a = 1;

for ntot = 1:length(subs)
    clear Exp
    load(subs{ntot});
    aa = Exp.PerformanceMat';
    for i = 1:max(aa(:,2)) % one ep at a time
        ep = aa(aa(:,2)==i,:);
        ep_id = size(ep,1);
        b = 1;
        for ii = 1:ep_id
            ev(a,1) = ntot;
            
            
            
            if i>1 && ii==1 %if it is the first trial and not the first episode
                ev(c,4) = ep(ii,5)-dd;  % for the duration of IEI, 
                                        % the time between
                                        % the response and the next first
                                        % trial's picture onset
                                        % is calculated this way
            end
            
            
            
            
               
            if mod(ii,trialnum) == 1 % if it is the first trial of the episode
                ev(a,2) = 1;
                ev(a,3) = ep(ii, 5)-Exp.expstarttime; % the onset of the trial picture 1
                ee = ep(ii, 5); % the onset of the trial picture to be used in duration calculation
            
             
            elseif mod(ii,trialnum)==0  % if it is the last trial of the episode
                ev(a,4) = ep(ii,5)+ep(ii,6)-ee; % Reaction moment-the onset of the first picture of the episode
                
                    % for inter-episode interval event
                    if i ~= max(aa(:,2))
                    ev(a+1,1) = ntot;
                    ev(a+1,2) = 2; % inter-episode interval event number
                    ev(a+1,3) = ep(ii,5)+ep(ii,6)- Exp.expstarttime; % onset of the response
               
                    dd = ep(ii,5)+ep(ii,6); % time of the response
                    c=a+1;
                    a=a+2;
                    end
             
            end
            
        end
    end
    
    
    
    % The rest at the beginning of the experiment
    
    if aa(1,1)==100 % if there is rest data
        ev(a,1) = ntot;
        ev(a,2) = 3;
        ev(a,3) = aa(1,5)-Exp.expstarttime; % beginning rest onset
        ev(a,4) = aa(1,6)-aa(1,5); % duration
        a=a+1;
    end
    
    % The rest at the end of the experiment
    if aa(size(aa,1),1)==100 % if there is rest data
        ev(a,1) = ntot;
        ev(a,2) = 3;
        ev(a,3) = aa(size(aa,1),5)-Exp.expstarttime; % ending rest onset
        ev(a,4) = aa(size(aa,1),6)-aa(size(aa,1),5); % duration
        a=a+1;
    end
end


%save('sub23.mat', 'ev');

% put all of it in a FOR loop for multiple participants