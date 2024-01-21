% this code is to grapgh the ROIs for linear_increase_nonT, and IEI1,IEI2,
% and Rest, and also to find the ROIs which show significant differences between
% the events of interest (in-task-rests and bigger-rests). 

% it uses roi_results *FROM NEWSTATS3

 load roi_result_3backonly.mat
 xx = aa; % from stats2 roi_results_04102021
 load roi_result_2backonly_till16.mat
 yy = aa;
 load roi_results_04102021_from17to22.mat
 zz = res.beta;
 load roi_results_sub23tosub33.mat
 tt = res.beta;


 aa=[xx yy zz tt];

list36 = [6]; % 2-back, 2 sessions
list42 = [1]; % 3-back, 2 sessions
list63 = [2 3 4 22 23 26 27 28 29 30 31 32]; % 3-back, 3 sessions
list54 = [9 11]; % 2-back, 3 sessions
list72 = [5 7 8 10 12 13 14 15 16 17 18 19 20 21]; % 2-back, 4 sessions
list84 = [24 25]; % 3back 4 sessions


%creating roi names to appear on the figures
roi_names=['ACC             ';'LEFT HAND       ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
    'PCC             ';'RIGHT HAND      ';'A1-L            ';'A1-R            ';'TPJ-R           ';...
    'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
    'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
    'I-R             ';'Hand S1-R       '];


