function landmarks = import_landmarks(index)

	landmarks = [];

	fid = fopen(['database/' int2str(index) '.landmarks']);

	for it = 1 : 40
		landmarks = [landmarks str2num(fgetl(fid))];
	end

	fclose(fid);

end