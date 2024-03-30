function cell_report= check_cell_sig_with_bonferroni(celldata,stimcode)
    % here data is 80*40 matrix 
    %80= trials 
   % 40=frames 
per_set=[1,2,3,4,5,6,7,8,9,10];
aper_set=[11,12,13,14,15,16];
%Initialize an empty array to store significant cells
numTests = 10; % Number of tests for Bonferroni correction
% number of stimuli 
stim=16;
alpha = 0.05 / (stim*numTests); % Adjusted significance level for Bonferroni correction
hMatrix = zeros(16,10); %

%%%%%%%%% baseline rames fo that cell %%%%%%%%%%%%%%%%%%
baselineFrames=zeros(80,1);
for j = 1:length(celldata)
    xx=celldata(j,:);
    baselineFrames(j,1)= mean(xx(:,4:8),2);
end

%%%%%%%%%%%%%%%%%%%%%%%%Stimwise classificaton of that cell for checking if they are responsing one %%%%
% Initialize a cell array to store the trials for each stimulus
stimuli = cell(1, 16);
stimorder=reshape(stimcode',1,80);
for stim=1:16
    inx=find(stimorder==stim);
      % for all the stimcode, if the stimcode is same as the stim among all iterations, 
      % then keep cell_dff for taht particular stim in the sig_cell_stimwise matrix as columns 
      % and rows as cells   
      for i = 1:length(inx)
            celldata_stimwise(i,:)=celldata(inx(i),:); % 100* 5*40 matrixoif singel stimuli 
        % get cell data for that particular stim
      end % verified 

        hValues =zeros(1,9); % Initialize an empty array to store h values
        for n = 0:9 % For each segment size (3, 6, 9, ..., 30)
            segmentSize = 3 * (n + 1); % Calculate the segment size
            if 9 + segmentSize - 1 <= size(celldata_stimwise, 2) % Ensure we don't exceed the matrix dimensions
                segmentFrames = mean(celldata_stimwise(:, 9:9+segmentSize-1),2);
                % Perform a t-test on the baseline and segment frames with bonferroni correction
                [h, ~] = ttest2(baselineFrames(:), segmentFrames(:), 'Alpha', alpha);
                hValues(n+1) = h; % Store the h value for this segment
            end
        end
        hMatrix(stim,:) =hValues; % Add the h values for this cell to the matrix
end % here we got hmatrix , which is 16*10 matrix showing taht cell responded or not 
if any(hMatrix(:) == 1) % If any cell is significant
 cell_report =1; % Get the indices of the significant cell
else
cell_report=0;
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%find periodic 
% Iterate over the data.stimcode matrix
