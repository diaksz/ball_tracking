function output = data_crunching
    
    accels = earth_accel_mags69;
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
    
%       cond1 = filtered_data(:,1) < start;   % Filters data before the throw
%       filtered_data(cond1,:) = [];
%       
%       cond3 = filtered_data(:,11) < z_end;  % Stops plotting once the ball reaches the z-plane of the hoop. 
%       cond4 = filtered_data(:,8) < 0;
%       cond3_and_4 = cond3 & cond4;
%       filtered_data(cond3_and_4,:) = [];
%       
%       another_cond1 = filtered_data(:,7) < 0;    % Doesn't plot when the ball moves in -y dir AND when it is in front of the rim (in case of bank shot)
%       another_cond2 = filtered_data(:,10) < 12;  %          - This should allow us to plot multiple shots from the same ball 
%       another_cond = another_cond1 & another_cond2;  %      - TO DO: Change the color of each shot (add another column to the data of ball color to denote each shot??)
%       filtered_data(another_cond,:) = []; 
    
    output = filtered_data;
end
    
    