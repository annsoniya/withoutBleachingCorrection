% categorising teh segments into periodic and random stimulus line outputa
clear all;
close all;
clc;
periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];
% load the data signifact cell
% read the stimcode from each cell and then categorise them into periodic and aperiodic as 1*80 iterS
%db=load('significantcells.mat');
db=load('cells_after_bleach_crrtn.mat');

db=db.cells_after_bleach_crrtn;
% db has   File 
% Animal_Number       
% Cell_dff            
% STIM_FRE          
% STIM_code      
% STIM_ATT
all_cell_stimwise_aftrblcrrn=cell(size(db,1),16);
%for each cell, categorise the cell_dff into periodic and aperiodic for each stimulus each iter
for cells=1:size(db,1)
    cell_dff=cell2mat(db(cells,1));
    cell_stimcode=cell2mat(db(cells,2));
    cell_stimcode=reshape(cell_stimcode',1,80);% verified 
    % stimcode is in 5*16 format .. convert it into 1*80 format along teh rows    
    for stim=1:16
          inx=find(cell_stimcode==stim);
            % for all the stimcode, if the stimcode is same as the stim among all iterations, 
            % then keep cell_dff for taht particular stim in the sig_cell_stimwise matrix as columns 
            % and rows as cells
          
            for i = inx
                all_cell_stimwise_aftrblcrrn{cells,stim} = [all_cell_stimwise_aftrblcrrn{cells,stim}; cell_dff(i,:)];
            end % verified 

    end
 
end
