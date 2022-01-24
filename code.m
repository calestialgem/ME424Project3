% 24.01.2022 gecgelcem
% BOUN ME 424

a = 3;
b = 1;
C_min = 4;
C_max = 12;

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

function S_y = f_S_y(S_u)
	S_y = 0.75*S_u;
end

function S_sy = f_S_sy(S_u)
	S_sy = 0.45*S_u;
end

function N_a = f_N_a(N_t)
	N_a = N_t-2;
end

function K_w = f_K_w(C)
	K_w = (4*C-1)/(4*C-4)+0.615/C;
end