for i = 1:22
    
    for iii =1:length(list36) % 2back
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

            nt1_2back(ii,:) = nanmean([s2_4(1); s2_4(19)]);
            nt2_2back(ii,:) = nanmean([s2_4(2); s2_4(20)]);
            nt3_2back(ii,:) = nanmean([s2_4(3); s2_4(21)]);
            nt4_2back(ii,:) = nanmean([s2_4(4); s2_4(22)]);
            nt5_2back(ii,:) = nanmean([s2_4(5); s2_4(23)]);
            nt6_2back(ii,:) = nanmean([s2_4(6); s2_4(24)]);
            t1_2back(ii,:) = nanmean([s2_4(7); s2_4(25)]);
            t2_2back(ii,:) = nanmean([s2_4(8); s2_4(26)]);
            t3_2back(ii,:) = nanmean([s2_4(9); s2_4(27)]);
            iei_1_2back(ii,:) = nanmean([s2_4(10); s2_4(28)]);
            iei_2_2back(ii,:) = nanmean([s2_4(11); s2_4(29)]);
            Rest_2back(ii,:) = nanmean([s2_4(12); s2_4(30)]);
        end 
    end 
    

   for iii =1:length(list72) % 2back
        for ii= list72(iii)
            s2_4 = aa{i,ii};
            nt1_2back(ii,:) = nanmean([s2_4(1); s2_4(19); s2_4(37); s2_4(55)]);
            nt2_2back(ii,:) = nanmean([s2_4(2); s2_4(20); s2_4(38); s2_4(56)]);
            nt3_2back(ii,:) = nanmean([s2_4(3); s2_4(21); s2_4(39); s2_4(57)]);
            nt4_2back(ii,:) = nanmean([s2_4(4); s2_4(22); s2_4(40); s2_4(58)]);
            nt5_2back(ii,:) = nanmean([s2_4(5); s2_4(23); s2_4(41); s2_4(59)]);
            nt6_2back(ii,:) = nanmean([s2_4(6); s2_4(24); s2_4(42); s2_4(60)]);
            t1_2back(ii,:) = nanmean([s2_4(7); s2_4(25); s2_4(43); s2_4(61)]);
            t2_2back(ii,:) = nanmean([s2_4(8); s2_4(26); s2_4(44); s2_4(62)]);
            t3_2back(ii,:) = nanmean([s2_4(9); s2_4(27); s2_4(45); s2_4(63)]);
            iei_1_2back(ii,:) = nanmean([s2_4(10); s2_4(28); s2_4(46); s2_4(64)]);
            iei_2_2back(ii,:) = nanmean([s2_4(11); s2_4(29); s2_4(47); s2_4(65)]);
            Rest_2back(ii,:) = nanmean([s2_4(12); s2_4(30); s2_4(48); s2_4(66)]);

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
    
     for iii =1:length(list54) % 2back
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

            nt1_2back(ii,:) = nanmean([s2_4(1); s2_4(19); s2_4(37)]);
            nt2_2back(ii,:) = nanmean([s2_4(2); s2_4(20); s2_4(38)]);
            nt3_2back(ii,:) = nanmean([s2_4(3); s2_4(21); s2_4(39)]);
            nt4_2back(ii,:) = nanmean([s2_4(4); s2_4(22); s2_4(40)]);
            nt5_2back(ii,:) = nanmean([s2_4(5); s2_4(23); s2_4(41)]);
            nt6_2back(ii,:) = nanmean([s2_4(6); s2_4(24); s2_4(42)]);
            t1_2back(ii,:) = nanmean([s2_4(7); s2_4(25); s2_4(43)]);
            t2_2back(ii,:) = nanmean([s2_4(8); s2_4(26); s2_4(44)]);
            t3_2back(ii,:) = nanmean([s2_4(9); s2_4(27); s2_4(45)]);
            iei_1_2back(ii,:) = nanmean([s2_4(10); s2_4(28); s2_4(46)]);
            iei_2_2back(ii,:) = nanmean([s2_4(11); s2_4(29); s2_4(47)]);
            Rest_2back(ii,:) = nanmean([s2_4(12); s2_4(30); s2_4(48)]);
        end 
    end 
            
    for iii =1:length(list63) %3back
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

            nt1_3back(ii,:) = nanmean([s2_4(1); s2_4(22); s2_4(43)]);
            nt2_3back(ii,:) = nanmean([s2_4(2); s2_4(23); s2_4(44)]);
            nt3_3back(ii,:) = nanmean([s2_4(3); s2_4(24); s2_4(45)]);
            nt4_3back(ii,:) = nanmean([s2_4(4); s2_4(25); s2_4(46)]);
            nt5_3back(ii,:) = nanmean([s2_4(5); s2_4(26); s2_4(47)]);
            nt6_3back(ii,:) = nanmean([s2_4(6); s2_4(27); s2_4(48)]);
            nt7_3back(ii,:) = nanmean([s2_4(7); s2_4(28); s2_4(49)]);
            nt8_3back(ii,:) = nanmean([s2_4(8); s2_4(29); s2_4(50)]);
            nt9_3back(ii,:) = nanmean([s2_4(9); s2_4(30); s2_4(51)]);
            t1_3back(ii,:) = nanmean([s2_4(10); s2_4(31); s2_4(52)]);
            t2_3back(ii,:) = nanmean([s2_4(11); s2_4(32); s2_4(53)]);
            t3_3back(ii,:) = nanmean([s2_4(12); s2_4(33); s2_4(54)]);
            iei_1_3back(ii,:) = nanmean([s2_4(13); s2_4(34); s2_4(55)]);
            iei_2_3back(ii,:) = nanmean([s2_4(14); s2_4(35); s2_4(56)]);
            Rest_3back(ii,:) = nanmean([s2_4(15); s2_4(36); s2_4(57)]);
        end 
    end         


    
    for iii =1:length(list84) %3back
        for ii= list84(iii)
            s2_4 = aa{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(22); s2_4(43); s2_4(64)]);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(23); s2_4(44); s2_4(65)]);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(24); s2_4(45); s2_4(66)]);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(25); s2_4(46); s2_4(67)]);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(26); s2_4(47); s2_4(68)]);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(27); s2_4(48); s2_4(69)]);
            nt7(ii,:) = nanmean([s2_4(7); s2_4(28); s2_4(49); s2_4(70)]);
            nt8(ii,:) = nanmean([s2_4(8); s2_4(29); s2_4(50); s2_4(71)]);
            nt9(ii,:) = nanmean([s2_4(9); s2_4(30); s2_4(51); s2_4(72)]);
            t1(ii,:) = nanmean([s2_4(10); s2_4(31); s2_4(52); s2_4(73)]);
            t2(ii,:) = nanmean([s2_4(11); s2_4(32); s2_4(53); s2_4(74)]);
            t3(ii,:) = nanmean([s2_4(12); s2_4(33); s2_4(54); s2_4(75)]);
            iei_1(ii,:) = nanmean([s2_4(13); s2_4(34); s2_4(55); s2_4(76)]);
            iei_2(ii,:) = nanmean([s2_4(14); s2_4(35); s2_4(56); s2_4(77)]);
            Rest(ii,:) = nanmean([s2_4(15); s2_4(36); s2_4(57); s2_4(78)]);

            nt1_3back(ii,:) = nanmean([s2_4(1); s2_4(22); s2_4(43); s2_4(64)]);
            nt2_3back(ii,:) = nanmean([s2_4(2); s2_4(23); s2_4(44); s2_4(65)]);
            nt3_3back(ii,:) = nanmean([s2_4(3); s2_4(24); s2_4(45); s2_4(66)]);
            nt4_3back(ii,:) = nanmean([s2_4(4); s2_4(25); s2_4(46); s2_4(67)]);
            nt5_3back(ii,:) = nanmean([s2_4(5); s2_4(26); s2_4(47); s2_4(68)]);
            nt6_3back(ii,:) = nanmean([s2_4(6); s2_4(27); s2_4(48); s2_4(69)]);
            nt7_3back(ii,:) = nanmean([s2_4(7); s2_4(28); s2_4(49); s2_4(70)]);
            nt8_3back(ii,:) = nanmean([s2_4(8); s2_4(29); s2_4(50); s2_4(71)]);
            nt9_3back(ii,:) = nanmean([s2_4(9); s2_4(30); s2_4(51); s2_4(72)]);
            t1_3back(ii,:) = nanmean([s2_4(10); s2_4(31); s2_4(52); s2_4(73)]);
            t2_3back(ii,:) = nanmean([s2_4(11); s2_4(32); s2_4(53); s2_4(74)]);
            t3_3back(ii,:) = nanmean([s2_4(12); s2_4(33); s2_4(54); s2_4(75)]);
            iei_1_3back(ii,:) = nanmean([s2_4(13); s2_4(34); s2_4(55); s2_4(76)]);
            iei_2_3back(ii,:) = nanmean([s2_4(14); s2_4(35); s2_4(56); s2_4(77)]);
            Rest_3back(ii,:) = nanmean([s2_4(15); s2_4(36); s2_4(57); s2_4(78)]);
        end 
    end  

    for iii =1:length(list42) %3back
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

            nt1_3back(ii,:) = nanmean([s2_4(1); s2_4(22)]);
            nt2_3back(ii,:) = nanmean([s2_4(2); s2_4(23)]);
            nt3_3back(ii,:) = nanmean([s2_4(3); s2_4(24)]);
            nt4_3back(ii,:) = nanmean([s2_4(4); s2_4(25)]);
            nt5_3back(ii,:) = nanmean([s2_4(5); s2_4(26)]);
            nt6_3back(ii,:) = nanmean([s2_4(6); s2_4(27)]);
            nt7_3back(ii,:) = nanmean([s2_4(7); s2_4(28)]);
            nt8_3back(ii,:) = nanmean([s2_4(8); s2_4(29)]);
            nt9_3back(ii,:) = nanmean([s2_4(9); s2_4(30)]);
            t1_3back(ii,:) = nanmean([s2_4(10); s2_4(31)]);
            t2_3back(ii,:) = nanmean([s2_4(11); s2_4(32)]);
            t3_3back(ii,:) = nanmean([s2_4(12); s2_4(33)]);
            iei_1_3back(ii,:) = nanmean([s2_4(13); s2_4(34)]);
            iei_2_3back(ii,:) = nanmean([s2_4(14); s2_4(35)]);
            Rest_3back(ii,:) = nanmean([s2_4(15); s2_4(36)]);
        end 
    end         
    color1=[0/255,0/255,0/255];
    color2=[95/255,158/255,160/255];
    color3=[105/255,105/255,105/255];

            nt1_3back=[nt1_3back(1:4,:); nt1_3back(22:32,:)];
            nt2_3back=[nt2_3back(1:4,:); nt2_3back(22:32,:)];
            nt3_3back=[nt3_3back(1:4,:); nt3_3back(22:32,:)];
            nt4_3back=[nt4_3back(1:4,:); nt4_3back(22:32,:)];
            nt5_3back=[nt5_3back(1:4,:); nt5_3back(22:32,:)];
            nt6_3back=[nt6_3back(1:4,:); nt6_3back(22:32,:)];
            nt7_3back=[nt7_3back(1:4,:); nt7_3back(22:32,:)];
            nt8_3back=[nt8_3back(1:4,:); nt8_3back(22:32,:)];
            nt9_3back=[nt9_3back(1:4,:); nt9_3back(22:32,:)];
            t1_3back=[t1_3back(1:4,:); t1_3back(22:32,:)];
            t2_3back=[t2_3back(1:4,:); t2_3back(22:32,:)];
            t3_3back=[t3_3back(1:4,:); t3_3back(22:32,:)];
            iei_1_3back=[iei_1_3back(1:4,:); iei_1_3back(22:32,:)];
            iei_2_3back=[iei_2_3back(1:4,:); iei_2_3back(22:32,:)];
            Rest_3back=[Rest_3back(1:4,:); Rest_3back(22:32,:)];

            nt1_2back=[nt1_2back(5:21,:)];
            nt2_2back=[nt2_2back(5:21,:)];
            nt3_2back=[nt3_2back(5:21,:)];
            nt4_2back=[nt4_2back(5:21,:)];
            nt5_2back=[nt5_2back(5:21,:)];
            nt6_2back=[nt6_2back(5:21,:)];
            t1_2back=[t1_2back(5:21,:)];
            t2_2back=[t3_2back(5:21,:)];
            t3_2back=[t3_2back(5:21,:)];
            iei_1_2back=[iei_1_2back(5:21,:)];
            iei_2_2back=[iei_2_2back(5:21,:)];
            Rest_2back=[Rest_2back(5:21,:)];

    
    
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



