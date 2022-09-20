% Event File Code, Number 3 (for Way1)

% the waiting time for 'press a button to cont.' screen for each trial,
% divided into 4 quartiles (20 events for each)
% one should add this code to relevant event code

% Events: first quartile: 1
%         second and third quartile: 2
%         fourth quartile: 3

clear all
subs = dir(fullfile(pwd,'*sess*.mat'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));

trialnum=6;

evv = nan(600,4);
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
            if mod(ii,trialnum)==1 % if it is the first trial
            evv(a,1) = ntot;
            evv(a,3) = ep(ii,10)-Exp.expstarttime;
            evv(a,4) = ep(ii,11);
            a=a+1;
            end
        end
    end
end
         

M = evv(1:80,4); % the nan values are ignored
M=sort(M);
st=M(20);
nd=M(40);
rd=M(60);

for i=1:size(evv)
    if evv(i,4)<=st
        evv(i,2)=1;
    elseif evv(i,4)>=rd
        evv(i,2)=3;
    elseif (st<evv(i,4)) && (evv(i,4)<rd)
        evv(i,2)=2;
    end
end



