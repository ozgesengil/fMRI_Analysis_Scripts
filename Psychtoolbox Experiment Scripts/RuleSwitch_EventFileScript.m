
clear all
rand('seed', sum(100 * clock));
subs = dir(fullfile(pwd,'*sess*.mat'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));

trialnum=10;

ev = nan(100,4);
a = 1;
counterend=0;

for ntot = 1:length(subs)
    clear Exp
    load(subs{ntot});
    aa = Exp.PerformanceMat_A';
    
    counterstart=counterend+1;
    b=0;
    
    
    
    for i = 1:max(aa(:,1)) % one ep at a time
        ep = aa(aa(:,1)==i,:);
        ep_id = size(ep,1);
        tcount=0;
 
            if ep(2,2)==1 % if it is a rule repeat trial
                
                            ev(a,1) = ntot;
                            ev(a,2)=1; 
                            ev(a,3)=ep(1,8)-Exp.experimentstarttime; % the onset of the trial picture
                            ev(a,4)=ep(10,9)-ep(1,8); % the duration of the event
                            a=a+1;
            elseif ep(2,2)==2 % if it is a rule switch trial
                
                            ev(a,1) = ntot;
                            ev(a,2)=2; 
                            ev(a,3)=ep(1,8)-Exp.experimentstarttime; % the onset of the trial picture
                            ev(a,4)=ep(10,9)-ep(1,8); % the duration of the event
                            a=a+1;
            end
               
            ev(a,1)=ntot;
            ev(a,2)=3;
            ev(a,3)=ep(10,9)-Exp.experimentstarttime;
            ev(a,4)=ep(10,13)-ep(10,9);
            a=a+1;
        
    end
    
    
end
                
save('sub04.mat', 'ev');


% put all of it in a FOR loop for multiple participants