function [] = training()

	averageError = 0;
    
    fileError = fopen('error.txt','w');

	for r = 1 : 20 % 1 : 20

		load(['processed/training_feature_vector_' num2str(r)]);
		load(['processed/training_truth_' num2str(r)]);

		['Training: ' num2str(r) ' / 20']

		cvpart = cvpartition(roi_response,'holdout',0.3);
		Xtrain = roi_bank(training(cvpart),:);
		Ytrain = roi_response(1, training(cvpart));
		Xtest = roi_bank(test(cvpart),:);
		Ytest = roi_response(1, test(cvpart),:);

		% tic
		% roi_gentleboost = fitensemble(roi_bank(1:10250, :), roi_response(1:10250), 'GentleBoost', 50, 'Tree', 'Holdout', 0.3);
		
		roi_gentleboost = fitensemble(Xtrain,Ytrain, 'GentleBoost', 1000, 'Tree');
		% roi_gentleboostCV = fitensemble(Xtrain,Ytrain, 'GentleBoost', 750, 'Tree', 'kfold', 5);
		% toc

		figure(r);
		plot(loss(roi_gentleboost,Xtest,Ytest,'mode','cumulative'));
        title(['Cumulative error for ROI #' num2str(r)]);
		xlabel('Number of trees');
		ylabel('Test classification error');

		% figure;
		% plot(loss(roi_gentleboost,Xtest,Ytest,'mode','cumulative'));
		% % hold on;
		% % plot(kfoldLoss(roi_gentleboostCV,'mode','cumulative'),'r.');
		% % hold off;
		% xlabel('Number of trees');
		% ylabel('Classification error');
		% % legend('Test','Cross-validation','Location','NE');
		% legend('Test','Location','NE');
		% title(['Cumulative error for ROI #' num2str(r)]);
		saveas(gcf, ['plot/' num2str(r) '.png']);
		close all;

		err = mean(loss(roi_gentleboost,Xtest,Ytest,'mode','cumulative'))
        fprintf(fileError,'ROI %d error: %d\n', round(r), err);
        
		averageError = averageError + mean(loss(roi_gentleboost,Xtest,Ytest,'mode','cumulative'));

		save(['boosters/training_roi_' num2str(r)], 'roi_gentleboost', '-v7.3');
		% save(['boosters/training_roi_cv_' num2str(r)], 'roi_gentleboostCV', '-v7.3');

	end

	averageError = averageError / 20
    fprintf(fileError, 'Average error: %d\n', averageError);
  
    fclose(fileError);
    
end