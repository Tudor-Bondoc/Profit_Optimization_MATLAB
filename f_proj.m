%% Functie ce calculeaza f(x) si gradientul
function [f,g]=f_proj(x)
f=(1e-4)*(x(1)^2)+(1e-3)*(x(2)^2)-2*x(1)-4*x(2);
g=[2*(1e-4)*x(1)-2; 2*(1e-3)*x(2)-4];
end