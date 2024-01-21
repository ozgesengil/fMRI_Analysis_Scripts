
% it uses roi_results_3back.mat *FROM STATSNAT
% It uses SPM.mat files of the subs from statsNAT to check whether a given
% never target event occured (for some subs, they never occured for some
% sessions so roi matrixes are not matching unless some further arrangement 
% is done, so this code is using individual's SPM.mat to read 
% roi betas in the correct order)

clear all

  color1=[0/255,0/255,0/255];
  color2=[95/255,158/255,160/255];
  color3=[105/255,105/255,105/255];
  color4=[255/255 255/255 153/255];
  color5=[153/255 153/255 255/255];
  color6=[255/255 204/255 159/255];
  color7=[255/255 153/255 51/255];
  color8=[0/255 153/255 153/255];
  color9=[115/255 142/255 141/255];

 load roi_results_3back.mat
 aa = res.beta;

%creating roi names to appear on the figures
roi_names=['ACC             ';'LEFT HAND       ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
    'PCC             ';'RIGHT HAND      ';'A1-L            ';'A1-R            ';'TPJ-R           ';...
    'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
    'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
    'I-R             ';'Hand S1-R       '];

rootdir= 'G:\OZGE_STUDY2\statsNAT';

subs={'sub02','sub03','sub04','sub23','sub24','sub25','sub26','sub27','sub28','sub29','sub30','sub31','sub32','sub33'};
subs = char(subs);
subs = cellstr(deblank(subs));
ntot = length(subs);

