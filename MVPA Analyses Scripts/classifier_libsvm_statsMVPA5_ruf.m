% MVPA classifier for fMRI
% Tanya Wen
% 28/09/2016
% edited: 03/01/2017
clear all
dbstop if error
% add required paths
% addpath('/imaging/local/software/spm_cbu_svn/releases/spm12_latest/')
addpath('C:\Users\HCF-Lab\Documents\MATLAB')
% addpath('/Users/ausaf/Documents/MATLAB/libsvm-3.25/matlab');
addpath('C:\Users\HCF-Lab\Desktop\libsvm-master');
% control variables
libSVMsettings='-s 1 -t 0'; % nu-SVM, linear
nRandomisations=1000;

% set up directories for each subject
firstlevel_dir = 'G:\OZGE_STUDY2\statsMVPA5';
cd(firstlevel_dir);
% subject_folders = dir;
% subject_folders = {subject_folders(3:end-1).name};

% %%% use these for 3 back participants
% subject_folders =  {'sub02','sub03','sub04','sub23','sub25','sub26','sub27','sub28','sub29','sub30','sub31','sub32','sub33'};
subject_folders =  {'sub02','sub03','sub04','sub23','sub24','sub25','sub26','sub27','sub28','sub29','sub30','sub31','sub32','sub33'};
sessnums=[3 3 3 3 4 4 3 3 3 3 3 3 3];
% % % sessnums=[3 3 3 3 3 4 4 3 3 3 3 3 3];

% subject_folders = {'sub06','sub07','sub09','sub10','sub11','sub15','sub17','sub20','sub22','sub23','sub24','sub25','sub26','sub27','sub28','sub29','sub30','sub31','sub32','sub33'};
% sessnums=[3 2 3 3 4 4 4 4 4 3 3 4 4 3 3 3 3 3 3 3]; %% !!!! From some subs the last session is excluded due to low event repetition. that is why this list is not accurate for other analyses!!

% % use these for 2 back participants
% subject_folders = {'sub06','sub07','sub08','sub09','sub10','sub11','sub12','sub13','sub14','sub15','sub16','sub17','sub18','sub19','sub20','sub21','sub22'};
% sessnums=[4 2 4 4 3 4 3 4 4 4 4 4 4 4 4 4 4];
% subject_folders = {'sub06','sub07','sub08','sub09','sub11','sub12','sub13','sub14','sub16','sub17','sub18','sub19','sub20','sub21','sub22'};
% sessnums=[4 2 4 4 4 3 4 4 4 4 4 4 4 4 4];
% loop through subjects

for sub = 1:numel(subject_folders)
    cd(fullfile(firstlevel_dir,'/',subject_folders{sub}));
    
    clear beta_data
    % get beta maps
    load('SPM.mat');
    for betas = 1:numel(SPM.Vbeta)
        V = spm_vol(sprintf('beta_%04d.nii',betas));
        data = spm_read_vols(V);
        beta_data(betas,:,:,:) = data(:,:,:);
    end
    
    % find condition labels for beta maps
    cond_type = {'nt1', 'nt2'};%{'s\d_\d', 'n\d_\d'};
    for ntype = 1:2
        type_all{ntype} = find(~cellfun(@isempty,regexp({SPM.Vbeta.descrip},cond_type{ntype})));
    end
    
    
    % load in ROIs
    cd('C:\Users\HCF-Lab\Desktop\MVPA-related\MD_rois')
%     cd('C:\Users\HCF-Lab\Desktop\MVPA-related\DMN rois')
%     roi_list = {'rL_leg.nii','rR_leg.nii'};
%     cd('/imaging/aa02/MD rois')
%     roi_list = {'rAuditory_Te3.nii','rL_aMPFC.nii','rR_aMPFC.nii','rL_PCC.nii','rR_PCC.nii'};
    roi_list = {'rL_AI.nii','rL_aMFG.nii','rL_FEF.nii','rL_IPS.nii','rL_mMFG.nii', 'rL_pMFG.nii', 'rL_preSMA.nii'...
        'rR_AI.nii','rR_aMFG.nii', 'rR_FEF.nii','rR_IPS.nii','rR_mMFG.nii', 'rR_pMFG.nii', 'rR_preSMA.nii',...
        'rL_ESV.nii', 'rR_ESV.nii'};