% 
% % BAR GRAPH WITH REST AS A DOTTED LINE with confidence intervals
%    
%    aa = [nanmean(nt1-iei_2) nanmean(nt2-iei_2) nanmean(nt3-iei_2) nanmean(nt4-iei_2)  nanmean(nt5-iei_2)  nanmean(nt6-iei_2)];
%     figure
%     g=bar([nanmean(nt1-iei_2) nanmean(nt2-iei_2) nanmean(nt3-iei_2) nanmean(nt4-iei_2)  nanmean(nt5-iei_2)  nanmean(nt6-iei_2)]);
%      
% bb = [(nt1-iei) (nt2-iei) (nt3-iei) (nt4-iei)  (nt5-iei) (nt6-iei) (nt7-iei) (nt8-iei) (nt9-iei)];
% 
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


% % BAR GRAPH WITH REST AS A DOTTED LINE with confidence intervals 2back
%    
% bb = [(nt1_3back) (nt2_3back) (nt3_3back) (nt4_3back)  (nt5_3back) (nt6_3back) (nt7_3back)  (nt8_3back) (nt9_3back)];
% figure
% ciwithincolored(bb,0.05,color2);
% 
%     fontsize = 25;
%     title(roi_names(i,:), 'FontSize', fontsize, 'Color', [0.5 0.5 0.5]);
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
%     barnames={'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9'};
%     set(gca,'xticklabels',barnames);
% %   set(gca, 'XColor', 'none');
%     set(gca, 'box','off');
%     set(gcf, 'color', 'w')
%     
%     hold on
%     yline(nanmean(Rest_3back), ':k');
% 
% 
    % BAR GRAPH WITH REST AS A DOTTED LINE with confidence intervals 3back
   
