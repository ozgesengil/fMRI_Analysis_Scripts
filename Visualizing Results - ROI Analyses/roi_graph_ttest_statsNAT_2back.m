
% it uses roi_results.mat *FROM STATSNAT
% It uses SPM.mat files of the subs from statsNAT to check whether a given
% never target event occured (for some subs, they never occured for some
% sessions so roi matrixes are not matching unless some further arrangement 
% is done, so this code is using individual's SPM.mat to read 
% roi betas in the correct order)


  color1=[0/255,0/255,0/255];
  color2=[95/255,158/255,160/255];
  color3=[105/255,105/255,105/255];

 load roi_results_2back.mat
 aa = res.beta;

%creating roi names to appear on the figures
roi_names=['ACC             ';'LEFT HAND       ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
    'PCC             ';'RIGHT HAND      ';'A1-L            ';'A1-R            ';'TPJ-R           ';...
    'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
    'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
    'I-R             ';'Hand S1-R       '];

rootdir= 'G:\OZGE_STUDY2\statsNAT';

subs = {'sub06','sub07','sub08','sub09','sub10','sub11','sub12','sub13','sub14','sub15','sub16','sub17','sub18','sub19','sub20','sub21','sub22'};
subs = char(subs);
subs = cellstr(deblank(subs));
ntot = length(subs);

                    % each event matrix consists of subs as the rows, and
                    % sessions as the columns
                    nt_nonT_1=nan(ntot,4);
                    nt_nonT_2=nan(ntot,4);
                    at_nonT_1=nan(ntot,4);
                    at_nonT_2=nan(ntot,4);
                    at_nonT_3=nan(ntot,4);
                    at_nonT_4=nan(ntot,4);
                    us_nonT_1=nan(ntot,4);
                    us_nonT_2=nan(ntot,4);
                    us_nonT_3=nan(ntot,4);
                    us_nonT_4=nan(ntot,4);
                    us_nonT_5=nan(ntot,4);
                    us_nonT_6=nan(ntot,4);
                    us_T_1=nan(ntot,4);
                    us_T_2=nan(ntot,4);
                    at_T_1=nan(ntot,4);
                    at_T_2=nan(ntot,4);
                    at_T_3=nan(ntot,4);


 for i=1:22 % for a given ROI (the rows of res.beta)
  for cc=1:ntot % for a given subject (the columns of res.beta)
      mat = aa{i, cc}; % the roi matrix for a sub for the given roi
     
      csub = subs{cc};
      a = load(fullfile(rootdir, csub, '\SPM.mat'));

     for ss=1:size(a.SPM.event_present,1) % for each session of sub's data
         b=23*(ss-1); % 23 = 17 events + 6 movement parameters
   
        if a.SPM.event_present(ss,1)~=0 && a.SPM.event_present(ss,2)~=0 %  if all never target events occured in that session
       
                    nt_nonT_1(cc,ss) = mat(1+b);
                    nt_nonT_2(cc,ss) = mat(2+b);
                    at_nonT_1(cc,ss) = mat(3+b) ;
                    at_nonT_2(cc,ss) =mat(4+b) ;
                    at_nonT_3(cc,ss) =mat(5+b) ;
                    at_nonT_4(cc,ss) =mat(6+b) ;
                    us_nonT_1(cc,ss) =mat(7+b) ;
                    us_nonT_2(cc,ss) =mat(8+b);
                    us_nonT_3(cc,ss) =mat(9+b);
                    us_nonT_4(cc,ss) =mat(10+b);
                    us_nonT_5(cc,ss) =mat(11+b);
                    us_nonT_6(cc,ss) =mat(12+b);
                    us_T_1(cc,ss) =mat(13+b);
                    us_T_2(cc,ss) =mat(14+b);
                    at_T_1(cc,ss) =mat(15+b);
                    at_T_2(cc,ss) =mat(16+b);
                    at_T_3(cc,ss) =mat(17+b);



        elseif (a.SPM.event_present(ss,1)~=0 && a.SPM.event_present(ss,2)~=1) % if only one of the nt events occured which is position 1

                    nt_nonT_1(cc,ss) =mat(1+b);
                    nt_nonT_2(cc,ss) = nan;
                    at_nonT_1(cc,ss) =mat(2+b);
                    at_nonT_2(cc,ss) =mat(3+b);
                    at_nonT_3(cc,ss) =mat(4+b);
                    at_nonT_4(cc,ss) =mat(5+b);
                    us_nonT_1(cc,ss) =mat(6+b);
                    us_nonT_2(cc,ss) =mat(7+b);
                    us_nonT_3(cc,ss) =mat(8+b);
                    us_nonT_4(cc,ss) =mat(9+b);
                    us_nonT_5(cc,ss) =mat(10+b);
                    us_nonT_6(cc,ss) =mat(11+b);
                    us_T_1(cc,ss) =mat(12+b);
                    us_T_2(cc,ss) =mat(13+b);
                    at_T_1(cc,ss) =mat(14+b);
                    at_T_2(cc,ss) =mat(15+b);
                    at_T_3(cc,ss) =mat(16+b);

        elseif (a.SPM.event_present(ss,1)~=1 && a.SPM.event_present(ss,2)~=0) % if only one of the nt events occured which is position 2
        
                    nt_nonT_1(cc,ss) = nan;
                    nt_nonT_2(cc,ss) =mat(1+b);
                    at_nonT_1(cc,ss) =mat(2+b);
                    at_nonT_2(cc,ss) =mat(3+b);
                    at_nonT_3(cc,ss) =mat(4+b);
                    at_nonT_4(cc,ss) =mat(5+b);
                    us_nonT_1(cc,ss) =mat(6+b);
                    us_nonT_2(cc,ss) =mat(7+b);
                    us_nonT_3(cc,ss) =mat(8+b);
                    us_nonT_4(cc,ss) =mat(9+b);
                    us_nonT_5(cc,ss) =mat(10+b);
                    us_nonT_6(cc,ss) =mat(11+b);
                    us_T_1(cc,ss) =mat(12+b);
                    us_T_2(cc,ss) =mat(13+b);
                    at_T_1(cc,ss) =mat(14+b);
                    at_T_2(cc,ss) =mat(15+b);
                    at_T_3(cc,ss) =mat(16+b);


        elseif a.SPM.event_present(ss,1)~=1 && a.SPM.event_present(ss,2)~=1 %  if none of the never target events occured (which is never the case for any participant by chance)
                    counter=counter+1;
                    nt_nonT_1(cc,ss) = nan;
                    nt_nonT_2(cc,ss) = nan;
                    at_nonT_1(cc,ss) = mat(1+b);
                    at_nonT_2(cc,ss) = mat(2+b);
                    at_nonT_3(cc,ss) =mat(3+b);
                    at_nonT_4(cc,ss) =mat(4+b);
                    us_nonT_1(cc,ss) =mat(5+b);
                    us_nonT_2(cc,ss) =mat(6+b);
                    us_nonT_3(cc,ss) =mat(7+b);
                    us_nonT_4(cc,ss) =mat(8+b);
                    us_nonT_5(cc,ss) =mat(9+b);
                    us_nonT_6(cc,ss) =mat(10+b);
                    us_T_1(cc,ss) =mat(11+b);
                    us_T_2(cc,ss) =mat(12+b);
                    at_T_1(cc,ss) =mat(13+b);
                    at_T_2(cc,ss) =mat(14+b);
                    at_T_3(cc,ss) =mat(15+b);
        end
     end
  end
   
    
   

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % NON_TARGETS in positions 1 and 2 (at, nt, ut)

