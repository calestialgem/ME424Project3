classdef result
properties
	given given
	material material
	C
	d
	D
	K_w
	K_s
	S_ut
	S_us
	S_y
	S_ys
	S_s
	% N_a
	% lambda_eff
	% delta_cr
	% SF_buckling
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
	self.S_ut = material.find_strength(d);
	self.S_us = self.S_ut*given.S_us_percentage;
	self.S_y = self.S_ut*given.S_y_percentage;
	self.S_ys = self.S_ut*given.S_ys_percentage;
	self.S_s = self.S_ut*given.S_s_percentage;
	% lambda_eff = 0.5*L_f/D;
	% delta_cr = L_f*c_1*(1-sqrt(1-c_2/lambda_eff^2));
	% SF_buckling = delta_cr/delta_max;
end
function N_a = find_yield_limit(self)
end
function N_a = find_surge_limit(self)
end
function N_a = find_fatigue_limit(self)
end
function N_a_max = find_buckling_limit(self)
	delta_cr_min = self.given.SF_buckling_min*self.given.delta_max;
	L_f_max = max(self.given.c_1*self.given.c_2*self.D^2/2/delta_cr_min/self.given.alpha+delta_cr_min/2/self.given.c_1, sqrt(self.given.c_2)*self.D/self.given.alpha);
	L_s_max = L_f_max-1.1*self.given.delta_max;
	N_t_max = L_s_max/self.d-1;
	N_a_max = N_t_max-2;
end
function print(self)
	file = printer('ME424_Project3_Gecgel_Sipahioglu.txt');
	file.print('F_min = %e N', self.given.F_min);
	file.print('F_max = %e N', self.given.F_max);
	file.print('d = %e m', self.d);
	file.print('C = %e', self.C);
	file.print('D = %e m', self.D);
	file.print('S_ut = %e Pa', self.S_ut);
	file.print('S_us = %e Pa', self.S_us);
	file.print('S_y = %e Pa', self.S_y);
	file.print('S_ys = %e Pa', self.S_ys);
	file.print('S_s = %e Pa', self.S_s);
end
end
end
