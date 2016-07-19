function patches = extract_patches(region)

figure, imshow(region);
hold on
	patch_size = 13;
	half_patch = floor(patch_size / 2);
	[region_size, region_size] = size(region);
	region_center = ceil(region_size / 2);

	patches = zeros(patch_size + 1, patch_size + 1, 25);

	it = 0;
	for y = -1 : 1
		for x = -1 : 1
			it = it + 1;

			patches(:, :, it) = region(region_center - half_patch + y : region_center + half_patch + y + 1, region_center - half_patch + x : region_center + half_patch + x + 1);
		
rectangle('Position', [region_center + x, region_center + y, 1, 1], 'Curvature', [0 0], 'EdgeColor', 'g', 'LineWidth', 1);

		end
	end

% 	locations = [-2 -2 -2 0 -2 2 0 -2 0 2 2 -2 2 0 2 2];

% 	for n = 1 : 2 : 16
% 			it = it + 1;
% 			patches(:, :, it) = region(region_center - half_patch + locations(n) : region_center + half_patch + locations(n) + 1, region_center - half_patch + locations(n + 1) : region_center + half_patch + locations(n + 1) + 1);
	
% rectangle('Position', [region_center + locations(n), region_center + locations(n + 1), 1, 1], 'Curvature', [0 0], 'EdgeColor', 'y', 'LineWidth', 1);

% 	end

	for n = 1 : 8
		distance = 0;
		while distance > 3 | distance < 2
			x = (half_patch) + round(rand() * (region_size - patch_size));
			y = (half_patch) + round(rand() * (region_size - patch_size));
			distance = sqrt((region_center - x) ^ 2 + (region_center - y) ^ 2);
		end
		it = it + 1;
		patches(:, :, it) = region(y - half_patch : y + half_patch + 1, x - half_patch : x + half_patch + 1);
	
rectangle('Position', [x, y, 1, 1], 'Curvature', [0 0], 'EdgeColor', 'y', 'LineWidth', 1);

	end

	for n = 1 : 8
		distance = 0;
		while distance < 3
			x = (half_patch) + round(rand() * (region_size - patch_size));
			y = (half_patch) + round(rand() * (region_size - patch_size));
			distance = sqrt((region_center - x) ^ 2 + (region_center - y) ^ 2);
		end
		it = it + 1;
		patches(:, :, it) = region(y - half_patch : y + half_patch + 1, x - half_patch : x + half_patch + 1);
	
rectangle('Position', [x, y, 1, 1], 'Curvature', [0 0], 'EdgeColor', 'r', 'LineWidth', 1);

	end

hold off

end