
function [Uset] = constraints(u1, UBounds)

    % bounds = [umax umin deltaumax deltaumin xmax xmin deltaxmax deltaxmin];
    umax = UBounds(1);
    umin = UBounds(2);
    deltaumax = UBounds(3);
    deltaumin = UBounds(4);
    
    
    
    % Define the input constraint set Uset
    m = size(u1,1);
    
    Gammau = [eye(m); -eye(m)];
    Lambdau = [min(deltaumax,umax - u1); -max(deltaumin,umin - u1 )];
    
    Uset = Polyhedron(Gammau,Lambdau );

end
