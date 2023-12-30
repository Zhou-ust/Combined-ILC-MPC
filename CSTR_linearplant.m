function y = CSTR_linearplant(t, x, u)

% Continuous-time state space model;
Ac = [-1.14  -3.8; 0.1  -0.96];
Bc = [0; 1.9];
ts = 1/10;   % Time Interval (min)
% Discrete-time system model;
[At,Bt] = c2d(Ac,Bc,ts);
Ct = eye(2);
eig_A = eig(At);
Co = ctrb(At,Bt);
unco = length(At) - rank(Co);
size(At);
size(Bt);

y = At*x + Bt*u;

end
