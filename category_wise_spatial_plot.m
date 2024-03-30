
category_wise_spatial_plot(category_index, x_pos, y_pos, category)

for i = 1:length(category_index) % For each Periodic > Aperiodic cell
    % For each Periodic > Aperiodic cell
    ci = category_index(i);
   %calculate distance with x_pos and y_pos
    distances = sqrt((x_pos - x_pos(ci)).^2 + (y_pos - y_pos(ci)).^2); 
    