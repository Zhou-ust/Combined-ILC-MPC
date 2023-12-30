function [ x_dot,x_t ] = inverted_pend( x,M_p,M_c,L,g,u,T )
%INVERTED_PEND Computes the derivative x_dot of the inverted pendulum
%system at a given state x with a given input u. Also computes the discrete
%step when given a sampling time T.
    
    x_dot = [ x(2) ; 
        (M_p*g*cos(x(3))*sin(x(3)) ...
        + u - M_p*L*sin(x(3))*x(4)^2)/(M_c+M_p*sin(x(3))^2) ; 
        x(4); 
        ((M_p+M_c)*g*sin(x(3)) + u*cos(x(3)) ...
        - M_p*L*sin(x(3))*cos(x(3))*x(4)^2)/(L*(M_c+M_p*sin(x(3))^2))];
    
    if exist('T','var')
%         x_t = T*x_dot + x;      % euler integration
        x_0 = x;
        [~,X_ode] = ode45(@(t,x)inverted_pend(x,M_p,M_c,L,g,u),[0,T],x_0);
        X_ode = X_ode';
        x_t = X_ode(:,end);
    end
    
end
