% it uses roi_results *FROM statsfir1

% this script creates different figures for 2-back and 3-back participants
% for each ROI

%  load roi_results_2back.mat % load 2back participants' data
%  xx=res.beta;
%  load roi_results_3back_latest26.mat % load 3back participants' data (sub01-sub04, and sub23-sub26)
%  yy=res.beta;
%  load 'roi_results_sub27tosub33.mat' %load other 3 back participants' data (sub27-sub33)
%  zz=res.beta;
% 
%  aa=[xx yy zz]; % combined ROI results for all subjects

load roi_results_2back.mat % load 2back participants' data
xx=res.beta;
load roi_results_3back.mat % load 3back participants' data (sub01-sub04, and sub23-sub26)
yy=res.beta;
aa=[xx yy];

%creating roi names to appear on the figures
roi_names=['ACC             ';'LEFT HEMISHPERE ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
    'PCC             ';'RIGHT HEMISPHERE';'A1-L            ';'A1-R            ';'TPJ-R           ';...
    'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
    'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
    'I-R             ';'Hand S1-R       '];

% % FOR PRINTING TURKISH TITLES OF ROIs
% feature('DefaultCharacterSet', 'UTF8');
% slCharacterEncoding('UTF-8')
% roi_names=['Anterior Singulat Korteks (ACC)             ';...
%     'Sol Yarıküre                                ';...
%     'Temporoparietal Kavşak (TPJ)-sol            ';...
%     'Anterior Prefrontal Korteks (APFC)-sol      ';...
%     'Precuneus -sol                              ';...
%     'Posterior Singulat Kortex (PCC)             ';...
%     'Sağ Yarıküre                                ';...
%     'İşitme Korteksi (A1)-sol                    ';...
%     'İşitme Korteksi (A1)-sağ                    ';...
%     'Temporoparietal Kavşak (TPJ)-sağ            ';...
%     'Anterior Prefrontal Korteks (APFC)-sağ      ';...
%     'Precuneus-sağ                               ';...
%     'Suplementer (Tamamlayıcı) Motor Alan (SMA)  ';...
%     'Anterior Medial Prefrontal Korteks (AMPFC)  ';...
%     'Inferior Frontal Sulkus (IFS)-sol           ';...
%     'Intraparietal Sulkus (IPS)-sol              ';...
%     'Insula (I)-sol                              ';...
%     'El Birincil Somatosensör Alanı (Hand S1)-sol';...
%     'Inferior Frontal Sulkus (IFS)-sağ           ';...
%     'Intraparietal Sulkus (IPS)-sağ              ';...
%     'Insula (I)-sağ                              ';...
%     'El Birincil Somatosensör Alanı (Hand S1)-sağ'];
char(roi_names);
    

color1=[0/255,0/255,0/255];
color2=[95/255,158/255,160/255];
color3=[255/255,99/255,71/255];


% Participants have different number of total regressors due to differences
% in session numbers. Create a list for each condition
list84 = [2]; % 2-back, 2 sessions
list126 = [5 7]; % 2-back, 3 sessions
list168 = [1 3 4 6 8 9 10 11 12 13 14 15 16 17]; % 2-back, 4 sessions

list108 = [18]; % 3-back 2 sessions
list162 = [19 20 21 22 23 26 27 28 29 30 31 32]; % 3-back, 3 sessions
list216 = [24 25]; % 3-back, 4 sessions
 

 

% 2-back event regressor numbers:
    % task: 18, iei:8, rest:10, mp:6
% 3-back event regressor numbers:
    % task: 45, iei:45, rest:45, mp:6   
    

    %%% the first 18 timepoints are choosen from 2-backs, and the first 30 time points are taken from 3-backs in this
    %%% analysis to make it comprehensive of a full episode in respective
    %%% tasks.




