clc
clear all
close all

%% Steady Conditions
Ca_ss = 0.87725294608097;
T_ss = 324.475443431599;
x_s = [Ca_ss;T_ss];
u_s = 300;

Iterations = 10;
Traillength = 100;
t_st=(0:1:Traillength);
l=length(t_st);

x0 = [(0.5 - Ca_ss )/Ca_ss; (300 - T_ss)/T_ss ];
u0 = (u_s - u_s)/u_s;
m = size(u0,1);                  	% number of inputs
n = size(x0,1);                  	% number of states

X0 = repmat(zeros(size(x0)),1,Traillength+1);
U0 = repmat(zeros(size(u0)),1,Traillength);
Vfun = computeCost(X0, U0);
IterationCost = Vfun(1);

%%
umax = 0.2; umin = -0.2; deltaumax = 0.1; deltaumin = -0.1;

UBounds = [umax umin deltaumax deltaumin];
Uset = constraints(u0, UBounds);

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

% Obtain the H matrix
% Hmatrix
Hmatrix = zeros(2*l,l);
for i = 1:l
    for j = 1:l
        Hmatrix((2*i-1):(2*i),j) = zeros(2,1);
        if i>=j
            Hmatrix((2*i-1):(2*i),j) = Ct*At^(i-j)*Bt;
        end
    end
end
Shouldbezero = Hmatrix(1:4, 1:2) - [Ct*Bt zeros(2,1);Ct*At*Bt Ct*Bt];
Hmatrix(1:8,1:4);

% Set the weigthing matrices
Qi = 10*eye(n);
Ri = 0.5*eye(m);

% Q  % R
Q = kron(eye(l),Qi);
R0 = kron(eye(l),Ri);

ILC_feedbackgain = inv(Hmatrix'*Q*Hmatrix + R0)*Hmatrix';

% return

N = 5;
% Now start iteration loop
disp('Please be patient! ')
% ================================= The Main algorithm ======================================================
j = 1;

% Store the data
XX = []; UU = [];
while (j <= Iterations)
    t = 1;
    x_OCP(:,t) = x0;
    ut = u0;
    tol = 10^(-8);
    
    disp(['Now, it runs for iteration: ', num2str(j)])
    
    while (t <= Traillength)
        disp(['Time step: ', num2str(t)])
        
        %----- This is the ILC part -----%
        u_ilc = solveILC(X0, l, ILC_feedbackgain);
        Onet = zeros(1,l); Onet(t) = 1;
        uilc(:,t) = Onet*u_ilc;

        %----- This is the MPC part -----%
        xt = x_OCP(:,t);
        [xPred, uPred ] = solveMPC(@CSTR_linearplant, t, xt, ut, N, X0, U0, UBounds);
        %   [xPred, uPred ] = solveOCP(@plant, t, x_t, u_t, N, Qfun, XX, UU, UBounds, XBounds)
        u_mpc(:,t) = double(uPred{1});
        
        %----- This is the final input -----%
        u_OCP(:,t) = uilc(:,t) + u_mpc(:,t);
        x_OCP(:,t+1) = CSTR_plant(t, x_OCP(:,t), u_OCP(:,t));
        
        xt = x_OCP(:,t+1);
        ut = u_OCP(:,t);
        t = t + 1;
    end
    
    X0 = x_OCP(:,:);
    XX   = [XX; x_OCP];
    UU   = [UU; u_OCP];
      
    totalCostVector = computeCost(x_OCP, u_OCP);
    IterationCost(j+1) = totalCostVector(1);
    
    % increase Iteration index and restart
    j = j + 1;
end

IterationCost(2:end)
% =======================================================================================

% Plot the Results
% Run Plotting.m
Plotting


