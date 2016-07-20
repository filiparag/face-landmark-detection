function result = landmark_detection()

	for r = 1 : 20 %20

		roi_bank = [];
		roi_response = [];

		for f = 1 : 5 % 592

			[keypoints image] = import_face(f);

			landmarks = import_landmarks(f);

			roi = regions_of_interest(landmarks, image);

			[bank, response] = region_bank(roi(:, :, r));

		  bank = real(bank);
		  bank = permute(bank, [2 1]);

		  roi_bank((f - 1) * 25 + 1 : f * 25, :) = bank;
		  roi_response = [roi_response response];

		end

		roi_gentleboost = fitensemble(roi_bank, roi_response, 'GentleBoost', 500, 'Tree');

		r

		save(['training_roi_' num2str(r)], 'roi_gentleboost');

	end
  
end