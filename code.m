% 24.01.2022 gecgelcem
% BOUN ME 424

a = 3;
b = 1;
C_min = 4;
C_max = 12;
d_standards = [
	0.10
	0.12
	0.16
	0.20
	0.25
	0.30
	0.35
	0.40
	0.45
	0.50
	0.55
	0.60
	0.65
	0.70
	0.80
	0.90
	1.00
	1.10
	1.20
	1.40
	1.60
	1.80
	2.00
	2.20
	2.50
	2.80
	3.00
	3.50
	4.00
	4.50
	5.00
	5.50
	6.00
	6.50
	7.00
	8.00
	9.00
	10.0
	11.0
	12.0
	13.0
	14.0
]*1e-3;

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

function S_u = f_S_u(material, d)
	persistent materials
	if isempty(materials)
		materials = [
			-0.1822 1753.3e6
			-0.1625 2153.3e6
			-0.1833 1831.2e6
			-0.1453 1909.9e6
			-0.0934 2059.2e6
		];
	end
	S_u = materials(material, 2)*(d*1e3)^materials(material, 1);
end

function delta_cl = f_delta_cl(delta_working)
	delta_cl = 0.1*delta_working;
end

function SF_surge = f_SF_surge(f_n, f)
	SF_surge = f_n/f;
end

function cost = f_cost(material, d, N_t, D)
	persistent materials
    if isempty(materials)
        materials = [
        	100
        	200
        	130
            250
            400
        ]*1e6;
    end
	cost = materials(material)*d^2*N_t*D;
end
