
close all

format long
costiter = IterationCost(2:end)

%% It depends on the iterations;
n = size(xt,1);
m = size(ut,1);

% figure;
%%
T = 0:Traillength;

%----------------------
figure;
h1 = axes;
plot3(T,(1)*ones(1,l),XX(1,:)*Ca_ss + Ca_ss); hold on
plot3(T,(2)*ones(1,l),XX(3,:)*Ca_ss + Ca_ss); hold on
plot3(T,(3)*ones(1,l),XX(5,:)*Ca_ss + Ca_ss); hold on
plot3(T,(4)*ones(1,l),XX(7,:)*Ca_ss + Ca_ss); hold on
plot3(T,(5)*ones(1,l),XX(9,:)*Ca_ss + Ca_ss); hold on
plot3(T,(6)*ones(1,l),XX(11,:)*Ca_ss + Ca_ss); hold on
plot3(T,(7)*ones(1,l),XX(13,:)*Ca_ss + Ca_ss); hold on
plot3(T,(8)*ones(1,l),XX(15,:)*Ca_ss + Ca_ss); hold on
plot3(T,(9)*ones(1,l),XX(17,:)*Ca_ss + Ca_ss); hold on
plot3(T,(10)*ones(1,l),XX(19,:)*Ca_ss + Ca_ss); hold on
set(h1, 'Ydir', 'reverse')
yticks([0:Iterations])
% zlim([-40 40])
grid on
xlim([0 Traillength]);
box on
xlabel('t ( 0.1 min )')
ylabel('Batch (k)')
zlabel('$\bf{c}_{A,k} ( \mathrm{mol/L} )$','interpreter','latex')
hold off

%----------------------
figure;
h1 = axes;
plot3(T,(1)*ones(1,l),XX(2,:)*T_ss + T_ss); hold on
plot3(T,(2)*ones(1,l),XX(4,:)*T_ss + T_ss); hold on
plot3(T,(3)*ones(1,l),XX(6,:)*T_ss + T_ss); hold on
plot3(T,(4)*ones(1,l),XX(8,:)*T_ss + T_ss); hold on
plot3(T,(5)*ones(1,l),XX(10,:)*T_ss + T_ss); hold on
plot3(T,(6)*ones(1,l),XX(12,:)*T_ss + T_ss); hold on
plot3(T,(7)*ones(1,l),XX(14,:)*T_ss + T_ss); hold on
plot3(T,(8)*ones(1,l),XX(16,:)*T_ss + T_ss); hold on
plot3(T,(9)*ones(1,l),XX(18,:)*T_ss + T_ss); hold on
plot3(T,(10)*ones(1,l),XX(20,:)*T_ss + T_ss); hold on
set(h1, 'Ydir', 'reverse')
yticks([0:Iterations])
% zlim([-40 40])
grid on
xlim([0 Traillength]);
box on
xlabel('t ( 0.1 min )')
ylabel('Batch (k)')
zlabel('$\bf{T}_{k} ( \mathrm{K} )$','interpreter','latex')
hold off

%----------------------
figure;
h1 = axes;
plot3(1:Traillength,(1)*ones(1,Traillength),UU(1,:)*u_s + u_s); hold on
plot3(1:Traillength,(2)*ones(1,Traillength),UU(2,:)*u_s + u_s); hold on
plot3(1:Traillength,(3)*ones(1,Traillength),UU(3,:)*u_s + u_s); hold on
plot3(1:Traillength,(4)*ones(1,Traillength),UU(4,:)*u_s + u_s); hold on
plot3(1:Traillength,(5)*ones(1,Traillength),UU(5,:)*u_s + u_s); hold on
plot3(1:Traillength,(6)*ones(1,Traillength),UU(6,:)*u_s + u_s); hold on
plot3(1:Traillength,(7)*ones(1,Traillength),UU(7,:)*u_s + u_s); hold on
plot3(1:Traillength,(8)*ones(1,Traillength),UU(8,:)*u_s + u_s); hold on
plot3(1:Traillength,(9)*ones(1,Traillength),UU(9,:)*u_s + u_s); hold on
plot3(1:Traillength,(10)*ones(1,Traillength),UU(10,:)*u_s + u_s); hold on
set(h1, 'Ydir', 'reverse');
yticks([0:Iterations]);
grid on;
xlim([0 Traillength]);
box on;
xlabel('t ( 0.1 min )');
ylabel('Batch (k)');
zlabel('$\bf{T}_{c, k} ( t )$','interpreter','latex');
hold off


%----------------------
figure
set(gcf,'Position',[200,50,400,300]); 
plot(1:10, costiter(1).*ones(10,1),'b--d'); hold on
plot(1:10, costiter,'r-o'); hold on
xlabel('Batch number (k)');
ylabel('Batch Cost');
xlim([1 10]);
grid on;
legend('MPC','ILC + MPC','Location','southeast');
hold off




