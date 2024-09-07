
%% Part 1 %%
%1. Design a PD controller using time-domain design method such that (1) Kv = 50 and (2) overshoot is smallest.

%Defining the system we are working with. We have been provided with the
%system's Open-Loop transfer function, and can use built in MATLAB
%functionality 'tf' to work with transfer functions.

%We need to define the Laplace variable as a continuous function to work with it.
s = tf('s'); 

%Open-loop transfer function coefficients
num = 10;
den = [1 27 162 0]; % s(s+9)(s+18) expands to s^3 + 27s^2 + 162s

%Displaying the open-loop transfer function
fprintf('The open-loop function of the system is:\n');
G = tf(num, den)

%Calculating the velocity constant Kv as s approaches 0
Kv = dcgain(s*G);

% Displaying the required open-loop gain to achieve a ramp-error constant Kv of 50
fprintf('The open-loop gain necessary to achieve a (Kv) ramp-error of 50 in our system is:\n');
Kp = 50 / Kv;
disp(Kp);

%Keeping Kp constant at the value calculated to maintain Kv = 50
%Kd will be determined using the rlocfind function on the root locus plot
%Defining Td as a placeholder for the derivative time constant
Td = s;

%Ploting the root locus for the system with PD control (using Kp)
%The PD controller's derivative term will be represented by Kd*s in the root locus
figure;
rlocus(Kp*G);
title('Root Locus of the System with PD Controller');
xlim([-100 4]); 
ylim([-100 100]);

%Using rlocfind to pick a point on the root locus to minimize overshoot
%This will pause execution and wait for the user to select a point on the plot
[Kd, poles] = rlocfind(Kp*G);

%Displaying the selected Kd and poles of the closed-loop system
disp('The selected derivative gain Kd is:');
disp(Kd);
disp('The closed-loop poles at the selected Kd are:');
disp(poles);

%Forming the PD controller with the fixed Kp and the selected Kd
%The derivative term is now properly represented by Kd*s
G_PD = Kp + Kd*s;

%Creating the closed-loop transfer function T with the PD controller and the plant G
T = feedback(G_PD*G, 1)

%Simulating and plot the step response of the closed-loop system with the PD controller
figure;
step(T);
title(sprintf('Closed-Loop Step Response with Kp = %.3f, Kd = %.3f', Kp, Kd));
