% Event File Code, Number 2


% Events: nontarget trials: 1,2,3,4,5,6,8,9
%         target trials: 10,11,12
%         interepisodeintervals: 13
%         rests: 14
%         TRIALs: from one picture onset to the other, and for the last
%         trial from picture onset to the end of the response
%         IEI: from the response to the onset of the first trial; and for
%         the last episode there is no IEI


clear all
subs = dir(fullfile(pwd,'*sess*.mat'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));

trialnum=9;

ev = nan(900,4);
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
                
                if ep(ii,4)==1 % if it is a non-target trial
                    ev(a,2) = ii; % event number is its position number
                else
                    ev(a,2) = 9+b; % if it is a target trial event number is 10,11, or 12
                    b=b+1; % respectively
                end
                
                ev(a,3) = ep(ii, 5)-Exp.expstarttime; % the onset of the trial picture
                                
                f = a;
                ee = ep(ii, 5); % the onset of the trial picture to be used in duration calculation
            
                
                a=a+1;
                    
            elseif mod(ii,trialnum)==0  % if it is the last trial of the episode
                
                if ep(ii,4)==1 % if it is a non-target trial
                    ev(a,2) = ii; % event number is its position number
                else
                    ev(a,2) = 9+b; % if it is a target trial event number is 10,11, or 12
                    b=b+1; % respectively
                end
                
                ev(a,3) = ep(ii, 5)-Exp.expstarttime; % the onset of the trial picture
                ev(a,4) = ep(ii,6); % ??????????? see how it is calculated in the original matrix
            
                ev(f,4) = ep(ii,5)-ee; % duration of the previous trial
            
                
                
                    % for inter-episode interval event
                    if i ~= max(aa(:,2))
                    ev(a+1,1) = ntot;
                    ev(a+1,2) = 13; % inter-episode interval event number
                    ev(a+1,3) = ep(ii,5)+ep(ii,6)- Exp.expstarttime; % onset of the response
               
                    dd = ep(ii,5)+ep(ii,6); % time of the response
                    c=a+1;
                    a=a+2;
                    end
                         
                
            else  % if it is trial 2 3 4 or 5
                
                if ep(ii,4)==1 % if it is a non-target trial
                    ev(a,2) = ii; % event number is its position number
                else
                    ev(a,2) = 9+b; % if it is a target trial event number is 9,10, or 11
                    b=b+1; % respectively
                end
                
                ev(a,3) = ep(ii, 5)-Exp.expstarttime; % the onset of the trial picture
                
                ev(f,4) = ep(ii,5)-ee; % duration of the previous trial
                 
                f = a;
                ee = ep(ii, 5); % the onset of the trial picture to be used in duration calculation
                
                a=a+1;
                
                
                
               
            end
            
        end
    end
    
    
    
    % The rest at the beginning of the experiment
    
    if aa(1,1)==100 % if there is rest data
        ev(a,1) = ntot;
        ev(a,2) = 14;
        ev(a,3) = aa(1,5)-Exp.expstarttime; % beginning rest onset
        ev(a,4) = aa(1,6)-aa(1,5); % duration
        a=a+1;
    end
    
    % The rest at the end of the experiment
    if aa(size(aa,1),1)==100 % if there is rest data
        ev(a,1) = ntot;
        ev(a,2) = 14;
        ev(a,3) = aa(size(aa,1),5)-Exp.expstarttime; % ending rest onset
        ev(a,4) = aa(size(aa,1),6)-aa(size(aa,1),5); % duration
        a=a+1;
    end
end


save('sub05.mat', 'ev');

% put all of it in a FOR loop for multiple participants