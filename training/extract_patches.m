function [patches, response] = extract_patches(region)

	patch_size = 12;
	half_patch = floor(patch_size / 2);
	[region_size, region_size] = size(region);
	region_center = ceil(region_size / 2);

	patches = zeros(patch_size + 1, patch_size + 1, 25);

	response = [];

	it = 0;
	for y = -1 : 1
		for x = -1 : 1
			it = it + 1;
			patches(:, :, it) = region(region_center - half_patch + y : region_center + half_patch + y, region_center - half_patch + x : region_center + half_patch + x);
			response = [response 1];
		end
	end

	for n = 1 : 8
		distance = 0;
		while distance > 3 | distance < 2
			x = (half_patch) + round(rand() * (region_size - patch_size));
			y = (half_patch) + round(rand() * (region_size - patch_size));
			distance = sqrt((region_center - x) ^ 2 + (region_center - y) ^ 2);
		end
		it = it + 1;
		patches(:, :, it) = region(y - half_patch : y + half_patch, x - half_patch : x + half_patch);
		response = [response -1];
	end

	for n = 1 : 8
		distance = 0;
		while distance < 3 & (x == 0 | y == 0)
			x = (half_patch) + round(rand() * (region_size - patch_size));
			y = (half_patch) + round(rand() * (region_size - patch_size));
			distance = sqrt((region_center - x) ^ 2 + (region_center - y) ^ 2);
		end
		it = it + 1;
		patches(:, :, it) = region(y - half_patch : y + half_patch, x - half_patch : x + half_patch);
		response = [response -1];
	end

end