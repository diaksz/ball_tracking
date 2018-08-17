%CONSTANTS
%Reads Corresponding Column in .csv file
function output = get_dataD
SENSORID=1;
TIMESTAMP=2;
FRAMENO=3;
ACCX = 4;
ACCY = 5;
ACCZ = 6;
GYRX = 7;
GYRY = 8;
GYRZ = 9;
MAGX = 10;
MAGY = 11;
MAGZ = 12;
EULX = 13;
EULY = 14;
EULZ = 15;
QUATW = 16;
QUATX = 17;
QUATY = 18;
QUATZ = 19;
LACCX= 20;
LACCY= 21;
LACCZ= 22;
PRESS= 23;

% settings
file = 'tests.csv'; %File to pull data from***
LINEWIDTH = 2;

%===========================================
data = csvread(file, 1, 0); %reads data with a row offset of 1 (no labels) and column offset of zero
save('data.m','data');      %Saves data to matrix in workspace
time = data(:, TIMESTAMP);  %reads timestamp data as only the column number related to timestamp
frames = data(:, FRAMENO);
acc = data(:, ACCX:ACCZ);   %reads accel data from corresponding columns of ACCX to ACCZ
gyr = data(:, GYRX:GYRZ);   %Gyroscope
mag = data(:, MAGX:MAGZ);       
quat = data(:, QUATW:QUATZ);
euler = data(:, EULX:EULZ)*(pi/180); %Ensures that Euler Angles are in radians
linacc = data(:, LACCX:LACCZ);
dt = 1/100;

%% Remove drift using average data of ball resting before each throw
lxa = mean(linacc(1:100,1)); 
lya = mean(linacc(1:100,2));
lza = mean(linacc(1:100,3));

linacc(:,1) = linacc(:,1)-lxa-.005; %Offset for Ball D 
linacc(:,2) = linacc(:,2)-lya;
linacc(:,3) = linacc(:,3)-lza;

%% Add some extra data for some reason?
linvel = zeros(size(linacc));

for i = 2:length(linacc)
    linvel(i,:) = linvel(i-1,:) + linacc(i,:)*dt;
end

% Probably will NOT use this, just want some sort of plot
posns = zeros(size(linvel));

for i = 2:length(linvel)
    posns(i,:) = posns(i-1,:) + linvel(i,:)*dt;
end

output = [time acc gyr euler linacc linvel quat];

end
 