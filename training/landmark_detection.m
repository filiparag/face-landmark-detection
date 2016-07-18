function result = landmark_detection()

	[keypoints image face] = import_face(250);

	landmarks = import_landmarks(250);

	roi = regions_of_interest(landmarks, image);

	patches = extract_patches(roi(:, :, 10));
    
end