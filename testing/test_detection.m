function result = test_detection()

	addpath('../training/');

	load('../training/boosters/training_roi_5.mat');

	[keypoints image] = import_face(102);

	roi = regions_of_interest(keypoints, image);

	wavelengths = [2 4 6 8 10 12];
	orientations = [0 22.5 45 67.5 90 112.5 135 157.5];
	patch_size = 13;

	bank = gabor_bank(roi{5}, patch_size, wavelengths, orientations, 0, 1, 0.5);
	bank(:, :, 49) = roi{5};

	[bankHeight, bankWidth, bankDepth] = size(bank);

	predictions = [];

	for y = ceil(patch_size / 2) + 1 : bankHeight - ceil(patch_size / 2)
		for x = ceil(patch_size / 2) + 1 : bankWidth - ceil(patch_size / 2)
			patch_bank = bank(y - 6 : y + 6, x - 6 : x + 6, :);
			patch_bank = real(patch_bank);
			patch_bank = reshape(patch_bank, [1 8281]);
			predictions = [predictions predict(roi_gentleboost, patch_bank)];
			[x y]
		end		
	end

	predictions
	max(predictions)

end