classdef result
properties
	given given
	material material
	C
	d
	D
	K_w
	K_s
	S_u
	S_y
	S_sy
	S_s
end
methods
function self = result(given, material, C, d)
	self.given = given;
	self.material = material;
	self.C = C;
	self.d = d;
	self.D = C*d;
	self.K_w = (4*C-1)/(4*C-4)+0.615/C;
	self.K_s = 1+0.5/C;
	self.S_u = material.find_strength(d);
	self.S_y = self.S_u*given.S_y_percentage;
	self.S_sy = self.S_u*given.S_sy_percentage;
	self.S_s = self.S_u*given.S_s_percentage;
end
function N_a = find_yield_limit(self)
end
function N_a = find_surge_limit(self)
end
function N_a = find_fatigue_limit(self)
end
function N_a = find_buckling_limit(self)
end
function print(self)
	file = printer('ME424_Project3_Gecgel_Sipahioglu.txt');
	file.print('F_min = %e N', self.given.F_min);
	file.print('F_max = %e N', self.given.F_max);
	file.print('d = %e m', self.d);
	file.print('C = %e', self.C);
	file.print('D = %e m', self.D);
	file.close();
end
end
end
