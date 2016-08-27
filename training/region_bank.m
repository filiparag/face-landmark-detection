function [bank, response] = region_bank(region)

	wavelengths = [2 4 6 8 10 12];
	orientations = [0 22.5 45 67.5 90 112.5 135 157.5];

	bank = zeros(13 * 13 * 49, 25);

    g = gabor(wavelengths,orientations);
    
	[patches, response] = extract_patches(region);
	for b = 1 : 25
        bnk = reshape(imgaborfilt(patches(:, :, 1), g), 1, 8112);
		bnk(8113 : 8281) = reshape(patches(:, :, b), 1, 169);
		bank(:, b) = bnk;
	end

end