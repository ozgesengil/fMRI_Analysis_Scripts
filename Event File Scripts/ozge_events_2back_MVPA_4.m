% Event File Code, MVPA 4
% there is no 3-back version because 3-back participants doesnot have the
% required events

% Events: 
%         1st and 2nd trials are modeled as onset (NEVER AND ALWAYS target pictures
%         when they appear as a non-target in trials 1 and 2) (4 PICTURES
%         to compare in terms of picture identity related activity, each has 2 chunks)

%         NTpic1_firstchunk=1
%         NTpic1_secondchunk=2
%         NTpic2_firstchunk=3
%         NTpic2_secondchunk=4
%         ATpic1_firstchunk=5
%         ATpic1_secondchunk=6
%         ATpic2_firstchunk=7
%         ATpic2_secondchunk=8


clear all
rand('seed', sum(100 * clock));
subs = dir(fullfile(pwd,'*sess*.mat'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));

trialnum=6;

ev = nan(100,4);
a = 1;
counterend=0;

for ntot = 1:length(subs)
    clear Exp
    load(subs{ntot});
    aa = Exp.PerformanceMat';
    
    counterstart=counterend+1;
    b=0;
    
                    % find NT1 pic number
                    NT1 = regexp(Exp.neverTs{1},'\d*','Match');
                        for iii= 1:length(NT1)
                          if ~isempty(NT1{iii})
                             Num(iii,1)=str2double(NT1{iii}(end));
                          else
                             Num(iii,1)=NaN;
                          end
                        end
                   
                    % find NT2 pic number    
                    NT2 = regexp(Exp.neverTs{2},'\d*','Match');
                        for iii= 1:length(NT2)
                          if ~isempty(NT2{iii})
                             Num(iii,1)=str2double(NT2{iii}(end));
                          else
                             Num(iii,1)=NaN;
                          end
                        end


                    % find AT1 pic number
                    AT1 = regexp(Exp.alwaysTs{1},'\d*','Match');
                        for iii= 1:length(AT1)
                          if ~isempty(AT1{iii})
                             Num(iii,1)=str2double(AT1{iii}(end));
                          else
                             Num(iii,1)=NaN;
                          end
                        end
                   
                    % find AT2 pic number    
                    AT2 = regexp(Exp.alwaysTs{2},'\d*','Match');
                        for iii= 1:length(AT2)
                          if ~isempty(AT2{iii})
                             Num(iii,1)=str2double(AT2{iii}(end));
                          else
                             Num(iii,1)=NaN;
                          end
                        end
    
    
    for i = 1:max(aa(:,2)) % one ep at a time
        ep = aa(aa(:,2)==i,:);
        ep_id = size(ep,1);
        tcount=0;
        for ii = 1:ep_id
            
            if ii==1 || ii==2 % if it is trial 1 or 2
                
                    
                        if ep(ii,9)==str2double(NT1{1}) % if it is NTpic1
                            ev(a,1) = ntot;
                            ev(a,2)=1; % all is modeled as event number 1 at first
                            ev(a,3)=ep(ii,5)-Exp.expstarttime; % the onset of the trial picture
                            ev(a,4)=0; % the duration of the event
                            a=a+1;
                            b=b+1;
                            
                        elseif ep(ii,9)==str2double(NT2{1}) % if it is NTpic2
                            ev(a,1) = ntot;
                            ev(a,2)=3; % all is modeled as event number 3 at first
                            ev(a,3)=ep(ii,5)-Exp.expstarttime; % the onset of the trial picture
                            ev(a,4)=0; % the duration of the event
                            a=a+1;
                            b=b+1;

                        elseif ep(ii,9)==str2double(AT1{1}) % if it is ATpic1
                            ev(a,1) = ntot;
                            ev(a,2)=5; % all is modeled as event number 5 at first
                            ev(a,3)=ep(ii,5)-Exp.expstarttime; % the onset of the trial picture
                            ev(a,4)=0; % the duration of the event
                            a=a+1;
                            b=b+1;
                            
                        elseif ep(ii,9)==str2double(AT2{1}) % if it is ATpic2
                            ev(a,1) = ntot;
                            ev(a,2)=7; % all is modeled as event number 7 at first
                            ev(a,3)=ep(ii,5)-Exp.expstarttime; % the onset of the trial picture
                            ev(a,4)=0; % the duration of the event
                            a=a+1;
                            b=b+1;
                        end
                    
            end   
        end
    end
    
    
    counterend=counterstart+b-1;
    
    % Now, pseudorandomly make the half of the modeled events a
           % different event (to create two chunks out of 1 pic), 
           % making sure not to take all the events for a chunk
           % from the beginning or the end of a session.
           
           indx_NT1=find(ev(counterstart:counterend,2)==1);
           indx_NT2=find(ev(counterstart:counterend,2)==3);
           indx_AT1=find(ev(counterstart:counterend,2)==5);
           indx_AT2=find(ev(counterstart:counterend,2)==7);
           
           num1=length(indx_NT1);
           num2=length(indx_NT2);
           num3=length(indx_AT1);
           num4=length(indx_AT2);
           
           if rem(num1,2)==0 % if the num of events are an even number
               currnums=randsample(indx_NT1,num1/2); % choose half of the events randomly
               ev(currnums+counterstart-1,2)=2; % make the choosen half event number 2
           else  % if they are in an odd number
               toss=randi(2); % choose which half will have higher number of events
               if toss==1
                   currnums=randsample(indx_NT1,(num1-1)/2);
                   ev(currnums+counterstart-1,2)=2; % make the choosen half event number 2
               elseif toss==2
                   currnums=randsample(indx_NT1,(num1+1)/2);
                   ev(currnums+counterstart-1,2)=2; % make the choosen half event number 2
               end
           end
                   
           
           if rem(num2,2)==0 % if the num of events are an even number
               currnums=randsample(indx_NT2,num2/2); % choose half of the events randomly
               ev(currnums+counterstart-1,2)=4; % make the choosen half event number 4
           else  % if they are in an odd number
               toss=randi(2); % choose which half will have higher number of events
               if toss==1
                   currnums=randsample(indx_NT2,(num2-1)/2);
                   ev(currnums+counterstart-1,2)=4; % make the choosen half event number 4
               elseif toss==2
                   currnums=randsample(indx_NT2,(num2+1)/2);
                   ev(currnums+counterstart-1,2)=4; % make the choosen half event number 4
               end
           end

           if rem(num3,2)==0 % if the num of events are an even number
               currnums=randsample(indx_AT1,num3/2); % choose half of the events randomly
               ev(currnums+counterstart-1,2)=6; % make the choosen half event number 6
           else  % if they are in an odd number
               toss=randi(2); % choose which half will have higher number of events
               if toss==1
                   currnums=randsample(indx_AT1,(num3-1)/2);
                   ev(currnums+counterstart-1,2)=6; % make the choosen half event number 6
               elseif toss==2
                   currnums=randsample(indx_AT1,(num3+1)/2);
                   ev(currnums+counterstart-1,2)=6; % make the choosen half event number 6
               end
           end

           if rem(num4,2)==0 % if the num of events are an even number
               currnums=randsample(indx_AT2,num4/2); % choose half of the events randomly
               ev(currnums+counterstart-1,2)=8; % make the choosen half event number 8
           else  % if they are in an odd number
               toss=randi(2); % choose which half will have higher number of events
               if toss==1
                   currnums=randsample(indx_AT2,(num4-1)/2);
                   ev(currnums+counterstart-1,2)=8; % make the choosen half event number 8
               elseif toss==2
                   currnums=randsample(indx_AT2,(num4+1)/2);
                   ev(currnums+counterstart-1,2)=8; % make the choosen half event number 8
               end
           end
end
                

save('sub22.mat', 'ev');

% put all of it in a FOR loop for multiple participants