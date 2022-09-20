%-----------------------------------------------------------------------
%Define design specific parameters
%-----------------------------------------------------------------------
clear
% spm('Defaults',modality)
spm_defaults
global defaults
if ~isfield(defaults,'modality')
    h = findobj(findobj('tag','Menu'),'tag','Modality');
    mstr = get(h,'String');
    h = get(h,'Value');
    defaults.modality = mstr{h};
end
% 
% rootdir = 'E:\ozge_fmri_analysis';        % top level study directory
% statsdir ='E:\ozge_fmri_analysis\stats2';           % directory for analysis results
% evdir = 'E:\ozge_fmri_analysis\events_irem2';     % directory with event onset files

rootdir = 'E:\OZGE_STUDY2';        % top level study directory
statsdir ='E:\OZGE_STUDY2\stats4';           % directory for analysis results
evdir = 'E:\OZGE_STUDY2\events4';     % directory with event onset files


% if exist(rootdir)~=7; mkdir(rootdir);end
if exist(statsdir)~=7;mkdir(statsdir);end
cd(statsdir);

%==========================================================================
%==========================================================================


% Create an array of event names. Each name will label one column in the
% design matrix




evnames = {};

evnames{1} = 'nt1';
evnames{2} = 'nt2';
evnames{3} = 'nt3';
evnames{4} = 'nt4';
evnames{5} = 'nt5';
evnames{6} = 'nt6';
% evnames{7} = 'nt7';
% evnames{8} = 'nt8';
% evnames{9} = 'nt9';
evnames{7} = 't1';
evnames{8} = 't2';
evnames{9} = 't3';

evnames{10} = 'iei';
% evnames{11} = 'iei_2';
evnames{11} = 'R';
% evnames{13} = 'R2';





% names for movement parameters
mnames={'x_trans' 'y_trans' 'z_trans' 'x_rot' 'y_rot' 'z_rot'};


%==========================================================================
%==========================================================================

% miscellaneous other parameters
ncond = length(evnames);    % number of conditions (columns) per sessione
% nsess = 3;                  % number of sessions
hpf=120;                    % high pass filter cutoff
moves=1;                    % include movement parameters as covariates in anaysis?
modeldur=1;                 % model event duration?
imgfilt = 'swarf*.nii';    % prefix for images to be used in the analysis
movefilt = 'rp*.txt';       % pattern to identify movement parameter file
owd = pwd;                  % original working directory
TR=2;                       % scanner TR
ndummies=0;                 % number of dummy scans at start of each session



dorfx=0;                    % do a random effects analysis
% rfxoffset = 1;              % which contrast to start random effects analysis at
% rfxcon = (1:13);



% get subjects  - find all directories matching "CBU*" in root directory
% exsubs = {'sub01','sub02','sub03','sub04','sub05','sub06','sub07'};
% exsubs = char(exsubs);
% exsubs = cellstr(deblank(exsubs));
% exsubs=exsubs';
% % alls = []; eidx = [];

subs = {'sub06','sub07','sub08','sub09','sub10','sub11','sub12','sub13','sub14','sub15','sub16','sub17','sub18','sub19','sub20','sub21','sub22'};
subs = char(subs);
subs = cellstr(deblank(subs));

% subs = dir(fullfile(rootdir,'sub*'));
% subs = deblank(char(subs.name));
% subs = cellstr(deblank(subs));
% 
% for s = 1:length(exsubs)
%     exi = strfind(subs,exsubs{s});
%     exi = char(exi{:})==' ';
%     subs = subs(exi==1);
% end


ntot = length(subs);






%-----------------------------------------------------------------------
% Define contrasts
%-----------------------------------------------------------------------

% building blocks that are used to construct the full contrast vectors

