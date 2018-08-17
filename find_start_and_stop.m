function output = find_start_and_stop
    posns = get_linPos;
    x = [];
    hoop = make_hoop;
    z_end = hoop(1,63);
    
    for i = 1:length(posns)
        x = [x;i];
    end
    
    posns = [x posns];
    
%     cond = posns(:,3) < .05;
%     posns(cond,:) = [];
    
%     cond2 = posns(:,4) < z_end;
%     stop = find(cond2-1,1);
    
    
    
    
%       cond3 = filtered_data(:,11) < z_end;  % Stops plotting once the ball reaches the z-plane of the hoop. 
%       cond4 = filtered_data(:,8) < 0;
%       cond3_and_4 = cond3 & cond4;
%       filtered_data(cond3_and_4,:) = [];
    
    output = posns(1,1);

end

    
% THIS FUNCTION RETURNS THE INDICES OF THE MAGNITUDES OF THE TWO LARGEST
% LINEAR ACCELERATIONS. SHOULD REPRESENT START AND STOP
    
%% Old Code
%     [M,I] = max(mags);  %Finds index of largest max
%     for i = 1:length(mags)
%         x = [x;i];
%     end
%     mags = [x mags];
%     x1 = I - 20;
%     x2 = I + 20;
%     cond1 = mags(:,1) > x1;
%     cond2 = mags(:,1) < x2;
%     cond = cond1 & cond2;
%     mags(cond,:) = [];
%     mags = mags(:,2);
%     
%     [X,Y] = max(mags); %Finds index of next largest max (Hopefully the catch)
%     
%     if Y>I       %Reverse start and stop if the "Throw" had a higher index
%         output = [I Y];
%     else
%         output = [Y I]; 
%     end




%     mags = earth_accel_mags;
%     mags = mags(:,1);
%     x = [];
%     
%     [M,I] = findpeaks(mags(:,1));
%     loc_max = [I M];
%     
%     cond = loc_max(:,2) < 13;
%     loc_max(cond,:) = [];
%     start = loc_max(1);
%     
%     output = start;
