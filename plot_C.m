%% Housekeeping
 
addpath('Quaternions');  % include quatenrion library
% close('figure 1')                 	% close all figures
clear;                         	% clear all variables
clc;                          	% clear the command terminal



%% Import data
data = get_dataC;
linaccx = data(:,11);
linaccy = data(:,12);
linaccz = data(:,13);
dt = 1/100;
acc = data(:,2:4);
gyr = data(:,5:7);
euler = data(:,8:10);
quat = data(:,17:20);
% linPos = data_crunching;
% linPos = linPos(:,9:11);
linPos = filter_posnsC;
pos_x = linPos(:,1);
pos_y = linPos(:,2);
pos_z = linPos(:,3);
hoop = make_hoop;
% old_pos_y = pos_y;
% old_pos_x = pos_x;

%% Filter Data
% pos_ind = find(pos_x>2,1); %Removes data from picking up ball
% % ind = min(find(linaccx(pos_ind:end)>8,1),find(linaccz(pos_ind:end)>8,1))+pos_ind; %Filter data based on g's (NEED TO TEST CONSISTENCY)
% 
% % pos_x = pos_x(1:ind);
% % pos_y = pos_y(1:ind);
% % pos_z = pos_z(1:ind);
% 
% %  pos_y = old_pos_y + old_pos_x/12.3; %Correct misalignment: 69 --> 12.3164
% pos_y = old_pos_y + old_pos_x/5; %Correct misalignment: C
% % pos_y = old_pos_y + old_pos_x/-40; %Correct misalignment: D

%% Generate Plot (with "hoop" overlayed) --> NEED TO RE-ANIMATE (AND ADD DEPTH OF BASKET?), MOVE HOOP CODE TO ANOTHER FUNCTION???

bcx = 0; %ball center, x, inches
bcy = 0; %ball center, y, inches
bcz = 12; %ball center, z, inches

rcx = 114.5; %rim center, x, inches
rcy = 0; %rim center, y, inches
rcz = 30; %rim center, z, inches

rd = 12; %rim depth, inches
rw = 12; %rim width, inches

bbw = 15.5; %back board width, inches
bbh = 6; %back baord height, inches

drcbb = 11.5; %distance of rim center to back board, inches
%% Plot With Hoop (We used this for EP)
% % Side View
% figure('units','normalized','outerposition',[0 0 1 1]);
% subplot(1,2,1)
% line([(rcx-bcx-rd/2)/12,(rcx-bcx+rd/2)/12],[(rcz-bcz)/12,(rcz-bcz)/12],'LineWidth',5); %hoop
% line([(rcx-bcx+rd/2)/12,(rcx-bcx+rd/2)/12],[(rcz-bcz)/12,(rcz-bcz+bbh)/12],'LineWidth',5); %back board
% hold on;
% scatter(pos_x,pos_z,500,[1 .5 0])
% title('Side View','FontSize',20)
% xlabel('X (ft)','FontSize',20)
% ylabel('Z (ft)','FontSize',20)
% xlim([-2 10])
% ylim([-2 8])
% 
% % Top View 
% subplot(1,2,2)
% scatter(-pos_y,pos_x,500,[1 .5 0])
% hold on;
% title('Top View','FontSize',20)
% xlabel('Y (ft)','FontSize',20)
% ylabel('X (ft)','FontSize',20)
% % rectangle('Position', [-(rw/2)/12 (rcx-bcx-rd/2)/12 rw/12 rd/12],'LineWidth',5); %hoop
% r = 1;
% theta = linspace(0,2*pi);
% a = r*cos(theta); 
% b = r*sin(theta)+7.3;
% plot(a,b,'LineWidth',3);
% 
% line([(-bbw/2)/12,+(bbw/2)/12],[(rcx-bcx+rd/2+drcbb)/12,(rcx-bcx+rd/2+drcbb)/12],'LineWidth',5); %back board
% 
% xlim([-6 6])
% ylim([-2 10])

