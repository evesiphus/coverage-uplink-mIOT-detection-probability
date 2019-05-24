%Ana.CDF of N_cum (Probabilistic Statistic & Poisson Approximation)
 clear;
 close all;
 clc;



c = 3.575;
N_P = 0:1:10; % Number of Packets threshold
LT = length(N_P);

T_1 = 1-exp(-0.1); % Non-empty probability
R_1 = 1; % non- restrict probability
P_1 = 0.8087; % P.Preamble success at 1st time slot£¨SINR threshold=-10 dB£©

T_slot =3;%Time Duration
Intsy = 0.1;%P.P.P arrival intensity
mu_New = T_slot * Intsy;
F_pa = zeros(1,length(N_P));
for  t = 1:length(N_P)
     y = N_P(t);
    %***CDF 2nd time slot
    
    F_ps11 = (mu_New)^(y+1) * exp(-mu_New) / factorial(y+1) * R_1 * P_1;
    syms x
    f1 = (mu_New)^x * exp(-mu_New) / factorial(x);
    
    F_ps12 = double(symsum(f1,x,0,y));
    F_ps(1,t) =  F_ps11+ F_ps12;
    
    %***Poission approximation 
    
    mu_2_Cum = mu_New -R_1*P_1 *(1-exp(-mu_New ));
    syms z
    f12=mu_2_Cum^z *exp(-mu_2_Cum)/factorial(z);
    F_pa(1,t)= double(symsum(f12,z,0,y));
    
end

%draw picture
 figure(4)
 plot(N_P, F_ps,'k','linewidth',1);
 axis([0 10 0 1]);
 xlabel('Number of Packets');
 ylabel('Probability ');
 hold on
 plot(N_P, F_pa,'k*-','linewidth',1);
 grid on;
  