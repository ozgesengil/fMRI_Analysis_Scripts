% this code is to grapgh the ROIs for linear_increase_nonT, and IEI1,IEI2,
% and Rest, and also to find the ROIs which show significant differences between
% the events of interest (in-task-rests and bigger-rests). 

% it uses roi_results.mat *FROM STATS2

 load roi_results.mat
 aa = res.beta; % from stats2 roi_results_04102021

 
list36 = [6]; % 2-back, 2 sessions
list42 = [1]; % 3-back, 2 sessions
list63 = [2 3 4]; % 3-back, 3 sessions
list54 = [9 11]; % 2-back, 3 sessions
list72 = [5 7 8 10 12 13 14 15 16 17 18 19 20 21]; % 2-back, 4 sessions


%creating roi names to appear on the figures
roi_names=['ACC             ';'LEFT HAND       ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
    'PCC             ';'RIGHT HAND      ';'A1-L            ';'A1-R            ';'TPJ-R           ';...
    'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
    'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
    'I-R             ';'Hand S1-R       '];


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
            iei_1(ii,:) = nanmean([s2_4(10); s2_4(28)]);
            iei_2(ii,:) = nanmean([s2_4(11); s2_4(29)]);
            Rest(ii,:) = nanmean([s2_4(12); s2_4(30)]);
        end 
    end 
    

   
    for iii =1:length(list42)
        for ii= list42(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(22)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(23)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(24)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(25)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(26)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(27)]);
            nt7(ii,:) = nanmean([s2_4(7); s2_4(28)]);
            nt8(ii,:) = nanmean([s2_4(8); s2_4(29)]);
            nt9(ii,:) = nanmean([s2_4(9); s2_4(30)]);
            t1(ii,:) = nanmean([s2_4(10); s2_4(31)]);
            t2(ii,:) = nanmean([s2_4(11); s2_4(32)]);
            t3(ii,:) = nanmean([s2_4(12); s2_4(33)]);
            iei_1(ii,:) = nanmean([s2_4(13); s2_4(34)]);
            iei_2(ii,:) = nanmean([s2_4(14); s2_4(35)]);
            Rest(ii,:) = nanmean([s2_4(15); s2_4(36)]);
        end 
    end         
            
    for iii =1:length(list63)
        for ii= list63(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(22); s2_4(43)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(23); s2_4(44)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(24); s2_4(45)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(25); s2_4(46)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(26); s2_4(47)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(27); s2_4(48)]);
            nt7(ii,:) = nanmean([s2_4(7); s2_4(28); s2_4(49)]);
            nt8(ii,:) = nanmean([s2_4(8); s2_4(29); s2_4(50)]);
            nt9(ii,:) = nanmean([s2_4(9); s2_4(30); s2_4(51)]);
            t1(ii,:) = nanmean([s2_4(10); s2_4(31); s2_4(52)]);
            t2(ii,:) = nanmean([s2_4(11); s2_4(32); s2_4(53)]);
            t3(ii,:) = nanmean([s2_4(12); s2_4(33); s2_4(54)]);
            iei_1(ii,:) = nanmean([s2_4(13); s2_4(34); s2_4(55)]);
            iei_2(ii,:) = nanmean([s2_4(14); s2_4(35); s2_4(56)]);
            Rest(ii,:) = nanmean([s2_4(15); s2_4(36); s2_4(57)]);
        end 
    end         

     

    for iii =1:length(list54)
        for ii= list54(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(19); s2_4(37)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(20); s2_4(38)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(21); s2_4(39)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(22); s2_4(40)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(23); s2_4(41)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(24); s2_4(42)]);
            t1(ii,:) = nanmean([s2_4(7); s2_4(25); s2_4(43)]);
            t2(ii,:) = nanmean([s2_4(8); s2_4(26); s2_4(44)]);
            t3(ii,:) = nanmean([s2_4(9); s2_4(27); s2_4(45)]);
            iei_1(ii,:) = nanmean([s2_4(10); s2_4(28); s2_4(46)]);
            iei_2(ii,:) = nanmean([s2_4(11); s2_4(29); s2_4(47)]);
            Rest(ii,:) = nanmean([s2_4(12); s2_4(30); s2_4(48)]);
        end 
    end 

    for iii =1:length(list72)
        for ii= list72(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(19); s2_4(37); s2_4(55)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(20); s2_4(38); s2_4(56)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(21); s2_4(39); s2_4(57)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(22); s2_4(40); s2_4(58)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(23); s2_4(41); s2_4(59)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(24); s2_4(42); s2_4(60)]);
            t1(ii,:) = nanmean([s2_4(7); s2_4(25); s2_4(43); s2_4(61)]);
            t2(ii,:) = nanmean([s2_4(8); s2_4(26); s2_4(44); s2_4(62)]);
            t3(ii,:) = nanmean([s2_4(9); s2_4(27); s2_4(45); s2_4(63)]);
            iei_1(ii,:) = nanmean([s2_4(10); s2_4(28); s2_4(46); s2_4(64)]);
            iei_2(ii,:) = nanmean([s2_4(11); s2_4(29); s2_4(47); s2_4(65)]);
            Rest(ii,:) = nanmean([s2_4(12); s2_4(30); s2_4(48); s2_4(66)]);
        end 
    end 
    
    color1=[0/255,0/255,0/255];
    color2=[95/255,158/255,160/255];
    color3=[105/255,105/255,105/255];
    
    %%%% BAR GRAPH - LINEAR INCREASE - NONT
  
    figure
