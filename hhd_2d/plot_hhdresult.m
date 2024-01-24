function plot_hhdresult(omega, curl_free, div_free, har, X, Y)

grid_size = size(X,1);


vecfFace_grid_omega = one_forms_to_vecfFace(omega, grid_size);
vecfFace_grid_curl_free = one_forms_to_vecfFace(curl_free, grid_size);
vecfFace_grid_div_free = one_forms_to_vecfFace(div_free, grid_size);
vecfFace_grid_har = one_forms_to_vecfFace(har, grid_size);

%%

[center_X, center_Y] = get_center_grid(X, Y);

% the original velocity field
figure;
hold on;
quiver(center_X, center_Y, ...
    vecfFace_grid_omega(:,:,1), vecfFace_grid_omega(:,:,2), 'k');
streamslice(center_X, center_Y, ...
    vecfFace_grid_omega(:,:,1), vecfFace_grid_omega(:,:,2), 3)
title("Original")
view(0,90)


% the curl free part
figure;
quiver(center_X, center_Y, vecfFace_grid_curl_free(:,:,1), vecfFace_grid_curl_free(:,:,2), 'k');
view(0,90)
streamslice(center_X, center_Y, vecfFace_grid_curl_free(:,:,1),...
    vecfFace_grid_curl_free(:,:,2), 3)
title("curl-free")


% the div free part
figure;
quiver(center_X, center_Y, ...
    vecfFace_grid_div_free(:,:,1), vecfFace_grid_div_free(:,:,2), 'k');
title("div-free")
streamslice(center_X, center_Y, ...
    vecfFace_grid_div_free(:,:,1), vecfFace_grid_div_free(:,:,2), 3)
view(0,90)


% the harmonic part
figure;
hold on;
quiver(center_X, center_Y, ...
    vecfFace_grid_har(:,:,1), vecfFace_grid_har(:,:,2), 'k');
title("har")
streamslice(center_X, center_Y, ...
    vecfFace_grid_har(:,:,1), vecfFace_grid_har(:,:,2), 3)
view(0,90)




end