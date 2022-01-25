clc();
clear();
close('all');

% Given / Input
% ~~~~~~~~~~~~~
a = 3; % Cem GEÇGEL
b = 1; % Mustafa Çağatay SİPAHİOĞLU
C_min = 4;
C_max = 12;
materials = [
	material("A227", 0.5e-3, 16e-3, -0.1822, 1753.3e6, 100e6)
	material("A228", 0.3e-3,  6e-3, -0.1625, 2153.3e6, 200e6)
	material("A229", 0.5e-3, 16e-3, -0.1833, 1831.2e6, 130e6)
	material("A232", 0.5e-3, 12e-3, -0.1453, 1909.9e6, 250e6)
	material("A401", 0.8e-3, 11e-3, -0.0934, 2059.2e6, 400e6)
];

function K_w = f_K_w(C)
	K_w = (4*C-1)/(4*C-4)+0.615/C;
end

function K_s = f_K_s(C)
	K_s = 1+0.5/C;
end

function D = f_D(C, d)
	D = C*d;
end

function k = f_k(d, C, N_a)
	k = 79e9*d/8/C^3/N_a;
end

function L_s = f_L_s(N_t, d)
	L_s = (N_t+1)*d;
end

function N_a = f_N_a(N_t)
	N_a = N_t-2;
end

function SF_sy = f_SF_sy(S_sy, tau_max)
	SF_sy = S_sy/tau_max;
end

function S_sy = f_S_sy(S_u)
	S_sy = 0.45*S_u;
end

function S_y = f_S_y(S_u)
	S_y = 0.75*S_u;
end

function delta_cl = f_delta_cl(delta_working)
	delta_cl = 0.1*delta_working;
end

function SF_surge = f_SF_surge(f_n, f)
	SF_surge = f_n/f;
end

function SF_buckling = f_SF_buckling(L_f, D, delta_max)
	persistent c_1
	persistent c_2
	if isempty(c_1)
		c_1 = 200e9/2/(200e9-79e9);
		c_2 = 2*pi^2*(200e9-79e9)/(2*79e9+200e9);
	end
	lambda_eff = 0.5*L_f/D;
	delta_cr = L_f*c_1*(1-sqrt(1-c_2/lambda_eff^2));
	SF_buckling = delta_cr/delta_max;
end