% % % % % %
% % % % tmp = sz;
% % % % tmp(3) = -1;
% % % % tmp(4) = 1;
% % % % con{2} = repmat([tz tmp mz],1, nsess);
% % % % ctype{2} = 'T';
% % % % connames{2} = 'T3-T2';
% % % % % %
% % % % tmp = sz;
% % % % tmp(2) = -1;
% % % % tmp(4) = 1;
% % % % con{3} = repmat([tz tmp mz],1, nsess);
% % % % ctype{3} = 'T';
% % % % connames{3} = 'T3-T1';
% % % % % %
% % % % tmp = sz;
% % % % tmp(2:3) = [-1 -1];
% % % % tmp(4) = 2;
% % % % con{4} = repmat([tz tmp mz],1, nsess);
% % % % ctype{4} = 'T';
% % % % connames{4} = 'T3 - (T2+T1)';
% % % % %
% % % % tmp = sz;
% % % % tmp(2:4) = [-1 -1 -1];
% % % % tmp(5) = 3;
% % % % con{5} = repmat([tz tmp mz],1, nsess);
% % % % ctype{5} = 'T';
% % % % connames{5} = 'X - ts';
% % % % %
% % % % tmp = sz;
% % % % tmp(2:3) = -1;
% % % % tmp(5) = 2;
% % % % con{6} = repmat([tz tmp mz],1, nsess);
% % % % ctype{6} = 'T';
% % % % connames{6} = 'X - (t1&t2)';
% % % % %
% % % % tmp = sz;
% % % % tmp(4) = -1;
% % % % tmp(5) = 1;
% % % % con{7} = repmat([tz tmp mz],1, nsess);
% % % % ctype{7} = 'T';
% % % % connames{7} = 'X - T3';
% % % %
% % % % %
% % % % tmp = sz;
% % % % tmp(2:4) = 1;
% % % % con{8} = repmat([tz tmp mz],1, nsess);
% % % % ctype{8} = 'T';
% % % % connames{8} = 'Ts';
% % % %
% % % % %
% % % % tmp = sz;
% % % % tmp(2) = 1;
% % % % con{9} = repmat([tz tmp mz],1, nsess);
% % % % ctype{9} = 'T';
% % % % connames{9} = 'T1';
% % % % %
% % % % tmp = sz;
% % % % tmp(3) = 1;
% % % % con{10} = repmat([tz tmp mz],1, nsess);
% % % % ctype{10} = 'T';
% % % % connames{10} = 'T2';
% % % % %
% % % % tmp = sz;
% % % % tmp(4) = 1;
% % % % con{11} = repmat([tz tmp mz],1, nsess);
% % % % ctype{11} = 'T';
% % % % connames{11} = 'T3';
% % % %
% % % % %
% % % % tmp = sz;
% % % % tmp(5) = 1;
% % % % con{12} = repmat([tz tmp mz],1, nsess);
% % % % ctype{12} = 'T';
% % % % connames{12} = 'X';
% % % % %
% % % % tmp = sz;
% % % % tmp(2:3) = 1;
% % % % con{13} = repmat([tz tmp mz],1, nsess);
% % % % ctype{13} = 'T';
% % % % connames{13} = 'T1,T2';
%


% con = con(usecons);
% ctype = ctype(usecons);
% connames = connames(usecons);

%for c = 1:length(con)
%    con{c} = con{c}(:,ci==1);
%end

%con = con(19:20);
%ctype = ctype(19:20);
%connames = connames(19:20);

%-----------------------------------------------------------------------
%Define the basis function
%-----------------------------------------------------------------------




xBF.name       = 'hrf';
xBF.length     = 32.2;              % length in seconds
xBF.order      = 1;                 % order of basis set
xBF.T          = 16;                % number of time bins per scan
xBF.T0         = 1;                 % first time bin (see slice timing)
xBF.UNITS      = 'secs';           % OPTIONS: 'scans'|'secs' for onsets
xBF.Volterra   = 1;                 % OPTIONS: 1|2 = order of convolution

% condition specific bf elements
% myxBF(1).name = 'Finite Impulse Response';
% myxBF(1).length = 51; % length in seconds
% myxBF(1).order = 26; % order of basis set

% myxBF(2).name = 'hrf';
% myxBF(2).length = 32; % length in seconds
% myxBF(2).order = 1; % order of basis set


