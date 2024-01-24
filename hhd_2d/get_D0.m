
function D0 = get_D0(grid_size)

    numV = grid_size*grid_size;
    numE = 2*(grid_size-1)*grid_size;

    D0 = sparse(numE, numV);

    for indE = 1:numE
    
        [i, j, d] = indE_to_ijd(indE, grid_size);
        
        indV = ij_to_indV(i, j, grid_size);
    
        D0(indE, indV) = -1;
        
        if d == 0
            indV = ij_to_indV(i+1, j, grid_size);
        else 
            indV = ij_to_indV(i, j+1, grid_size);
        end
    
        D0(indE,indV) = 1; 
    
    end
end