%    bb = [(nt1_2back) (nt2_2back) (nt3_2back) (nt4_2back)  (nt5_2back) (nt6_2back) ];
%    figure
%    ciwithin(bb,0.05);
% 
%     fontsize = 25;
%     title(roi_names(i,:), 'FontSize', fontsize, 'Color', [0.5 0.5 0.5]);
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
%     hold on
%     yline(nanmean(Rest_2back), ':k');

%     [h1(i),p1(i),ci1(i,:),stats1]=ttest2((iei_1), (iei_2)); %
%     [h2(i),p2(i),ci2(i,:),stats2]=ttest2((iei_2), (Rest));
%     [h3(i),p3(i),ci3(i,:),stats3]=ttest2(nanmean([(iei_2);(iei_1)]), (Rest));
% 
%     res.rois(find(h3),:)

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


%%%% combining with ipek's data for the poster %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% combining study1 (İpek's) 9 trial episodes with study2 (Ozge's) 3-back
%%% episodes

% take ipek's data %
load all_beta_norm_ipek.mat;

short_6 = cell2mat(all_beta(2:end,2:7,i));

long_9 = cell2mat(all_beta(2:end,8:16,i));

varlong_9 = cell2mat(all_beta(2:end,17:25,i));

short_6(find(isnan(short_6(:,1))),:)=[];

long_9(find(isnan(long_9(:,1))),:)=[];

varlong_9(find(isnan(varlong_9(:,1))),:)=[];



% then back to ozge's data % 
iei_mean=(iei_2_3back+iei_1_3back)/2; % take the average of interepisode interval for study 2

matrix_study1=long_9;
matrix_study2=[(nt1_3back)-iei_mean (nt2_3back)-iei_mean (nt3_3back)-iei_mean (nt4_3back)-iei_mean  (nt5_3back)-iei_mean (nt6_3back)-iei_mean (nt7_3back)-iei_mean  (nt8_3back)-iei_mean (nt9_3back)-iei_mean];

% combined_9 = [(nt1_3back-iei_mean) (study1_9_1)
%     (nt2_3back-iei_mean) (study1_9_2)
%     (nt3_3back-iei_mean) (study1_9_3)
%     (nt4_3back-iei_mean) (study1_9_4)
%     (nt5_3back-iei_mean) (study1_9_5)
%     (nt6_3back-iei_mean) (study1_9_6)
%     (nt7_3back-iei_mean) (study1_9_7)
%     (nt8_3back-iei_mean) (study1_9_8)
%     (nt9_3back-iei_mean)(study1_9_9)];

combined_9 = [mean(nt1_3back-iei_mean) mean(long_9(:,1))
    mean(nt2_3back-iei_mean) mean(long_9(:,2))
    mean(nt3_3back-iei_mean) mean(long_9(:,3))
    mean(nt4_3back-iei_mean) mean(long_9(:,4))
    mean(nt5_3back-iei_mean) mean(long_9(:,5))
    mean(nt6_3back-iei_mean) mean(long_9(:,6))
    mean(nt7_3back-iei_mean) mean(long_9(:,7))
    mean(nt8_3back-iei_mean) mean(long_9(:,8))
    mean(nt9_3back-iei_mean) mean(long_9(:,9))];

% ciwithincolored(matrix_study2,0.05,color2);
% ciwithincolored(matrix_study1,0.05,color2);


%setting plot parameters
xlab={'1','2','3','4','5','6','7','8','9'}; 
figure

b=bar(combined_9, 'grouped');
title(roi_names(i,:), 'FontSize', 50, 'Color', color1);
xlabel('Trials in an Episode');
set(gca,'xticklabel',xlab)



ylabel('Beta Values'); 
%set(b, {'DisplayName'}, {'Concurrent WM Load:2','Concurrent WM Load:3'}');

b(1).FaceColor = [.2 .6 .5]; %bar colour 1
b(2).FaceColor = [.5, 0.75, 0.75]; %bar colour 2

set(gca, 'box','off');
set(gcf, 'color', 'w')
grid off
% ylim([-2,2]); %plot height


% confidence intervals for matrix1 (study1)
matrix=matrix_study1;
alpha=0.05;
color1 = '#E4D00A';
color2 = [0.2 0.2 0.2];


c=size(matrix,2);
new_matrix=matrix-(mean(matrix,2));
new_matrix=new_matrix+mean(mean(matrix,2));
n = size(new_matrix,1); 
tcrit2 = tinv(1-alpha/2,n-1); 
normalized_mean = mean(new_matrix);
normalized_SD = std(new_matrix);
 
CILower_m=[];
CIHigher_m=[];
 
for v=1:c
CILower_m =  [CILower_m, normalized_mean(v)-(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))]; 
CIHigher_m =  [CIHigher_m, normalized_mean(v)+(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))];  
end
 
