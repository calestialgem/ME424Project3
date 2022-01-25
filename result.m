classdef result
properties
	C
end
methods
function self = result(C)
	self.C = C;
end
function self = print(self)
	file = printer('ME424_Project3_Gecgel_Sipahioglu.txt');
	file.print('C = %.2f', self.C);
	file.close();
end
end
end
