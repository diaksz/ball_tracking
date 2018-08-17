function output = filter_posnsC
%% Import Data
linPos = get_linPosC*3.28084;
pos_x = linPos(:,1);
pos_y = linPos(:,2);
pos_z = linPos(:,3);
old_pos_y = pos_y;
old_pos_x = pos_x;
linacc = earth_accel_magsC;
mags = linacc(:,1);
linaccx = linacc(:,2);
linaccy = linacc(:,3);
linaccz = linacc(:,4);
data = [linacc linPos];

%% Filter Based on Shock
% pos_ind = find(pos_x>2,1); %Removes data from picking up ball
% ind = min(find(linaccx(pos_ind:end)>8,1),find(linaccz(pos_ind:end)>8,1))+pos_ind; %Filter data based on g's (NEED TO TEST CONSISTENCY)

% cond1 = data(:,5) > 4; % Filter based on pos_x
cond2 = data(:,1) > 50;  %Filter based on g force
% cond = cond1 & cond2;
ind = find(cond2,1);% ind = find(cond,1) + 25;


pos_x = pos_x(1:ind);
pos_y = pos_y(1:ind);
pos_z = pos_z(1:ind);

%% Correct Misalignment
% pos_y = pos_y + pos_x/5; %Correct misalignment: C
% 
 output = [pos_x pos_y pos_z];
end

