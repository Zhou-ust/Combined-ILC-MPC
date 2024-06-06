function cost = terminalcost(t, x)

if size(x,2) == 1
    x = x;
else
    x = x';
end

cost =  10*(x(1))^2 + 10.*(x(2))^2 ;
end