% which basis function to use for which condition

%bfnum=[1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 2 2 2 2 2 2 2 2]; % hrf for first two conditions, FIR for remainder
% bfnum=[1 2 2 2 2 2 2 2 2]; % hrf for first two conditions, FIR for remainder

% % for m=1:3 % 3 sessions
% %
% %     for n=[1:9] % 9 conditions
% %
% %         ... other stuff to specify event timings...
% %
% %         xBF.Sess(m).Cond(n).xBF=myxBF(bfnum(n));
% %
% %     end;
% %
% % end;







%======================================================================
%======================================================================
%RUN SINGLE SUBJ FIXED EFFECTS ANALYSES

for sub = 1:ntot               % loop through subjects
    
    % the first part of the code is collecting information that defines the
    % design (event timings, covariates, which images to use etc) and
    % entering it into the correct fields of a data structure calles SPM.
    % Once all the information is collected, this structure will be passed
    % into the routines that carry out the analysis.
    
    clear SPM scols
    SPM.xY.RT = TR;
    SPM.xGX.iGXcalc = 'None';
    SPM.xVi.form = 'AR(1)';
    SPM.xBF = xBF;
    
    csub = subs{sub};
    %     disp(csub);
    
    subdir = fullfile(statsdir,csub);
    if exist(subdir)~=7;mkdir(subdir);end
    cd(subdir);
    % load file defining stimulus events
    
    ont = load(fullfile(evdir, [csub '.mat']));
    %    ont = 'C:\Users\ausaf\Documents\Ozge\ELHI040721_21_04_07-17_21_40-DST-1_3_12_2_1107_5_2_32_35397\events\sub01.mat';
    hello=fieldnames(ont);
    eval(['ons=ont.' hello{1}]);
    %     load(ont);
    %      ons = ont;
    % load file containing movement parameters (from realignment)
    
    sr =0; %con
    allfiles = [];
    event_present=[];
    
    Sess = dir(fullfile(rootdir,csub,'SESSION_*'));
    Sess = deblank(char(Sess.name));
    Sess = cellstr(deblank(Sess));
    nsess = length(Sess);
    
    
    
    
    for s =1: nsess             % loop through sessions (scans)con
        
        % get image files for this session
        sessdata = fullfile(rootdir,csub,['SESSION_' num2str(s)]);
        sessname = ['SESSION_' num2str(s)];
        mparams = dir(fullfile(rootdir,csub,sessname,movefilt));
        mparams = spm_load(fullfile(rootdir,csub,sessname,mparams.name));
        
        %         sessdata = 'C:\Users\ausaf\Documents\Ozge\ELHI040721_21_04_07-17_21_40-DST-1_3_12_2_1107_5_2_32_35397\AUSAF_OZGE_20210407_172213_953000\MOCOSERIES_0006';
        files = dir(fullfile(sessdata, imgfilt));
        files = [repmat([sessdata filesep],size(files,1),1) strvcat(files(:).name)];
        files = files(ndummies+1:end,:);
        
        
        SPM.nscan(s) = size(files,1);
        allfiles = strvcat(allfiles,files); % master list of iamge files for all sessions
        
        % get event information for the current sessioncon
        sons = ons(ons(:,1)==s,2:4);
        
        % index of which columns are present / absent in current sessioncon
        event_present(s,1:ncond) = 1;
        ec=0;
        
        for cc = 1:(ncond)     % loop through event types
            onidx = find(sons(:,1)==cc); % get index of events matching current type
            
            if length(onidx)>0
                ec = ec+1;
                if modeldur
                    durs = sons(onidx,3);
                else
                    durs = zeros(size(onidx,1),1);
                end
                
                % enter event information into SPM structure
                SPM.Sess(s).U(ec) = struct(...
                    'ons',sons(onidx,2),...     % onset
                    'dur',durs,...              % duration
                    'name',{{evnames{cc}}},...   % name
                    'P',struct('name','none')); % parametric modulator
            else
                event_present(s,cc)=0;
            end
        end                % end of event loop
        
        SPM.xX.K(s).HParam = hpf; % set high pass filter
        
        
        % get index of scans belonging to this session
        %         sr = sr(end)+ndummies+1:sr(end)+SPM.nscan(s)+ndummies;
        sr =1:SPM.nscan(s);
        
        % if specified, enter movement parameters as covariatecon
        if moves==1
            SPM.Sess(s).C.C    = mparams(sr,:);     % [n x c double] covariates
            SPM.Sess(s).C.name = mnames;            % [1 x c cell] namescon
            %scols(s,ncond+1:ncond+6)=1;
        else
            SPM.Sess(s).C.C = [];
            SPM.Sess(s).C.name = {};
        end
    end                 % end of session loop
    
    
    
    SPM.xY.P = allfiles; % enter list of all files
    
    
    % Set up of SPM structure is done. Now for the actual analysis bit...
    % -------------------------------------------------------------------
        SPM = spm_fmri_spm_ui(SPM); % set up design matrix
        spm_unlink(fullfile('.', 'mask.img')); % avoid overwrite dialog
        SPM = spm_spm(SPM); % estimate design
    load(fullfile(subdir,'SPM.mat'));
    
    
    
     SPM.xCon =[]; % delete this line later on....

    sz = zeros(1,ncond); % num of conditions
    
    mz = zeros(1,6); % movement parameters
    % tz = zeros(1,25); %Num of FIR reg - 1 (because the 1st FIR reg is included in 'ncond' above in sz)
    
    
