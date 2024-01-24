
clear, clc

addpath('../hhd_2d')

load('data/pancrea_2d_umap.mat')
%% preprocessing the data

[X, Y, U] = preprocess_data(x_grid, y_grid, u_grid, v_grid);

% get the original 1-form
omega_ori = vecfVert_to_1forms(U); 

% Hodge decomposition
[omega, curl_free, div_free, har] = hhd(omega_ori, X, Y, bf_grid);

%  plot_results
plot_hhdresult(omega, curl_free, div_free, har, X, Y)
