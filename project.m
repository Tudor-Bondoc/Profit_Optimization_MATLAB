N=2; %dimensiunea lui x
C=[1 3; 3 4];
d=[200;480]; %constrangerile de inegalitate

%% CVX
cvx_begin
variable x(N)
maximize x(1)*(2-0.0001*x(1))+x(2)*(4-0.001*x(2))
subject to
C*x<=d;
cvx_end
%%
%% Definirea formei QP
 H=[0.0002 0; 0 0.002];
 q=[-2; -4];
 xx=quadprog(H,q,C,d);

%% Gradient Proiectat

L=max(eig(H)); %constanta Lipschitz
alfa=1/L; %pasul constant
x_0=[0;0];
xgp=x_0; %x gradient proiectat
xbar=x_0+1;
eps=1e-5;
while (norm(xbar-xgp)>=eps) %conditia de oprire
    [f,g]=f_proj(xgp); %calculez functia si gradientul la fiecare pas
    grad_step=xgp-alfa*g; %metoda gradient
    xbar=quadprog(2*eye(2),-2*grad_step, C, d); %proiectia
    xgp=xgp+0.5*(xbar-xgp);
end

disp 'valoarea optima a profitului gasita cu CVX:'
cvx_optval
disp 'valoarea optima a lui x gasita cu quadprog:'
xx
disp 'valoarea optima a lui x gasita cu Gradient Proiectat:'
xgp



