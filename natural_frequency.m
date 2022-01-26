clc();
clear();
close('all');
% Cem GEÇGEL					2018405033	a = 3
% Mustafa Çağatay SİPAHİOĞLU	2018405171	b = 1
given = given(3, 1);
material = material("A227 Cold Drawn",   0.5e-3, 16e-3, -0.1822, 1753.3e6, 100e6);

d = 0.0065;
C = 4.8;
D = C*d;
m = @(N_a) pi*d^2/4*pi*D*N_a*given.rho;
k = @(N_a) given.G*d/8/C^3/N_a;
m_div_k = sqrt(pi^2*d^2*2*C^4*given.rho/given.G);
m_mul_k = sqrt(pi^2*d^4/32*given.rho*given.G/C^2)/given.M;
f_n_exp = @(N_a, f_n) tan(f_n*m_div_k*N_a)-m_mul_k/f_n;
f_n = @(N_a) fzero(@(x)f_n_exp(N_a, x), sqrt(k(N_a)/given.M));

N_a = 7.45258;
f_n_range = (0.025:1:1000)*given.f;
f_n_exp_range = zeros(size(f_n_range));
for k = 1:length(f_n_range)
	f_n_exp_range(k) = f_n_exp(N_a, f_n_range(k));
end

figure();
hold('on');
grid('on');
title_string = sprintf("Natural Frequency Expression for C=%g d=%gmm N_a=%g", C, d*1e3, N_a);
title(title_string);
xlabel('f_n (Hz)');
ylabel('f_n Expression');
plot(f_n_range, f_n_exp_range, 'LineWidth', 2);
yline(0, '--', 'LineWidth', 2);
saveas(gcf, title_string + ".jpg", 'jpeg');

N_a_range = 1:1:100;
f_n_range = zeros(size(N_a_range));
for k = 1:length(N_a_range)
	f_n_range(k) = f_n(N_a_range(k));
end

figure();
hold('on');
grid('on');
title_string = sprintf("Natural Frequencies for C=%g d=%gmm", C, d*1e3);
title(title_string);
xlabel('N_a');
ylabel('f_n (Hz)');
plot(N_a_range, f_n_range, 'LineWidth', 2);
yline(given.f, '--', 'LineWidth', 2);
saveas(gcf, title_string + ".jpg", 'jpeg');
