function regions = regions_of_interest(landmarks, image)

	region_size = 36;

	regions = zeros(region_size + 1, region_size + 1, 20);

	landmarks = landmarks.';

	for it = 1 : 2 : 40
		regions(:, :, ceil(it / 2)) = image(round(landmarks(it + 1) - region_size / 2) : round(landmarks(it + 1) + region_size / 2), round(landmarks(it) - region_size / 2) : round(landmarks(it) + region_size / 2));
	end
	
end