function output = earth_accel_mags
    data = get_data;
    data = get_data;
    dt = .01;
    acc = data(:,2:4);
    gyr = data(:,5:7);
    euler = data(:,8:10);
    quat = data(:,17:20);
    linacc = data(:,11:13);
    indices = find_start_and_stop;
    start = indices(:,1);
    %stop = indices(:,2);
    
    earth_accel = (quaternRotate([linacc(:,1) linacc(:,2) linacc(:,3)], quaternConj(quat)))*9.80665;

      x = [];
      for i = 1:length(earth_accel)
          x = [x; i];
      end
      earth_accel = [x earth_accel];
 
    cond1 = earth_accel(:,1) < start;
    earth_accel(cond1,:) = [];

%     cond2 = earth_accel(:,1) > ;
%     earth_accel(cond2,:) = [];

    output = earth_accel;

end