CIdist_Lower_m_matrix1 = abs(mean(new_matrix)-CILower_m);
CIdist_Higher_m_matrix1 = abs(mean(new_matrix)-CIHigher_m);
 


% confidence intervals for matrix2 (study2)

matrix=matrix_study2;
alpha=0.05;
color1 = '#E4D00A';
color2 = [0.2 0.2 0.2];


c=size(matrix,2);
new_matrix=matrix-(mean(matrix,2));
new_matrix=new_matrix+mean(mean(matrix,2));
n = size(new_matrix,1); 
tcrit2 = tinv(1-alpha/2,n-1); 
normalized_mean = mean(new_matrix);
normalized_SD = std(new_matrix);
 
CILower_m=[];
CIHigher_m=[];
 
for v=1:c
CILower_m =  [CILower_m, normalized_mean(v)-(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))]; 
CIHigher_m =  [CIHigher_m, normalized_mean(v)+(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))];  
end
 
CIdist_Lower_m_matrix2 = abs(mean(new_matrix)-CILower_m);
CIdist_Higher_m_matrix2 = abs(mean(new_matrix)-CIHigher_m);


% combining confidence intervals to plot on top of the grouped figure


CIdist_Lower_m=[];
CIdist_Higher_m=[];

for z=1:9

    CIdist_Lower_m(z,1) = CIdist_Lower_m_matrix1(z);
    CIdist_Lower_m(z,2) = CIdist_Lower_m_matrix2(z);

    CIdist_Higher_m(z,1) = CIdist_Lower_m_matrix1(z);
    CIdist_Higher_m(z,2) = CIdist_Lower_m_matrix2(z);


end


[ngroups,nbars] = size(combined_9);

b=bar(combined_9,'grouped');

hold on
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for n = 1:nbars
    x(n,:) = b(n).XEndPoints;
end
 
% Plot the errorbars on top of the original means
errorbar(x', combined_9, CIdist_Lower_m, CIdist_Higher_m,'k','linestyle','none');
er.Color = [0 0 0];

colorx=[0/255 153/255 76/255];
colory=[153/255 0/255 153/255];

b(1).FaceColor=colorx;
b(2).FaceColor=colory;

% legend({'Withheld WM Load:1','Withheld WM Load:2'});

box off
title(roi_names(i,:), 'FontSize', 30, 'Color', [0 0 0], 'FontWeight','bold','FontName','Times New Roman');
ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];

   

    ax.YColor=color3;
    ax.XColor=color3;
    


    barnames={'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9'};
    set(gca,'xticklabels',barnames);

    set(gca, 'box','off');
    set(gcf, 'color', 'w')

