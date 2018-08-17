%% Housekeeping
 
addpath('ximu_matlab_library');	% include x-IMU MATLAB library
addpath('Quaternions');  % include quatenrion library
close all;                     	% close all figures
clear;                         	% clear all variables
clc;                          	% clear the command terminal

% delete('TrueData_CalInertialAndMag.csv');
% gyrofile = 'LoggedData/Gyroscope23.csv';
% accelfile = 'LoggedData/Accelerometer23.csv';
% offsets = 'offsets';
% 
% CreateDataFile(gyrofile,accelfile,offsets);









%% Import data
data = get_data;
dt = .01;
acc = data(:,2:4);
gyr = data(:,5:7);
euler = data(:,8:10);
quat = data(:,17:19);

counter = [];
% for i = length(acc):-1:1
%     if abs(acc(i,1))<3 && abs(acc(i,2))<3 && abs(acc(i,3))<3 
%         acc(i,1) = [];
%         acc(i,2) = [];
%         acc(i,3) = [];
%         counter = [counter; i];
%     else 
%         acc = acc;
%     end
% end
%  disp(acc);


% TF1 = abs(acc(:,1))<3;
% TF2 = abs(acc(:,2))<3;
% TF3 = abs(acc(:,3))<3;
% TFall = TF1 & TF2 & TF3;
% acc(TFall,:) = [];



% Plot
% figure('NumberTitle', 'off', 'Name', 'Gyroscope');
% hold on;
% plot(gyr(:,1), 'r');
% plot(gyr(:,2), 'g');
% plot(gyr(:,3), 'b');
% xlabel('sample');
% ylabel('dps');
% title('Gyroscope');
% legend('X', 'Y', 'Z');

figure('NumberTitle', 'off', 'Name', 'Accelerometer');
hold on;
plot(acc(:,1), 'r');
plot(acc(:,2), 'g');
plot(acc(:,3), 'b');
xlabel('sample');
ylabel('g');
title('Accelerometer');
legend('X', 'Y', 'Z');

%% Process data through AHRS algorithm (calcualte orientation)
% See: http://www.x-io.co.uk/open-source-imu-and-ahrs-algorithms/

R = zeros(3,3,length(gyr));     % rotation matrix describing sensor relative to Earth

ahrs = MahonyAHRS('SamplePeriod', dt, 'Kp', 1);

for i = 1:length(gyr)
    ahrs.UpdateIMU(gyr(i,:)*(pi/180), acc(i,:));	% gyroscope units must be radians
    R(:,:,i) = quatern2rotMat(ahrs.Quaternion)';    % transpose because ahrs provides Earth relative to sensor
end

%% Calculate 'tilt-compensated' accelerometer

tcAcc = zeros(size(acc));  % accelerometer in Earth frame

for i = 1:length(acc)
    tcAcc(i,:) = R(:,:,i) * acc(i,:)';
end




