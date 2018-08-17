y = [];
for i = 1:10
    if mod(x(i),2)==0 && x(i) > 5
        y = [y x(i)];
    else
        y = [y];
    end
end
disp(y);
        