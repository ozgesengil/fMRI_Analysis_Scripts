% this code is to grapgh the ROIs for linear_increase_nonT, and IEI1,IEI2,
% and Rest, and also to find the ROIs which show significant differences between
% the events of interest (in-task-rests and bigger-rests). 

% it uses roi_results.mat *FROM STATS2_irem or STATS3 (ozge)

 load roi_results.mat
 xx = res.beta; % first 15 subs, from stats3 roi_results
 load roi_results_04102021_from17to22.mat
 yy = res.beta; % then 6 more subs, from stats3, roi_results_04102021_from17to22
 
 aa = [xx, yy];

%creating roi names to appear on the figures
roi_names=['ACC             ';'LEFT HAND       ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
    'PCC             ';'RIGHT HAND      ';'A1-L            ';'A1-R            ';'TPJ-R           ';...
    'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
    'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
    'I-R             ';'Hand S1-R       '];


list36 = [1 6];
list54 = [2 3 4 9 11 ];
list72 = [5 7 8 10 12 13 14 15 16 17 18 19 20 21];

for i = 1:22
    
    for iii =1:length(list36)
        for ii= list36(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(19)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(20)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(21)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(22)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(23)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(24)]);
            t1(ii,:) = nanmean([s2_4(7); s2_4(25)]);
            t2(ii,:) = nanmean([s2_4(8); s2_4(26)]);
            t3(ii,:) = nanmean([s2_4(9); s2_4(27)]);
            iei1(ii,:) = nanmean([s2_4(10); s2_4(28)]);
            iei2(ii,:) = nanmean([s2_4(11); s2_4(29)]);
            Rest(ii,:) = nanmean([s2_4(12); s2_4(30)]);
        end 
    end 
            
    for iii =1:length(list54)
        for ii= list54(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(19);s2_4(37)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(20);s2_4(38)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(21);s2_4(39)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(22);s2_4(40)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(23);s2_4(41)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(24);s2_4(42)]);
            t1(ii,:) = nanmean([s2_4(7); s2_4(25);s2_4(43)]);
            t2(ii,:) = nanmean([s2_4(8); s2_4(26);s2_4(44)]);
            t3(ii,:) = nanmean([s2_4(9); s2_4(27);s2_4(45)]);
            iei1(ii,:) = nanmean([s2_4(10); s2_4(28);s2_4(46)]);
            iei2(ii,:) = nanmean([s2_4(11); s2_4(29);s2_4(47)]);
            Rest(ii,:) = nanmean([s2_4(12); s2_4(30);s2_4(48)]);
        end 
    end         
            
    
     for iii =1:length(list72)
        for ii= list72(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(19);s2_4(37);s2_4(55) ]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(20);s2_4(38);s2_4(56)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(21);s2_4(39);s2_4(57)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(22);s2_4(40);s2_4(58)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(23);s2_4(41);s2_4(59)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(24);s2_4(42);s2_4(60)]);
            t1(ii,:) = nanmean([s2_4(7); s2_4(25);s2_4(43);s2_4(61)]);
            t2(ii,:) = nanmean([s2_4(8); s2_4(26);s2_4(44);s2_4(62)]);
            t3(ii,:) = nanmean([s2_4(9); s2_4(27);s2_4(45);s2_4(63)]);
            iei1(ii,:) = nanmean([s2_4(10); s2_4(28);s2_4(46);s2_4(64)]);
            iei2(ii,:) = nanmean([s2_4(11); s2_4(29);s2_4(47);s2_4(65)]);
            Rest(ii,:) = nanmean([s2_4(12); s2_4(30);s2_4(48);s2_4(66)]);
        end 
    end         
           
    
    color1=[0/255,0/255,0/255];
    color2=[95/255,158/255,160/255];
    color3=[105/255,105/255,105/255];
    
    %%%% BAR GRAPH - LINEAR INCREASE - NONT
  
    figure
%   bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5)  nanmean(nt6) nan nan  nanmean(t1)  nanmean(t2)   nanmean(t3)  nan nan  nanmean(iei1)  nan nan  nanmean(iei2)    nan nan nanmean(Rest)])
    
    f=bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5)  nanmean(nt6)]);
    
    fontsize = 25;
    title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);

    set(f, 'FaceColor', color2);
   
    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
    f.EdgeColor=color2;
   
    ax.YColor=color3;
    ax.XColor=color3;
   
    xlabel('Trials');
    barnames={'1','2','3','4','5','6'};
    set(gca,'xticklabels',barnames);
%     set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    
%     
% %     [h(i) p(i) ci(i,:)]= ttest(iei1,Rest)      %run this part firstly
%     [h(i) p(i) ci(i,:)]= ttest(iei2,Rest)
% %     title(res.rois(i,1:10))                   % run these three secondly
%     
%     res.rois(find(h),:)    % this is to find the ROIs which shows
%     %     significant differences between contrasted events, run this part
%     %     thirdly
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    %%%% BAR GRAPH - IEI1, IEI2, REST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure
    g=bar([nanmean(iei1) nanmean(iei2) nanmean(Rest)]);
    fontsize = 25;
    title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);

    set(g, 'FaceColor', color2);
   
    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
    g.EdgeColor=color2;
   
    ax.YColor=color3;
    ax.XColor=color3;
    
    %xlabel('');
    barnames={'IEI-1','IEI-2','REST'};
    set(gca,'xticklabels',barnames);
%     set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    
    
%     
     [h(i) p(i) ci(i,:)]= ttest(iei1,iei2)      %run this part firstly
%     [h(i) p(i) ci(i,:)]= ttest(iei2,Rest)
% %     title(res.rois(i,1:10))                   % run these three secondly
%     
 res.rois(find(h),:)    % this is to find the ROIs which shows
%     %     significant differences between contrasted events, run this part
    %     thirdly
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


% % For iei1 vs Rest 
%      'ACC_roi.mat        '
%     'RH_roi.mat         '
%     'ROI_l_adtry_roi.mat'
%     'ROI_r_adtry_roi.mat'
%     'left_hand_roi.mat  '
%     'rIPS_roi.mat       '
%     'right_hand_roi.mat '



% %% For iei2 vs Rest
%     'ACC_roi.mat        '
%     'L_prCn_roi.mat     '
%     'RH_roi.mat         '
%     'ROI_l_adtry_roi.mat'
%     'ROI_r_adtry_roi.mat'
%     'R_TPJ_roi.mat      '
%     'R_aPFC_roi.mat     '
%     'R_prCn_roi.mat     '
%     'SMA_roi.mat        '
%     'aMPFC_roi.mat      '
%     'lIPS_roi.mat       '
%     'left_hand_roi.mat  '
%     'rIPS_roi.mat       '
%     'rI_roi.mat         '
%     'right_hand_roi.mat '
