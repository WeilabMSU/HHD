
function [P2, S2] = get_P2S2(X, Y, bf_grid, key)

grid_size = size(X, 1);

if nargin < 4
    key = "normal";
end

epsilon = 1e-5;
numF = (grid_size-1)*(grid_size-1);

P2 = sparse(numF, numF);
S2 = sparse(numF, numF);

n = 1;
for indF = 1: numF

    [i, j] = indF_to_ij(indF, grid_size);

    if key == "normal"

        f0 = boundary_function(X(j,i), Y(j,i), bf_grid);
        f1 = boundary_function(X(j,i+1), Y(j,i+1), bf_grid);
        f2 = boundary_function(X(j+1,i), Y(j+1,i), bf_grid);
        f3 = boundary_function(X(j+1, i+1), Y(j+1, i+1), bf_grid);

        if(f0<=0 || f1<=0 || f2<=0 || f3<=0) % normal % the dual cell volume is unchanged

            S2(indF, indF) = 1/max(get_primal_Farea(f0, f1, f2, f3), epsilon^2);
            P2(n, indF) = 1;
            n = n+1;
        end
        
    elseif key == "tangential"

        f0 = boundary_function(X(j,i)+1/2, Y(j,i)+1/2, bf_grid);

        if f0 <= 0 % tangential % the primal cell volume is unchanged

            S2(indF, indF) = 1;
            P2(n, indF) = 1;
            n = n+1;
        end
    end

end
P2( ~any(P2,2), : ) = [];

end
