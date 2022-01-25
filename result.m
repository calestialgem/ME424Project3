classdef result
properties
	given given
	material material
	C
	d
	D
end
methods
function self = result(given, material, C, d)
	self.given = given;
	self.material = material;
	self.C = C;
	self.d = d;
	self.D = self.C*self.d;
end
function self = print(self)
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