rawmatrix=NaN(33,14,2);


                    %%%% Number of ROWS that corresponds to EVENTS for a given ROI Mat (The multidimensional matrix this script creates) PAGES
                            %                     nt_nonT_1=1
                            %                     nt_nonT_2=2
                            %                     nt_nonT_3=3
                            %                     nt_nonT_4=4
                            %                     nt_nonT_5=5
                            %                     nt_nonT_6=6
                            %                     nt_nonT_7=7
                            %                     nt_nonT_8=8
                            %                     nt_nonT_9=9
                            % 
                            %                     at_nonT_1=10
                            %                     at_nonT_2=11
                            %                     at_nonT_3=12
                            %                     at_nonT_4=13
                            %                     at_nonT_5=14
                            %                     at_nonT_6=15
                            %                     at_nonT_7=16
                            %                     at_nonT_8=17
                            %                     at_nonT_9=18
                            % 
                            % 
                            %                     us_nonT_1=19
                            %                     us_nonT_2=20
                            %                     us_nonT_3=21
                            %                     us_nonT_4=22
                            %                     us_nonT_5=23
                            %                     us_nonT_6=24
                            %                     us_nonT_7=25
                            %                     us_nonT_9=26
                            % 
                            % 
                            %                     us_T_1=27
                            %                     us_T_2=28
                            %                     us_T_3=29
                            % 
                            %                     at_T_1=30
                            %                     at_T_2=31
                            %                     at_T_3=32


 for i=1:22 % for a given ROI (the rows of res.beta)
     matrix=[];
  for cc=1:ntot % for a given subject (the columns of res.beta)
      mat = aa{i, cc}; % the roi matrix for a sub for the given roi
     
      csub = subs{cc};
      a = load(fullfile(rootdir, csub, '\SPM.mat')); % load the subjects own SPM.mat from the first level analysis

      subdata=a.SPM.event_present;
      absentevents=find(subdata(:,:)==0);
      subdata(absentevents)=nan;

      roicounter=1; % track the values in the roimat

     for ss=1:size(subdata,1) % for each session of sub's data
           
            if ss>1 % add the movement parameters to the counter starting from the end of the first session
               roicounter=roicounter+6;
            end
        
           for x=1:size(subdata,2) % for each regressor 

               if ~isnan(subdata(ss,x))
                   subdata(ss,x)=mat(roicounter);
                   roicounter=roicounter+1;
               end

           end
           
     end

     matrix=[matrix, (nanmean(subdata))'];

     if size(subdata,1)==2

         firstpart(:,cc,1)=subdata(1,:);
         secondpart(:,cc,1)=subdata(2,:);
         lastpart(:,cc,1)=subdata(2,:);
         thirdpart(:,cc,1)=nan(1,33);
         fourthpart(:,cc,1)=nan(1,33);

     elseif size(subdata,1)==3
         firstpart(:,cc,1)=subdata(1,:);
         secondpart(:,cc,1)=subdata(2,:);
         thirdpart(:,cc,1)=subdata(3,:);
         lastpart(:,cc,1)=subdata(3,:);
         fourthpart(:,cc,1)=nan(1,33);

     elseif size(subdata,1)==4
         firstpart(:,cc,1)=subdata(1,:);
         secondpart(:,cc,1)=subdata(2,:);
         thirdpart(:,cc,1)=subdata(3,:);
         fourthpart(:,cc,1)=subdata(4,:);
         lastpart(:,cc,1)=subdata(4,:);

     end
     
  end
  
  Mat(:,:,i)=matrix; % Pages:rois (N=22), 33 events (rows), 14 participants (columns)
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   % NON_TARGETS in positions 1 and 2 and 3 (nt, at, ut)  %%%%%%%%%%%%%%%%%%
 
   nt_nonT_123= nanmean([Mat(1,:,i)' Mat(2,:,i)' Mat(3,:,i)'],2);
   us_nonT_123= nanmean([Mat(19,:,i)' Mat(20,:,i)' Mat(21,:,i)'],2);
   at_nonT_123= nanmean([Mat(10,:,i)' Mat(11,:,i)' Mat(12,:,i)'],2);
   b=([at_nonT_123 us_nonT_123 nt_nonT_123]);
            figure
            ciwithinnan(b,0.05,color2);
            fontsize = 25;
            title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
            ax=gca;
            ax.YMinorTick = 'off';
            ax.TickLength = [0 0];
            set(gca, 'box','off');
            set(gcf, 'color', 'w')
            %ylabel()
            xlabel('Non-Targets in Initial Positions')
            barnames={'AT','UT','NT'};
            set(gca, 'xticklabels',barnames)
            ax.YColor=color3;
            ax.XColor=color3;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % NON_TARGETS in positions 4,5,6 

nt_nonT_456= nanmean([Mat(4,:,i)' Mat(5,:,i)' Mat(6,:,i)'],2);
at_nonT_456= nanmean([Mat(13,:,i)' Mat(14,:,i)' Mat(15,:,i)'],2);
us_nonT_456= nanmean([Mat(22,:,i)' Mat(23,:,i)' Mat(24,:,i)'],2);
c=([at_nonT_456 us_nonT_456 nt_nonT_456]);
            figure
            ciwithinnan(c,0.05,color4);
            fontsize = 25;
            title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
            ax=gca;
            ax.YMinorTick = 'off';
            ax.TickLength = [0 0];
            set(gca, 'box','off');
            set(gcf, 'color', 'w')
            box off
            %ylabel()
            xlabel('Non-Targets in Middle Positions')
            barnames={'AT','UT','NT'};
            set(gca, 'xticklabels',barnames)
            ax.YColor=color3;
            ax.XColor=color3;
            [h_atandusnonT456(i), p_atandusnonT456(i), ci_atandusnonT456(i,:)]= ttest(at_nonT_456,us_nonT_456);   %run this part firstly
            % res.rois(find(h_atandusnonT456),:)    % this is to find the ROIs which shows
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %  NON_TARGETS when they appear in positions 1 2 3 4 5 6 for at nt ut
% % 

    nt_nonT_all6= nanmean([Mat(1,:,i)' Mat(2,:,i)' Mat(3,:,i)' Mat(4,:,i)' Mat(5,:,i)' Mat(6,:,i)'],2);
    at_nonT_all6= nanmean([Mat(10,:,i)' Mat(11,:,i)' Mat(12,:,i)' Mat(13,:,i)' Mat(14,:,i)' Mat(15,:,i)'],2);
    us_nonT_all6= nanmean([Mat(19,:,i)' Mat(20,:,i)' Mat(21,:,i)' Mat(22,:,i)' Mat(23,:,i)' Mat(24,:,i)'],2);
    c=([at_nonT_all6 us_nonT_all6 nt_nonT_all6]);
                figure
                ciwithinnan(c,0.05,color5);
                fontsize = 25;
                title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);   
                ax=gca;
                ax.YMinorTick = 'off';
                ax.TickLength = [0 0];
                set(gca, 'box','off'); 
                set(gcf, 'color', 'w')
                box off
                %ylabel()
                xlabel('Non-Targets in First 6 Positions')
                barnames={'AT','UT','NT'};
                set(gca, 'xticklabels',barnames)
                ax.YColor=color3;
                ax.XColor=color3;
%                 [h_ATandUSnonTinfirst6(i), p_ATandUSnonTinfirst6(i), ci_ATandUSnonTinfirst6(i,:)]= ttest(at_nonT_all6,us_nonT_all6);   %run this part firstly
%             %     res.rois(find(h_ATandUSnonTinfirst6),:)    % this is to find the ROIs which shows
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % TARGETS at_T_2 vs us_T_2, at_T vs us_T

    at_T_2= nanmean([Mat(31,:,i)'],2);
    us_T_2= nanmean([Mat(28,:,i)'],2);
    c=([at_T_2 us_T_2]);
           figure
           ciwithinnan(c,0.05,color6);
           fontsize = 25;
           title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
            ax=gca;
            ax.YMinorTick = 'off';
            ax.TickLength = [0 0];
            set(gca, 'box','off'); 
            set(gcf, 'color', 'w')
            box off
            %ylabel()
            xlabel('Target 2')
            barnames={'AT','UT'};
            set(gca, 'xticklabels',barnames)
            ax.YColor=color3;
            ax.XColor=color3;
%             [h_T2(i), p_T2(i), ci_T2(i,:)]= ttest(at_T_2,us_T_2);   %run this part firstly
%         %     res.rois(find(h_T2),:)    % this is to find the ROIs which shows
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % TARGETS at_T_1 vs us_T_1, at_T vs us_T
% 
    at_T_1= nanmean([Mat(30,:,i)'],2);
    us_T_1= nanmean([Mat(27,:,i)'],2);
    c=([at_T_1 us_T_1]);
               figure
               ciwithinnan(c,0.05,color7);
               fontsize = 25;
               title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
                ax=gca;
                ax.YMinorTick = 'off';
                ax.TickLength = [0 0];
                set(gca, 'box','off');    
                set(gcf, 'color', 'w')
                box off
                %ylabel()
                xlabel('Target 1')
                barnames={'AT','UT'};
                set(gca, 'xticklabels',barnames)
                ax.YColor=color3;
                ax.XColor=color3;
%                 [h_T1(i), p_T1(i), ci_T1(i,:)]= ttest(at_T_1,us_T_1);   %run this part firstly
%             %     res.rois(find(h_T1),:)    % this is to find the ROIs which shows
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % TARGETS at_T_12 vs us_T_12, at_T vs us_T
% 
    at_T_12= nanmean([Mat(30,:,i)' Mat(31,:,i)'],2);
    us_T_12= nanmean([Mat(27,:,i)' Mat(28,:,i)'],2);
    c=([at_T_12 us_T_12]);
            figure
            ciwithinnan(c,0.05,color8);
            fontsize = 25;
            title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
            ax=gca;
            ax.YMinorTick = 'off';
            ax.TickLength = [0 0];
            set(gca, 'box','off');
            set(gcf, 'color', 'w')
            box off
            %ylabel()
            xlabel('Targets 1 and 2')
            barnames={'AT','UT'};
            set(gca, 'xticklabels',barnames)
            ax.YColor=color3;
            ax.XColor=color3;
%             [h_T12(i), p_T12(i), ci_T12(i,:)]= ttest(at_T_12,us_T_12);   %run this part firstly
%         %     res.rois(find(h_T12),:)    % this is to find the ROIs which shows
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % TARGETS at_T_2 vs us_T_2, at_T vs us_T, COMPARING FIRST PART WITH THE
% % % % % % SECOND PART OF THE EXPERIMENT
% 
      at_T_12_firstpart= nanmean([firstpart(30,:)' firstpart(31,:)'],2);
      us_T_12_firstpart= nanmean([firstpart(27,:)' firstpart(28,:)'],2);

      at_T_12_lastpart= nanmean([lastpart(30,:)' lastpart(31,:)'],2);
      us_T_12_lastpart= nanmean([lastpart(27,:)' lastpart(28,:)'],2);

             [h1(i), p1(i), ci1(i,:)]= ttest(at_T_12_firstpart,at_T_12_lastpart);      %run this part firstly
             [h2(i), p2(i), ci2(i,:)]= ttest(us_T_12_firstpart,us_T_12_lastpart);
             [h3(i), p3(i), ci3(i,:)]= ttest(at_T_12_firstpart, us_T_12_firstpart);
             [h4(i), p4(i), ci4(i,:)]= ttest(at_T_12_lastpart, us_T_12_lastpart);
%              % res.rois(find(h1),:)    % this is to find the ROIs which shows

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % TARGETS at_T_2 vs us_T_2, at_T vs us_T, MAKING A SESSION-WISE COMPARISON

at_T12_sess1=nanmean([firstpart(30,:)' firstpart(31,:)'],2);
at_T12_sess2=nanmean([secondpart(30,:)' secondpart(31,:)'],2);
at_T12_sess3=nanmean([thirdpart(30,:)' thirdpart(31,:)'],2);
at_T12_sess4=nanmean([fourthpart(30,:)' fourthpart(31,:)'],2);
us_T12_sess1=nanmean([firstpart(27,:)' firstpart(28,:)'],2);
us_T12_sess2=nanmean([secondpart(27,:)' secondpart(28,:)'],2);
us_T12_sess3=nanmean([thirdpart(27,:)' thirdpart(28,:)'],2);
us_T12_sess4=nanmean([fourthpart(27,:)' fourthpart(28,:)'],2);

matrix1=[at_T12_sess1 at_T12_sess2 at_T12_sess3 at_T12_sess4];
matrix2=[us_T12_sess1 us_T12_sess2 us_T12_sess3 us_T12_sess4];

figure
ciwithinnan(matrix1,0.05, color9);
fontsize = 25;
   title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    box off
    %ylabel()
    xlabel('AlwaysT Targets 1 and 2 Across Sessions')
    barnames={'sess1','sess2','sess3','sess4'};
    set(gca, 'xticklabels',barnames)
    ax.YColor=color3;
    ax.XColor=color3;

figure
ciwithinnan(matrix2,0.05, color9);
fontsize = 25;
   title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    box off
    %ylabel()
    xlabel('UsualT Targets 1 and 2 Across Sessions')
     barnames={'sess1','sess2','sess3','sess4'};
    set(gca, 'xticklabels',barnames)
    ax.YColor=color3;
    ax.XColor=color3;



    % matrix3=[at_T12_sess1 at_T12_sess2 at_T12_sess3 at_T12_sess4 us_T12_sess1 us_T12_sess2 us_T12_sess3 us_T12_sess4];
    matrix3=[at_T12_sess1 at_T12_sess2 at_T12_sess3 us_T12_sess1 us_T12_sess2 us_T12_sess3];
    figure
    ciwithinnan(matrix3,0.05, color9);
    fontsize = 25;
    title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    box off
    %ylabel()
    xlabel('AlwaysT and UsualT Targets 1 and 2 Across Sessions')
    %barnames={'ATsess1','ATsess2','ATsess3','ATsess4','UTsess1','UTsess2','UTsess3','UTsess4'};
    barnames={'ATsess1','ATsess2','ATsess3','UTsess1','UTsess2','UTsess3'};
    set(gca, 'xticklabels',barnames)
    ax.YColor=color3;
    ax.XColor=color3;
    %b.FaceColor='flat';
       %


end


