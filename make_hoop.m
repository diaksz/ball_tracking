function output = make_hoop
    
    [X,Y,Z] = cylinder(1.33); % Generates a cylinder of r = .1 m and height = 1 m
    X = X ;  % Moves x center to x meters
    Y = Y + 12;  % Moves y center to y meters
    Z = Z/60 + 2.833;
    
    output = [X Y Z];
end