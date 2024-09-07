%Defining the System:
s = tf('s'); % We need to define the Lapace variable as a continous function to work with it.
num = 10;
den = [1 27 162 0]; % s(s+9)(s+18) = s^3 + 27s^2 + 162sa
G = tf(num, den) 

%Bode plot to find initial Kv and phase margin of the system without
%phase-lead.

figure;
margin(G);
[Gm, Pm, Wcg, Wcp] = margin(G);


%Design parameters for the phase-lead compensator
alpha = 5.828; %Solving for a where phi_m is 45, we have a value of 5.828
T = .3573; %solved for analytically by deriving desried crossover frequency.

% Phase-lead transfer function:
Gc = (s*T + 1) / (s*alpha*T + 1);
K = 161.99; %K needed fpor Kv = 10: (Found analytically) %161.999



%Open-loop transfer function with compensator
OL_TF = K * Gc * G

% Bode plot of system with compensator
figure;
margin(OL_TF);
[Gm, Pm, Wcg, Wcp] = margin(OL_TF);


%Tweaking the parameters, these are the best I could make!
alpha = 7; 
T = .858;

% Phase-lead transfer function:
Gc = (s*T + 1) / (s*alpha*T + 1);
K = 161.99; %K needed fpor Kv = 10: (Found analytically) %161.999

%Open-loop transfer function with compensator
OL_TF = K * Gc * G


% Bode plot of system with compensator
figure;
margin(OL_TF)
[Gm, Pm, Wcg, Wcp] = margin(OL_TF);
