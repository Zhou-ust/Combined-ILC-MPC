function u_ilc = solveILC(XX, l, ILC_feedbackgain)

%
et = XX;
Onet = zeros(1,l);

Error = reshape(et,2*l,1);
u_ilc = ILC_feedbackgain*Error;

end
