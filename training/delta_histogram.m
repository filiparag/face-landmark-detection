function [histogram] = delta_histogram(input_array)

	% def calculateDeltaHistograms(image):

	%    differenceTreshold = 3
	%    horizontalHistogram, verticalHistogram = [0] * len(image[0]), [0] * len(image)

	%    for point, row in enumerate(image):
	%        for i in range(1, len(row)):
	%            if abs(int(row[i]) - int(row[i - 1])) > differenceTreshold:
	%                verticalHistogram[point] += abs(int(row[i]) - int(row[i - 1]))

	%    for point, column in enumerate(image.transpose()):
	%        for i in range(1, len(column)):
	%            if abs(int(column[i]) - int(column[i - 1])):
	%                horizontalHistogram[point] += abs(int(column[i]) - int(column[i - 1]))

	%    return horizontalHistogram, verticalHistogram	

	input_array = int16(input_array * 255);
	input_array = input_array.';

	difference_treshold = 7;

	[width, height] = size(input_array);

	histogram = zeros(height);

	for y = 1 : height
		for x = 2 : width
			if abs(int16(input_array(x, y)) - int16(input_array(x - 1, y))) > difference_treshold
				histogram(y) = histogram(y) + abs(int16(input_array(x, y)) - int16(input_array(x - 1, y)));
			end
		end
	end

	histogram = int16(histogram * 0.1);

end