%Defining the given system
s = tf('s');
G = 10 / (s*(s+9)*(s+18));

%PI Controller parameters (initial guesses, tweaked below)
Kp = 100; %Starting with a small value for Proportional gain
Ki = 1;   %Starting with a small value for Integral gain

%Defining the PI Controller Open Loop transfer function
PI = Kp + Ki/s;
OL_TF = PI * G;

%Generating the root locus plot of the open-loop transfer function
figure;
rlocus(OL_TF)
title('Root Locus of the System with PI Controller');

%Using rlocfind to test and select points on the root locus plot

[K, poles] = rlocfind(OL_TF);

%Updating Kp and Ki based on the selected gain K
%The gain K returned from rlocfind is used to adjust the PI controller gains
Kp = Kp * K
Ki = Ki * K

%Redefining the PI controller with the updated gains
PI = Kp + Ki/s

%Creating the closed-loop transfer function with the updated PI controller
T = feedback(PI * G, 1)

%Simulating and plot the step response of the closed-loop system
figure;
step(T);
title(sprintf('Closed-Loop Step Response with Kp = %.3f, Ki = %.3f', Kp, Ki));

%Fetching step response characteristics
info = stepinfo(T);

%Displaying the overshoot and settling time
fprintf('Overshoot: %.2f%%\n', info.Overshoot);
fprintf('SettlingTime: %.2f seconds\n', info.SettlingTime);