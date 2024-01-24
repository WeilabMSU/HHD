
function [omega, curl_free, div_free, har] = hhd(omega_ori, X, Y, bf_grid)

% get all differential operators
D0 = get_D0(size(X, 1));
D1 = get_D1(size(X, 1));

[P0n, ~] = get_P0S0(X, Y, bf_grid, "normal");
[P1n, S1n] = get_P1S1(X, Y, bf_grid, "normal");

D0n_int = P1n*D0*P0n';
S1n_int = P1n*S1n*P1n';

[P1t, S1t] = get_P1S1(X, Y, bf_grid, "tangential");
[P2t, S2t] = get_P2S2(X, Y, bf_grid, "tangential");

D1t_int = P2t*D1*P1t';
S1t_int = P1t*S1t*P1t';
S2t_int = P2t*S2t*P2t';

L0n = D0n_int'*S1n_int*D0n_int;
L2t = S2t_int*D1t_int*inv(S1t_int)*D1t_int'*S2t_int;

%% Hodge decomposition
omega_n = inv(S1n_int)*P1n*omega_ori;
omega_t = P1t*omega_ori;

% curl free
cfp_n = L0n \ D0n_int'*S1n_int*omega_n;
curl_free_n = D0n_int*cfp_n;

% div free
dfp_t = L2t \ S2t_int*D1t_int*omega_t;
div_free_t = inv(S1t_int)*D1t_int'*S2t_int*dfp_t;

% projected back to the whole grid
omega = P1t'*omega_t;
curl_free = P1n'*S1n_int*curl_free_n;
div_free = P1t'*div_free_t;
har = P1t'*omega_t - curl_free - div_free;

end