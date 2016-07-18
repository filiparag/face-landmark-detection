function result = gabor_bank(image, kernel_size, wavelengths, orientations, phase_offset, standard_deviation, aspect_ratio)

	result = [];

	for o = 1 : 8
		for w = 1 : 6
			kernel = gabor_kernel(kernel_size, wavelengths(w), orientations(o), phase_offset, standard_deviation, aspect_ratio);	
			result(:, :, o * w) = imfilter(image, kernel);
		end
	end

end