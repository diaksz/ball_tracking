function output = get_linVel69
    accels = earth_accel_mags69;
    accels = accels(:,2:4);
    dt = 1/100;
    
    linvel = zeros(size(accels));
    

%     for i = 2:length(linvel)
%         linvel(i,:) = linvel(i-1,:) + accels(i,:) * dt;
%     end

linvel(:,1) = cumtrapz(accels(:,1))/100;
linvel(:,2) = cumtrapz(accels(:,2))/100;
linvel(:,3) = cumtrapz(accels(:,3))/100;
    
    output = linvel;
    
end