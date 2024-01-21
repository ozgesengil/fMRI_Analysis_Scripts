% This script is a template that can be used for a decoding analysis on 
% brain image data. It is for people who have betas available from an 
% SPM.mat and want to automatically extract the relevant images used for
% classification, as well as corresponding labels and decoding chunk numbers
% (e.g. run numbers). If you don't have this available, then use
% decoding_template_nobetas.m

% Make sure the decoding toolbox and your favorite software (SPM or AFNI)
% are on the Matlab path (e.g. addpath('/home/decoding_toolbox') )
% TDT
%  addpath('D:\the_decoding_toolbox\decoding_toolbox')
addpath('C:\Users\HCF-Lab\Documents\MATLAB\spm12\toolbox\decoding_toolbox')
assert(~isempty(which('decoding_defaults.m', 'function')), 'TDT not found in path, please add')
% SPM/AFNI
%  addpath('D:\spm12')
addpath('C:\Users\HCF-Lab\Documents\MATLAB\spm12')
assert((~isempty(which('spm.m', 'function')) || ~isempty(which('BrikInfo.m', 'function'))) , 'Neither SPM nor AFNI found in path, please add (or remove this assert if you really dont need to read brain images)')

% Set defaults
cfg1 = decoding_defaults;

% Set the analysis that should be performed (default is 'searchlight')
cfg1.analysis = 'searchlight'; % standard alternatives: 'wholebrain', 'ROI' (pass ROIs in cfg.files.mask, see below)
cfg1.searchlight.radius = 3; % use searchlight of radius 3 (by default in voxels), see more details below

% subject_folders = dir;
% subject_folders = {subject_folders(3:end-1).name};
subject_folders ={'sub02','sub03','sub04','sub23','sub24','sub25','sub26','sub27','sub28','sub29','sub30','sub31','sub32','sub33'};
%subject_folders ={'sub25','sub26','sub27','sub28','sub29','sub30','sub31','sub32','sub33'};


%subs = {'sub06','sub07','sub08','sub09','sub10','sub11','sub12','sub13','sub14','sub15','sub16','sub17','sub18','sub19','sub20','sub21','sub22'};
% sub08','sub09','sub10','sub11','sub12','sub13','sub14','sub15',
%% Set additional parameters
% Set additional parameters manually if you want (see decoding.m or
% decoding_defaults.m). Below some example parameters that you might want 
% to use a searchlight with radius 12 mm that is spherical:

% cfg.searchlight.unit = 'mm';
% cfg.searchlight.radius = 12; % if you use this, delete the other searchlight radius row at the top!
 cfg1.searchlight.spherical = 1;
 cfg1.verbose = 2; % you want all information to be printed on screen
% cfg.decoding.train.classification.model_parameters = '-s 0 -t 0 -c 1 -b 0 -q'; 

% Enable scaling min0max1 (otherwise libsvm can get VERY slow)
% if you dont need model parameters, and if you use libsvm, use:
cfg1.scale.method = 'min0max1';
cfg1.scale.estimation = 'all'; % scaling across all data is equivalent to no scaling (i.e. will yield the same results), it only changes the data range which allows libsvm to compute faster

% if you like to change the decoding software (default: libsvm):
% cfg1.decoding.software = 'liblinear'; % for more, see decoding_toolbox\decoding_software\. 
% Note: cfg1.decoding.software and cfg1.software are easy to confuse.
% cfg1.decoding.software contains the decoding software (standard: libsvm)
% cfg1.software contains the data reading software (standard: SPM/AFNI)

% Some other cool stuff
% Check out 
%   combine_designs(cfg, cfg2)
% if you like to combine multiple designs in one cfg1.

%% Decide whether you want to see the searchlight/ROI/... during decoding
cfg1.plot_selected_voxels = 500; % 0: no plotting, 1: every step, 2: every second step, 100: every hundredth step...

%% Add additional output measures if you like
% See help decoding_transform_results for possible measures
cfg3= cfg1;
% loop through subjects
for sub = 1:numel(subject_folders)
 
% Set the output directory where data will be saved, e.g. 'c:\exp\results\buttonpress'

cfg3.results.dir = fullfile('G:\OZGE_STUDY2\resultsMVPA6searchlight_nochunks_3back_ruf\0T_9-2T_9', subject_folders{sub});


% Set the filepath where your SPM.mat and all related betas are, e.g. 'c:\exp\glm\model_button'
beta_loc = 'G:\OZGE_STUDY2\statsMVPA6_nochunks';
betas = fullfile(beta_loc,subject_folders{sub});
cd(betas);
% Set the filename of your brain mask (or your ROI masks as cell matrix) 
% for searchlight or wholebrain e.g. 'c:\exp\glm\model_button\mask.img' OR 
% for ROI e.g. {'c:\exp\roi\roimaskleft.img', 'c:\exp\roi\roimaskright.img'}
% You can also use a mask file with multiple masks inside that are
% separated by different integer values (a "multi-mask")
%cfg.files.mask = 'E:\fMRI_nback_varlength\fmri_analysis_files\events_mvpa_fixedpostbuttoniei_10022022\stats_mvpa_fixedpostbuttoniei_10022022\smaroi\rL_preSMA.nii ';

% Set the label names to the regressor names which you want to use for 
% decoding, e.g. 'button left' and 'button right'
% don't remember the names? -> run display_regressor_names(beta_loc)
% infos on '*' (wildcard) or regexp -> help decoding_describe_data
 
  labelname1 = '0T_9';
  labelname2 = '2T_9';
%   labelname3 = '0T_6';
%   labelname4 = '1T_6';



%labelvalue1 = 1; % value for labelname1
%labelvalue2 = -1; % value for labelname2

cfg3.results.output = {'accuracy_minus_chance'};
% You can also use all methods that start with "transres_", e.g. use
%   cfg1.results.output = {'SVM_pattern'};
% will use the function transres_SVM_pattern.m to get the pattern from 
% linear svm weights (see Haufe et al, 2015, Neuroimage)

%% Nothing needs to be changed below for a standard leave-one-run out cross
%% validation analysis.

% The following function extracts all beta names and corresponding run
% numbers from the SPM.mat
regressor_names = design_from_spm(betas);

% Extract all information for the cfg1.files structure (labels will be [1 -1] if not changed above)
% cfg = decoding_describe_data(cfg,{labelname1 labelname2},[labelvalue1 labelvalue2],regressor_names,beta_loc);



cfg3 = decoding_describe_data_ruf(cfg3,{labelname1 labelname2},[1 -1],regressor_names,betas);

% This creates the leave-one-run-out cross validation design:

cfg3.design = make_design_cv(cfg3);
% Run decoding
%cfg1.results.overwrite = 1;
 results = decoding(cfg3);
end 