% saveas(gcf, string([roi_names(i,:) '9.png']))









%%% combining study1 (İpek's) 6 trial episodes with study2 (Ozge's) 2-back
%%% episodes

iei_mean=(iei_2_2back+iei_1_2back)/2; % take the average of interepisode interval for study 2





matrix_study1=short_6;
matrix_study2=[(nt1_2back)-iei_mean (nt2_2back)-iei_mean (nt3_2back)-iei_mean (nt4_2back)-iei_mean  (nt5_2back)-iei_mean (nt6_2back)-iei_mean];

%     combined_9 = [(nt1_3back-iei_mean) mean(short_6(:,1))
%     (nt2_3back-iei_mean) mean(short_6(:,1))
%     (nt3_3back-iei_mean) mean(short_6(:,1))
%     (nt4_3back-iei_mean) mean(short_6(:,1))
%     (nt5_3back-iei_mean) mean(short_6(:,1))
%     (nt6_3back-iei_mean) mean(short_6(:,1))
%     (nt7_3back-iei_mean) mean(short_6(:,1))
%     (nt8_3back-iei_mean) mean(short_6(:,1))
%     (nt9_3back-iei_mean) mean(short_6(:,1))];

combined_6 = [mean(nt1_2back-iei_mean) mean(short_6(:,1))
    mean(nt2_2back-iei_mean) mean(short_6(:,2))
    mean(nt3_2back-iei_mean) mean(short_6(:,3))
    mean(nt4_2back-iei_mean) mean(short_6(:,4))
    mean(nt5_2back-iei_mean) mean(short_6(:,5))
    mean(nt6_2back-iei_mean) mean(short_6(:,6))];

% ciwithincolored(matrix_study2,0.05,color2);
% ciwithincolored(matrix_study1,0.05,color2);


%setting plot parameters
xlab={'1','2','3','4','5','6'}; 
figure
b=bar(combined_6, 'grouped');
title(roi_names(i,:), 'FontSize', 50, 'Color', color1);
xlabel('Trials in an Episode');
set(gca,'xticklabel',xlab)


ylabel('Beta Values'); 
%set(b, {'DisplayName'}, {'Concurrent WM Load:2','Concurrent WM Load:3'}');

b(1).FaceColor = [.2 .6 .5]; %bar colour 1
b(2).FaceColor = [.5, 0.75, 0.75]; %bar colour 2

set(gca, 'box','off');
set(gcf, 'color', 'w')
grid off
ylim([-2,2]); %plot height


%confidence intervals for matrix1 (study1)
matrix=matrix_study1;
alpha=0.05;
color1 = '#E4D00A';
color2 = [0.2 0.2 0.2];


c=size(matrix,2);
new_matrix=matrix-(mean(matrix,2));
new_matrix=new_matrix+mean(mean(matrix,2));
n = size(new_matrix,1); 
tcrit2 = tinv(1-alpha/2,n-1); 
normalized_mean = mean(new_matrix);
normalized_SD = std(new_matrix);
 
CILower_m=[];
CIHigher_m=[];
 
for v=1:c
CILower_m =  [CILower_m, normalized_mean(v)-(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))]; 
CIHigher_m =  [CIHigher_m, normalized_mean(v)+(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))];  
end
 
CIdist_Lower_m_matrix1 = abs(mean(new_matrix)-CILower_m);
CIdist_Higher_m_matrix1 = abs(mean(new_matrix)-CIHigher_m);
 


%confidence intervals for matrix2 (study2)

matrix=matrix_study2;
alpha=0.05;
color1 = '#E4D00A';
color2 = [0.2 0.2 0.2];


c=size(matrix,2);
new_matrix=matrix-(mean(matrix,2));
new_matrix=new_matrix+mean(mean(matrix,2));
n = size(new_matrix,1); 
tcrit2 = tinv(1-alpha/2,n-1); 
normalized_mean = mean(new_matrix);
normalized_SD = std(new_matrix);
 
CILower_m=[];
CIHigher_m=[];
 
for v=1:c
CILower_m =  [CILower_m, normalized_mean(v)-(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))]; 
CIHigher_m =  [CIHigher_m, normalized_mean(v)+(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))];  
end
 
CIdist_Lower_m_matrix2 = abs(mean(new_matrix)-CILower_m);
CIdist_Higher_m_matrix2 = abs(mean(new_matrix)-CIHigher_m);


%combining confidence intervals to plot on top of the grouped figure

CIdist_Lower_m=[];
CIdist_Higher_m=[];

