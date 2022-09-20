% Event File Code for Never-Always Targets-Related analysis, 3-back

% will be used for subs 2,3,4
% the other 3-back subs will require another event file!!!!

% Events:
% Never-Target Non-Targets: 1,2 (in accordance with their position)
% Always-Target Non-Targets: 3,4,5,6,7,8,9,10,11 (in acc. with their position)
% Usual Non-Targets: 12,13,14,15,16,17,18,19,20 (in acc. with their position)
% Usual Targets: 21,22,23 (in acc. with their occurence)
% Always-Target Special Targets: 24,25,26 (in acc. with their occurence)


clear all
subs = dir(fullfile(pwd,'*sess*.mat'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));
%ntot = length(subs);

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
        b=0;     
        d=0;
        for ii = 1:ep_id
            ev(a,1) = ntot;
            
            if sum(ep(:,4))<=10 % if there is <=1 targets in the episode
                
                  if ii>3 && ep(ii,9)==ep(ii-3,9) % if the trial is a TARGET trial
                      ev(a,2) = 21; % Usual Target-1
                      ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                      ev(a,4) = 0; % duration of the picture event
                      a=a+1;
                      
                      
                  elseif ii<=3 || (ii>3 && ep(ii,9)~=ep(ii-3,9)) % if the trial is a NON_TARGET trial

                      if (ep(ii,9)==17 || ep(ii,9)==18) && ii==1 % 'never target' in the position 1
                              ev(a,2)=1; % 'NEVER TARGET - NON-TARGET 1'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==17 || ep(ii,9)==18) && ii==2 % 'never target' in position 2
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
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==5 % 'always target' in position 5
                              ev(a,2)=7; % 'ALWAYS TARGET - NON-TARGET 5'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==6 % 'always target' in position 6
                              ev(a,2)=8; % 'ALWAYS TARGET - NON-TARGET 6'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==7 % 'always target' in position 7
                              ev(a,2)=9; % 'ALWAYS TARGET - NON-TARGET 7'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==8 % 'always target' in position 8
                              ev(a,2)=10; % 'ALWAYS TARGET - NON-TARGET 8'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==9 % 'always target' in position 9
                              ev(a,2)=11; % 'ALWAYS TARGET - NON-TARGET 9'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      else % 'remaining non-targets' will be modeled by their position
                              ev(a,2)=ii+11; % 'SOMETIMES TARGET - NON-TARGETS', (12,13,14,15,16,17,18,19,20)
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                          
                          
                      end
                          
     
                  end
                
                
            elseif sum(ep(:,4))>10 % if there is more than 1 target in the episode
               
                if ii>3 && ep(ii,9)==ep(ii-3,9) % if the trial is a TARGET trial
                      
                      if ep(ii,9)==26 || ep(ii,9)==27 % 'if it is an always target picture'
                          ev(a,2) = 24+b; % 'ALWAYS TARGET - SPECIAL TARGET 1,2 or 3' (24,25,26)
                          ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                          ev(a,4) = 0; % duration of the picture event
                          b=b+1;
                          a=a+1;
                          
                      else % if it is a usual target picture
                          ev(a,2) = 21+b; % USUAL TARGET (T1,T2,T3), (21,22,23)
                          ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                          ev(a,4) = 0; % duration of the picture event
                          b=b+1;
                          a=a+1;
                      end
                      
                      
                elseif ii<3 || (ii>3 && ep(ii,9)~=ep(ii-3,9)) % if the trial is a NON_TARGET trial
                      
                      if      (ep(ii,9)==17 || ep(ii,9)==18) && ii==1 % 'always target' in position 1
                              ev(a,2)=3; % 'ALWAYS TARGET - NON-TARGET 1'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;        
                      elseif (ep(ii,9)==17 || ep(ii,9)==18) && ii==2 % 'always target' in position 2
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
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==5 % 'always target' in position 5
                              ev(a,2)=7; % 'ALWAYS TARGET - NON-TARGET 5'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==6 % 'always target' in position 6
                              ev(a,2)=8; % 'ALWAYS TARGET - NON-TARGET 6'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==7 % 'always target' in position 7
                              ev(a,2)=9; % 'ALWAYS TARGET - NON-TARGET 7'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==8 % 'always target' in position 8
                              ev(a,2)=10; % 'ALWAYS TARGET - NON-TARGET 8'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                      elseif (ep(ii,9)==26 || ep(ii,9)==27) && ii==9 % 'always target' in position 9
                              ev(a,2)=11; % 'ALWAYS TARGET - NON-TARGET 9'
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                      else % 'remaining non-targets' will be modeled by their position
                              ev(a,2)=ii+11; % 'SOMETIMES TARGET - NON-TARGETS', (12,13,14,15,16,17,18,19,20)
                              ev(a,3) = ep(ii, 5)-Exp.expstarttime;
                              ev(a,4) = 0; % duration of the picture event
                              a=a+1;
                
                      end
                
                end
            end
            
            
            
        end
    end
end

%save('sub04.mat', 'ev');
