function output = data_crunchingC
    
    accels = earth_accel_magsC;
    mags = accels(:,1);
    accels = accels(:,2:4);
    hoop = make_hoop;
    z_end = hoop(1,63);

    velocity = get_linVel;
    posn = get_linPos*3.28084; % Convert from meters to feet
    start = find_start_and_stop;
    
    x = [];
    for i = 1:length(accels)
        x = [x;i];
    end
    
    filtered_data = [x mags accels velocity posn];
    
    output = filtered_data;
end
    
    