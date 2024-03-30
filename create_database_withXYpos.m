files = dir('*.mat');
%db = table();% use only for first set 

animalNumber = input('Enter the animal number: ');

for i = 1:length(files)
    data = load(files(i).name);
%     stim_fre=data.PP_PARAMS.AUD_IMG_STIM.STIMS.Fre;
%     stimcode=data.PP_PARAMS.AUD_IMG_STIM.STIMS.stimcode;
%     stim_att=data.PP_PARAMS.protocol.stim_protocol.db_atten ;
    if isfield(data, 'Cell_dff') && isfield(data, 'PP_PARAMS')
        for j = 1:size(data.Cell_dff, 1)% for teh first cell in taht file 


            %% bleachhing correction and positions incoporate 
            allcdff=squeeze({data.Cell_dff(j, :, :)});
            allcdff=squeeze(cell2mat(allcdff));
            %imagesc(squeeze(mean(allcdff)));
            % do correction for all iters seperately  
            for ii=1:size(allcdff,1)      % for all iterations seperately 
                pp=polyfit(1:10,(log(1+allcdff(ii,1:10))),1);
                blcorr=exp(pp(1)*[1:40]+pp(2))-1;
                allcdff(ii,:)=allcdff(ii,:)-blcorr;       
            end
            dff_bleach{j}={allcdff};
            % add bleaching correcetd cell_dff to the table
            % also add the position of each cell x and y from cellData
            
            row = table({files(i).name}, animalNumber, squeeze({data.Cell_dff(j, :, :)}), {data.PP_PARAMS.AUD_IMG_STIM.STIMS.Fre},{data.PP_PARAMS.AUD_IMG_STIM.STIMS.stimcode},{data.PP_PARAMS.protocol.stim_protocol.db_atten},dff_bleach{j},data.CellData.x(j),data.CellData.y(j),squeeze({data.lum_of_cells(j, :, :)}),   'VariableNames', {'File', 'Animal_Number', 'Cell_dff', 'STIM_FRE', 'STIM_code', 'STIM_ATT','Cell_dff_afr_bleachng_crrn','x','y','lumofcells'});
            db = [db; row];
        end
    end
end

%% for second folder on for next animals 

% db = load('existing_database.mat');

  