%     % % the contrasts themselves for 2BACK
     tmp = sz;
    tmp(1:6) = -1;
    tmp(7:9)=2;
    con{1} = repmat([tmp mz],1,nsess);
    ctype{1} = 'T';
    connames{1} = 'T-NT';
%     
    tmp = sz;
    tmp(7) = -1;
    tmp(9)=1;
    con{2} = repmat([tmp mz],1,nsess);
    ctype{2} = 'T';
    connames{2} = 'T3-T1';
%     
    tmp = sz;
    tmp(1:6) = -1;
    tmp(10)=6;
    con{3} = repmat([tmp mz],1,nsess);
    ctype{3} = 'T';
    connames{3} = 'IEI-NT';
%     
    tmp = sz;
    tmp(10) = -1;
    tmp(11)=1;
    con{4} = repmat([tmp mz],1,nsess);
    ctype{4} = 'T';
    connames{4} = 'R-IEI';
    %
        tmp = sz;
    tmp(1:6) = -1;
    tmp(11)=6;
    con{5} = repmat([tmp mz],1,nsess);
    ctype{5} = 'T';
    connames{5} = 'R-NT';
%
        tmp = sz;
    tmp(11) = -1;
    tmp(10)=1;
    con{6} = repmat([tmp mz],1,nsess);
    ctype{6} = 'T';
    connames{6} = 'IEI-R';
    %
%      tmp = sz;
%     tmp(10) = -1;
%     tmp(11)=1;
%     con{7} = repmat([tmp mz],1,nsess);
%     ctype{7} = 'T';
%     connames{7} = 'IEI2-IEI1';
    %
     tmp = sz;
    tmp(2:6) = [-2 -1 0 1 2];
%     tmp(11)=1;
    con{7} = repmat([tmp mz],1,nsess);
    ctype{7} = 'T';
    connames{7} = 'lin_inc_nonT';
    
%    tmp = sz;
%     tmp(12) = -1;
%     tmp(11)=1;
%     con{8} = repmat([tmp mz],1,nsess);
%     ctype{8} = 'T';
%     connames{8} = 'IEI-R';
    
    


