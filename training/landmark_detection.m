function result = landmark_detection()

	[keypoints image face] = import_face(250);

	landmarks = import_landmarks(250);

	roi = regions_of_interest(landmarks, image);

	for r = 1 : 1 %20
		[bank, response] = region_bank(roi(:, :, r));
  end

  bank = real(bank);

	gentle = fitensemble(bank, response, 'GentleBoost', 5, 'Tree');

	% Yfit = predict(gentle, elements)
  
end