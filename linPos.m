function output = get_linPos
    data = linVel;
    dt = .01;
    
    linpos = zeros(size(linVel));

    for i = 2:length(linVel)
        linpos(i,:) = linpos(i-1,:) + linVel(i,:) * dt;
    end

    cond = linpos(:,3) < 0;
    linpos(cond,:) = [];
    
    output = linpos;
end