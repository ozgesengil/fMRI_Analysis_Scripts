% resulting cell has a matrix for each sub, the first column is the pic
% identity/number, the other columns are the number of occurences of the
% pic in each position (for 2 back from 1 to 6, for 3 back from 1 to 9).


% problems to consider in further analyses:

    % sub01 performance matrix didnot save each trial's pic number, so sub01
    % cannot be used in further analyses that require us to know the picture
    % identity.

    % sub05 is eliminated from the analyses, but here its behavioral data
    % is preserved. Consider that when checking the sub numbers.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all


% finding the occurences of pictures in each trial
behdir = 'G:\OZGE_STUDY2\behavioral data'; % the folder of behavioral data

subs = dir(fullfile(behdir,'sub*'));
subs = deblank(char(subs.name));
subs = cellstr(deblank(subs));

ntot=length(subs);

PPIC={};

for sub = 1:ntot
    csub = subs{sub};
    
   if sub>4 || sub<23 % for 2-back participants
    
    Sess = dir(fullfile(behdir, csub, '*sess*'));
    Sess = deblank(char(Sess.name));
    Sess = cellstr(deblank(Sess));
    nsess = length(Sess);
    
   
    
    for sess = 1:nsess
        cSess = Sess{sess}; 
    
        ont = load(fullfile(behdir, csub, cSess));
    

        aa=ont.Exp.PerformanceMat(9,:);
        
          [ii,jj,kk] = unique(aa); % getting the identity of the pictures
          freq=accumarray(kk,1); % calculating their frequency
          out=[ii' freq]; % first column: picture identity, second column: frequency
           
            aa(2,:)=(1:length(aa));
            for i=1:length(aa)
                
            aa(2,i) = mod(aa(2,i),6);
            
            end
            
            if isnan(aa(1,1)) % if there is a rest column in the beginning
                
               aa(2,:)=aa(2,:)-1;
               
               i_pos5 = find(aa(2,:)==-1);
               aa(2, i_pos5)=5;
               
               i_pos6 = find(aa(2,:)==0);
               aa(2, i_pos6)=6;
 
               aa(2,1)=99;
            else
               i_pos6 = find(aa(2,:)==0);
               aa(2, i_pos6)=6;
               
            end
            
            if isnan(aa(1,length(aa))) % if there is a rest column in the end
                
                aa(2,length(aa))=99;
            end
        
            
            
            PIC=[];
            for i=1:length(ii)
            
                % finding the occurrences of a picture in each trial
            i_pic_pos1 = find(aa(1,:)==ii(1,i) & aa(2,:)==1);
            i_pic_pos2 = find(aa(1,:)==ii(1,i) & aa(2,:)==2);
            i_pic_pos3 = find(aa(1,:)==ii(1,i) & aa(2,:)==3);
            i_pic_pos4 = find(aa(1,:)==ii(1,i) & aa(2,:)==4);
            i_pic_pos5 = find(aa(1,:)==ii(1,i) & aa(2,:)==5);
            i_pic_pos6 = find(aa(1,:)==ii(1,i) & aa(2,:)==6);
            
          % In the PIC, the first column is picture identity; other columns
          % are occurence of that picture in trials 1 to 6
            PIC = [PIC; ii(1,i) length(i_pic_pos1) length(i_pic_pos2) length(i_pic_pos3) ...
                length(i_pic_pos4) length(i_pic_pos5) length(i_pic_pos6)];
            
             if sess
                A=zeros(length(ii),7);
             end
            end
             
            A=(A+PIC);
            
          
    end
    
%     A(:,1)=A(:,1)./nsess;
    PPIC{1,sub} = A;  % each cell is containing the pics that participant has seen (first column)
                        % how many times they have seen them in total for a position (1-6) (from
                        % columns 2 to 7)
   end
    
    if sub<5  ||  sub>22 % for 3-back participants
    
    Sess = dir(fullfile(behdir, csub, '*sess*'));
    Sess = deblank(char(Sess.name));
    Sess = cellstr(deblank(Sess));
    nsess = length(Sess);
    
   
    
    for sess = 1:nsess
        cSess = Sess{sess}; 
    
        ont = load(fullfile(behdir, csub, cSess));
    

        aa=ont.Exp.PerformanceMat(9,:);
        
          [ii,jj,kk] = unique(aa); % getting the identity of the pictures
          freq=accumarray(kk,1); % calculating their frequency
          out=[ii' freq]; % first column: picture identity, second column: frequency
           
            aa(2,:)=(1:length(aa));
            for i=1:length(aa)
                
            aa(2,i) = mod(aa(2,i),9);
            
            end
            
            if isnan(aa(1,1)) % if there is a rest column in the beginning
                
               aa(2,:)=aa(2,:)-1;
               
               i_pos8 = find(aa(2,:)==-1);
               aa(2, i_pos8)=8;
               
               i_pos9 = find(aa(2,:)==0);
               aa(2, i_pos9)=9;
 
               aa(2,1)=99;
            else
               i_pos9 = find(aa(2,:)==0);
               aa(2, i_pos9)=9;
               
            end
            
            if isnan(aa(1,length(aa))) % if there is a rest column in the end
                
                aa(2,length(aa))=99;
            end
        
            
            
            PIC=[];
            for i=1:length(ii)
            
                % finding the occurrences of a picture in each trial
            i_pic_pos1 = find(aa(1,:)==ii(1,i) & aa(2,:)==1);
            i_pic_pos2 = find(aa(1,:)==ii(1,i) & aa(2,:)==2);
            i_pic_pos3 = find(aa(1,:)==ii(1,i) & aa(2,:)==3);
            i_pic_pos4 = find(aa(1,:)==ii(1,i) & aa(2,:)==4);
            i_pic_pos5 = find(aa(1,:)==ii(1,i) & aa(2,:)==5);
            i_pic_pos6 = find(aa(1,:)==ii(1,i) & aa(2,:)==6);
            i_pic_pos7 = find(aa(1,:)==ii(1,i) & aa(2,:)==7);
            i_pic_pos8 = find(aa(1,:)==ii(1,i) & aa(2,:)==8);
            i_pic_pos9 = find(aa(1,:)==ii(1,i) & aa(2,:)==9);
           
            
          % In the PIC, the first column is picture identity; other columns
          % are occurence of that picture in trials 1 to 6
            PIC = [PIC; ii(1,i) length(i_pic_pos1) length(i_pic_pos2) length(i_pic_pos3) ...
                length(i_pic_pos4) length(i_pic_pos5) length(i_pic_pos6) length(i_pic_pos7) length(i_pic_pos8) length(i_pic_pos9)];
            
             if sess
                A=zeros(length(ii),10);
             end
            end
             
            A=(A+PIC);
            
          
    end
    
%     A(:,1)=A(:,1)./nsess;
    PPIC{1,sub} = A;  % each cell is containing the pics that participant has seen (first column)
                        % how many times they have seen them in total for a position (1-9) (from
                        % columns 2 to 10)
   end
end


