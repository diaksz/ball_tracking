function output = filter_posns
%% Import Data
linPos = data_crunching;
linPos = linPos(:,9:11);
pos_x = linPos(:,1);
pos_y = linPos(:,2);
pos_z = linPos(:,3);
old_pos_y = pos_y;
old_pos_x = pos_x;

%% Filter Based on Shock
pos_ind = find(pos_x>2,1); %Removes data from picking up ball
% ind = min(find(linaccx(pos_ind:end)>8,1),find(linaccz(pos_ind:end)>8,1))+pos_ind; %Filter data based on g's (NEED TO TEST CONSISTENCY)

% pos_x = pos_x(1:ind);
% pos_y = pos_y(1:ind);
% pos_z = pos_z(1:ind);

%% Correct Misalignment
%  pos_y = old_pos_y + old_pos_x/12.3; %Correct misalignment: 69 --> 12.3164
pos_y = old_pos_y + old_pos_x/5; %Correct misalignment: C
% pos_y = old_pos_y + old_pos_x/-40; %Correct misalignment: D

output = [pos_x pos_y pos_z];
end