% Plot
figure('NumberTitle', 'off', 'Name', '''Tilt-Compensated'' accelerometer');
hold on;
plot(tcAcc(:,1), 'r');
plot(tcAcc(:,2), 'g');
plot(tcAcc(:,3), 'b');
xlabel('sample');
ylabel('g');
title('''Tilt-compensated'' accelerometer');
legend('X', 'Y', 'Z');

%% Calculate linear acceleration in Earth frame (subtracting gravity)

%linAcc = tcAcc - [zeros(length(tcAcc), 1), zeros(length(tcAcc), 1), ones(length(tcAcc), 1)];
 linAcc = tcAcc;
 for i = 1:length(linAcc)
     if linAcc(i,3) < 0 
         linAcc(i,3) = linAcc(i,3) + 1;
     else
         linAcc(i,3) = linAcc(i,3) - 1;
     end
 end
 
TF1 = abs(linAcc(:,1))>1;
TF2 = abs(linAcc(:,2))>1;
TF3 = abs(linAcc(:,3))>1;
TFall = TF1 & TF2 & TF3;
linAcc(TFall,:) = [];
linAcc = linAcc * 9.80665;     % convert from 'g' to m/s/s



% Plot
figure('NumberTitle', 'off', 'Name', 'Linear Acceleration');
hold on;
plot(linAcc(:,1), 'r');
plot(linAcc(:,2), 'g');
plot(linAcc(:,3), 'b'); 
xlabel('sample');
ylabel('m/s^2');
title('Linear acceleration');
legend('X', 'Y', 'Z');

%% Calculate linear velocity (integrate acceleartion)

linVel = zeros(size(linAcc));

for i = 2:length(linVel)
    linVel(i,:) = linVel(i-1,:) + linAcc(i,:) * dt;
end


% Plot
figure('NumberTitle', 'off', 'Name', 'Linear Velocity');
hold on;
plot(linVel(:,1), 'r');
plot(linVel(:,2), 'g');
plot(linVel(:,3), 'b');
xlabel('sample');
ylabel('g');
title('Linear velocity');
legend('X', 'Y', 'Z');

%% High-pass filter linear velocity to remove drift

order = 1;
filtCutOff = 0.1;
[b, a] = butter(order, (2*filtCutOff)/(1/dt), 'high');
linVelHP = filtfilt(b, a, linVel);

% Plot
figure('NumberTitle', 'off', 'Name', 'High-pass filtered Linear Velocity');
hold on;
plot(linVelHP(:,1), 'r');
plot(linVelHP(:,2), 'g');
plot(linVelHP(:,3), 'b');
xlabel('sample');
ylabel('g');
title('High-pass filtered linear velocity');
legend('X', 'Y', 'Z');

%% Calculate linear position (integrate velocity)

linPos = zeros(size(linVelHP));

for i = 2:length(linVelHP)
    linPos(i,:) = linPos(i-1,:) + linVelHP(i,:) * dt;
end

% Plot
figure('NumberTitle', 'off', 'Name', 'Linear Position');
hold on;
plot(linPos(:,1), 'r');
plot(linPos(:,2), 'g');
plot(linPos(:,3), 'b');
xlabel('sample');
ylabel('g');
title('Linear position');
legend('X', 'Y', 'Z');

%% High-pass filter linear position to remove drift

order = 1;
filtCutOff = 0.1;
[b, a] = butter(order, (2*filtCutOff)/(1/dt), 'high');
linPosHP = filtfilt(b, a, linPos);

% Plot
figure('NumberTitle', 'off', 'Name', 'High-pass filtered Linear Position');
hold on;
plot(linPosHP(:,1), 'r');
plot(linPosHP(:,2), 'g');
plot(linPosHP(:,3), 'b');
xlabel('sample');
ylabel('g');
title('High-pass filtered linear position');
legend('X', 'Y', 'Z');







%% Play animation
% first = 0;
% last = 0;
% 
% for i = 1:length(acc)
% 
%     j = abs(acc(i,2));
%     if j > 0
%         first = i;
%         break
%     end 
% end
% for i = first + 300 : length(tcAcc)
% 
%     j = abs(tcAcc(i,3));
% 
%     if j > 1.5
%         last = i;
%         break
%     else
%         last = length(acc) - 50;
%     end
% 
%     
% end   




X = linPosHP(:,1);
Y = linPosHP(:,2);
Z = linPosHP(:,3);


figure('NumberTitle', 'off', 'Name', '2d view');
hold on;
subplot(2,2,1);
plot(X,Y,'k');
title('X vs. Y');
legend('Ball');

subplot(2,2,2);
plot(Y,Z,'k');
title('Y vs. Z');
legend('Ball');

subplot(2,2,3);
plot(X,Z,'k');
title('X vs Z');
legend('Ball'); 


SamplePlotFreq = 1;

SixDOFanimation(linPosHP, R, ...
                'SamplePlotFreq', SamplePlotFreq, 'Trail', 'DotsOnly', ...
                'Position', [9 39 1280 720], ...
                'AxisLength', 0.1, 'ShowArrowHead', true, ...
                'Xlabel', 'X (m)', 'Ylabel', 'Y (m)', 'Zlabel', 'Z (m)', 'ShowLegend', false, 'Title', 'Unfiltered',...
                'CreateAVI', true, 'AVIfileNameEnum', false, 'AVIfps', ((1/dt) / SamplePlotFreq));            
 
%% End of script