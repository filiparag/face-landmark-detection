function [bank, response] = region_bank(region)

	wavelengths = [2 4 6 8 10 12];
	orientations = [0 22.5 45 67.5 90 112.5 135 157.5];

	bank = zeros(13, 13, 49 * 25);

	[patches, response] = extract_patches(region);
	for b = 1 : 25
		bank(:, :, (b - 1) * 49 + 1 : b * 49 - 1) = gabor_bank(patches(:, :, b), 13, wavelengths, orientations, 0, 1, 0.5);
		bank(:, :, b * 49) = patches(:, :, b);
	end

end