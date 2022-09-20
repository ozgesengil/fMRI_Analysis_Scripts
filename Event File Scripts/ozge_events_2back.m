% This event-file code is modelit


clear all
subs = dir(fullfile(pwd,'*sess*.mat'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));
%ntot = length(subs);

trialnum=6;

ev = nan(500,4);
a = 1;

for ntot = 1:length(subs)
    clear Exp
    load(subs{ntot});
    aa = Exp.PerformanceMat';
    for i = 1:max(aa(:,2)) % one ep at a time
        ep = aa(aa(:,2)==i,:);
        ep_id = size(ep,1); % adding the interepisode intervals
        b = 1;
        for ii = 1:ep_id
            ev(a,1) = ntot;
            
            if i>1 && ii==1
                ev(c,4) = ep(ii,10)-dd;
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
                ev(a+1,3) = ep(1,10) - Exp.expstarttime; % onset
                ev(a+1,4) = ep(1,5)- ep(1,10); % duration
                
                
                
                a=a+2;
                
                
                if i ~= max(aa(:,2))
                    ev(a,1) = ntot; % inter-episode interval 2 - at the end of the episode, until press a button
                    ev(a,2) = 11;
                    ev(a,3) = ep(ii,5)+ep(ii,6)-Exp.expstarttime;
                    c=a;
                    a=a+1;
                end
                
                
                
                dd = ep(ii,5)+ep(ii,6); % onset of the inter-episode interval after the response for the 9th trial is made
                
            else % trial onset
                if ep(ii,4)==1
                    ev(a,2) = ii;
                else
                    ev(a,2) = 6+b;
                    b=b+1;
                end
                
                ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                ev(a,4) = 0;
                a = a+1;
            end
            
        end
    end
    
    
    
    % The rest at the beginning of the experiment
    
    if aa(1,1)==100 % if there is a rest data
        ev(a,1) = ntot;
        ev(a,2) = 12;
        ev(a,3) = aa(1,5)-Exp.expstarttime; % beginning rest onset
        ev(a,4) = aa(1,6)-aa(1,5); % duration
        a=a+1;
    end
    
    % The rest at the end of the experiment
    if aa(size(aa,1),1)==100 % if there is a rest data
        ev(a,1) = ntot;
        ev(a,2) = 12;
        ev(a,3) = aa(size(aa,1),5)-Exp.expstarttime; % ending rest onset
        ev(a,4) = aa(size(aa,1),6)-aa(size(aa,1),5); % duration
        a=a+1;
    end
end


%save('sub22.mat', 'ev');

% put all of it in a FOR loop for multiple participants