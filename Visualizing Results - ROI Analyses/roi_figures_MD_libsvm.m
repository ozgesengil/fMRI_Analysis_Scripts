
clear all

load('libsvm_accuracy_MVPA4_MD_AT1pic-ATpic2.mat')


compmat=accuracy_roi-50;

for i=1:16 % for all ROIs

[h(i,:),p(i,:),c(:,i)]=ttest(compmat(:,i));

end


% calculate the distance of the confidence interval from the roi means

negdist=abs(c(1,:)-mean(compmat));
posdist=abs(c(1,:)-mean(compmat));

xlab={'L-AI','L-aMFG','L-FEF','L-IPS','L-mMFG', 'L-pMFG', 'L-preSMA'...
        'R-AI','R-aMFG.', 'R-FEF','R-IPS','R-MFG', 'R-pMFG', 'R-preSMA',...
        'rL-ESV', 'rR-ESV'}; 
%x=[1:16];

figure
b=bar(mean(compmat));
xticks([1:16])
hold on

%Plot the errorbars on top of the original means
errorbar([1:16], mean(compmat), negdist, posdist,'k','linestyle','none');
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
b.CData(15,:)=colory;
b.CData(16,:)=colory;


box off

ax=gca;
    ax.YMinorTick = 'off';
    %ax.TickLength = [0 0];


xlabel('FP ROIs','FontSize',20);
set(gca,'xticklabel',xlab,'FontWeight','normal','FontName','Times New Roman')

xtickangle(90)

hold off