%  roi_list = {'rR_TPJ.nii', 'rR_TempP.nii', 'rR_Rsp.nii', 'rR_pIPL.nii', 'rR_PHC.nii', 'rR_PCC.nii','rR_LTC.nii', 'rR_HF.nii', 'rR_aMPFC.nii',...
%         'rL_TPJ.nii', 'rL_TempP.nii', 'rL_Rsp.nii', 'rL_pIPL.nii', 'rL_PHC.nii', 'rL_PCC.nii','rL_LTC.nii', 'rL_HF.nii', 'rL_aMPFC.nii',...
%         'rvMPFC.nii', 'rdMPFC.nii'};
%     
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
        



       % loop through shifted class 2
%        for ii = 1:((sessnums(sub)))

           % loop through each member being tested
           for i = 1:((sessnums(sub)))
           
             test_ind = [type_all{1}(i), type_all{2}(i)];
             train_ind = [(setdiff(type_all{1}(:),type_all{1}(i)))', (setdiff(type_all{2}(:),type_all{2}(i)))'];
            
             labels_train = cond_label(train_ind);
             patternsTrain = beta_vect(train_ind,:);
        
             labels_test = cond_label(test_ind);
             patternsTest = beta_vect(test_ind,:);
        
             
             model=svmtrain(labels_train',patternsTrain,libSVMsettings);
             
          
             [predicted,accuracy,~]=svmpredict(labels_test',patternsTest,model);
             ac(i) = accuracy(1);
           end

% %          type_all{2} = circshift(type_all{2},1);
% %          acc(ii)=nanmean(ac);

%        end 
       accuracy_roi(sub, rois) = nanmean(ac);
    end
end

        
        
% %         accuracy_1=nanmean(acc);
%         type_all{2} = circshift(type_all{2},1);
%         for i = 1:((sessnums(sub)*2)-1)
%         train_ind = [type_all{1}(1:3), type_all{2}(1:3)];
%         test_ind = [type_all{1}(4:6), type_all{2}(4:6)];
%             
%         labels_train_ = cond_label(test_ind);
%         patternsTrain_ = beta_vect(test_ind,:);
%         
%         labels_test_ = cond_label(train_ind);
%         patternsTest_ = beta_vect(train_ind,:);
%         
%         type_all{1} = circshift(type_all{1},1);
%         
%         model_=svmtrain(labels_train_',patternsTrain_,libSVMsettings);
%         
%         [predicted,accuracy,~]=svmpredict(labels_test_',patternsTest_,model_);
%         acc(2) = accuracy(1);
% %             
%         end
% %         accuracy_2=nanmean(acc_);
%        % type_all{2} = circshift(type_all{2},1);
%         
%         accuracy_roi(sub, rois) = nanmean(acc);
% %         
% 
% 
%         % if participant has 2 sessions
%       elseif sessnums(sub)==2
%         for i = 1:((sessnums(sub)*2))
%         train_ind = [type_all{1}(1:2), type_all{2}(1:2)];
%         test_ind = [type_all{1}(3:4), type_all{2}(3:4)];
%             
%         labels_train = cond_label(train_ind);
%         patternsTrain = beta_vect(train_ind,:);
%         
%         labels_test = cond_label(test_ind);
%         patternsTest = beta_vect(test_ind,:);
%         
%         type_all{2} = circshift(type_all{2},1);
%         
%         model=svmtrain(labels_train',patternsTrain,libSVMsettings);
%         
%         [predicted,accuracy,~]=svmpredict(labels_test',patternsTest,model);
%         acc(1) = accuracy(1);
%             
%         end
%         
% %         accuracy_1=nanmean(acc);
% %         type_all{2} = circshift(type_all{2},1);
% 
%         for i = 1:((sessnums(sub)*2))
%         train_ind = [type_all{1}(1:2), type_all{2}(1:2)];
%         test_ind = [type_all{1}(3:4), type_all{2}(3:4)];
%             
%         labels_train_ = cond_label(test_ind);
%         patternsTrain_ = beta_vect(test_ind,:);
%         
%         labels_test_ = cond_label(train_ind);
%         patternsTest_ = beta_vect(train_ind,:);
%         
%         type_all{1} = circshift(type_all{1},1);
%         
%         model_=svmtrain(labels_train_',patternsTrain_,libSVMsettings);
%         
%         [predicted,accuracy,~]=svmpredict(labels_test_',patternsTest_,model_);
%         acc(2) = accuracy(1);
% %             
%         end
% %         accuracy_2=nanmean(acc_);
%         % type_all{2} = circshift(type_all{2},1);
%         
%         accuracy_roi(sub, rois) = nanmean(acc);
%         
% 
% 
% 
%         % if participant has 4 sessions
%       elseif sessnums(sub)==4
%         for i = 1:((sessnums(sub)*2))
%         train_ind = [type_all{1}(1:4), type_all{2}(1:4)];
%         test_ind = [type_all{1}(5:8), type_all{2}(5:8)];
%             
%         labels_train = cond_label(train_ind);
%         patternsTrain = beta_vect(train_ind,:);
%         
%         labels_test = cond_label(test_ind);
%         patternsTest = beta_vect(test_ind,:);
%         
%         type_all{2} = circshift(type_all{2},1);
%         
%         model=svmtrain(labels_train',patternsTrain,libSVMsettings);
%         
%         [predicted,accuracy,~]=svmpredict(labels_test',patternsTest,model);
%         acc(1) = accuracy(1);
%             
%         end
%         
% %         accuracy_1=nanmean(acc);
% %         type_all{2} = circshift(type_all{2},1);
%         
%         for i = 1:((sessnums(sub)*2))
%         train_ind = [type_all{1}(1:4), type_all{2}(1:4)];
%         test_ind = [type_all{1}(5:8), type_all{2}(5:8)];
%             
%         labels_train_ = cond_label(test_ind);
%         patternsTrain_ = beta_vect(test_ind,:);
%         
%         labels_test_ = cond_label(train_ind);
%         patternsTest_ = beta_vect(train_ind,:);
%         
%         type_all{1} = circshift(type_all{1},1);
%         
%         model_=svmtrain(labels_train_',patternsTrain_,libSVMsettings);
%         
%         [predicted,accuracy,~]=svmpredict(labels_test_',patternsTest_,model_);
%         acc(2) = accuracy(1);
%           
%         end
% %         accuracy_2=nanmean(acc_);
% %         type_all{2} = circshift(type_all{2},1);
%         
%         accuracy_roi(sub, rois) = nanmean(acc);
%       end
% 
%     end
% end
% 
% % % 
% % % rnames=char(roi_list);
% % % s1=all(repmat(rnames(1,:),[length(roi_list),1])==rnames);
% % % rnames=rnames(:,find(~s1,1):end);
% % % rnames=cellstr(rnames);
% % % rroot=roi_list{1}(1:find(~s1,1)-1);
% % % roinames=unique(regexprep(rnames,{'_?left','_?right'},{'',''},'ignorecase'));
% % % roinames = strrep(roinames, '_', '-');
% % % roinames = strrep(roinames, '.nii', '');
% % % 
% % % plotnum = 1;
% % % for session = 1:2
% % %     for ROIs = 1:numel(roi_list)
% % %         subplot(numel(cond_type),numel(roi_list),plotnum)
% % %         bar(squeeze(mean(accuracy_matrix(session,:,ROIs,:),4)))
% % %         hold on
% % %         errorbar(squeeze(mean(accuracy_matrix(session,:,ROIs,:),4)),squeeze(std(accuracy_matrix(session,:,ROIs,:)/sqrt(sub),0,4)),'.');
% % %         ylim([0 1]);
% % %         xlim([0 7]);
% % %         title({cond_type{session};roinames{ROIs}},'FontSize',6);
% % %         plotnum = plotnum+1;
% % %     end
% % % end
% % % cd('/imaging/tw05/Motion_Coherence_Study');
% % % saveas(gcf,'Classifier-5fold-trainlevel2-top10.png')
% % % 
% % % % blocked and intermixed seperate
% % % grouptype={'blocked','intermixed'};
% % % for sub = 1:numel(subject_folders)
% % %     % group1 = blocked; group2 = intermixed
% % %     group(sub)=all(~cellfun(@isempty,regexp(cellstr(spm_select('List',fullfile('/imaging/tw05/Motion_Coherence_Study/Behavioral Data',subject_folders{sub},'*.mat'))),grouptype{2})));
% % % end
% % % 
% % % for g = 0:1
% % %     figure;
% % %     plotnum = 1;
% % %     for session = 1:2
% % %         for ROIs = 1:numel(roi_list)
% % %             subplot(numel(cond_type),numel(roi_list),plotnum)
% % %             bar(squeeze(mean(accuracy_matrix(session,:,ROIs,group==g),4)))
% % %             hold on
% % %             errorbar(squeeze(mean(accuracy_matrix(session,:,ROIs,group==g),4)),squeeze(std(accuracy_matrix(session,:,ROIs,group==g)/sqrt(sub/2),0,4)),'.');
% % %             ylim([0 1]);
% % %             xlim([0 7]);
% % %             title({cond_type{session};roinames{ROIs}},'FontSize',6);
% % %             plotnum = plotnum + 1;
% % %         end
% % %     end
% % %     suptitle(strcat('MVPA - ',grouptype{g+1}));
% % % end
% % % save('Classifier-5fold-trainlevel2-top10.mat');
% 
% 
% 
% 
% aa=accuracy_roi-50;
% [h p ci]=ttest(aa)

