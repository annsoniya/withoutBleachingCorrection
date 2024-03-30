
function rows1= container_map_for_roi(data.db)
load('db.mat');
fname_to_rows_map= containers.Map;
for u = 1:size(db,1)
    fname = db{u,1};
    fname = fname{1};

    if isKey(fname_to_rows_map, fname)
        rows = fname_to_rows_map(fname);
        rows = [rows; u];
        fname_to_rows_map(fname) = rows;
    else
        fname_to_rows_map(fname) = [u];
    end
end

all_keys = keys(fname_to_rows_map);% all keys is each roi names 
% to get cells for each roi
for k = 1:length(all_keys)
 rows1{k}=fname_to_rows_map(all_keys{k});
end



end


