function [ x, u ] = solveMPC(CSTR_linearplant, t, x_t, u_t, N, X0, U0, UBounds)
    
    % Clear Yalmip Variables
    yalmip('clear')
    
    n = size(X0,1);
    m = size(U0,1);
    
    x = sdpvar(n*ones(1,N+1),ones(1,N+1));
    u = sdpvar(m*ones(1,N),ones(1,N));
    
    % Initial Condition
    Constraints = [x_t == x{1}];

    for i = 1:N
        Uset = constraints(u_t, UBounds);
        Hu  = Uset.A;  bu  = Uset.b;

        Constraints = [Constraints;
            x{i+1} == CSTR_linearplant( t + i,x{i},u{i});
            Hu * u{i} <= bu;];
    end
    
    
    % Running Cost
    Cost = 0;
    for i = 1:N
        Cost = Cost + runningcost( t + i, x{i}, u{i});
    end
    
   
    % Solver setting
    options = sdpsettings('solver','mosek','verbose',0);
    
    % Solve the FTOCP
    Problem = optimize(Constraints, Cost, options);
    Objective = double(Cost);
    cost = value(Cost);
    
    % yalmip('clear')

end

