function output = earth_accel_magsC
    data = get_dataC;
    dt = 1/100;
    acc = data(:,2:4);
    gyr = data(:,5:7);
    euler = data(:,8:10);
    quat = data(:,17:20);
    linacc = data(:,11:13);
    
    earth_accel = (quaternRotate([linacc(:,1) linacc(:,2) linacc(:,3)], quaternConj(quat)))*9.80665; % Forces linear accel into Earth frame, and converts to m/s/s

%     x = [];
%     for i = 1:length(earth_accel)
%         x = [x; i];
%     end
    mag = sqrt((earth_accel(:,1)).^2 + (earth_accel(:,2)).^2 + (earth_accel(:,3)).^2); %Magnitude of acceleration vector (earth frame)

  output = [mag earth_accel];
    
end
