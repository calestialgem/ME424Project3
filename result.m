classdef result
properties (Access = private)
	given given
	material material
	C
	d
	D
	S_ut
	S_us
	S_y
	S_ys
	S_s
	K_s
	K_w
	k
	delta_max
	delta_cl
	delta_s
	N_t
	N_a
	L_s
	L_f
	F_s
	SF_buckling
	m
	f_n
	SF_surge
	tau_s
	SF_yield
	tau_a
	tau_m
	SF_fatigue
	cost
end
methods
function self = result(given, material, C, d)
	self.given = given;
	self.material = material;
	self.C = C;
	self.d = d;
	self.D = self.C*self.d;
	self.S_ut = self.material.find_strength(self.d);
	self.S_us = self.S_ut*self.given.S_us_percentage;
	self.S_y = self.S_ut*self.given.S_y_percentage;
	self.S_ys = self.S_ut*self.given.S_ys_percentage;
	self.S_s = self.S_ut*self.given.S_s_percentage;
	self.K_s = 1+0.5/self.C;
	self.K_w = (4*self.C-1)/(4*self.C-4)+0.615/self.C;
	self.k = (self.given.F_max-self.given.F_min)/self.given.delta_working;
	self.delta_max = self.given.F_max/self.k;
	self.delta_cl = 0.1*self.given.delta_working;
	self.delta_s = self.delta_cl+self.delta_max;
	self.N_a = self.given.G*self.d/8/self.C^3/self.k;
	self.N_t = self.N_a+2;
	self.L_s = (self.N_t+1)*self.d;
	self.L_f = self.L_s+self.delta_s;
	self = self.buckling_analysis();
	self = self.surge_analysis();
	self = self.yield_analysis();
	self = self.fatigue_analysis();
	if self.SF_surge < given.SF_surge_min || self.SF_buckling < given.SF_buckling_min || self.SF_fatigue < given.SF_fatigue_min
		self.cost = inf;
		return;
	end
	% Find the cost if we reach here, the cost in infinite otherwise.
	self.cost = material.find_cost(self.d, self.N_t, self.D);
end
function print(self)
	file = printer('ME424_Project3_Gecgel_Sipahioglu.txt');
	file.print('F_min = %g N', self.given.F_min);
	file.print('F_max = %g N', self.given.F_max);
	file.print('d = %g m', self.d);
	file.print('C = %g', self.C);
	file.print('D = %g m', self.D);
	file.print('delta_cl = %g m', self.delta_cl);
	file.print('k = %g N/m', self.k);
	file.print('N_a = %g', self.N_a);
	file.print('N_t = %g', self.N_t);
	file.print('L_s = %g m', self.L_s);
	file.print('L_f = %g m', self.L_f);
	file.print('F_s = %g N', self.F_s);
	file.print('K_s = %g', self.K_s);
	file.print('K_w = %g', self.K_w);
	file.print('L_f/D = %g', self.L_f/self.D);
	file.print('delta_max/L_f = %g', self.delta_max/self.L_f);
	file.print('SF_buckling = %g', self.SF_buckling);
	file.print('m = %g kg', self.m);
	file.print('f_n = %g Hz', self.f_n);
	file.print('SF_surge = %g', self.SF_surge);
	file.print('S_ut = %g Pa', self.S_ut);
	file.print('S_us = %g Pa', self.S_us);
	file.print('S_y = %g Pa', self.S_y);
	file.print('S_ys = %g Pa', self.S_ys);
	file.print('tau_s = %g Pa', self.tau_s);
	file.print('SF_yield = %g', self.SF_yield);
	file.print('tau_a = %g Pa', self.tau_a);
	file.print('tau_m = %g Pa', self.tau_m);
	file.print('S_s = %g Pa', self.S_s);
	file.print('SF_fatigue = %g', self.SF_fatigue);
	file.print('Material = %s', self.material.name)
	file.print('cost = %g ₺', self.cost);
end
function better = is_better(self, other)
	better = isempty(other) || other.cost > self.cost;
end
end
methods (Access = private)
function self = buckling_analysis(self)
	lambda_eff = 0.5*self.L_f/self.D;
	if self.given.c_2/lambda_eff^2 <= 1
		delta_cr = self.L_f*self.given.c_1*(1-sqrt(1-self.given.c_2/lambda_eff^2));
		self.SF_buckling = delta_cr/self.delta_max;
	else
		self.SF_buckling = inf;
	end
end
function self = surge_analysis(self)
	self.m = pi*self.d^2/4*pi*self.D*self.N_a*self.given.rho;
	self.f_n = sqrt(self.k/self.given.M);
	self.SF_surge = self.f_n/self.given.f;
end
function self = yield_analysis(self)
	self.F_s = self.k*self.delta_s;
	self.tau_s = self.K_s*8*self.F_s*self.C/pi/self.d^2;
	self.SF_yield = self.S_ys/self.tau_s;
end
function self = fatigue_analysis(self)
	self.tau_a = self.K_w*8*(self.given.F_max-self.given.F_min)/2*self.C/pi/self.d^2;
	self.tau_m = self.K_w*8*abs(self.given.F_max+self.given.F_min)/2*self.C/pi/self.d^2;
	S_f = self.S_s/2/(1-self.S_s/2/self.S_us);
	self.SF_fatigue = 1/(self.tau_a/S_f+self.tau_m/self.S_us);
end
end
end