for z=1:6

    CIdist_Lower_m(z,1) = CIdist_Lower_m_matrix1(z);
    CIdist_Lower_m(z,2) = CIdist_Lower_m_matrix2(z);

    CIdist_Higher_m(z,1) = CIdist_Lower_m_matrix1(z);
    CIdist_Higher_m(z,2) = CIdist_Lower_m_matrix2(z);


end


[ngroups,nbars] = size(combined_6);

b=bar(combined_6,'grouped');

hold on
%Get the x coordinate of the bars
l = nan(nbars, ngroups);
for p = 1:nbars
    l(p,:) = b(p).XEndPoints;
end


%Plot the errorbars on top of the original means
errorbar(l', combined_6, CIdist_Lower_m, CIdist_Higher_m,'k','linestyle','none');
er.Color = [0 0 0];

colorx=[76/255 153/255 0/255];
colory=[153/255 0/255 76/255];

b(1).FaceColor=colorx;
b(2).FaceColor=colory;

%legend({'Withheld WM Load:1','Withheld WM Load:2'});

box off
title(roi_names(i,:), 'FontSize', 30, 'Color', [0 0 0], 'FontWeight','bold','FontName','Times New Roman');
ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];

   

    ax.YColor=color3;
    ax.XColor=color3;
    


    barnames={'T1', 'T2', 'T3', 'T4', 'T5', 'T6'};
    set(gca,'xticklabels',barnames);

    set(gca, 'box','off');
    set(gcf, 'color', 'w')

hold off

% saveas(gcf, string([roi_names(i,:) '6.png']))















%%%% Ipek's 9 trial, vari 9 trials and Ozge's 9 trials

% then back to ozge's data % 
iei_mean=(iei_2_3back+iei_1_3back)/2; % take the average of interepisode interval for study 2

matrix_study1=long_9;
matrix_study2=[(nt1_3back)-iei_mean (nt2_3back)-iei_mean (nt3_3back)-iei_mean (nt4_3back)-iei_mean  (nt5_3back)-iei_mean (nt6_3back)-iei_mean (nt7_3back)-iei_mean  (nt8_3back)-iei_mean (nt9_3back)-iei_mean];
matrix_study3=varlong_9;
% combined_9 = [(nt1_3back-iei_mean) (study1_9_1)
%     (nt2_3back-iei_mean) (study1_9_2)
%     (nt3_3back-iei_mean) (study1_9_3)
%     (nt4_3back-iei_mean) (study1_9_4)
%     (nt5_3back-iei_mean) (study1_9_5)
%     (nt6_3back-iei_mean) (study1_9_6)
%     (nt7_3back-iei_mean) (study1_9_7)
%     (nt8_3back-iei_mean) (study1_9_8)
%     (nt9_3back-iei_mean)(study1_9_9)];

combined_var9 = [mean(nt1_3back-iei_mean) mean(long_9(:,1))  mean(varlong_9(:,1))
    mean(nt2_3back-iei_mean) mean(long_9(:,2)) mean(varlong_9(:,2))
    mean(nt3_3back-iei_mean) mean(long_9(:,3)) mean(varlong_9(:,3))
    mean(nt4_3back-iei_mean) mean(long_9(:,4)) mean(varlong_9(:,4))
    mean(nt5_3back-iei_mean) mean(long_9(:,5)) mean(varlong_9(:,5))
    mean(nt6_3back-iei_mean) mean(long_9(:,6)) mean(varlong_9(:,6))
    mean(nt7_3back-iei_mean) mean(long_9(:,7)) mean(varlong_9(:,7))
    mean(nt8_3back-iei_mean) mean(long_9(:,8)) mean(varlong_9(:,8))
    mean(nt9_3back-iei_mean) mean(long_9(:,9)) mean(varlong_9(:,9))];

% ciwithincolored(matrix_study2,0.05,color2);
% ciwithincolored(matrix_study1,0.05,color2);


%setting plot parameters
xlab={'1','2','3','4','5','6','7','8','9'}; 
figure

b=bar(combined_9, 'grouped');
title(roi_names(i,:), 'FontSize', 50, 'Color', color1);
xlabel('Trials in an Episode');
set(gca,'xticklabel',xlab)



