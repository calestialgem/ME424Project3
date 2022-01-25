classdef material
	properties
		name
		d_range
		b
		A
		cost_mul
	end
	methods
		function self = material(name, d_min, d_max, b, A, cost_mul)
			persistent d_standards
			if isempty(d_standards)
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
			end
			self.name = name;
			self.d_range = d_standards((d_standards>=d_min)&(d_standards<=d_max));
			self.b = b;
			self.A = A;
			self.cost_mul = cost_mul;
		end
		function S_u = find_strength(self, d)
			S_u = self.A*(d/1e-3)^self.b;
		end
		function cost = find_cost(self, d, N_t, D)
			cost = self.cost_mul*d^2*N_t*D;
		end
	end
end
