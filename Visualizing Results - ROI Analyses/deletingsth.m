% rootdir= 'C:\Users\ausaf\Documents\OZGE_STUDY2\stats3';
% subs = dir(fullfile(rootdir,'sub*'));
% subs = deblank(char(subs.name));
% subs = cellstr(deblank(subs));
% 
% ntot = length(subs);
%  for i=1:ntot
%      csub = subs{i};
%      a = dir(fullfile(rootdir, csub, '\con_000*'));
% %      a=a.name;
%      a = deblank(char(a.name));
%      a = cellstr(deblank(a));
%      fprintf(1, 'Now deleting %s\n', csub);
%       for j=1:size(a,1)
%           a{j,:} = deblank(char(a{j,:}));
%           b = dir(fullfile(rootdir, csub, a{j,:}));
%           fprintf(1, 'Now deleting %s\n', b.name);
%           delete(b.name)
%       end
%  end
% 
%  


