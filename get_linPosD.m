function output = get_linPosD
    data = get_linVelD;
    dt = 1/100;
    
    linpos = zeros(size(data));

    for i = 2:length(data)
        linpos(i,:) = linpos(i-1,:) + data(i,:) * dt;
    end
% 
%     cond = linpos(:,3) < 0;
%     linpos(cond,:) = [];
    
    output = linpos;
end