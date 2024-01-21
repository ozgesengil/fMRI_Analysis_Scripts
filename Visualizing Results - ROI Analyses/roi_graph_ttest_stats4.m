

% it uses roi_results.mat *FROM STATS4
% the place of events in the res mat is cross-checked with SPM mat
% of each participant from stats4/sub* folders

 load roi_results_tillsub22inc.mat
 cc = res.beta;
 load roi_results_fromsub23tosub33inc.mat
 bb = res.beta;

 aa=[cc bb];

%%
%creating roi names to appear on the figures
roi_names=['ACC             ';'LEFT HAND       ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
    'PCC             ';'RIGHT HAND      ';'A1-L            ';'A1-R            ';'TPJ-R           ';...
    'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
    'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
    'I-R             ';'Hand S1-R       '];

list34 = [6]; % 2-back, 2 sessions
list40 = [1]; % 3-back, 2 sessions
list60 = [2 3 4 22 23 26 27 28 29 30 31 32]; % 3-back, 3 sessions
list51 = [9 11]; % 2-back, 3 sessions
list68 = [5 7 8 10 12 13 14 15 16 17 18 19 20 21]; % 2-back, 4 sessions
list80 = [24 25]; % 3-back, 4 sessions

for i = 1:22
    
    for iii =1:length(list34)
        for ii= list34(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(18)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(19)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(20)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(21)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(22)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(23)]);
            t1(ii,:) = nanmean([s2_4(7); s2_4(24)]);
            t2(ii,:) = nanmean([s2_4(8); s2_4(25)]);
            t3(ii,:) = nanmean([s2_4(9); s2_4(26)]);
            iei(ii,:) = nanmean([s2_4(10); s2_4(27)]);
            Rest(ii,:) = nanmean([s2_4(11); s2_4(28)]);

            nt1_2back(ii,:) = nanmean([s2_4(1); s2_4(18)]);
            nt2_2back(ii,:) = nanmean([s2_4(2); s2_4(19)]);
            nt3_2back(ii,:) = nanmean([s2_4(3); s2_4(20)]);
            nt4_2back(ii,:) = nanmean([s2_4(4); s2_4(21)]);
            nt5_2back(ii,:) = nanmean([s2_4(5); s2_4(22)]);
            nt6_2back(ii,:) = nanmean([s2_4(6); s2_4(23)]);
            t1_2back(ii,:) = nanmean([s2_4(7); s2_4(24)]);
            t2_2back(ii,:) = nanmean([s2_4(8); s2_4(25)]);
            t3_2back(ii,:) = nanmean([s2_4(9); s2_4(26)]);
            iei_2back(ii,:) = nanmean([s2_4(10); s2_4(27)]);
            Rest_2back(ii,:) = nanmean([s2_4(11); s2_4(28)]);
        end 
    end 
    

   
    for iii =1:length(list40)
        for ii= list40(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(21)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(22)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(23)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(24)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(25)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(26)]);
            nt7(ii,:) = nanmean([s2_4(7); s2_4(27)]);
            nt8(ii,:) = nanmean([s2_4(8); s2_4(28)]);
            nt9(ii,:) = nanmean([s2_4(9); s2_4(29)]);
            t1(ii,:) = nanmean([s2_4(10); s2_4(30)]);
            t2(ii,:) = nanmean([s2_4(11); s2_4(31)]);
            t3(ii,:) = nanmean([s2_4(12); s2_4(32)]);
            iei(ii,:) = nanmean([s2_4(13); s2_4(33)]);
            Rest(ii,:) = nanmean([s2_4(14); s2_4(34)]);

            nt1_3back(ii,:) = nanmean([s2_4(1); s2_4(21)]);
            nt2_3back(ii,:) = nanmean([s2_4(2); s2_4(22)]);
            nt3_3back(ii,:) = nanmean([s2_4(3); s2_4(23)]);
            nt4_3back(ii,:) = nanmean([s2_4(4); s2_4(24)]);
            nt5_3back(ii,:) = nanmean([s2_4(5); s2_4(25)]);
            nt6_3back(ii,:) = nanmean([s2_4(6); s2_4(26)]);
            nt7_3back(ii,:) = nanmean([s2_4(7); s2_4(27)]);
            nt8_3back(ii,:) = nanmean([s2_4(8); s2_4(28)]);
            nt9_3back(ii,:) = nanmean([s2_4(9); s2_4(29)]);
            t1_3back(ii,:) = nanmean([s2_4(10); s2_4(30)]);
            t2_3back(ii,:) = nanmean([s2_4(11); s2_4(31)]);
            t3_3back(ii,:) = nanmean([s2_4(12); s2_4(32)]);
            iei_3back(ii,:) = nanmean([s2_4(13); s2_4(33)]);
            Rest_3back(ii,:) = nanmean([s2_4(14); s2_4(34)]);
        end 
    end         
            
    for iii =1:length(list60)
        for ii= list60(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(21); s2_4(41)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(22); s2_4(42)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(23); s2_4(43)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(24); s2_4(44)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(25); s2_4(45)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(26); s2_4(46)]);
            nt7(ii,:) = nanmean([s2_4(7); s2_4(27); s2_4(47)]);
            nt8(ii,:) = nanmean([s2_4(8); s2_4(28); s2_4(48)]);
            nt9(ii,:) = nanmean([s2_4(9); s2_4(29); s2_4(49)]);
            t1(ii,:) = nanmean([s2_4(10); s2_4(30); s2_4(50)]);
            t2(ii,:) = nanmean([s2_4(11); s2_4(31); s2_4(51)]);
            t3(ii,:) = nanmean([s2_4(12); s2_4(32); s2_4(52)]);
            iei(ii,:) = nanmean([s2_4(13); s2_4(33); s2_4(53)]);
            Rest(ii,:) = nanmean([s2_4(14); s2_4(34); s2_4(54)]);

            nt1_3back(ii,:) = nanmean([s2_4(1); s2_4(21); s2_4(41)]);
            nt2_3back(ii,:) = nanmean([s2_4(2); s2_4(22); s2_4(42)]);
            nt3_3back(ii,:) = nanmean([s2_4(3); s2_4(23); s2_4(43)]);
            nt4_3back(ii,:) = nanmean([s2_4(4); s2_4(24); s2_4(44)]);
            nt5_3back(ii,:) = nanmean([s2_4(5); s2_4(25); s2_4(45)]);
            nt6_3back(ii,:) = nanmean([s2_4(6); s2_4(26); s2_4(46)]);
            nt7_3back(ii,:) = nanmean([s2_4(7); s2_4(27); s2_4(47)]);
            nt8_3back(ii,:) = nanmean([s2_4(8); s2_4(28); s2_4(48)]);
            nt9_3back(ii,:) = nanmean([s2_4(9); s2_4(29); s2_4(49)]);
            t1_3back(ii,:) = nanmean([s2_4(10); s2_4(30); s2_4(50)]);
            t2_3back(ii,:) = nanmean([s2_4(11); s2_4(31); s2_4(51)]);
            t3_3back(ii,:) = nanmean([s2_4(12); s2_4(32); s2_4(52)]);
            iei_3back(ii,:) = nanmean([s2_4(13); s2_4(33); s2_4(53)]);
            Rest_3back(ii,:) = nanmean([s2_4(14); s2_4(34); s2_4(54)]);
        end 
    end         

     

    for iii =1:length(list51)
        for ii= list51(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(18); s2_4(35)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(19); s2_4(36)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(20); s2_4(37)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(21); s2_4(38)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(22); s2_4(39)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(23); s2_4(40)]);
            t1(ii,:) = nanmean([s2_4(7); s2_4(24); s2_4(41)]);
            t2(ii,:) = nanmean([s2_4(8); s2_4(25); s2_4(42)]);
            t3(ii,:) = nanmean([s2_4(9); s2_4(26); s2_4(43)]);
            iei(ii,:) = nanmean([s2_4(10); s2_4(27); s2_4(44)]);
            Rest(ii,:) = nanmean([s2_4(11); s2_4(28); s2_4(45)]);

            nt1_2back(ii,:) = nanmean([s2_4(1); s2_4(18); s2_4(35)]);
            nt2_2back(ii,:) = nanmean([s2_4(2); s2_4(19); s2_4(36)]);
            nt3_2back(ii,:) = nanmean([s2_4(3); s2_4(20); s2_4(37)]);
            nt4_2back(ii,:) = nanmean([s2_4(4); s2_4(21); s2_4(38)]);
            nt5_2back(ii,:) = nanmean([s2_4(5); s2_4(22); s2_4(39)]);
            nt6_2back(ii,:) = nanmean([s2_4(6); s2_4(23); s2_4(40)]);
            t1_2back(ii,:) = nanmean([s2_4(7); s2_4(24); s2_4(41)]);
            t2_2back(ii,:) = nanmean([s2_4(8); s2_4(25); s2_4(42)]);
            t3_2back(ii,:) = nanmean([s2_4(9); s2_4(26); s2_4(43)]);
            iei_2back(ii,:) = nanmean([s2_4(10); s2_4(27); s2_4(44)]);
            Rest_2back(ii,:) = nanmean([s2_4(11); s2_4(28); s2_4(45)]);
        end 
    end 

    for iii =1:length(list68)
        for ii= list68(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(18); s2_4(35); s2_4(52)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(19); s2_4(36); s2_4(53)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(20); s2_4(37); s2_4(54)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(21); s2_4(38); s2_4(55)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(22); s2_4(39); s2_4(56)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(23); s2_4(40); s2_4(57)]);
            t1(ii,:) = nanmean([s2_4(7); s2_4(24); s2_4(41); s2_4(58)]);
            t2(ii,:) = nanmean([s2_4(8); s2_4(25); s2_4(42); s2_4(59)]);
            t3(ii,:) = nanmean([s2_4(9); s2_4(26); s2_4(43); s2_4(60)]);
            iei(ii,:) = nanmean([s2_4(10); s2_4(27); s2_4(44); s2_4(61)]);
            Rest(ii,:) = nanmean([s2_4(11); s2_4(28); s2_4(45); s2_4(62)]);

            nt1_2back(ii,:) = nanmean([s2_4(1); s2_4(18); s2_4(35); s2_4(52)]);
            nt2_2back(ii,:) = nanmean([s2_4(2); s2_4(19); s2_4(36); s2_4(53)]);
            nt3_2back(ii,:) = nanmean([s2_4(3); s2_4(20); s2_4(37); s2_4(54)]);
            nt4_2back(ii,:) = nanmean([s2_4(4); s2_4(21); s2_4(38); s2_4(55)]);
            nt5_2back(ii,:) = nanmean([s2_4(5); s2_4(22); s2_4(39); s2_4(56)]);
            nt6_2back(ii,:) = nanmean([s2_4(6); s2_4(23); s2_4(40); s2_4(57)]);
            t1_2back(ii,:) = nanmean([s2_4(7); s2_4(24); s2_4(41); s2_4(58)]);
            t2_2back(ii,:) = nanmean([s2_4(8); s2_4(25); s2_4(42); s2_4(59)]);
            t3_2back(ii,:) = nanmean([s2_4(9); s2_4(26); s2_4(43); s2_4(60)]);
            iei_2back(ii,:) = nanmean([s2_4(10); s2_4(27); s2_4(44); s2_4(61)]);
            Rest_2back(ii,:) = nanmean([s2_4(11); s2_4(28); s2_4(45); s2_4(62)]);
        end 
    end 
    

    for iii =1:length(list80)
        for ii= list80(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(21); s2_4(41); s2_4(61)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(22); s2_4(42); s2_4(62)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(23); s2_4(43); s2_4(63)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(24); s2_4(44); s2_4(64)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(25); s2_4(45); s2_4(65)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(26); s2_4(46); s2_4(66)]);
            nt7(ii,:) = nanmean([s2_4(7); s2_4(27); s2_4(47); s2_4(67)]);
            nt8(ii,:) = nanmean([s2_4(8); s2_4(28); s2_4(48); s2_4(68)]);
            nt9(ii,:) = nanmean([s2_4(9); s2_4(29); s2_4(49); s2_4(69)]);
            t1(ii,:) = nanmean([s2_4(10); s2_4(30); s2_4(50); s2_4(70)]);
            t2(ii,:) = nanmean([s2_4(11); s2_4(31); s2_4(51); s2_4(71)]);
            t3(ii,:) = nanmean([s2_4(12); s2_4(32); s2_4(52); s2_4(72)]);
            iei(ii,:) = nanmean([s2_4(13); s2_4(33); s2_4(53); s2_4(73)]);
            Rest(ii,:) = nanmean([s2_4(14); s2_4(34); s2_4(54); s2_4(74)]);

            nt1_3back(ii,:) = nanmean([s2_4(1); s2_4(21); s2_4(41); s2_4(61)]);
            nt2_3back(ii,:) = nanmean([s2_4(2); s2_4(22); s2_4(42); s2_4(62)]);
            nt3_3back(ii,:) = nanmean([s2_4(3); s2_4(23); s2_4(43); s2_4(63)]);
            nt4_3back(ii,:) = nanmean([s2_4(4); s2_4(24); s2_4(44); s2_4(64)]);
            nt5_3back(ii,:) = nanmean([s2_4(5); s2_4(25); s2_4(45); s2_4(65)]);
            nt6_3back(ii,:) = nanmean([s2_4(6); s2_4(26); s2_4(46); s2_4(66)]);
            nt7_3back(ii,:) = nanmean([s2_4(7); s2_4(27); s2_4(47); s2_4(67)]);
            nt8_3back(ii,:) = nanmean([s2_4(8); s2_4(28); s2_4(48); s2_4(68)]);
            nt9_3back(ii,:) = nanmean([s2_4(9); s2_4(29); s2_4(49); s2_4(69)]);
            t1_3back(ii,:) = nanmean([s2_4(10); s2_4(30); s2_4(50); s2_4(70)]);
            t2_3back(ii,:) = nanmean([s2_4(11); s2_4(31); s2_4(51); s2_4(71)]);
            t3_3back(ii,:) = nanmean([s2_4(12); s2_4(32); s2_4(52); s2_4(72)]);
            iei_3back(ii,:) = nanmean([s2_4(13); s2_4(33); s2_4(53); s2_4(73)]);
            Rest_3back(ii,:) = nanmean([s2_4(14); s2_4(34); s2_4(54); s2_4(74)]);
        end 
    end 
    color1=[0/255,0/255,0/255];
    color2=[0/255,128/255,128/255];
    color3=[105/255,105/255,105/255];
    
    %%%% BAR GRAPH - NONT - 2back
  
