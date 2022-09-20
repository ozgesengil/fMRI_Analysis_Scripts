% Evet File Code, Number 4

% Events: nontarget trials: 1,2,3,4,5,6 (just onsets)
%         target trials: 7,8,9 (just onsets)
%         interepisodeintervals: 10,11 (durations)
%         rests: 12 (durations)
%         the waiting time at the 'press a button to continue' screen will
%         be added to the fifth column to IEI-1 and as a parametric regressor to the
%         SPM



clear all
subs = dir(fullfile(pwd,'*sess*.mat'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));
%ntot = length(subs);

trialnum=6;

ev = nan(500,5);
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
            
            if i>1 && ii==1
                ev(c,4) = ep(ii,10)-dd; % for the duration of interepisode interval 2, 
                                        % the time between
                                        % the response and the next 'press...
                                        % a button to cont.' screen onset
                                        % is calculated this way
                                        
                ev(c,5) = gg; % waiting time %%%%%%%%%%%%%%%%%%%%%%                        
            end
            
            
            if mod(ii,trialnum)==0  % inter-episode interval after the episode started (calculated from the first trial of each episode)
                % (if between 1 and 2, it is under episode 2)
                
                
                
                
                if ep(ii,4)==1
                    ev(a,2) = ii;
                else
                    ev(a,2) = 6+b;
                    b=b+1;
                end
                
                ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                ev(a,4) = 0;
                
                
               
                ev(a+1,1) = ntot;
                ev(a+1,2) = 10; % inter-episode interval 1 - at the beginning of the episode
                ev(a+1,3) = ep(1,10) - Exp.expstarttime; % onset of 'press a button to continue' screen
                ev(a+1,4) = ep(1,5)- ep(1,10); % duration: from that screen to the onset of the next picture
                
                
     
                
                a=a+2;
                
                
                if i ~= max(aa(:,2))
                    ev(a,1) = ntot; % inter-episode interval 2 - at the end of the episode, until press a button
                    ev(a,2) = 11;
                    ev(a,3) = ep(ii,5)+ep(ii,6)-Exp.expstarttime; % onset: starting at the time of response
                    
                   
                    
                    c=a;
                    a=a+1;
                end
                
                
                
                dd = ep(ii,5)+ep(ii,6); % onset of the inter-episode interval after the response for the 6th trial is made
                
            elseif mod(ii,trialnum)==1 %%%%%%%%%%%%%%%%%%%%%%
                
                if ep(ii,4)==1 % if the trial is a non-target one
                    ev(a,2) = ii; % then the trial number is the event number
                else % if the trial is a target trial (coded as 2 in the respmat)
                    ev(a,2) = 6+b; % the event number is 7,8,or 9 in respect to the sequence
                    b=b+1;
                end
                
                ev(a,3) = ep(ii, 5)-Exp.expstarttime; % picture onset for the trial
                ev(a,4) = 0; % duration of the picture event
                a=a+1;
                
                gg = ep(ii,11); % the waiting time at the 'press a button to cont.' screen
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            else % trial event (2 to 9)
                if ep(ii,4)==1 % if the trial is a non-target one
                    ev(a,2) = ii; % then the trial number is the event number
                else % if the trial is a target trial (coded as 2 in the respmat)
                    ev(a,2) = 6+b; % the event number is 7,8,or 9 in respect to the sequence
                    b=b+1;
                end
                
                ev(a,3) = ep(ii, 5)-Exp.expstarttime; % picture onset for the trial
                ev(a,4) = 0; % duration of the picture event
                a = a+1;
            end
            
        end
    end
    
    
    
    % The rest at the beginning of the experiment
    
    if aa(1,1)==100 % if there is rest data
        ev(a,1) = ntot;
        ev(a,2) = 12;
        ev(a,3) = aa(1,5)-Exp.expstarttime; % beginning rest onset
        ev(a,4) = aa(1,6)-aa(1,5); % duration
        a=a+1;
    end
    
    % The rest at the end of the experiment
    if aa(size(aa,1),1)==100 % if there is rest data
        ev(a,1) = ntot;
        ev(a,2) = 12;
        ev(a,3) = aa(size(aa,1),5)-Exp.expstarttime; % ending rest onset
        ev(a,4) = aa(size(aa,1),6)-aa(size(aa,1),5); % duration
        a=a+1;
    end
end


save('sub22.mat', 'ev');

% put all of it in a FOR loop for multiple participants