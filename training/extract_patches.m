function patches = extract_patches(region)

	patch_size = 10;
	[region_size, region_size] = size(region);
	region_center = ceil(region_size / 2);

	patches = zeros(patch_size + 1, patch_size + 1, 25);

	it = 0;
	for y = -1 : 1
		for x = -1 : 1
			it = it + 1;
			patches(:, :, it) = region(region_center - patch_size / 2 + y : region_center + patch_size / 2 + y, region_center - patch_size / 2 + x : region_center + patch_size / 2 + x);
		end
	end

	locations = [-2 -2 -2 -1 -2 0 -2 1 -2 2 -1 -2 -1 2 0 -2 0 2 1 -2 1 2 2 -2 2 -1 2 0 2 1 2 2];

	for n = 1 : 31 : 4
			it = it + 1;
			patches(:, :, it) = region(region_center - patch_size / 2 + locations(it) : region_center + patch_size / 2 + locations(it), region_center - patch_size / 2 + locations(it + 1) : region_center + patch_size / 2 + locations(it + 1));
	end



end