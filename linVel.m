function output = get_linVel
    accels = algo_zach;
    dt = .01;
    
    linvel = zeros(size(accels));

    for i = 2:length(linvel)
        linvel(i,:) = linvel(i-1,:) + accels(i,:) * dt;
    end
    
    output = linvel;
    
end