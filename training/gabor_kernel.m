function gb = gabor_kernel(dimensions, lambda, theta, psi, sigma, gamma)

    sigma = lambda/pi*sqrt(log(2)/2)*(2^sigma+1)/(2^sigma-1);
	sigma_x = sigma;
	sigma_y = sigma / gamma;

	[x, y] = meshgrid(-fix(dimensions / 2) : fix(dimensions / 2), fix(-dimensions / 2) : 1 : fix(dimensions / 2));

	x_theta = x * cos(theta*pi/180) - y * sin(theta*pi/180); % rotacija koor sistema u smeru kazaljke na satu
	y_theta = x * sin(theta*pi/180) + y * cos(theta*pi/180);
	 
	% gb = exp(-0.5 * (x_theta .^ 2 / sigma_x ^ 2 + y_theta .^ 2 / sigma_y ^ 2)) .* cos(2 * pi / lambda * x_theta + psi); % R
	gb = exp(-0.5 * (x_theta .^ 2 / sigma_x ^ 2 + y_theta .^ 2 / sigma_y ^ 2)) .* exp(i * (2 * pi / lambda * x_theta + psi)); % C

end