classdef material
	properties
		name
		d_min
		d_max
		b
		A
		cost_mul
	end
	methods
		function self = material(name, d_min, d_max, b, A, cost_mul)
			self.name = name;
			self.d_min = d_min;
			self.d_max = d_max;
			self.b = b;
			self.A = A;
			self.cost_mul = cost_mul;
		end
		function d_range = find_in_range_diameters(self, d_values)
			d_range = d_values((d_values>=d_min)&(d_values<=d_max));
		end
		function S_u = find_strength(self, d)
			S_u = self.A*(d/1e-3)^self.b;
		end
		function cost = find_cost(self, d, N_t, D)
			cost = self.cost_mul*d^2*N_t*D;
		end
	end
end