%     figure
% %   bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5)  nanmean(nt6) nan nan  nanmean(t1)  nanmean(t2)   nanmean(t3)  nan nan  nanmean(iei1)  nan nan  nanmean(iei2)    nan nan nanmean(Rest)])
%     
% %     f=bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5) nanmean(nt7) nanmean(nt8) nanmean(nt9)]);
% %     f=bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5) nanmean(nt6)]);
%     f=bar([nanmean(nt1_2back) nanmean(nt2_2back) nanmean(nt3_2back) nanmean(nt4_2back)  nanmean(nt5_2back) nanmean(nt6_2back)]);
%     
%     
%     fontsize = 25;
%     title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
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
%     xlabel('Trials');
% %     barnames={'1','2','3','4','5','6'};
%     barnames={'1','2','3','4','5','6'};
%     set(gca,'xticklabels',barnames);
% %     set(gca, 'XColor', 'none');
%     set(gca, 'box','off');
%     set(gcf, 'color', 'w')
%     legend({'STUDY2 2back'},'Location','northeast')
% 
% 
%     %%%% BAR GRAPH - NONT - 3back
%     figure
% %   bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5)  nanmean(nt6) nan nan  nanmean(t1)  nanmean(t2)   nanmean(t3)  nan nan  nanmean(iei1)  nan nan  nanmean(iei2)    nan nan nanmean(Rest)])
%     
%     f=bar([nanmean(nt1_3back) nanmean(nt2_3back) nanmean(nt3_3back) nanmean(nt4_3back)  nanmean(nt5_3back) nanmean(nt7_3back) nanmean(nt8_3back) nanmean(nt9_3back)]);
% %   f=bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5) nanmean(nt6)]);
%     %f=bar([nanmean(nt1_2back) nanmean(nt2_2back) nanmean(nt3_2back) nanmean(nt4_2back)  nanmean(nt5_2back) nanmean(nt6_2back)]);
%     
%     
%     fontsize = 25;
%     title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% 
%     set(f, 'FaceColor', color2)
%    
%     ax=gca;
%     ax.YMinorTick = 'off';
%     ax.TickLength = [0 0];
%     f.EdgeColor=color2;
%    
%     ax.YColor=color3;
%     ax.XColor=color3;
%    
%     xlabel('Trials');
% %     barnames={'1','2','3','4','5','6'};
%     barnames={'1','2','3','4','5','6','7','8','9'};
%     set(gca,'xticklabels',barnames);
% %     set(gca, 'XColor', 'none');
%     set(gca, 'box','off');
%     set(gcf, 'color', 'w')
%     legend({'STUDY2 3back'},'Location','northeast')
% 
% 
% %     
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     
%     
% %     %%%% BAR GRAPH - IEI, REST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     
%     figure
%     %g=bar([nanmean(iei) nanmean(Rest)]);
%     g=[(iei) (Rest)];
% %     fontsize = 25;
% %     title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% % 
% %     set(g, 'FaceColor', color2);
% %    
% %     ax=gca;
% %     ax.YMinorTick = 'off';
% %     ax.TickLength = [0 0];
% %     g.EdgeColor=color2;
% %    
% %     ax.YColor=color3;
% %     ax.XColor=color3;
% 
%      ciwithincolored(g,0.05,color2);
% 
%     fontsize = 25;
%     title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
%  
% 
% %     set(g, 'FaceColor', color2);
%    
% 
%     ax=gca;
%     ax.YMinorTick = 'off';
%     ax.TickLength = [0 0];
% %     g.EdgeColor=color2;
%    
% 
%     ax.YColor=color3;
%     ax.XColor=color3;
%     
%     
%     %xlabel('');
%     barnames={'IEI','REST'};
%     set(gca,'xticklabels',barnames);
% %     set(gca, 'XColor', 'none');
%     set(gca, 'box','off');
%     set(gcf, 'color', 'w')
%     
%     
% [h(i) p(i) ci(i,:)]= ttest(iei,Rest)      %run this part firstly
%     
% res.rois(find(h),:)    % this is to find the ROIs which shows
% %     %     significant differences between contrasted events
% 
% 
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%    figure
%    f=([(nt1) (nt2) (nt3) (nt4) (nt5) (nt6)]);
%    ciwithinnan(f,0.05,color2)
%     fontsize = 25;
%     title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
%    
%     ax=gca;
%     ax.YMinorTick = 'off';
%     ax.TickLength = [0 0];
%     
% 
%     set(gca, 'box','off');
%     set(gcf, 'color', 'w')
% 
%     %ylabel()
%     xlabel('Non-Target Trials')
% 
%     barnames={'1','2','3','4','5','6'};
%     set(gca, 'xticklabels',barnames)
%    
%     ax.YColor=color3;
%     ax.XColor=color3;




