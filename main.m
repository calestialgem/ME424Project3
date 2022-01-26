clc();
clear();
close('all');
tic();
% Cem GEÇGEL					2018405033	a = 3
% Mustafa Çağatay SİPAHİOĞLU	2018405171	b = 1
given = given(3, 1);
materials = [
	material("A227 Cold Drawn",   0.5e-3, 16e-3, -0.1822, 1753.3e6, 100e6)...
	material("A228 Music Wire",   0.3e-3,  6e-3, -0.1625, 2153.3e6, 200e6)...
	material("A229 Oil Tempered", 0.5e-3, 16e-3, -0.1833, 1831.2e6, 130e6)...
	material("A232 Chrome-v.",    0.5e-3, 12e-3, -0.1453, 1909.9e6, 250e6)...
	material("A401 Chrome-s.",    0.8e-3, 11e-3, -0.0934, 2059.2e6, 400e6)...
];
optimum = [];
for material = materials
	for C = given.C_min:0.1:given.C_max
		for d = material.d_range
			current = result(given, material, C, d);
			if current.is_better(optimum)
				optimum = current;
			end
		end
	end
end
optimum.print();
toc();
