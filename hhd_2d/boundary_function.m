
function f = boundary_function(x,y,bf_grid)

epsilon = 1e-5;
grid_size = size(bf_grid,1);

% here x and y may be decimal numbers but not integers
if abs(mod(x,1)) < epsilon && abs(mod(y, 1)) < epsilon
    f = bf_grid(round(y)+1, round(x)+1);
elseif abs(mod(x,1)) < epsilon && abs(mod(y,1)-1/2) < epsilon
    y0 = floor(y);
    if y0<0 || y0>=grid_size-1
        f = inf; % set the function value to be inf outside the grid
        return;
    end
    f = (bf_grid(y0+1, round(x)+1)+ bf_grid(y0+2, round(x)+1))/2;
elseif abs(mod(x,1)-1/2) < epsilon && abs(mod(y,1)) < epsilon
    x0 = floor(x);
    if x0<0 || x0>=grid_size-1
        f = inf;
        return;
    end
    f = (bf_grid(round(y)+1, x0+1)+ bf_grid(round(y)+1, x0+2))/2;
else  

    x0 = floor(x);
    y0 = floor(y);

    if x0<0 || y0<0 || x0>=grid_size-1 || y0>=grid_size-1
        f = inf;
        return;
    end

    f = (bf_grid(y0+1, x0+1) + bf_grid(y0+1, x0+2)+...
        bf_grid(y0+2, x0+1) + bf_grid(y0+2, x0+2))/4;

end
