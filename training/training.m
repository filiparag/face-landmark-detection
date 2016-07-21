function [] = training()

	for r = 1 : 20 % 20

		load(['processed/training_feature_vector_' num2str(r)]);
		load(['processed/training_truth_' num2str(r)]);

		['Training: ' num2str(r) ' / 20']

		roi_gentleboost = fitensemble(roi_bank, roi_response, 'GentleBoost', 500, 'Tree');

		save(['boosters/training_roi_' num2str(r)], 'roi_gentleboost');

	end
  
end