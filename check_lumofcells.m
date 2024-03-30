for r=1:size(rows1,2)% rois
    c=rows1{r};
    %get the data of lumofcell from db
    allLumofcell=[];
    for c=1:length(c)
        lumofcell = squeeze(cell2mat(db.lumofcells(c,:)));
        % append for all cells
        allLumofcell = [allLumofcell; lumofcell];
    end
    mean_lumofcell =mean(allLumofcell,1);
    plot(mean_lumofcell);

    title(sprintf('roi = %d', r)); % Add title here
    pause
end