% BAR GRAPH WITH REST AS A DOTTED LINE with confidence intervals
   
%    aa = [nanmean(nt1-iei_2) nanmean(nt2-iei_2) nanmean(nt3-iei_2) nanmean(nt4-iei_2)  nanmean(nt5-iei_2)  nanmean(nt6-iei_2)];
%     figure
%     g=bar([nanmean(nt1-iei_2) nanmean(nt2-iei_2) nanmean(nt3-iei_2) nanmean(nt4-iei_2)  nanmean(nt5-iei_2)  nanmean(nt6-iei_2)]);
     
% bb = [(nt1-iei) (nt2-iei) (nt3-iei) (nt4-iei)  (nt5-iei) (nt6-iei) (nt7-iei) (nt8-iei) (nt9-iei)];

% bb = [(nt1-iei) (nt2-iei) (nt3-iei) (nt4-iei)  (nt5-iei) (nt6-iei)];
% figure
% ciwithincolored(bb,0.05,color2);
% 
%     fontsize = 25;
%     title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
%  
% 
% %     set(g, 'FaceColor', color2);
%    
% 
%     ax=gca;
%     ax.YMinorTick = 'off';
%     ax.TickLength = [0 0];
% %     g.EdgeColor=color2;
%    
% 
%     ax.YColor=color3;
%     ax.XColor=color3;
%     
% 
%     %xlabel('');
%     barnames={'T1', 'T2', 'T3', 'T4', 'T5', 'T6'};
%     set(gca,'xticklabels',barnames);
% %   set(gca, 'XColor', 'none');
%     set(gca, 'box','off');
%     set(gcf, 'color', 'w')
%     
% 
%     
% 
%     hold on
%     yline(nanmean(Rest), ':k');
% 

