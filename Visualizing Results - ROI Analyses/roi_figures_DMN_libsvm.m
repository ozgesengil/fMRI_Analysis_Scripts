%load('accuracy_MDroi_MVPA1_old_N24.mat')
load('libsvm_accuracy_2backonly_DMN_0T6-1T6.mat')


compmat=accuracy_roi-50;

for i=1:20 % for all ROIs

[h(i,:),p(i,:),c(:,i)]=ttest(compmat(:,i));

end


% calculate the distance of the confidence interval from the roi means

negdist=abs(c(1,:)-mean(compmat));
posdist=abs(c(1,:)-mean(compmat));

xlab={'R-TPJ', 'R-TempP', 'R-Rsp', 'R-pIPL', 'R-PHC', 'R-PCC','R-LTC', 'R-HF', 'R-aMPFC',...
        'L-TPJ', 'L-TempP', 'L-Rsp', 'L-pIPL', 'L-PHC', 'L-PCC','L-LTC', 'L-HF', 'L-aMPFC',...
        'vMPFC', 'dMPFC'};
%x=[1:16];

figure
b=bar(mean(compmat));
xticks([1:20])
hold on

%Plot the errorbars on top of the original means
errorbar([1:20], mean(compmat), negdist, posdist,'k','linestyle','none');
er.Color = [0 0 0];

colorx=[0/255 153/255 76/255];
colory=[153/255 0/255 153/255];

b.FaceColor='flat';

b.CData(1,:)=colorx;
b.CData(2,:)=colorx;
b.CData(3,:)=colorx;
b.CData(4,:)=colorx;
b.CData(5,:)=colorx;
b.CData(6,:)=colorx;
b.CData(7,:)=colorx;
b.CData(8,:)=colorx;
b.CData(9,:)=colorx;
b.CData(10,:)=colorx;
b.CData(11,:)=colorx;
b.CData(12,:)=colorx;
b.CData(13,:)=colorx;
b.CData(14,:)=colorx;
b.CData(15,:)=colorx;
b.CData(16,:)=colorx;
b.CData(17,:)=colorx;
b.CData(18,:)=colorx;
b.CData(19,:)=colorx;
b.CData(20,:)=colorx;




box off

ax=gca;
    ax.YMinorTick = 'off';
    %ax.TickLength = [0 0];


xlabel('DMN ROIs','FontSize',20);
set(gca,'xticklabel',xlab,'FontWeight','normal','FontName','Times New Roman')

xtickangle(90)

hold off
