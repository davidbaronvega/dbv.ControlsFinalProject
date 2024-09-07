%Defining the system:
s = tf('s');
G = 10 / (s*(s+9)*(s+18));

%Tuning the PID Controller Gains;
Kp = 110;
Ki = 12;
Kd = 13;

%PID Controller Transfer Function
PID = Kp + Ki/s + Kd*s

%Closed-loop Transfer Function with PID controller
T_PID = feedback(PID * G, 1)


%Simulating, plotting the step response of the closed-loop system
figure;
step(T_PID);
title(sprintf('Closed-Loop Step Response with Kp = %.3f, Ki = %.3f, Kd = %.3f', Kp, Ki, Kd));

%Step Response Simulation without plotting:
[response, t] = step(T_PID);

%step response characteristics
info = stepinfo(T_PID);

%Displaying the performance metrics:
fprintf('RiseTime: %.2f seconds\n', info.RiseTime);
fprintf('SettlingTime: %.2f seconds\n', info.SettlingTime);
fprintf('Overshoot: %.2f%%\n', info.Overshoot);
