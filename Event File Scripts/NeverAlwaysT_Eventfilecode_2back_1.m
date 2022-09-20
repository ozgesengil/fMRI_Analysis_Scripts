% Event File Code for Never-Always Targets-Related analysis, 2-back
% modified 11/01/2022 as the last version

% for subs 6-22 (inc)

% Events:
% Never-Target Non-Targets: 1,2 (in accordance with their position)
% Always-Target Non-Targets: 3,4,5,6 (in acc. with their position) (they
% occur in position 1 2 3 and 4)
% Usual Non-Targets: 7,8,9,10,11,12 (in acc. with their position) (they
% occur in every position)
% Usual Targets: 13,14 (in acc. with their occurence) (they never occur as
% the third target)
% Always-Target Special Targets: 15,16,17 (in acc. with their occurence)


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
        ep_id = size(ep,1);
        b=0;     
        d=0;
        for ii = 1:ep_id
            ev(a,1) = ntot;
            
            
            nt=0; %finding the number of targets in an episode
            for tt = 1:(ep_id-2)
                if ep(tt+2,9)==ep(tt,9)
                    nt=nt+1;
                end
            end


            if nt<=1 % if there is <=1 targets in the episode
                
                  if ii>2 && ep(ii,9)==ep(ii-2,9) % if the trial is a TARGET trial
                      ev(a,2) = 13; % Usual Target-1
                      ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                      ev(a,4) = 0; % duration of the picture event
                      a=a+1;
                      
                      
                  elseif ii<3 || (ii>2 && ep(ii,9)~=ep(ii-2,9)) % if the trial is a NON_TARGET trial

                      if (ep(ii,9)==28 || ep(ii,9)==29) && ii==1 % 'never target' in the position 1
                              ev(a,2)=1; % 'NEVER TARGET - NON-TARGET 1'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==28 || ep(ii,9)==29) && ii==2 % 'never target' in position 2
                              ev(a,2)=2; % 'NEVER TARGET - NON-TARGET 2'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==1 % 'always target' in position 1
                              ev(a,2)=3; % 'ALWAYS TARGET - NON-TARGET 1'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;        
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==2 % 'always target' in position 2
                              ev(a,2)=4; % 'ALWAYS TARGET - NON-TARGET 2'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==3 % 'always target' in position 3
                              ev(a,2)=5; % 'ALWAYS TARGET - NON-TARGET 3'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==4 % 'always target' in position 4
                              ev(a,2)=6; % 'ALWAYS TARGET - NON-TARGET 4'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      else % 'remaining non-targets' will be modeled by their position
                              ev(a,2)=ii+6; % 'USUAL TARGET - NON-TARGETS', (7,8,9,10,11,12)
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                          
                          
                      end
                          
     
                  end
                
                
            elseif nt>1 % if there is more than 1 target in the episode
               
                if ii>2 && ep(ii,9)==ep(ii-2,9) % if the trial is a TARGET trial
                      
                      if ep(ii,9)==26 || ep(ii,9)==27 % 'if it is an always target picture'
                          ev(a,2) = 15+b; % 'ALWAYS TARGET - SPECIAL TARGET 1,2 or 3' (15,16,17)
                          ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                          ev(a,4) = 0; % duration of the picture event
                          b=b+1;
                          a=a+1;
                          
                      else % if it is a usual target picture
                          ev(a,2) = 13+b; % USUAL TARGET (T1,T2), (13,14)
                          ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                          ev(a,4) = 0; % duration of the picture event
                          b=b+1;
                          a=a+1;
                      end
                      
                      
                elseif ii<3 || (ii>2 && ep(ii,9)~=ep(ii-2,9)) % if the trial is a NON_TARGET trial
                      
                      if      (ep(ii,9)==26 || ep(ii,9)==27) && ii==1 % 'always target' in position 1
                              ev(a,2)=3; % 'ALWAYS TARGET - NON-TARGET 1'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;        
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==2 % 'always target' in position 2
                              ev(a,2)=4; % 'ALWAYS TARGET - NON-TARGET 2'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==3 % 'always target' in position 3
                              ev(a,2)=5; % 'ALWAYS TARGET - NON-TARGET 3'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==4 % 'always target' in position 4
                              ev(a,2)=6; % 'ALWAYS TARGET - NON-TARGET 4'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      else % 'remaining non-targets' will be modeled by their position
                              ev(a,2)=ii+6; % 'USUAL TARGET - NON-TARGETS', (7,8,9,10,11,12)
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                
                      end
                
                end
            end
            
            
            
        end
    end
end

save('sub22.mat', 'ev');
