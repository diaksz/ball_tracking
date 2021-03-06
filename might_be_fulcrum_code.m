function posns = might_be_fulcrum()
    
    data = get_data;
    accels = data(:,2:4);
    dt = .01;
    ax = data(:,2);
    ay = data(:,3);
    az = data(:,4);
    gx = data(:,5);
    gy = data(:,6);
    gz = data(:,7);
    phi = data(:,8)*(pi/180); %Converts to radians
    theta = data(:,9)*(pi/180);
    psi = data(:,10)*(pi/180);
    linvel = data(:,14:16);
    vX = data(:,14);
    vY = data(:,15);
    vZ = data(:,16);
    x = 0;
    y = 0;
    z = 0;
    g = 9.81; 
    p = gx; % Sets p, q, and r as gyro data
    q = gy;
    r = gz;
   
%posns = zeros(size(linvel));    
    for i = length(ax)      % p, q, r are MOST LIKELY angular velocities from gyros
        
        dPhi=p(i)+tan(theta(i))*(q(i)*sin(phi(i))+r(i)*cos(phi(i))); %I think we can leave @ least d(Eulers) out b/c we already know the next angle.
        dTheta=q(i)*cos(phi(i))-r(i)*sin(phi(i));
        dPsi=sec(theta(i))*(q(i)*sin(phi(i)))+r(i)*cos(phi(i));
        dVX=ax(i)-q(i)*vZ+r(i)*vY-g*sin(theta(i));
        dVY=ay(i)-r(i)*vX+p(i)*vZ+g*cos(theta(i))*sin(phi(i));
        dVZ=az(i)-p(i)*vY+q(i)*vX+g*cos(theta(i))*cos(phi(i));
        dPX=vX*cos(theta(i))*cos(psi(i))+vY*(sin(phi(i))*sin(theta(i))*cos(psi(i))-cos(phi(i))*sin(psi(i)))+vZ*(cos(phi(i))*sin(theta(i))*cos(psi(i))+sin(phi(i))*sin(psi(i)));
        dPY=vX*cos(theta(i))*sin(psi(i))+vY*(sin(phi(i))*sin(theta(i))*sin(psi(i))+cos(phi(i))*sin(psi(i)))+vZ*(cos(phi(i))*sin(theta(i))*sin(psi(i))-sin(phi(i))*cos(psi(i)));
        dPZ=-vX*sin(theta(i))+vY*sin(phi(i))*cos(theta(i))+vZ*cos(phi(i))*cos(theta(i));

        x = x + dPX*dt;
        y = y + dPY*dt;
        z = z + dPZ*dt;
        
%         posns(i,1) = posns(i-1,1) + dPX*dt;
%         posns(i,2) = posns(i-1,2) + dPY*dt;
%         posns(i,3) = posns(i-1,3) + dPZ*dt;
    end
   
    
    


% for i = 2:length(linvel)
%     posns(i,:) = posns(i-1,:) + linvel(i,:)*dt;
% end
    
    
    plot3(x,y,z);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    
    
   
    %obj.vX = obj.vX + timeInterval*dVX;
    %obj.vY = obj.vY + timeInterval*dVY;
    %obj.vZ = obj.vZ + timeInterval*dVZ;
    %obj.phi = obj.phi + timeInterval*dPhi;
    %obj.theta = obj.theta + timeInterval*dTheta;
    %obj.psi = obj.psi + timeInterval*dPsi;

           
    end

           
 