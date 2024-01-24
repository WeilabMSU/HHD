
function [P0, S0] = get_P0S0(X, Y, bf_grid, key)

grid_size = size(X, 1);

if nargin < 4
    key = "normal";
end

numV = grid_size*grid_size;

P0 = sparse(numV, numV);
S0 = sparse(numV, numV);

n = 1;
for indV = 1: numV

    [i, j] = indV_to_ij(indV, grid_size);

    if key == "normal"

        f0 = boundary_function(X(j,i), Y(j,i), bf_grid);
        
        if f0<=0
            % the dual cell volume is unchanged
            S0(indV, indV) = 1;
            P0(n, indV) = 1;
            n = n+1;
        end

    elseif key == "tangential" 
        
        f0 = boundary_function(X(j,i)-1/2, Y(j,i)-1/2, bf_grid);
        f1 = boundary_function(X(j,i)+1/2, Y(j,i)-1/2, bf_grid);
        f2 = boundary_function(X(j,i)-1/2, Y(j,i)+1/2, bf_grid);
        f3 = boundary_function(X(j,i)+1/2, Y(j,i)+1/2, bf_grid);

        if (f0<=0 || f1<=0 || f2<=0 || f3<=0)
        
            S0(indV, indV) = get_dual_Farea(f0, f1, f2, f3);
            P0(n, indV) = 1;
            n = n+1;
        end
    end
end
P0( ~any(P0,2), : ) = [];

end
