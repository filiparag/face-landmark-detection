function regions = regions_of_interest(landmarks, image)

  ED = landmarks(3) - landmarks(1);

  % left_eyebrow_region = image(int16(landmarks(2) - 0.4 * ED) : int16(landmarks(4) - 0.05 * ED) , int16(landmarks(1) - 0.6 * ED) : int16(landmarks(1) + 0.5 * ED));
  % right_eyebrow_region = image(int16(landmarks(2) - 0.4 * ED) : int16(landmarks(4) - 0.05 * ED) , int16(landmarks(1) + 0.5 * ED) : int16(landmarks(3) + 0.6 * ED));
  % left_eye_region = image(int16(landmarks(2) - 0.25 * ED) : int16(landmarks(4) + 0.25 * ED) , int16(landmarks(1) - 0.4 * ED) : int16(landmarks(1) + 0.4 * ED));
  % right_eye_region = image(int16(landmarks(2) - 0.25 * ED) : int16(landmarks(4) + 0.25 * ED) , int16(landmarks(1) + 0.6 * ED) : int16(landmarks(3) + 0.4 * ED));
  % nose_region = image(int16(landmarks(6) - 0.7 * ED) : int16(landmarks(6) - 0.25 * ED) , int16(landmarks(5) - 0.45 * ED) : int16(landmarks(5) + 0.45 * ED));
  % mouth_region = image(int16(landmarks(6) - 0.25 * ED) : int16(landmarks(6) + 0.25 * ED) , int16(landmarks(5) - 0.55 * ED) : int16(landmarks(5) + 0.55 * ED));
  % chin_region = image(int16(landmarks(6) + 0.3 * ED) : int16(landmarks(6) + 0.55 * ED) , int16(landmarks(5) - 0.2 * ED) : int16(landmarks(5) + 0.2 * ED));

  % figure(1);
  % hold on;
  % subplot(4,3,1), subimage(left_eyebrow_region);
  % subplot(4,3,3), subimage(right_eyebrow_region);
  % subplot(4,3,4), subimage(left_eye_region);
  % subplot(4,3,6), subimage(right_eye_region);
  % subplot(4,3,5), subimage(nose_region);
  % subplot(4,3,8), subimage(mouth_region);
  % subplot(4,3,11), subimage(chin_region);
  % hold off;

  lebl = image(int16(landmarks(2) - 0.4 * ED) : int16(landmarks(2) - 0.05 * ED) , int16(landmarks(1) - 0.6 * ED) : int16(landmarks(1) + 0.1 * ED));
  lebr = image(int16(landmarks(2) - 0.4 * ED) : int16(landmarks(2) - 0.05 * ED) , int16(landmarks(1) - 0.1 * ED) : int16(landmarks(1) + 0.5 * ED));

  rebl = image(int16(landmarks(4) - 0.4 * ED) : int16(landmarks(4) - 0.05 * ED) , int16(landmarks(3) - 0.6 * ED) : int16(landmarks(3) + 0.1 * ED));
  rebr = image(int16(landmarks(4) - 0.4 * ED) : int16(landmarks(4) - 0.05 * ED) , int16(landmarks(3) - 0.1 * ED) : int16(landmarks(3) + 0.6 * ED));

  lel = image(int16(landmarks(2) - 0.20 * ED) : int16(landmarks(2) + 0.20 * ED) , int16(landmarks(1) - 0.4 * ED) : int16(landmarks(1) + 0.0 * ED));
  ler = image(int16(landmarks(2) - 0.20 * ED) : int16(landmarks(2) + 0.20 * ED) , int16(landmarks(1) - 0.0 * ED) : int16(landmarks(1) + 0.4 * ED));
  let = image(int16(landmarks(2) - 0.3 * ED) : int16(landmarks(2) + 0.0 * ED) , int16(landmarks(1) - 0.25 * ED) : int16(landmarks(1) + 0.25 * ED));
  leb = image(int16(landmarks(2) - 0.0 * ED) : int16(landmarks(2) + 0.3 * ED) , int16(landmarks(1) - 0.25 * ED) : int16(landmarks(1) + 0.25 * ED));

  rel = image(int16(landmarks(4) - 0.20 * ED) : int16(landmarks(4) + 0.20 * ED) , int16(landmarks(3) - 0.4 * ED) : int16(landmarks(3) + 0.0 * ED));
  rer = image(int16(landmarks(4) - 0.20 * ED) : int16(landmarks(4) + 0.20 * ED) , int16(landmarks(3) - 0.0 * ED) : int16(landmarks(3) + 0.4 * ED));
  ret = image(int16(landmarks(4) - 0.3 * ED) : int16(landmarks(4) + 0.0 * ED) , int16(landmarks(3) - 0.25 * ED) : int16(landmarks(3) + 0.25 * ED));
  reb = image(int16(landmarks(4) - 0.0 * ED) : int16(landmarks(4) + 0.3 * ED) , int16(landmarks(3) - 0.25 * ED) : int16(landmarks(3) + 0.25 * ED));

  nsl = image(int16(landmarks(6) - 0.7 * ED) : int16(landmarks(6) - 0.25 * ED) , int16(landmarks(5) - 0.45 * ED) : int16(landmarks(5) + 0.0 * ED));
  nst = image(int16(landmarks(6) - 0.7 * ED) : int16(landmarks(6) - 0.35 * ED) , int16(landmarks(5) - 0.20 * ED) : int16(landmarks(5) + 0.20 * ED));
  nsr = image(int16(landmarks(6) - 0.7 * ED) : int16(landmarks(6) - 0.25 * ED) , int16(landmarks(5) - 0.0 * ED) : int16(landmarks(5) + 0.45 * ED));

  mtl = image(int16(landmarks(6) - 0.25 * ED) : int16(landmarks(6) + 0.25 * ED) , int16(landmarks(5) - 0.55 * ED) : int16(landmarks(5) - 0.1 * ED));
  mtr = image(int16(landmarks(6) - 0.25 * ED) : int16(landmarks(6) + 0.25 * ED) , int16(landmarks(5) + 0.1 * ED) : int16(landmarks(5) + 0.55 * ED));
  mtt = image(int16(landmarks(6) - 0.3 * ED) : int16(landmarks(6) + 0.0 * ED) , int16(landmarks(5) - 0.2 * ED) : int16(landmarks(5) + 0.2 * ED));
  mtb = image(int16(landmarks(6) - 0.0 * ED) : int16(landmarks(6) + 0.3 * ED) , int16(landmarks(5) - 0.2 * ED) : int16(landmarks(5) + 0.2 * ED));

  chin = image(int16(landmarks(6) + 0.6 * ED) : int16(landmarks(6) + 0.9 * ED) , int16(landmarks(5) - 0.2 * ED) : int16(landmarks(5) + 0.2 * ED));

  % figure(2);
  % hold on;
  % subplot(5, 4,1), subimage(lebl);
  % subplot(5,4,2), subimage(lebr);
  % subplot(5,4,3), subimage(rebl);
  % subplot(5,4,4), subimage(rebr);

  % subplot(5,4,5), subimage(lel);
  % subplot(5,4,6), subimage(ler);
  % subplot(5,4,9), subimage(let);
  % subplot(5,4,10), subimage(leb);

  % subplot(5,4,7), subimage(rel);
  % subplot(5,4,8), subimage(rer);
  % subplot(5,4,11), subimage(ret);
  % subplot(5,4,12), subimage(reb);

  % subplot(5,4,14), subimage(nsl);
  % subplot(5,4,15), subimage(nst);
  % subplot(5,4,16), subimage(nsr);

  % subplot(5,4,17), subimage(mtl);
  % subplot(5,4,18), subimage(mtr);
  % subplot(5,4,19), subimage(mtt);
  % subplot(5,4,20), subimage(mtb);

  % subplot(5,4,13), subimage(chin);
  % hold off;

  regions = {chin, lebl, lebr, rebl, rebr, nst, nsl, nsr, lel, let, leb, ler, rel, ret, reb, rer, mtl, mtt, mtr, mtb};

end