%   bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5)  nanmean(nt6) nan nan  nanmean(t1)  nanmean(t2)   nanmean(t3)  nan nan  nanmean(iei1)  nan nan  nanmean(iei2)    nan nan nanmean(Rest)])
    
%     f=bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5) nanmean(nt7) nanmean(nt8) nanmean(nt9)]);
%     f=bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5) nanmean(nt6)]);
    f=bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5) nanmean(nt6)]);
    
    
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
%     barnames={'1','2','3','4','5','6'};
    barnames={'1','2','3','4','5','6'};
    set(gca,'xticklabels',barnames);
%     set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    
%     

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    %%%% BAR GRAPH - IEI, REST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure
    g=bar([nanmean(iei_1) nanmean(iei_2) nanmean(Rest)]);
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
    barnames={'IEI_1','IEI_2','REST'};
    set(gca,'xticklabels',barnames);
%     set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    
    
% [h(i) p(i) ci(i,:)]= ttest(iei_2,Rest)      %run this part firstly
%     
% res.rois(find(h),:)    % this is to find the ROIs which shows
%     %     significant differences between contrasted events


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % BAR GRAPH WITH REST AS A DOTTED LINE
    figure
    g=bar([nanmean(iei_2) nanmean(iei_1) nan nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5)  nanmean(nt6)]);
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
    barnames={'IEI-2', 'IEI-1', '', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6'};
    set(gca,'xticklabels',barnames);
%   set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    

    

    hold on
    yline(nanmean(Rest), ':k');
    
    

%     [h1(i),p1(i),ci1(i,:),stats1]=ttest2((iei_1), (iei_2)); %
%     [h2(i),p2(i),ci2(i,:),stats2]=ttest2((iei_2), (Rest));
%     [h3(i),p3(i),ci3(i,:),stats3]=ttest2(nanmean([(iei_2);(iei_1)]), (Rest));
% 
%     res.rois(find(h3),:)
end

%     h1 results: iei_1 vs iei_2
%     18×19 char array
% 
%     'ACC_roi.mat        '
%     'LH_roi.mat         '
%     'L_TPJ_roi.mat      '
%     'L_aPFC_roi.mat     '
%     'L_prCn_roi.mat     '
%     'R_TPJ_roi.mat      '
%     'R_aPFC_roi.mat     '
%     'R_prCn_roi.mat     '
%     'SMA_roi.mat        '
%     'aMPFC_roi.mat      '
%     'lIFS_roi.mat       '
%     'lIPS_roi.mat       '
%     'lI_roi.mat         '
%     'left_hand_roi.mat  '
%     'rIFS_roi.mat       '
%     'rIPS_roi.mat       '
%     'rI_roi.mat         '
%     'right_hand_roi.mat '


%        h2 results: iei_2 vs Rest
%        15×19 char array
% 
%     'ACC_roi.mat        '
%     'LH_roi.mat         '
%     'L_prCn_roi.mat     '
%     'RH_roi.mat         '
%     'ROI_l_adtry_roi.mat'
%     'ROI_r_adtry_roi.mat'
%     'R_aPFC_roi.mat     '
%     'R_prCn_roi.mat     '
%     'SMA_roi.mat        '
%     'lIPS_roi.mat       '
%     'left_hand_roi.mat  '
%     'rIFS_roi.mat       '
%     'rIPS_roi.mat       '
%     'rI_roi.mat         '
%     'right_hand_roi.mat '







