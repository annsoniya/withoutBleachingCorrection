function cell_report=check_pervsAper_mean_allframes(celldata,stimcode)
cell_report=9;
    per_set=[1,2,3,4,5,6,7,8,9,10];
    aper_set=[11,12,13,14,15,16];
    stimuli = cell(1, 16);
stimorder=reshape(stimcode',1,80);
per_data_each_cell=[];
aper_data_each_cell=[];

%% take each stim and get data 
for stim=1:16
    inx=find(stimorder==stim);
      % for all the stimcode, if the stimcode is same as the stim among all iterations, 
      % then keep cell_dff for taht particular stim in the sig_cell_stimwise matrix as columns 
      % and rows as cells   
      for i = 1:length(inx)
            celldata_stimwise(i,:)=celldata(inx(i),:); % 100* 5*40 matrixoif singel stimuli 
        % get cell data for that particular stim
      end 
      %%%%%%% categoriise tht stimuli data onto per and aper set
      if ismember(stim,per_set)
        per_data_each_cell=[per_data_each_cell;celldata_stimwise];
      else
        aper_data_each_cell=[aper_data_each_cell;celldata_stimwise];
      end
    end
%%%%%%%%%%%%%% do ttest and report it 
% per>Aper- right tailed ttest 
x=mean(per_data_each_cell(:,9:33),2);
yy=mean(aper_data_each_cell(:,9:33),2);

[h_rt,p_rt]=ttest2(x,yy,'Tail','right');
[h_lt,p_lt]=ttest2(x,yy,'Tail','left');
[h_2t,p_2t]=ttest2(x,yy,'Tail','both');

if h_rt==1
    cell_report=1;
elseif h_lt==1
    cell_report=2;
else
    cell_report=3;
end

end
