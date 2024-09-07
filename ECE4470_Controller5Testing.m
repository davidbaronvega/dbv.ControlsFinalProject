%%Step 5: Design a Phase-lag controller using frequency-domain design
%%method such that Kv = 10 and Phase margin is 45 degrees.


%Defining the System:
s = tf('s'); 
num = 10;
den = [1 27 162 0]; % s(s+9)(s+18) = s^3 + 27s^2 + 162sa
G = tf(num, den) 

%Bode plot to find initial Kv and phase margin of the system without
%phase-lead, same as before.
figure;
margin(G);
[Gm, Pm, Wcg, Wcp] = margin(G);


%Design parameters for the phase-lead compensator
alpha = 79.433; 
T = .0281;

%Phase-lead transfer function:
Gc = (s*T + 1) / (s*alpha*T + 1);
K = 161.99; %K needed fpor Kv = 10: (Found analytically) %161.999. Same as controller 4.

%Open-loop transfer function with compensator, untuned.
OL_TF = K * Gc * G

%Bode plot of system with phase-lag controlled:
figure;
margin(OL_TF)
[Gm, Pm, Wcg, Wcp] = margin(OL_TF);


%%Definitely needs to be tweaked!

%Design parameters for the phase-lead compensator
alpha = .01259; 
T = .042;

%Phase-lead transfer function:
Gc = (s*T + 1) / (s*alpha*T + 1);
K = 161.99; %K needed fpor Kv = 10: (Found analytically) %161.999. Same as controller 4.

%Open-loop transfer function with compensator, untuned.
OL_TF = K * Gc * G

%Bode plot of system with phase-lag controlled:
figure;
margin(OL_TF)
[Gm, Pm, Wcg, Wcp] = margin(OL_TF);