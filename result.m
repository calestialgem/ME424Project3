classdef result
properties
	given given
	material material
	C
	d
	N_t
	cost
end
methods
function self = result(given, material, C, d)
	self.given = given;
	self.material = material;
	self.C = C;
	self.d = d;
	N_t_max = min(self.find_surge_limit(), self.find_buckling_limit());
	N_t_min = self.find_yield_limit();
	if N_t_min > N_t_max
		self.cost = inf;
		return
	end
	self.N_t = N_t_min;
	self.cost = material.find_cost(d, self.N_t, C*d);
end
function N_t_min = find_yield_limit(self)
	K_s = 1+0.5/self.C;
	S_ut = self.material.find_strength(self.d);
	S_ys = S_ut*self.given.S_ys_percentage;
	N_a_min = K_s*1.1*self.given.delta_max*self.given.G*self.given.SF_yield_min/pi/self.d/self.C^2/S_ys;
	N_t_min = N_a_min+2;
end
function N_t_max = find_surge_limit(self)
	N_a_max = self.given.G*self.d*pi^2/8/self.C^3/self.given.M/self.given.SF_surge_min^2*self.given.f^2;
	N_t_max = N_a_max+2;
end
function N_t_max = find_buckling_limit(self)
	D = self.C*self.d;
	delta_cr_min = self.given.SF_buckling_min*self.given.delta_max;
	L_f_max = max(self.given.c_1*self.given.c_2*D^2/2/delta_cr_min/self.given.alpha+delta_cr_min/2/self.given.c_1, sqrt(self.given.c_2)*D/self.given.alpha);
	L_s_max = L_f_max-1.1*self.given.delta_max;
	N_t_max = L_s_max/self.d-1;
end
function print(self)
	D = self.C*self.d;
	N_a = self.N_t-2;
	k = self.given.G*self.d/8/self.C^3/N_a;
	L_s = (self.N_t+1)*self.d;
	L_f = L_s+1.1*self.given.delta_max;
	F_s = k*1.1*self.given.delta_max;
	K_s = 1+0.5/self.C;
	K_w = (4*self.C-1)/(4*self.C-4)+0.615/self.C;
	lambda_eff = 0.5*L_f/D;
	if self.given.c_2/lambda_eff^2 <= 1
		delta_cr = L_f*self.given.c_1*(1-sqrt(1-self.given.c_2/lambda_eff^2));
		SF_buckling = delta_cr/self.given.delta_max;
	else
		SF_buckling = inf;
	end
	m = pi*self.d^2/4*pi*D*N_a*self.given.rho;
	f_n = pi*sqrt(k/self.given.M);
	SF_surge = f_n/self.given.f;
	S_ut = self.material.find_strength(self.d);
	S_us = S_ut*self.given.S_us_percentage;
	S_y = S_ut*self.given.S_y_percentage;
	S_ys = S_ut*self.given.S_ys_percentage;
	tau_s = K_s*8*F_s*self.C/pi/self.d^2;
	SF_yield = S_ys/tau_s;
	S_s = S_ut*self.given.S_s_percentage;
	file = printer('ME424_Project3_Gecgel_Sipahioglu.txt');
	file.print('F_min = %g N', self.given.F_min);
	file.print('F_max = %g N', self.given.F_max);
	file.print('d = %g m', self.d);
	file.print('C = %g', self.C);
	file.print('D = %g m', D);
	file.print('delta_cl = %g m', 0.1*self.given.delta_max);
	file.print('k = %g N/m', k);
	file.print('N_a = %g', N_a);
	file.print('N_t = %g', self.N_t);
	file.print('L_s = %g m', L_s);
	file.print('L_f = %g m', L_f);
	file.print('F_s = %g N', F_s);
	file.print('K_s = %g', K_s);
	file.print('K_w = %g', K_w);
	file.print('L_f/D = %g', L_f/D);
	file.print('delta_max/L_f = %g', self.given.delta_max/L_f);
	file.print('SF_buckling = %g', SF_buckling);
	file.print('m = %g kg', m);
	file.print('f_n = %g Hz', f_n);
	file.print('SF_surge = %g', SF_surge);
	file.print('S_ut = %g Pa', S_ut);
	file.print('S_us = %g Pa', S_us);
	file.print('S_y = %g Pa', S_y);
	file.print('S_ys = %g Pa', S_ys);
	file.print('tau_s = %g Pa', tau_s);
	file.print('SF_yield = %g', SF_yield);
	file.print('S_s = %g Pa', S_s);
	file.print('cost = %g ₺', self.cost);
end
end
end
