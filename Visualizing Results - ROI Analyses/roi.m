clear

%make sure marsbar is on matlab path
mbd = fullfile(spm('dir'),'toolbox','marsbar');
if exist(mbd)==7; addpath(mbd); end

%addpath /imaging/local/software/spm_toolbox/marsbar/marsbar_v0.44

% Set paths etc ***********************************************************

rootdir = 'G:\OZGE_STUDY2\stats4';   %main analysis directory
roidir = 'G:\OZGE_STUDY2\ROI';%'/imaging/aa02/TM3/AA/ROIS';% directory containing roi.mat files
resdir = 'G:\OZGE_STUDY2\stats4\roi_results';
if exist(resdir)~=7;mkdir(resdir);end


roi_summary_function = 'mean'; % what function marsbar uses to summarise
%roi data over voxels. options= 'mean', 'median', 'eig1', 'wtmean'


subfilt = 'sub*';
modeldur=1;
%max_ev_cols = 30;
nsess=1;

% results structure
res = struct('roi','','subs','','beta',[],...
    'percent',[],'dims','roi, sub, event');

% names of output files. The script will save the res structure to a matlab
% mat file, and also write the results to tab delimited text files (these
% are useful for reading into Excel etc.
resmat = fullfile(resdir,'roi_results.mat');
restxtb = fullfile(resdir,'roi_betas.txt');
restxtp = fullfile(resdir,'roi_percent.txt');






% Get subs ****************************************************************
%(find all individual subject directories within the root directory)
% subs = dir(fullfile(rootdir,subfilt));
% subs = cellstr(deblank(char(subs.name)));

subs = {'sub01','sub02','sub03','sub04','sub06','sub07','sub08','sub09','sub10','sub11','sub12','sub13','sub14','sub15','sub16','sub17','sub18','sub19','sub20','sub21','sub22','sub23','sub24','sub25','sub26','sub27','sub28','sub29','sub30','sub31','sub32','sub33'};
%subs = {'sub01','sub02','sub03','sub04'};
subs = char(subs);
subs = cellstr(deblank(subs));

% % subs = {'170311','170316','170319','170320','170322','170325','170330','170333'};
% subs = {'170375'};
% exsubs = {'sub05'};%any subjects you want to exclude from the analysis

% for s = 1:length(exsubs)
%     exi = strfind(subs,exsubs{s});
%     exi = char(exi{:})==' ';
%     subs = subs(exi==1);
% end
nsubs = length(subs);







% Get ROIs ****************************************************************
%find all roi.mat files in the roi directory
rois = spm_select('List',roidir,'roi.mat$');
nrois = size(rois,1);
roi_short = rois;
res.rois = rois;
rois = [repmat([roidir filesep],nrois,1) rois];

for i = 1:nrois
    nom = roi_short(i,:);
    nom = deblank(nom);
    l = length(nom);
    nom = nom(1:4);
    roishort{i}=nom;
end
% try
%     load(resmat)
% catch
for s=1:nsubs
    clear SPM f
    csub = subs{s};
    
    % sn = sprintf('%s\n%s\t%s','','sub','roi');
    
    % get SPM.mat file for the current subject...
    % datadir = fullfile(rootdir,csub,'stats');
    desfile = fullfile(rootdir,csub,'SPM.mat');
    SPM = load(desfile);
    D = mardo(SPM);
    
    
    % Loop through ROIs ***************************************************
    for r=1:nrois
        croi = deblank(rois(r,:));
        
        %     disp(sprintf('%s\n%s   :   %s\n%s',repmat('*',20,1),csub,croi,repmat('*',20,1)))
        
        
        % ==============================================================
        % this is the main marsbar analysis...
        % ==============================================================
        
        R = maroi(croi); % load roi into a marsbar maroi object structure
        Y = get_marsy(R,D,roi_summary_function); % get summarised time course for this ROI
        E = estimate(D,Y); % estimate design based on this summarised time course
        SPM = des_struct(E); %unpack marsbar design structure
        smeans = SPM.betas(SPM.xX.iB); % session means - these are used for calculating percent signal change
        res.beta{r,s} = SPM.betas(SPM.xX.iC); % load beta values for effects of interest into results structure
        
        % ==============================================================
        
        
        % calculate percent signal change for each beta value, marsbar
        % style
        %         i=0;
        %         res.percent{r,s}=[];
        %         for sess = 1:size(SPM.Sess,2)
        %             for ev = 1:size(SPM.Sess(sess).col,2)
        %                 cc = SPM.Sess(sess).col(ev);
        %                 cb = SPM.betas(cc);
        %
        %                 if ev<=length(SPM.Sess(sess).U)
        %                     if modeldur
        %                         evdur = mean(SPM.Sess(sess).U(ev).dur);
        %                     else
        %                         evdur=1;
        %                     end
        %
        %                     if evdur==0
        %                         sf = zeros(SPM.xBF.T,1);
        %                         sf(1) = SPM.xBF.T;
        %                     else
        %                         sf = ones(round(evdur/SPM.xBF.dt), 1);
        %                     end
        %
        %                     X = [];
        %                     for b = 1:size(SPM.xBF.bf,2)
        %                         X = [X conv(sf, SPM.xBF.bf(:,b))];
        %                     end
        %
        %                     Yh = X*cb;
        %                     [d i] = max(abs(Yh), [], 1);
        %                     d = Yh(i);
        %                 else
        %                     d=cb;
        %                 end
        %
        %                 res.percent{r,s}(end+1)= 100*(d/smeans(sess));
        %             end
        % end
    end
end
save(resmat,'res');

% end



%
