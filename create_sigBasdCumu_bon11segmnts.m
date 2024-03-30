% load main database and pass it into db variable

clear ;
clc;
Sig_bon_cumu_Frms_38frms= table();
data=load('all_cell_stimwise_aftrblcrrn.mat');
data=data.all_cell_stimwise_aftrblcrrn;

hValues = []; % Initialize an empty array to store h values
significantCells = []; % Initialize an empty array to store significant cells
numTests = 10; % Number of tests for Bonferroni correction
% number of stimuli 
stim=16;
alpha = 0.05 / (stim*numTests); % Adjusted significance level for Bonferroni correction
hMatrix = []; % Initialize an empty matrix to store h values for all cells
for i = 1:length(data)
    disp(['i = ' num2str(i) '/' num2str(length(data))])
    baselineFrames =[];
    for j = 1:stim
        xx=data{i,j};
        base = [];
        base= mean(xx(:,4:8),2);
        %append teh baseline mean to the baseline array for all stim 
        baselineFrames = [baselineFrames;base];
    end
    for jj=1:stim 
        xx=data{i,jj};
        hValues = []; % Initialize an empty array to store h values for this stimli 
        for n = 0:9 % For each segment size (3, 6, 9, ..., 30)
            segmentSize = 3 * (n + 1); % Calculate the segment size
            if 9 + segmentSize - 1 <= size(xx, 2) % Ensure we don't exceed the matrix dimensions
                segmentFrames = mean(xx(:, 9:9+segmentSize-1),2);
                % Perform a t-test on the baseline and segment frames with bonferroni correction
                [h, ~] = ttest2(baselineFrames(:), segmentFrames(:), 'Alpha', alpha);
                hValues = [hValues, h]; % Store the h value for this segment
            else
                hValues = [hValues, NaN]; % If the segment size exceeds the matrix dimensions, store NaN
            end
        end
        hMatrix = [hMatrix; hValues]; % Add the h values for this cell to the matrix
    end
%check if the cell is significant for any of the stim
    if any(hMatrix(i,:))
        significantCells = [significantCells, i]; % If the cell is significant for any of the stim, store the cell index
    end
end
%get the index of the significant cells
%get the significant cells
for i = 1:length(significantCells)
    Sig_bon_cumu_Frms_38frms = [Sig_bon_cumu_Frms_38frms; data(significantCells(i),:)];
end
% disp('h values matrix:');
% disp(hMatrix);
% 


