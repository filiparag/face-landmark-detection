function result = test_detection()

	addpath('../training/');

	load('../training/training_roi_10.mat');

	[keypoints image] = import_face(102);

	roi = regions_of_interest(keypoints, image);

	wavelengths = [2 4 6 8 10 12];
	orientations = [0 22.5 45 67.5 90 112.5 135 157.5];

	bank = gabor_bank(roi{10}, 13, wavelengths, orientations, 0, 1, 0.5);
	bank(:, :, 49) = roi{10};

	bank = bank(1 : 13, 1 : 13, :);

	bank = real(bank);

	bank = reshape(bank, [1 8281]);

	predict(roi_gentleboost, bank)
    
end