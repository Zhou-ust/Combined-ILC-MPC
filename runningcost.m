function cost = runningcost(t, x, u)

cost = 10.*(x(1))^2 + 10.*(x(2))^2 + 1*u(1)^2;
end
