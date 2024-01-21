addpath(genpath('/imaging/local/software/spm_cbu_svn/releases/spm12_latest/'));

VV=char('/imaging/aa02/TM3/AA/aamod_firstlevel_model_00001/140437/stats/beta_0001.nii',...
    'L_AI.nii','L_aMFG.nii','L_ESV.nii','L_FEF.nii','L_IPS.nii','L_mMFG.nii','L_pMFG.nii','L_preSMA.nii',...
    'R_AI.nii','R_aMFG.nii','R_ESV.nii','R_FEF.nii','R_IPS.nii','R_mMFG.nii','R_pMFG.nii','R_preSMA.nii');
spm_reslice(VV,struct('mean',false,'which',1,'interp',0)); % 1 for linear

VV=char('/imaging/aa02/TM3/AA/aamod_firstlevel_model_00001/140398/stats/beta_0001.nii',...
    'dMPFC.nii','L_aMPFC.nii','L_HF.nii','L_LTC.nii','L_PCC.nii','L_PHC.nii','L_pIPL.nii','L_Rsp.nii','L_TempP.nii','L_TPJ.nii',...
    'R_aMPFC.nii','R_HF.nii','R_LTC.nii','R_PCC.nii','R_PHC.nii','R_pIPL.nii','R_Rsp.nii','R_TempP.nii','R_TPJ.nii','vMPFC.nii');
spm_reslice(VV,struct('mean',false,'which',1,'interp',0)); % 1 for linear

