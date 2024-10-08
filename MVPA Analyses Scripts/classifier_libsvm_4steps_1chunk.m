% MVPA classifier for fMRI

clear all;
dbstop if error
% add required paths
addpath('/imaging/local/software/spm_cbu_svn/releases/spm12_latest/')
addpath('/imaging/aa02/libsvm-mat-2.87-1');
% control variables
libSVMsettings='-s 1 -t 0'; % nu-SVM, linear
nRandomisations=1000;

% set up directories for each subject
firstlevel_dir = '/imaging/aa02/TM5/AA/sess123';
cd(firstlevel_dir);
subject_folders = dir('190*');
subject_folders = {subject_folders(1:end).name};

list = 1:12;
test_lists = [1:4;5:8;9:12];
test_lists_alt = [9:12; 5:8; 1:4];
cd('/imaging/aa02/TM5/Uninvolved/MD rois')
% roi_list = {'rR_TPJ.nii', 'rR_TempP.nii', 'rR_Rsp.nii', 'rR_pIPL.nii', 'rR_PHC.nii', 'rR_PCC.nii','rR_LTC.nii', 'rR_HF.nii', 'rR_aMPFC.nii',...
%         'rL_TPJ.nii', 'rL_TempP.nii', 'rL_Rsp.nii', 'rL_pIPL.nii', 'rL_PHC.nii', 'rL_PCC.nii','rL_LTC.nii', 'rL_HF.nii', 'rL_aMPFC.nii',...
%         'rvMPFC.nii', 'rdMPFC.nii', 'rAuditory_Te3.nii', 'rL_leg.nii', 'rR_leg.nii'};
roi_list = {'rL_AI.nii','rL_aMFG.nii','rL_FEF.nii','rL_IPS.nii','rL_mMFG.nii', 'rL_pMFG.nii', 'rL_preSMA.nii'...
    'rR_AI.nii','rR_aMFG.nii', 'rR_FEF.nii','rR_IPS.nii','rR_mMFG.nii', 'rR_pMFG.nii', 'rR_preSMA.nii',...
    'rL_ESV.nii', 'rR_ESV.nii'};