% %    at_nonT_12=([mean(nanmean(at_nonT_1,2)) mean(nanmean(at_nonT_2,2))])
% %    us_nonT_12=([mean(nanmean(us_nonT_1,2)) mean(nanmean(us_nonT_2,2))])
% %    nt_nonT_12=([mean(nanmean(us_nonT_1,2)) mean(nanmean(us_nonT_2,2))])
% %   
  
   figure
   f=bar([mean([mean(nanmean(at_nonT_1,2)) mean(nanmean(at_nonT_2,2))]), mean([mean(nanmean(us_nonT_1,2)) mean(nanmean(us_nonT_2,2))]),...
       mean([nanmean(nanmean(nt_nonT_1,2)) nanmean(nanmean(nt_nonT_2,2))])]);
   fontsize = 25;
   title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);

    set(f, 'FaceColor', color2);
   
    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
    f.EdgeColor=color2;
   
    ax.YColor=color3;
    ax.XColor=color3;

    xlabel('');
    barnames={'at_nonT_1_2''us_nonT_1_2''nt_nonT_1_2'};
    set(gca,'xticklabels',barnames);
    set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % NON_TARGETS in positions 3 and 4 (at,ut)
% % at_nonT_34=([mean(nanmean(at_nonT_3,2)) mean(nanmean(at_nonT_4,2))])
% % us_nonT_34=([mean(nanmean(us_nonT_3,2)) mean(nanmean(us_nonT_4,2))])
% %    figure
% %    f=bar([mean([mean(nanmean(at_nonT_3,2)) mean(nanmean(at_nonT_4,2))]) mean([mean(nanmean(us_nonT_3,2)) mean(nanmean(us_nonT_4,2))])]);
% % %%%    ciwithin(f,0.05);
% %    fontsize = 25;
% %    title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% % 
% %     set(f, 'FaceColor', color2);
% %    
% %     ax=gca;
% %     ax.YMinorTick = 'off';
% %     ax.TickLength = [0 0];
% %     f.EdgeColor=color2;
% %    
% %     ax.YColor=color3;
% %     ax.XColor=color3;
% % 
% %     xlabel('');
% %     barnames={'at_nonT_3_4''us_nonT_3_4'};
% %     set(gca,'xticklabels',barnames);
% %     set(gca, 'XColor', 'none');
% %     set(gca, 'box','off');
% %     set(gcf, 'color', 'w')
% % 
% %  [h(i) p(i) ci(i,:)]= ttest(at_nonT_34,us_nonT_34);   %run this part firstly
% %  res.rois(find(h),:)    % this is to find the ROIs which shows
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  NON_TARGETS when they appear in positions 1,2,3,4 for at vs ut
% 
% at_nonT=(mean([nanmean(at_nonT_1,2) nanmean(at_nonT_2,2) nanmean(at_nonT_3,2) nanmean(at_nonT_4,2)],2));
% us_nonT=(mean([nanmean(us_nonT_1,2) nanmean(us_nonT_2,2) nanmean(us_nonT_3,2) nanmean(us_nonT_4,2)],2));
% figure
% f=bar([mean(at_nonT) mean(us_nonT)]);
% %%%    ciwithin(f,0.05);
%    fontsize = 25;
%    title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% 
%     set(f, 'FaceColor', color2);
%    
%     ax=gca;
%     ax.YMinorTick = 'off';
%     ax.TickLength = [0 0];
%     f.EdgeColor=color2;
%    
%     ax.YColor=color3;
%     ax.XColor=color3;
% 
%     xlabel('');
%     barnames={'at_nonT''us_nonT'};
%     set(gca,'xticklabels',barnames);
%     set(gca, 'XColor', 'none');
%     set(gca, 'box','off');
%     set(gcf, 'color', 'w')
% 
% 
%     [h(i) p(i) ci(i,:)]= ttest(at_nonT,us_nonT);   %run this part firstly
%     res.rois(find(h),:)    % this is to find the ROIs which shows
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % TARGETS at_T_2 vs us_T_2, at_T vs us_T
% % % display(GetSecs-aaaa)
% % %          aaaa=GetSecs;
% % % at_T=mean([nanmean(at_T_2,2)],2);
% % % us_T=mean([nanmean(us_T_2,2)],2);
% % % 
% % % 
% % %     figure
% % %     g=bar([mean(at_T) mean(us_T)]);
% % %     fontsize = 25;
% % %     title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% % % 
% % %     set(g, 'FaceColor', color2);
% % %    
% % %     ax=gca;
% % %     ax.YMinorTick = 'off';
% % %     ax.TickLength = [0 0];
% % %     g.EdgeColor=color2;
% % %    
% % %     ax.YColor=color3;
% % %     ax.XColor=color3;
% % %     
% % %     %xlabel('');
% % %     barnames={'at_T','us_T'};
% % %     set(gca,'xticklabels',barnames);
% % % %     set(gca, 'XColor', 'none');
% % %     set(gca, 'box','off');
% % %     set(gcf, 'color', 'w')
% % %     
% % %     
% % % [h(i), p(i), ci(i,:)]= ttest(at_T,us_T);      %run this part firstly
% % %     
% % % res.rois(find(h),:)    % this is to find the ROIs which shows
% % % %     %     significant differences between contrasted events


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % TARGETS at_T_2 vs us_T_2, at_T vs us_T, COMPARING FIRST HALF WITH THE
% % % % SECOND HALF OF THE EXPERIMENT
% % % % display(GetSecs-aaaa)
% % % %          aaaa=GetSecs;
% % % 
% % % at_T_half1=nanmean([nanmean(at_T_2(:,1:2),2)],2);
% % % at_T_half2=nanmean([nanmean(at_T_2(:,3:4),2)],2);
% % % us_T_half1=nanmean([nanmean(us_T_2(:,1:2),2)],2);
% % % us_T_half2=nanmean([nanmean(us_T_2(:,3:4),2)],2);
% % % 
% % % 
% % %     matt=([nanmean(at_T_half1) nanmean(us_T_half1); nanmean(at_T_half2) nanmean(us_T_half2)]);
% % %     figure
% % %     g=bar(matt, 'FaceColor', 'flat');
% % %     xlabel('targets')
% % %     fontsize = 25;
% % %     title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% % % 
% % %     
% % %    
% % %     ax=gca;
% % %     ax.YMinorTick = 'off';
% % %     ax.TickLength = [0 0];
% % % %     g.EdgeColor=color2;
% % %    
% % %     ax.YColor=color3;
% % %     ax.XColor=color3;
% % %     
% % %     %xlabel('');
% % %     xlab={'half1','half2'};
% % %     set(gca,'xticklabels',xlab);
% % % %     set(gca, 'XColor', 'none');
% % %     set(gca, 'box','off');
% % %     set(gcf, 'color', 'w')
% % %     legend({'at_T2','us_T2'});
% % %     
% % %     
% % % [h1(i), p1(i), ci1(i,:)]= ttest(at_T_half1,us_T_half1);      %run this part firstly
% % %     
% % % res.rois(find(h1),:)    % this is to find the ROIs which shows
% % % %     %     significant differences between contrasted events
% % % 
% % % [h2(i), p2(i), ci2(i,:)]= ttest(at_T_half2,us_T_half2);      %run this part firstly
% % %     
% % % res.rois(find(h2),:)    % this is to find the ROIs which shows
% % % %     %     significant differences between contrasted events
% % % 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % TARGETS at_T_2 vs us_T_2, at_T vs us_T, MAKING A SESSION-WISE COMPARISON
% % 
% % at_T2_sess1=nanmean(at_T_2(:,1),2);
% % at_T2_sess2=nanmean(at_T_2(:,2),2);
% % at_T2_sess3=nanmean(at_T_2(:,3),2);
% % at_T2_sess4=nanmean(at_T_2(:,4),2);
% % us_T2_sess1=nanmean(us_T_2(:,1),2);
% % us_T2_sess2=nanmean(us_T_2(:,2),2);
% % us_T2_sess3=nanmean(us_T_2(:,3),2);
% % us_T2_sess4=nanmean(us_T_2(:,4),2);
% % 
% % matt=([nanmean(at_T2_sess1) nanmean(us_T2_sess1); nanmean(at_T2_sess2) nanmean(us_T2_sess2);...
% %     nanmean(at_T2_sess3) nanmean(us_T2_sess3); nanmean(at_T2_sess4) nanmean(us_T2_sess4)]);
% %   figure
% % g=bar(matt, 'FaceColor', 'flat');
% % xlabel('sessions')
% % fontsize = 25;
% % title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% % 
% % ax=gca;
% % ax.YMinorTick = 'off';
% % ax.TickLength = [0 0];
% % ax.YColor=color3;
% % ax.XColor=color3;
% %  %xlabel('');
% % xlab={'sess1','sess2', 'sess3', 'sess4'};
% % set(gca,'xticklabels',xlab);
% % set(gca, 'XColor', 'none');
% % set(gca, 'box','off');
% % set(gcf, 'color', 'w')
% % legend({'at_T2','us_T2'});

 end


