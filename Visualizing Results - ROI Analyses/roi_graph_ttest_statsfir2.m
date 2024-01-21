% it uses roi_results.mat *FROM statsfir2

 load roi_results_2back.mat
 xx = res.beta;
 load roi_results_3back.mat
 yy = res.beta;

 aa=[xx yy];

%creating roi names to appear on the figures
roi_names=['ACC             ';'LEFT HAND       ';'TPJ-L           ';'APFC-L          ';'PRECUNEUS-L     ';...
    'PCC             ';'RIGHT HAND      ';'A1-L            ';'A1-R            ';'TPJ-R           ';...
    'APFC-R          ';'PRECUNEUS-R     ';'SMA             ';'AMPFC           ';'IFS-L           ';...
    'IPS-L           ';'I-L             ';'Hand S1-L       ';'IFS-R           ';'IPS-R           ';...
    'I-R             ';'Hand S1-R       '];

    color1=[0/255,0/255,0/255];
    color2=[95/255,158/255,160/255];
    color3=[105/255,105/255,105/255];


list192 = [2]; % 2-back, 2 sessions
list288_2 = [5 7]; % 2-back, 3 sessions
list384 = [1 3 4 6 8 9 10 11 12 13 14 15 16 17]; % 2-back, 4 sessions

%list232 = [1]; % 3-back, 2 sessions
%list348 = [2 3 4]; % 3-back, 3 sessions
list288_3 =[18]; % 3 back 2 sessions
list432 =[19 20 21 22 23 26 27 28 29 30 31 32]; % 3 back 3 sessions
list576 =[24 25]; % 3 back 4 sessions

for i = 1:22
    f=[];
    f_2back=[];
    f_3back=[];
    for iii =1:length(list192) % 2 back
        for ii= list192(iii)
            s2_4 = aa{i,ii};

            a=nanmean([s2_4(1:96),s2_4(97:192)],2);
            f=[f, a];
            f_2back=[f_2back, a];

        end 
    end 
    

   
    for iii =1:length(list288_2) % 2 back
        for ii= list288_2(iii)
            s2_4 = aa{i,ii};

            a=nanmean([s2_4(1:96),s2_4(97:192),s2_4(193:288)],2);
            f=[f,a];
            f_2back=[f_2back, a];

        end 
    end         
          


    for iii =1:length(list384) % 2 back
        for ii= list384(iii)
            s2_4 = aa{i,ii};
            a=nanmean([s2_4(1:96),s2_4(97:192),s2_4(193:288),s2_4(289:384)],2);
            f=[f,a];
            f_2back=[f_2back, a];

        end 
    end         

   

    for iii =1:length(list288_3) % 3-backs, only first 18 tpoints are taken for task events for f
        for ii= list288_3(iii)
            s2_4 = aa{i,ii};
            xx=nanmean([s2_4(1:144),s2_4(145:288)],2);
            a=[xx(1:18);xx(31:48);xx(61:78);xx(91:108);xx(121:128);xx(129:138);xx(139:144)];
            b=[xx(1:30);xx(31:60);xx(61:90);xx(91:120)];
            f=[f,a];
            f_3back=[f_3back, b];

        end 
    end       



    for iii =1:length(list432) % 3-backs, only first 18 tpoints are taken for task events for f
        for ii= list432(iii)
            s2_4 = aa{i,ii};
             xx=nanmean([s2_4(1:144),s2_4(145:288),s2_4(289:432)],2);
            a=[xx(1:18);xx(31:48);xx(61:78);xx(91:108);xx(121:128);xx(129:138);xx(139:144)];
            b=[xx(1:30);xx(31:60);xx(61:90);xx(91:120)];
            f=[f,a];
            f_3back=[f_3back, b];

        end 
    end       

    for iii =1:length(list576) % 3-backs, only first 18 tpoints are taken for task events for f
        for ii= list576(iii)
            s2_4 = aa{i,ii};
             xx=nanmean([s2_4(1:144),s2_4(145:288),s2_4(289:432),s2_4(433:576)],2);
            a=[xx(1:18);xx(31:48);xx(61:78);xx(91:108);xx(121:128);xx(129:138);xx(139:144)];
            b=[xx(1:30);xx(31:60);xx(61:90);xx(91:120)];
            f=[f,a];
            f_3back=[f_3back, b];

        end 
    end       

    fir_roi{i}=f;
    fir_roi_2back{i}=f_2back;
    fir_roi_3back{i}=f_3back;
    

end


for i=1:22

xx=nanmean(fir_roi{1,i}');
fontsize = 25;

figure
p0=plot(xx(1:18));
title(roi_names(i,:), 'FontSize', fontsize, 'Color',color1);
hold on
p1=plot(xx(19:36));
hold on
p2=plot(xx(37:54));
hold on
p3=plot(xx(55:72));
fontsize = 25;


h=[p0;p1;p2;p3];
legend(h,'Taskw0T','Taskw1T','Taskw2T','Taskw3T')
end

for i=1:22

xx=nanmean(fir_roi_2back{1,i}');
fontsize = 25;

figure
p0=plot(xx(1:18));
title(roi_names(i,:), 'FontSize', fontsize, 'Color',color2);
hold on
% p1=plot(xx(19:36));
% hold on
% p2=plot(xx(37:54));
% hold on
p3=plot(xx(55:72));
fontsize = 25;


% h=[p0;p1;p2;p3];
h=[p0;p3];
% legend(h,'Taskw0T 2back','Taskw1T 2back','Taskw2T 2back','Taskw3T 2back')
legend(h,'Taskw0T 3back','Taskw3T 3back')
end

for i=1:22

xx=nanmean(fir_roi_3back{1,i}');
fontsize = 25;

figure
p0=plot(xx(1:30));
title(roi_names(i,:), 'FontSize', fontsize, 'Color',color3);
hold on
% p1=plot(xx(31:60));
% hold on
% p2=plot(xx(61:90));
% hold on
p3=plot(xx(91:120));
fontsize = 25;


% h=[p0;p1;p2;p3];
h=[p0;p3];
legend(h,'Taskw0T 3back','Taskw3T 3back')
end