ylabel('Beta Values'); 
%set(b, {'DisplayName'}, {'Concurrent WM Load:2','Concurrent WM Load:3'}');

% b(1).FaceColor = [.2 .6 .5]; %bar colour 1
% b(2).FaceColor = [.5, 0.75, 0.75]; %bar colour 2


set(gca, 'box','off');
set(gcf, 'color', 'w')
grid off
% ylim([-2,2]); %plot height


% confidence intervals for matrix1 (study1)
matrix=matrix_study1;
alpha=0.05;
color1 = '#E4D00A';
color2 = [0.2 0.2 0.2];


c=size(matrix,2);
new_matrix=matrix-(mean(matrix,2));
new_matrix=new_matrix+mean(mean(matrix,2));
n = size(new_matrix,1); 
tcrit2 = tinv(1-alpha/2,n-1); 
normalized_mean = mean(new_matrix);
normalized_SD = std(new_matrix);
 
CILower_m=[];
CIHigher_m=[];
 
for v=1:c
CILower_m =  [CILower_m, normalized_mean(v)-(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))]; 
CIHigher_m =  [CIHigher_m, normalized_mean(v)+(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))];  
end
 
CIdist_Lower_m_matrix1 = abs(mean(new_matrix)-CILower_m);
CIdist_Higher_m_matrix1 = abs(mean(new_matrix)-CIHigher_m);
 


% confidence intervals for matrix2 (study2)

matrix=matrix_study2;
alpha=0.05;
color1 = '#E4D00A';
color2 = [0.2 0.2 0.2];


c=size(matrix,2);
new_matrix=matrix-(mean(matrix,2));
new_matrix=new_matrix+mean(mean(matrix,2));
n = size(new_matrix,1); 
tcrit2 = tinv(1-alpha/2,n-1); 
normalized_mean = mean(new_matrix);
normalized_SD = std(new_matrix);
 
CILower_m=[];
CIHigher_m=[];
 
for v=1:c
CILower_m =  [CILower_m, normalized_mean(v)-(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))]; 
CIHigher_m =  [CIHigher_m, normalized_mean(v)+(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))];  
end
 
CIdist_Lower_m_matrix2 = abs(mean(new_matrix)-CILower_m);
CIdist_Higher_m_matrix2 = abs(mean(new_matrix)-CIHigher_m);



% confidence intervals for matrix3 (varlong from study2)

matrix=matrix_study3;
alpha=0.05;
color1 = '#E4D00A';
color2 = [0.2 0.2 0.2];


c=size(matrix,2);
new_matrix=matrix-(mean(matrix,2));
new_matrix=new_matrix+mean(mean(matrix,2));
n = size(new_matrix,1); 
tcrit2 = tinv(1-alpha/2,n-1); 
normalized_mean = mean(new_matrix);
normalized_SD = std(new_matrix);
 
CILower_m=[];
CIHigher_m=[];
 
for v=1:c
CILower_m =  [CILower_m, normalized_mean(v)-(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))]; 
CIHigher_m =  [CIHigher_m, normalized_mean(v)+(tcrit2.*(normalized_SD(v)./sqrt(n)).*(sqrt(c/(c-1))))];  
end
 
CIdist_Lower_m_matrix3 = abs(mean(new_matrix)-CILower_m);
CIdist_Higher_m_matrix3 = abs(mean(new_matrix)-CIHigher_m);



% combining confidence intervals to plot on top of the grouped figure

for z=1:9

    CIdist_Lower_m(z,1) = CIdist_Lower_m_matrix1(z);
    CIdist_Lower_m(z,2) = CIdist_Lower_m_matrix2(z);
    CIdist_Lower_m(z,3) = CIdist_Lower_m_matrix3(z);

    CIdist_Higher_m(z,1) = CIdist_Lower_m_matrix1(z);
    CIdist_Higher_m(z,2) = CIdist_Lower_m_matrix2(z);
    CIdist_Higher_m(z,3) = CIdist_Lower_m_matrix3(z);


end


[ngroups,nbars] = size(combined_var9);

b=bar(combined_var9,'grouped');

hold on
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for n = 1:nbars
    x(n,:) = b(n).XEndPoints;
end
 
% Plot the errorbars on top of the original means
errorbar(x', combined_var9, CIdist_Lower_m, CIdist_Higher_m,'k','linestyle','none');
er.Color = [0 0 0];

colorx=[0/255 153/255 76/255];
colory=[153/255 0/255 153/255];
colorz=[0/255 102/255 102/255];

b(1).FaceColor=colorx;
b(2).FaceColor=colory;
b(3).FaceColor=colorz;

% legend({'Withheld WM Load:1','Withheld WM Load:2'});

box off
title(roi_names(i,:), 'FontSize', 30, 'Color', [0 0 0], 'FontWeight','bold','FontName','Times New Roman');
ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];

   

    ax.YColor=color3;
    ax.XColor=color3;
    


    barnames={'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9'};
    set(gca,'xticklabels',barnames);

    set(gca, 'box','off');
    set(gcf, 'color', 'w')

% saveas(gcf, string([roi_names(i,:) 'var9.png']))


end


