clc();
clear();
close('all');

% Cem GEÇGEL					2018405033	a = 3
% Mustafa Çağatay SİPAHİOĞLU	2018405171	b = 1
given = given(3, 1);
materials = [
	material("A227", 0.5e-3, 16e-3, -0.1822, 1753.3e6, 100e6)
	material("A228", 0.3e-3,  6e-3, -0.1625, 2153.3e6, 200e6)
	material("A229", 0.5e-3, 16e-3, -0.1833, 1831.2e6, 130e6)
	material("A232", 0.5e-3, 12e-3, -0.1453, 1909.9e6, 250e6)
	material("A401", 0.8e-3, 11e-3, -0.0934, 2059.2e6, 400e6)
];

result = result(given, materials(1), 8, 1e-3);
result.print();

function k = f_k(d, C, N_a)
	k = 79e9*d/8/C^3/N_a;
end

function L_s = f_L_s(N_t, d)
	L_s = (N_t+1)*d;
end

function N_a = f_N_a(N_t)
	N_a = N_t-2;
end

function SF_sy = f_SF_sy(S_ys, tau_max)
	SF_sy = S_ys/tau_max;
end

function delta_cl = f_delta_cl(delta_working)
	delta_cl = 0.1*delta_working;
end

function SF_surge = f_SF_surge(f_n, f)
	SF_surge = f_n/f;
end
