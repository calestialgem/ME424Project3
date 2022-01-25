classdef given
properties
	a
	b
	f
	F_min
	F_max
	delta_max
	M
	C_min
	C_max
	SF_yield_min
	SF_surge_min
	S_s_percentage
	SF_fatigue_min
	SF_buckling_min
end
methods
function self = given(a, b)
	self.a = a;
	self.b = b;
	self.f = (200+3*self.b)/60;
	self.F_min = 100+12*self.a;
	self.F_max = 800+12*self.a;
	self.delta_max = (20+0.5*self.b)*1e-3;
	self.M = 0.3+0.05*self.a;
	self.C_min = 4;
	self.C_max = 12;
	self.SF_yield_min = 1;
	self.SF_surge_min = 5;
	self.S_s_percentage = 36.3424;
	self.SF_fatigue_min = 1.2;
	self.SF_buckling_min = 1.5;
end
end
end
