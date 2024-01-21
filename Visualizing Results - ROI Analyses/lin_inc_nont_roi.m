% this code is to find the ROIs which show lin_inc_nont from trials 1 to 6
% in Ozge's data, without any significance testing, just visualizing the
% trend.

% it uses roi_results.mat from Irem's stats2

% load roi_results_2.mat
% xx = res.beta;
% load roi_results.mat
% res.beta(:,5:6)=xx;

%creating roi names to appear on the figures
% roi_names=['ACC             ';'LEFT HEMISPHERE ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
%     'PCC             ';'RIGHT HEMISPHERE';'A1-L            ';'A1-R            ';'TPJ-R           ';...
%     'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
%     'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
%     'I-R             ';'Hand S1-R       '];

feature('DefaultCharacterSet', 'UTF8');
slCharacterEncoding('UTF-8')
roi_names=['Anterior Singulat Korteks (ACC)             ';...
    'SOL YARIKURE                                ';...
    'Temporoparietal Kav?ak (TPJ)-sol            ';...
    'Anterior Prefrontal Korteks (APFC)-sol      ';...
    'Precuneus -sol                              ';...
    'Posterior Singulat Kortex (PCC)             ';...
    'SAG YARIKURE                                ';...
    '??itme Korteksi (A1)-sol                    ';...
    '??itme Korteksi (A1)-sag                    ';...
    'Temporoparietal Kav?ak (TPJ)-sag            ';...
    'Anterior Prefrontal Korteks (APFC)-sag      ';...
    'Precuneus-sag                               ';...
    'Suplementer (Tamamlay?c?) Motor Alan (SMA)  ';...
    'Anterior Medial Prefrontal Korteks (AMPFC)  ';...
    'Inferior Frontal Sulkus (IFS)-sol           ';...
    'Intraparietal Sulkus (IPS)-sol              ';...
    'Insula (I)-sol                              ';...
    'El Birincil Somatosensör Alan? (Hand S1)-sol';...
    'Inferior Frontal Sulkus (IFS)-sag           ';...
    'Intraparietal Sulkus (IPS)-sag              ';...
    'Insula (I)-sag                              ';...
    'El Birincil Somatosensör Alan? (Hand S1)-sag'];
char(roi_names);
 

%load('roi_results.mat'); % from stats2_irem

list36 = [1 6];
list54 = [2 3 4 9 11 ];
list72 = [5 7 8 10 12 13 14 15];

for i = 1:22
 
    for iii =1:length(list36)
        for ii= list36(iii)
            s2_4 = res.beta{i,ii};
            nt1(ii,:) = nanmean([s2_4(1); s2_4(19)']);
            nt2(ii,:) = nanmean([s2_4(2); s2_4(20)']);
            nt3(ii,:) = nanmean([s2_4(3); s2_4(21)']);
            nt4(ii,:) = nanmean([s2_4(4); s2_4(22)']);
            nt5(ii,:) = nanmean([s2_4(5); s2_4(23)']);
            nt6(ii,:) = nanmean([s2_4(6); s2_4(24)']);
            t1(ii,:) = nanmean([s2_4(7); s2_4(25)']);
            t2(ii,:) = nanmean([s2_4(8); s2_4(26)']);
            t3(ii,:) = nanmean([s2_4(9); s2_4(27)']);
            iei1(ii,:) = nanmean([s2_4(10); s2_4(28)']);
            iei2(ii,:) = nanmean([s2_4(11); s2_4(29)']);
            R(ii,:) = nanmean([s2_4(12); s2_4(30)']);
        end 
    end 
            
    for iii =1:length(list54)
        for ii= list54(iii)
            s2_4 = res.beta{i,ii};
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
            R(ii,:) = nanmean([s2_4(12); s2_4(30);s2_4(48)]);
        end 
    end         
            
    
     for iii =1:length(list72)
        for ii= list72(iii)
            s2_4 = res.beta{i,ii};
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
            R(ii,:) = nanmean([s2_4(12); s2_4(30);s2_4(48);s2_4(66)]);
        end 
    end         
           
    
    color1=[0/255,0/255,0/255]
    color2=[246/255,190/255,0/255]  
    color3=[105/255,105/255,105/255]
    
    figure
    f = bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5)  nanmean(nt6)], 0.6);
%    bar([nanmean(nt1) nanmean(nt2) nanmean(nt3) nanmean(nt4)  nanmean(nt5)  nanmean(nt6) nan nan  nanmean(t1)  nanmean(t2)   nanmean(t3)  nan nan  nanmean(iei1)  nan nan  nanmean(iei2)    nan nan nanmean(R)])
   % title(res.rois(i,1:10))                    % run these three secondly
    fontsize = 25;
    title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
 %  [h(i) p(i) ci(i,:)]= ttest(iei1,R)      %run this part firstly
    
    set(f, 'FaceColor', color2);
   
    ax=gca;
    ax.YMinorTick = 'off';
    ax.TickLength = [0 0];
    f.EdgeColor=color2
   
    ax.YColor=color3
   
    xlabel('trials');
    set(gca, 'XColor', 'none');
    set(gca, 'box','off');
    set(gcf, 'color', 'w')
 %  res.rois(find(h),:)    % this is to find the ROIs which shows
%     significant differences between contrasted events, run this part
%     thirdly

end

