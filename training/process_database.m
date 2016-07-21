function [] = process_database()

	for r = 1 : 20 % 20

		['Processing: ' num2str(r) ' / 20']

		roi_bank = [];
		roi_response = [];

		for f = 1 : 593 % 410 / 593

			[keypoints image] = import_face(f - 1);

			landmarks = import_landmarks(f - 1);

			roi = regions_of_interest(landmarks, image);

			[bank, response] = region_bank(roi(:, :, r));

		  bank = real(bank);
		  bank = permute(bank, [2 1]);

		  roi_bank((f - 1) * 25 + 1 : f * 25, :) = bank;
		  roi_response = [roi_response response];

		end

		save(['processed/training_feature_vector_' num2str(r)], 'roi_bank');
		save(['processed/training_truth_' num2str(r)], 'roi_response');

	end

end