% to plot the spacial matrix or all cells of all rois into categorie
load('roi_x_y_category.mat')
%% cell_peport values
%   0= not responded cell (for sig test )
% 1= per>Aper on tailed ttest
% 2=Aper>Per on tailed ttest
% 3= indifferent per vs aper



delta = 10; % Base distance unit, adjust as needed
maxDistance=500; % To consider distances up to 5*delta, adjust as needed
categories = [0,1,2, 3]; % Categories to compare against
% map of the cells in the 
spatialMatrix = cell(4,4);% construct a cell for all rois *all cells*4 categories*distances 
% roi dimension = 228 x 137

for r=1:length(roi_x_y_category) % each roi 
    x_pos=roi_x_y_category{r,1};
    y_pos=roi_x_y_category{r,2};
    category=roi_x_y_category{r,3};
    Numofcells=size(x_pos,2);
    
    for i=1:Numofcells-1
        for j=i+1:Numofcells
            distance = sqrt((x_pos(i)-x_pos(j))^2 + (y_pos(i)-y_pos(j))^2);
            distance = distance*1.17;
            spatialMatrix{category(i)+1,category(j)+1} = [spatialMatrix{category(i)+1,category(j)+1}, distance];
            spatialMatrix{category(j)+1,category(i)+1} = [spatialMatrix{category(j)+1,category(i)+1}, distance];

        end
    end
end
disp(r)
return
    
    % now we have the roi_x, roi_y and roi_category for all the rois
    %%%%%% for periodic matrix
    periodicCellsIndex = find(category == 1); % Index of Periodic > Aperiodic cells
    aperiodicCellsIndex = find(category == 2); % Index of Aperiodic > Periodic cells
    indifferentCellsIndex = find(category == 3); % Index of Indifferent cells
    nonRespondedCellsIndex = find(category == 0); % Index of non-responded cells
    
    % create a function  to figure out for each roi
    category_wise_spa(periodicCellsIndex, x_pos, y_pos, category)
    category_matrix(aperiodicCellsIndex, x_pos, y_pos, category)
    category_matrix(indifferentCellsIndex, x_pos, y_pos, category)
    category_matrix(nonRespondedCellsIndex, x_pos, y_pos, category)


    
    
