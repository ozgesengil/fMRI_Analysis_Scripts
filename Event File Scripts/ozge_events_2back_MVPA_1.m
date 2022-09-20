% Event File Code, MVPA 1

% Events: 
%         2nd and 3rd target trials are modeled as onset
%         ATpic1_firsthalf=1
%         ATpic1_secondhalf=2
%         ATpic2_firsthalf=3
%         ATpic2_secondhalf=4


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
            
            if ii>2 % after the first two trials for 2-back
                if ep(ii,9)==ep(ii-2,9) % if it is a target trial
                    tcount=tcount+1;
                  
                    
                    if tcount>1 % if it is the 2nd or 3rd target
                        if ep(ii,9)==str2double(AT1{1}) % if it is ATpic1
                            ev(a,1) = ntot;
                            ev(a,2)=1; % all is modeled as event number 1 at first
                            ev(a,3)=ep(ii,5)-Exp.expstarttime; % the onset of the trial picture
                            ev(a,4)=0; % the duration of the event
                            a=a+1;
                            b=b+1;
                            
                        elseif ep(ii,9)==str2double(AT2{1}) % if it is ATpic2
                            ev(a,1) = ntot;
                            ev(a,2)=3; % all is modeled as event number 3 at first
                            ev(a,3)=ep(ii,5)-Exp.expstarttime; % the onset of the trial picture
                            ev(a,4)=0; % the duration of the event
                            a=a+1;
                            b=b+1;
                        end
                    end
                end       
            end
        end
    end
    
    counterend=counterstart+b-1;
    
    % Now, pseudorandomly make the half of the modeled events a
           % different event, make sure to not take all the same events
           % from the beginning or the end of a session.
           
           indx_AT1=find(ev(counterstart:counterend,2)==1);
           indx_AT2=find(ev(counterstart:counterend,2)==3);
           
           num1=length(indx_AT1);
           num2=length(indx_AT2);
           
           if rem(num1,2)==0 % if the events are an even number
               currnums=randsample(indx_AT1,num1/2); % choose half of the events randomly
               ev(currnums+counterstart-1,2)=2; % make the choosen half event number 2
           else  % if they are in an odd number
               toss=randi(2); % choose which half will have higher number of events
               if toss==1
                   currnums=randsample(indx_AT1,(num1-1)/2);
                   ev(currnums+counterstart-1,2)=2; % make the choosen half event number 2
               elseif toss==2
                   currnums=randsample(indx_AT1,(num1+1)/2);
                   ev(currnums+counterstart-1,2)=2; % make the choosen half event number 2
               end
           end
                   
           
           if rem(num2,2)==0 % if the events are an even number
               currnums=randsample(indx_AT2,num2/2); % choose half of the events randomly
               ev(currnums+counterstart-1,2)=4; % make the choosen half event number 2
           else  % if they are in an odd number
               toss=randi(2); % choose which half will have higher number of events
               if toss==1
                   currnums=randsample(indx_AT2,(num2-1)/2);
                   ev(currnums+counterstart-1,2)=4; % make the choosen half event number 2
               elseif toss==2
                   currnums=randsample(indx_AT2,(num2+1)/2);
                   ev(currnums+counterstart-1,2)=4; % make the choosen half event number 2
               end
           end
end
                

% save('sub22.mat', 'ev');

% put all of it in a FOR loop for multiple participants