for i = 1:22
    f_2back=[];
    f_3back=[];
    for iii =1:length(list84) % 2back
        for ii= list84(iii)
            currmat = aa{i,ii};

            a=nanmean([currmat(1:42),currmat(43:84)],2);
            f_2back=[f_2back, a];

        end 
    end 
    

   
    for iii =1:length(list126) %2back
        for ii= list126(iii)
            currmat = aa{i,ii};

            a=nanmean([currmat(1:42),currmat(43:84),currmat(85:126)],2);
            f_2back=[f_2back, a];

        end 
    end         
            
    for iii =1:length(list168) % 2back
        for ii= list168(iii)
            currmat = aa{i,ii};
            a=nanmean([currmat(1:42),currmat(43:84),currmat(85:126),currmat(127:168)],2);
            f_2back=[f_2back, a];

        end 
    end         

    for iii =1:length(list108) % 3back
        for ii= list108(iii)
            currmat = aa{i,ii};
            a=nanmean([[currmat(1:30);currmat(31:38);currmat(39:48);currmat(49:54)],...
                [currmat(55:84);currmat(85:92);currmat(93:102);currmat(103:108)]],2); 
            f_3back=[f_3back, a];
 

        end 
    end         
 

 for iii =1:length(list162) % 3back
        for ii= list162(iii)
            currmat = aa{i,ii};
            a=nanmean([[currmat(1:30);currmat(31:38);currmat(39:48);currmat(49:54)],...
                [currmat(55:84);currmat(85:92);currmat(93:102);currmat(103:108)],...
                [currmat(109:138);currmat(139:146);currmat(147:156);currmat(157:162)]],2); 
            f_3back=[f_3back, a];
 

        end 
 end
 

 for iii =1:length(list216) %3back
        for ii= list216(iii)
            currmat = aa{i,ii};
            a=nanmean([[currmat(1:30);currmat(31:38);currmat(39:48);currmat(49:54)],...
                [currmat(55:84);currmat(85:92);currmat(93:102);currmat(103:108)],...
                [currmat(109:138);currmat(139:146);currmat(147:156);currmat(157:162)],...
                [currmat(163:192);currmat(193:200);currmat(201:210);currmat(211:216)]],2); 
            f_3back=[f_3back, a];

        end 
 end         



    fir_roi_2back{i}=f_2back;
    fir_roi_3back{i}=f_3back;

    
    

end


% for i=1:22 % plotting for 2 back participants only
% xx=nanmean(fir_roi_2back{1,i}');
% figure
% p=plot(xx(1:18),'-o','Color',color2);
% fontsize = 35;
% title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% 
% % ax.YColor=color3;
% % ax.XColor=color3;
% 
% p(1).LineWidth=2;
% 
% %set(gca, 'XColor', 'none');
% set(gca, 'box','off');
% set(gca,'linewidth',1)
% set(gcf, 'color', 'w')
% 
% %ylabel('beta değerleri')
% xlabel('time(s)')
% %set(gca, 'XAxisLocation','origin','YAxisLocation','origin')
% xticks([0 6 12])
% xticklabels({'0' '12' '24'})
% 
% % hold on
% 
% % cc=nanmean(ipekfir(:,:,i));
% % k=plot(cc,'-o','Color',color3);
% % 
% % k(1).LineWidth=2;
% % 
% % legend({'STUDY2','STUDY1'},'Location','northeast')
% 
% legend({'STUDY2 2back'},'Location','northeast')
% end


for i=1:22 % plotting for 3 back participants only

    colorx=[0/255 153/255 76/255];
    colory=[153/255 0/255 153/255];

xx=nanmean(fir_roi_3back{1,i}');
figure

plot(xx(1:30),'-o','Color',colorx);
figure
p=plot(xx(1:30),'-o','Color',colorx);
fontsize = 35;
title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);

% ax.YColor=color3;
% ax.XColor=color3;

p(1).LineWidth=2;

%set(gca, 'XColor', 'none');
set(gca, 'box','off');
set(gca,'linewidth',1)
set(gcf, 'color', 'w')

%ylabel('beta değerleri')
xlabel('time(s)')
%set(gca, 'XAxisLocation','origin','YAxisLocation','origin')
xticks([0 10 20])
xticklabels({'0' '20' '40'})

% legend({'STUDY2 3back'},'Location','northeast')

hold on

% load all_beta__roi_fir_only_numbers.mat;
load all_beta_roi_fir_epiieirest_ipek_uptodate.mat;

% ipekfir = cell2mat(all_beta(1:end,:,i));
ipekfir = cell2mat(all_beta(2:end,20:49,i));

ipekfir(find(isnan(ipekfir(:,1))),:)=[];



cc=nanmean(ipekfir);
k=plot(cc,'-o','Color',colory);

k(1).LineWidth=2;

% legend({'STUDY2','STUDY1'},'Location','northeast')

saveas(gcf, string([roi_names(i,:) '.png']))

end



% for i=1:22 % plotting for 2 and 3 back participants
% xx=nanmean(fir_roi_3back{1,i}');
% figure
% p=plot(xx(1:30),'-o','Color',color3);
% fontsize = 35;
% title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
% 
% % ax.YColor=color3;
% % ax.XColor=color3;
% 
% p(1).LineWidth=2;
% 
% %set(gca, 'XColor', 'none');
% set(gca, 'box','off');
% set(gca,'linewidth',1)
% set(gcf, 'color', 'w')
% 
% %ylabel('beta değerleri')
% xlabel('time(s)')
% %set(gca, 'XAxisLocation','origin','YAxisLocation','origin')
% xticks([0 10 20])
% xticklabels({'0' '20' '40'})
% 
% hold on
% yy=nanmean(fir_roi_2back{1,i}');
% k=plot(yy(1:18),'-o','Color',color2);
% k(1).LineWidth=2;
% 
% legend({'STUDY2 3back', 'STUDY2 2back'},'Location','northeast')




% end

