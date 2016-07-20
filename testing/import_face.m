function [points, image] = import_face(fileIndex)

	fid = fopen(['../training/database/' int2str(fileIndex) '.keypoints']);

	points = [];

	for it = 1 : 3
		x = str2num(fgetl(fid));
		y = str2num(fgetl(fid));
		points = [points x y];
	end

	fclose(fid);

	image = im2double(imread(['../training/database/' int2str(fileIndex) '.png']));

	if(size(size(image))) == [1 3]
		image = rgb2gray(image);
	end

end