%% Plot Without Hoop (Used this for Vivek's Lecture)
figure('units','normalized','outerposition',[0 0 1 1]);
line([(rcx-bcx-rd/2)/12,(rcx-bcx+rd/2)/12],[(rcz-bcz)/12,(rcz-bcz)/12],'LineWidth',5); %hoop
line([(rcx-bcx+rd/2)/12,(rcx-bcx+rd/2)/12],[(rcz-bcz)/12,(rcz-bcz+bbh)/12],'LineWidth',5); %back board
% line([(114.5+12)/12,(114.5+12)/12], [0,0], [30/12,35/12],'LineWidth',5)
title('The Yankees Stink')
xlabel('X (ft)');
ylabel('Y (ft)');
zlabel('Z (ft)');
xlim([-2 10]);
ylim([-3 3]);
zlim([-2 6]);
view([-8 16]);
grid on;
hold on;
for i = 1:length(pos_x)
    
    scatter3(pos_x(i), pos_y(i), pos_z(i), 500, [0 1 0])
    pause(.0001);
    
end

%% Old Code

% zc = z_end;
% theta = linspace(0,2*pi);
% c = r*cos(theta) + zc;
% d = r*sin(theta) + yc;
% %plot(c,d)

% SixDOFanimation(linPos, R, ...
%                 'SamplePlotFreq', SamplePlotFreq, 'Trail', 'DotsOnly', ...
%                 'Position', [9 39 1280 720], ...
%                 'AxisLength', 0.1, 'ShowArrowHead', true, ...
%                 'Xlabel', 'X (m)', 'Ylabel', 'Y (m)', 'Zlabel', 'Z (m)', 'ShowLegend', false, 'Title', 'Unfiltered',...
%                 'CreateAVI', true, 'AVIfileNameEnum', false, 'AVIfps', ((1/dt) / SamplePlotFreq));


% scatter3(pos_x,pos_y,pos_z);
% title('Profile View')
% % axis([0,12,0,15,0,12]);
% xlabel('X (ft)')
% ylabel('Y (ft)')
% zlabel('Z (ft)')
% view([90 0])
% grid on
% hold on
% surf(X,Y,Z);
% hold off

% subplot(1,2,1)
% surf(X,Y,Z)
% view([90 0])
% hold on
% comet3(pos_x,pos_y,pos_z)
% hold off
 
% subplot(1,2,2)
% r = .667;
% theta = linspace(0,2*pi);
% a = r*cos(theta); 
% b = r*sin(theta)+12;
% plot(a,b,'k')
% hold on
% title('Top View')
% xlabel('X (ft)')
% ylabel('Y (ft)')
% xlim([-1 1])
% ylim([0 15])
% grid on
% hold on
% comet(pos_x,pos_y,.5)
% hold off

% HOOP
% X = hoop(1:2,1:21); 
% Y = hoop(1:2,22:42);  
% Z = hoop(1:2,43:63);
% x_end = hoop(1,21);
% y_end = hoop(1,42);
% z_end = hoop(1,63);
% r = .875/2;
% theta = linspace(0,2*pi);
% a = r*cos(theta); 
% b = r*sin(theta)+12;


% figure;
% plot(pos_x,pos_y);
% xlabel('X (ft)')
% ylabel('Y (ft)')
% figure;
% plot(pos_x,pos_z);
% xlabel('X (ft)')
% ylabel('Z (ft)')
% figure;
% plot(pos_y,pos_z);
% xlabel('Y (ft)')
% ylabel('Z (ft)')
 
% figure(2)
% subplot(1,2,1)
% scatter(pos_y,pos_z)
% title('Side View')
% xlabel('Y (ft)')
% ylabel('Z (ft)')
% 
% subplot(1,2,2)
% scatter(pos_x,pos_y);
% title('Top View')
% xlabel('X (ft)')
% ylabel('Y (ft)')

% figure('units','normalized','outerposition',[0 0 1 1]);
% scatter3(pos_x,pos_y,pos_z,[],[1 .5 0]);
% for i = 1:length(pos_x
%     
%     % PROFILE VIEW
%     
%     hold on
%     scatter3(pos_x(i),pos_y(i),pos_z(i),[],[1 .5 0])
%     pause(.001)
%     
% %     % TOP VIEW
% %     subplot(1,2,2)
% %     hold on
% %     scatter(pos_x(i),pos_y(i),100,[1 .5 0])
%     
% end


%rectangle('Position', [-.4375 12 .875 1.167]);

% Animate trajectory 
% for i = 1:length(pos_x)
%     
%     % PROFILE VIEW
%     subplot(1,2,1)
%     hold on
%     scatter3(pos_x(i),pos_y(i),pos_z(i),[],[1 .5 0])
%     pause(.001)
%     
%     % TOP VIEW
%     subplot(1,2,2)
%     hold on
%     scatter(pos_x(i),pos_y(i),100,[1 .5 0])
%     
% end
% scatter3(pos_x,pos_y,pos_z)
%% End of script