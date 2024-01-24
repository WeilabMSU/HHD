
function [i, j, direction] = indE_to_ijd(indE, grid_size)

   direction = floor((indE-1)/((grid_size-1)*grid_size));
   
   if direction == 0 % horizontal
       i = mod(indE-1, grid_size-1) + 1;
       j = floor((indE-1)/(grid_size-1)) + 1;
   else % vertical
       i = mod(indE-(grid_size-1)*grid_size-1, grid_size) + 1; 
       j = floor((indE-(grid_size-1)*grid_size-1)/grid_size) + 1;
   end
end