% BAR GRAPH WITH REST AS A DOTTED LINE with confidence intervals 2back
   
bb = [(nt1_3back) (nt2_3back) (nt3_3back) (nt4_3back)  (nt5_3back) (nt6_3back) (nt7_3back)  (nt8_3back) (nt9_3back)];
figure
ciwithincolored(bb,0.05,color2);
%bar(mean(bb))

    fontsize = 25;
    title(roi_names(i,:), 'FontSize', fontsize, 'Color', [0.5 0.5 0.5]);
 

%     set(g, 'FaceColor', color2);
   

    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
%     g.EdgeColor=color2;
   

    ax.YColor=color3;
    ax.XColor=color3;
    

    %xlabel('');
    barnames={'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9'};
    set(gca,'xticklabels',barnames);
%   set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    
    hold on
    yline(nanmean(Rest_3back), ':k');


    % BAR GRAPH WITH REST AS A DOTTED LINE with confidence intervals 3back
   
   bb = [(nt1_2back) (nt2_2back) (nt3_2back) (nt4_2back)  (nt5_2back) (nt6_2back) ];
   figure
   ciwithincolored(bb,0.05,color2);

    fontsize = 25;
    title(roi_names(i,:), 'FontSize', fontsize, 'Color', [0.5 0.5 0.5]);
 

%     set(g, 'FaceColor', color2);
   

    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
%     g.EdgeColor=color2;
   

    ax.YColor=color3;
    ax.XColor=color3;
    

    %xlabel('');
    barnames={'T1', 'T2', 'T3', 'T4', 'T5', 'T6'};
    set(gca,'xticklabels',barnames);
%   set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
    
    hold on
    yline(nanmean(Rest_2back), ':k');
end
