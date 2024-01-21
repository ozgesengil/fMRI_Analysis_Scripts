function result = ciwithin(matrix,alpha,color1)

  %%%% inputs %%%%

%matrix should be output matrix of interest with columns for
%within subject events/variables and rows of participant's means (for one
%way comparison with multiple levels)

% alpha = alpha value for ci intervals
  
  %%%%        %%%%
  
  
% matrix=EPRT_1vs2;
% alpha=0.05;
% color1 = '#E4D00A';
% color2 = [0.2 0.2 0.2];


c=size(matrix,2);

%remove between subject variances by simply substracting each participant's
%mean from each of the conditions. This will balance out each participant's
%data around 0.
new_matrix=matrix-(mean(matrix,2));

%These RTs/errors no longer makes sense because negatives exist. To make
%the data appropriate for the conditions, simply add the grand mean to all
%the normalised means. (original means - participant means + grand mean)
new_matrix=new_matrix+mean(mean(matrix,2));



%after that notice that the patterns in the last two operations are the same, 
%but the reaction times are now in a normal range for the conditions 
%(i.e. we have removed the between-participant variance, but the normalised 
%means are the same as the original means).
 

% calculate within-participant confidence intervals, but we need to make one
% change to the original formula (this is the Morey part of the 
% Cousineau-Morey method).where c is the number of within-participant 
% conditions. In our 2Ã—2 example, there are four conditions. Evaluating 
% sqrt(4 / (4-1)) gives us 1.15, so this correction factor is going to make
% the confidence intervals slightly larger. Note that the largest increase 
% in the confidence intervals would be with 2 within-participant conditions
% [sqrt(2 / (2-1)) = 1.41] and that this correction decreases with more 
% conditions. use the normalized data mean and SD 
 

% CI = Mean +/- t(1-alpha/2, n-1) * (SD / sqrt(n)) * sqrt(c / (c-1))
 

%to claculate critical t value: (you need to download CritT function)
n = size(new_matrix,1); 
tcrit2 = tinv(1-alpha/2,n-1); 
%tcrit1 = tinv(1-alpha,n-1); 
 

% c=number of within participant conditions


%find normalized means and SDs
normalized_mean = mean(new_matrix);
normalized_SD = std(new_matrix);
 
CILower_m=[];
CIHigher_m=[];
 

for i=1:c
CILower_m =  [CILower_m, normalized_mean(i)-(tcrit2.*(normalized_SD(i)./sqrt(n)).*(sqrt(c/(c-1))))]; 
CIHigher_m =  [CIHigher_m, normalized_mean(i)+(tcrit2.*(normalized_SD(i)./sqrt(n)).*(sqrt(c/(c-1))))];  
end
 

CIdist_Lower_m = abs(mean(new_matrix)-CILower_m);
CIdist_Higher_m = abs(mean(new_matrix)-CIHigher_m);
 

[nbars, ngroups] = size(mean(new_matrix));

b=bar(mean(new_matrix));

hold on
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
 


% Plot the errorbars on top of the original means
errorbar(x', mean(new_matrix), CIdist_Lower_m, CIdist_Higher_m,'k','linestyle','none');
er.Color = [0 0 0];
b.FaceColor=color1;
 
hold off
end