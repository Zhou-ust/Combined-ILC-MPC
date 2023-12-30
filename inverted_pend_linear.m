function y = inverted_pend_linear(t, x, u)

% system parameters
T = 0.05;                       % sampling time
M = 1;                          % pendulum mass
L = 1;                          % pendulum length
f = 0.01;                   	% friction coefficient
g = 10;                         % gravity
A = [1,T;
    g*T/L,1-f*T/(M*L^2)];    	% A matrix
B = [0;T];                      % input matrix
m = size(B,2);               	% number of inputs
n = size(A,1);                	% number of states

y = A*x + B*u;

end
