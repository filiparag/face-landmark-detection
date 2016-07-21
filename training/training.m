function [] = training()

	for r = 1 : 20 % 20

		load(['processed/training_feature_vector_' num2str(r)]);
		load(['processed/training_truth_' num2str(r)]);

		['Training: ' num2str(r) ' / 20']

		roi_gentleboost = fitensemble(roi_bank(1:10250, :), roi_response(1:10250), 'GentleBoost', 500, 'Tree');

		save(['boosters/training_roi_' num2str(r)], 'roi_gentleboost');

	end
  
end