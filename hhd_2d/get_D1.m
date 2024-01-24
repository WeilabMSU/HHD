
function D1 = get_D1(grid_size)
    numE = 2*(grid_size-1)*grid_size;
    numF = (grid_size-1)*(grid_size-1);

    D1 = sparse(numF, numE);

    for indF = 1:numF
    
        [i, j] = indF_to_ij(indF, grid_size);
    
        D1(indF, ijd_to_indE(i, j, 0, grid_size)) = 1;
        D1(indF, ijd_to_indE(i, j, 1, grid_size)) = -1;
        D1(indF, ijd_to_indE(i+1, j, 1, grid_size)) = 1;
        D1(indF, ijd_to_indE(i, j+1, 0, grid_size)) = -1;
    end
end