%     tmp = sz;
%     tmp(10:12) = -1;
%     tmp(14)=3;
%     con{4} = repmat([tmp mz],1,nsess);
%     ctype{4} = 'T';
%     connames{4} = 'IEI2-T';
    
  
    
  
    
    if ~isfield(SPM,'event_present')
        SPM.event_present = event_present;
        save(fullfile(subdir,'SPM.mat'),'SPM');
    end
    
    if moves
        event_present = [event_present ones(size(event_present,1),6)];
    end
    event_present = [reshape(event_present',1,prod(size(event_present))) ones(1,nsess)];
    
    % now loop through and define contrasts
    for i = 1:length(con)
        disp([csub ' : ' num2str(i)])
        clear cc
        cc.name = connames{i};                          % name
        cc.STAT = ctype{i};                             % type
        cc.c = [con{i} zeros(size(con{i},1),nsess)];   % weights
        cc.c = cc.c(event_present==1); % can remove later
        
        %re-weight the contrast to take account of any columns that are
        %missing from the design matrix
        
        %if any(scols==0)
        %    cc.c = cc.c(:,scols==1);
        %end
        
        for r=1:size(cc.c,1)
            posi = find(cc.c(r,:)>0);
            negi = find(cc.c(r,:)<0);
            if ~isempty(negi)
                poswt = abs(sum(cc.c(r,negi)));
                negwt = abs(sum(cc.c(r,posi)));
                cc.c(r,posi) = cc.c(r,posi).*poswt;
                cc.c(r,negi) = cc.c(r,negi).*negwt;
                idx = find(cc.c(r,:)~=0);
                cc.c(r,:) = cc.c(r,:)./min(abs(cc.c(r,idx)));
            end
        end
        
        cc = spm_FcUtil('Set',cc.name,cc.STAT,'c',cc.c',SPM.xX.xKXs);
        if isfield(SPM,'xCon') & isempty(SPM.xCon)==false
            SPM.xCon(end+1) = cc;
        else
            SPM.xCon = cc;
        end
    end
    
    spm_contrasts(SPM);
    clear ont hello
    
end % ntot - fixed effects


% =====================================================================
% =====================================================================
% GROUP ANALYSIS

if dorfx
    rfxdir = fullfile(statsdir,'group_dummies');
    if exist(rfxdir)~=7;mkdir(rfxdir);end
    cd(rfxdir)
    
    
    
    
    
    for c = 1:size(rfxcon,2)
        currcon = rfxcon(c);
        wd = fullfile(rfxdir,connames{currcon});
        if exist(wd)~=7; mkdir(wd);end
        cd (wd)
        
        
        %==================================================================
        %TYPE 1: 1 SAMP T TEST
        
        clear SPM
        
        files = [];
        
        for s = 1:ntot
            
            fstr = num2str(currcon);
            fstr = ['con_' repmat('0',1,4-length(fstr)) fstr];
            fstr = fullfile(statsdir,subs{s},[fstr '.img']);
            f = dir(fstr);
            if length(f)~=1
                error(['too many or too few possible images! (' fstr ')']);
            else
                files{s} = fstr;
            end
        end
        
        job = [];
        
        job.dir = {wd};
        job.des.t1.scans = files;
        job.cov = struct('c',{},'cname',{},'iCFI',{},'iCC',{});
        tm = struct('tm_none',[]);
        job.masking = struct('tm',tm,'im',1,'em',{{''}});
        job.globalc = struct('g_omit',[]);
        gmsca = struct('gmsca_no',[]);
        job.globalm = struct('gmsca',gmsca,'glonorm',1);
        
        spm_unlink(fullfile('.', 'SPM.mat')); % avoid overwrite dialog
        spm_unlink(fullfile('.', 'mask.img')); % avoid overwrite dialog
        
        SPM = batch_run_stats(job);
        SPM = spm_spm(SPM);
        
        cname = ['Group ana: ' connames{currcon}];
        cc = spm_FcUtil('Set',cname,'T','c',1,SPM.xX.xKXs);
        if isfield(SPM,'xCon') & isempty(SPM.xCon)==false
            SPM.xCon(end+1) = cc;
        else
            SPM.xCon = cc;
        end
        spm_contrasts(SPM);
        
    end
end

cd(rootdir)

% global defaults
% defaults.stats.topoFDR=0