accuracies = nan(numel(subject_folders),size(roi_list,2)*4);
% loop through subjects
for sub = 1:numel(subject_folders)
    cd(fullfile(firstlevel_dir,'/',subject_folders{sub},'/stats'));
    
    clear beta_data
    % get beta maps
    load('SPM.mat');
    for betas = 1:numel(SPM.Vbeta)
        V = spm_vol(sprintf('beta_%04d.nii',betas));
        data = spm_read_vols(V);
        beta_data(betas,:,:,:) = data(:,:,:);
    end
    
    % find condition labels for beta maps
    cond_type = {'o\d', 'e\d'};
    for ntype = 1:2
        type_all{ntype} = find(~cellfun(@isempty,regexp({SPM.Vbeta.descrip},cond_type{ntype})));
    end
    
    cd('/imaging/aa02/TM5/Uninvolved/MD rois')
    
    if (size(type_all{1},2) |size(type_all{2},2))<12
        list = 1:8;
        test_lists = [1:4; 5:8];
        test_lists_alt = [5:8; 1:4];
        pp = 2;
    else
        list = 1:12;
        test_lists = [1:4;5:8;9:12];
        test_lists_alt = [9:12; 5:8; 1:4];
        pp = 3;
    end
    % load in ROIs
    %
    %  cd('/imaging/aa02/legs')
    %  roi_list = {'rL_leg.nii','rR_leg.nii'};
    %     roi_list = {'rL_AI.nii','rL_aMFG.nii','rL_FEF.nii','rL_IPS.nii','rL_mMFG.nii', 'rL_pMFG.nii', 'rL_preSMA.nii'...
    %         'rR_AI.nii','rR_aMFG.nii', 'rR_FEF.nii','rR_IPS.nii','rR_mMFG.nii', 'rR_pMFG.nii', 'rR_preSMA.nii',...
    %         'rL_ESV.nii', 'rR_ESV.nii'};
    %  roi_list = {'rR_TPJ.nii', 'rR_TempP.nii', 'rR_Rsp.nii', 'rR_pIPL.nii', 'rR_PHC.nii', 'rR_PCC.nii','rR_LTC.nii', 'rR_HF.nii', 'rR_aMPFC.nii',...
    %         'rL_TPJ.nii', 'rL_TempP.nii', 'rL_Rsp.nii', 'rL_pIPL.nii', 'rL_PHC.nii', 'rL_PCC.nii','rL_LTC.nii', 'rL_HF.nii', 'rL_aMPFC.nii',...
    %         'rvMPFC.nii', 'rdMPFC.nii', 'rAuditory_Te3.nii'};
    
    % loop through ROIs and do MVPA for each
    for rois = 1:numel(roi_list)
        Vroi = spm_vol(char(roi_list(rois)));
        roi_mask = spm_read_vols(Vroi);
        clear beta_vect
        for b = 1:size(beta_data,1)
            data_temp(:,:,:) = beta_data(b,:,:,:);
            beta_vect(b,:) = data_temp(roi_mask~=0);
            clear data_temp;
        end
        beta_vect = beta_vect(:,all(~isnan(beta_vect)));
        
        % set labels to classify left or right
        cond_label = zeros(size(SPM.Vbeta));
        cond_label(type_all{1}) = 1; %shape
        cond_label(type_all{2}) = 2; %number
        
        %         % get top 10% active voxels
        %         beta_vect(cond_label==0,:) = NaN;
        %         beta_avg = nanmean(beta_vect,1);
        %         [sortedValues,sortIndex] = sort(beta_avg,'descend');
        %         maxIndex = sortIndex(1:ceil(numel(beta_avg)/10));
        %         beta_vect = beta_vect(:,maxIndex);
        accuracy_fold = nan(6,4);
        for p = 1:4
            for i = 1:pp
                
                test_ind = [type_all{1}(test_lists(i,p)), type_all{2}(test_lists(i,p))];
                train_lists = list;
                train_lists(test_lists(i,p))=[];
                train_ind = [type_all{1}(train_lists), type_all{2}(train_lists)];
                labels_train = cond_label(train_ind);
                patternsTrain = beta_vect(train_ind,:);
                
                labels_test = cond_label(test_ind);
                patternsTest = beta_vect(test_ind,:);
                model=svmtrain(labels_train',patternsTrain,libSVMsettings);
                
                [predicted,accuracy,~]=svmpredict(labels_test',patternsTest,model);
                accuracy_fold(i,p)=accuracy(1);
                
                
            end
            
        end
        
%         for p = 1:4
%             for i = 1:pp
%                 
%                 test_ind = [type_all{1}(test_lists(i,p)), type_all{2}(test_lists_alt(i,p))];
%                 train_lists = list;
%                 train_lists_alt = list;
%                 train_lists(test_lists(i,p))=[];
%                 train_lists_alt(test_lists_alt(i,p))=[];
%                 train_ind = [type_all{1}(train_lists), type_all{2}(train_lists_alt)];
%                 labels_train = cond_label(train_ind);
%                 patternsTrain = beta_vect(train_ind,:);
%                 
%                 labels_test = cond_label(test_ind);
%                 patternsTest = beta_vect(test_ind,:);
%                 model=svmtrain(labels_train',patternsTrain,libSVMsettings);
%                 
%                 [predicted,accuracy,~]=svmpredict(labels_test',patternsTest,model);
%                 accuracy_fold(i+3,p)=accuracy(1);
%                 
%                 
%             end
%             
%         end
        
        %         train_ind = [type_all{1}(1:4), type_all{2}(1:4)];
        %         test_ind = [type_all{1}(5:8), type_all{2}(5:8)];
        %
        %         labels_train = cond_label(train_ind);
        %         patternsTrain = beta_vect(train_ind,:);
        %
        %         labels_test = cond_label(test_ind);
        %         patternsTest = beta_vect(test_ind,:);
        %
        %         fold = 1;
        %
        %         model=svmtrain(labels_train',patternsTrain,libSVMsettings);
        %
        %         [predicted,accuracy,~]=svmpredict(labels_test',patternsTest,model);
        %         accuracy_fold(rois,fold)=accuracy(1);
        %
        %         fold = 2;
        %
        %         model=svmtrain(labels_test',patternsTest,libSVMsettings);
        %
        %         [predicted,accuracy,~]=svmpredict(labels_train',patternsTrain,model);
        %         accuracy_fold(rois,fold)=accuracy(1);
        accuracies(sub, 4*(rois-1)+1:4*(rois-1)+4) = nanmean(accuracy_fold);
        
        %         accuracy_roi = [];
        
        %         accuracy_roi(sub,rois) = mean(accuracy_fold(rois,:));
    end
end

% %
% % rnames=char(roi_list);
% % s1=all(repmat(rnames(1,:),[length(roi_list),1])==rnames);
% % rnames=rnames(:,find(~s1,1):end);
% % rnames=cellstr(rnames);
% % rroot=roi_list{1}(1:find(~s1,1)-1);
% % roinames=unique(regexprep(rnames,{'_?left','_?right'},{'',''},'ignorecase'));
% % roinames = strrep(roinames, '_', '-');
% % roinames = strrep(roinames, '.nii', '');
% %
% % plotnum = 1;
% % for session = 1:2
% %     for ROIs = 1:numel(roi_list)
% %         subplot(numel(cond_type),numel(roi_list),plotnum)
% %         bar(squeeze(mean(accuracy_matrix(session,:,ROIs,:),4)))
% %         hold on
% %         errorbar(squeeze(mean(accuracy_matrix(session,:,ROIs,:),4)),squeeze(std(accuracy_matrix(session,:,ROIs,:)/sqrt(sub),0,4)),'.');
% %         ylim([0 1]);
% %         xlim([0 7]);
% %         title({cond_type{session};roinames{ROIs}},'FontSize',6);
% %         plotnum = plotnum+1;
% %     end
% % end
% % cd('/imaging/tw05/Motion_Coherence_Study');
% % saveas(gcf,'Classifier-5fold-trainlevel2-top10.png')
% %
% % % blocked and intermixed seperate
% % grouptype={'blocked','intermixed'};
% % for sub = 1:numel(subject_folders)
% %     % group1 = blocked; group2 = intermixed
% %     group(sub)=all(~cellfun(@isempty,regexp(cellstr(spm_select('List',fullfile('/imaging/tw05/Motion_Coherence_Study/Behavioral Data',subject_folders{sub},'*.mat'))),grouptype{2})));
% % end
% %
% % for g = 0:1
% %     figure;
% %     plotnum = 1;
% %     for session = 1:2
% %         for ROIs = 1:numel(roi_list)
% %             subplot(numel(cond_type),numel(roi_list),plotnum)
% %             bar(squeeze(mean(accuracy_matrix(session,:,ROIs,group==g),4)))
% %             hold on
% %             errorbar(squeeze(mean(accuracy_matrix(session,:,ROIs,group==g),4)),squeeze(std(accuracy_matrix(session,:,ROIs,group==g)/sqrt(sub/2),0,4)),'.');
% %             ylim([0 1]);
% %             xlim([0 7]);
% %             title({cond_type{session};roinames{ROIs}},'FontSize',6);
% %             plotnum = plotnum + 1;
% %         end
% %     end
% %     suptitle(strcat('MVPA - ',grouptype{g+1}));
% % end
% % save('Classifier-5fold-trainlevel2-top10.mat');
