%Script m - file: project.m
%
%Matlab script used for evaluating the butterworth low - pass filter for 5
%orders from 1 through 5
%
%Konrad Włodarczyk
%Date: 18.12.2023
%Computational Techniques Laboratory Project 
%AGH - University of science

clc; clear; close all; %Cleaning the workspace with each launch of the script

w_tf = logspace(-1, 2, 1000); %Defining the frequency range
w_c = 1; %Cutoff frequency of the filter (normalized frequency = 1, but can change to desired)
s = 1i.*w_tf; 

%Transfer functions of different orders of filter:
H_s1 = 1./(s./w_c + 1); %1st order
H_s2 = 1./((s./w_c).^2 + 1.414.*(s./w_c) + 1); %2nd order
H_s3 = 1./((s./w_c).^3 + 2.*(s./w_c).^2 + 2.*(s./w_c) + 1); %3rd order
H_s4 = 1./(((s./w_c).^4) + 2.6132.*((s./w_c).^3) + 3.4143.*((s./w_c).^2) + 2.6132.*(s./w_c) + 1); %4th order
H_s5 = 1./(((s./w_c).^5) + 3.236.*((s./w_c).^4) + 5.235924.*((s./w_c).^3) + 5.235924.*((s./w_c).^2) + 3.236.*(s./w_c) + 1); %5th order

%Obtaining the h(t) by the partial fraction decomposition inverse laplace transform of the H(s)
dt = 0.01; %Obtaining the sampling frequency
t = 0:dt:15; %Defining the time range
num = 1; %Common numerator of all the transfer functions

%1st order of the lowpass butterworth filter
denom1 = [1./w_c 1]; %Denominator of the 1st order lowpass butterworth filter
[r1, p1] = CustomResidue(num, denom1); %Calculating the residues and poles
h_t1 = InverseLaplaceTransform(r1, p1, t); %Calculating the inverse Laplace Transform

%2nd order of the lowpass butterworth filter
denom2 = [1./(w_c.^2) 1.414./w_c 1]; %Denominator of the 2nd order lowpass butterworth filter
[r2, p2] = CustomResidue(num, denom2); 
h_t2 = InverseLaplaceTransform(r2, p2, t); 

%3rd order of the lowpass butterworth filter
denom3 = [1./(w_c.^3) 2./(w_c.^2) 2./w_c 1]; %Denominator of the 3rd order lowpass butterworth filter
[r3, p3] = CustomResidue(num, denom3); 
h_t3 = InverseLaplaceTransform(r3, p3, t); 

%4th order of the lowpass butterworth filter
denom4 = [1./(w_c.^4) 2.6132./(w_c.^3) 3.4143./(w_c.^2) 2.6132./w_c 1]; %Denominator of the 4th order lowpass butterworth filter
[r4, p4] = CustomResidue(num, denom4); 
h_t4 = InverseLaplaceTransform(r4, p4, t); 

%5th order of the lowpass butterworth filter
denom5 = [1./(w_c.^5) 3.236./(w_c.^4) 5.235924./(w_c.^3) 5.235924./(w_c.^2) 3.236./w_c 1]; %Denominator of the 5th order lowpass butterworth filter
[r5, p5] = CustomResidue(num, denom5); 
h_t5 = InverseLaplaceTransform(r5, p5, t);

%Introducing the input x(t) cosine signal
A = 1; %Amplitude of the cosine signal
x_t = A.*cos(w_c.*t); %Defining the input cosine signal x(t) 

%Calculating the convolution for 5 orders of the filter
%We multiply the result by 'dt' in order to get rid of the scaling issue
y_t1 = conv(x_t, h_t1, 'full').*dt; %1st order
y_t2 = conv(x_t, h_t2, 'full').*dt; %2nd order
y_t3 = conv(x_t, h_t3, 'full').*dt; %3rd order
y_t4 = conv(x_t, h_t4, 'full').*dt; %4th order
y_t5 = conv(x_t, h_t5, 'full').*dt; %5th order

%Creating seperate time vector so that the plots look accurate
t_conv = 0:dt:(length(y_t1)-1)*0.01;

%Creating a seperate frequency vector so that the plots to look accurate
%and for the frequency reponse to have the same length as the transfer
%function
w_fft = w_tf;

%Calculating the fourier transforms for 5 different orders
%We multiply the result by 'dt' in order to get rid of the scaling issue
H_w1 = FourierTransform(h_t1, w_fft).*dt; %1st order
H_w2 = FourierTransform(h_t2, w_fft).*dt; %2nd order
H_w3 = FourierTransform(h_t3, w_fft).*dt; %3rd order
H_w4 = FourierTransform(h_t4, w_fft).*dt; %4th order
H_w5 = FourierTransform(h_t5, w_fft).*dt; %5th order

%Plotting the obtained characteristics

%Amplitude - frequency characteristics

    figure(1);
        subplot(2, 1, 1)
            semilogx(w_tf, abs(H_s1), "LineWidth", 2, "Color", [0 0 1]); grid on; hold on; 
            semilogx(w_tf, abs(H_s2), "LineWidth", 2, "Color", [1 0 0]); 
            semilogx(w_tf, abs(H_s3), "LineWidth", 2, "Color", [1 1 0]);
            semilogx(w_tf, abs(H_s4), "LineWidth", 2, "Color", [1 0 1]);
            semilogx(w_tf, abs(H_s5), "LineWidth", 2, "Color", [0 1 0]); 
            plot(w_c, abs(w_c./(w_c + 1i*w_c)), 'ro', "MarkerSize", 8, "LineWidth", 2); title('Butterworth lowpass filter Transfer Function Amplitude - Frequency Characteristics'); xlabel('Angular Frequency [rad/s]'); ylabel('|H(s)|'); legend("n = 1", "n = 2", "n = 3", "n = 4", "n = 5", "Cutoff frequency");     

%Phase - frequency characteristics

        subplot(2, 1, 2)
            semilogx(w_tf, unwrap(angle(H_s1)), "LineWidth", 2, "Color", [0 0 1]); grid on; hold on; 
            semilogx(w_tf, unwrap(angle(H_s2)), "LineWidth", 2, "Color", [1 0 0]);
            semilogx(w_tf, unwrap(angle(H_s3)), "LineWidth", 2, "Color", [1 1 0]);
            semilogx(w_tf, unwrap(angle(H_s4)), "LineWidth", 2, "Color", [1 0 1]); 
            semilogx(w_tf, unwrap(angle(H_s5)), "LineWidth", 2, "Color", [0 1 0]); title('Butterworth lowpass filter Transfer Function Phase - Frequency Characteristics'); xlabel('Angular Frequency [rad/s]'); ylabel('phase(H(s))'); legend("n = 1", "n = 2", "n = 3", "n = 4", "n = 5");

%Impulse responses

    figure(2);
        plot(t, h_t1, "LineWidth", 2, "Color", [0 0 1]); grid on; hold on;
        plot(t, h_t2, "LineWidth", 2, "Color", [1 0 0]); 
        plot(t, h_t3, "LineWidth", 2, "Color", [1 1 0]); 
        plot(t, h_t4, "LineWidth", 2, "Color", [1 0 1]); 
        plot(t, h_t5, "LineWidth", 2, "Color", [0 1 0]); title("Butterworth lowpass filter impulse response h(t) for 5 orders"); xlabel('time [s]'); ylabel('h(t)'); legend("n = 1", "n = 2", "n = 3", "n = 4", "n = 5");

%x(t) input signal and y(t) output signals

    figure(3);
        subplot(2, 1, 1)
            plot(t, x_t, "LineWidth", 2); grid on; title("Input signal x(t)"); xlabel('time [s]'); ylabel('x(t)');
        subplot(2, 1, 2)
            plot(t_conv, y_t1, "LineWidth" ,2, "Color", [0 0 1]); grid on; hold on;
            plot(t_conv, y_t2, "LineWidth", 2, "Color", [1 0 0]);
            plot(t_conv, y_t3, "LineWidth", 2, "Color", [1 1 0]);
            plot(t_conv, y_t4, "LineWidth", 2, "Color", [1 0 1]); 
            plot(t_conv, y_t5, "LineWidth", 2, "Color", [0 1 0]); title("Butterworth lowpass filter output signal y(t) for 5 orders"); xlabel('time [s]'); ylabel('y(t)'); legend("n = 1", "n = 2", "n = 3", "n = 4", "n = 5");

%Amplitude - Frequency characteristics obtained from manually calculating them

    figure(4);
        subplot(2, 1, 1)
            semilogx(w_fft, abs(H_w1), "LineWidth", 2, "Color", [0 0 1]); grid on; hold on; 
            semilogx(w_fft, abs(H_w2), "LineWidth", 2, "Color", [1 0 0]);  
            semilogx(w_fft, abs(H_w3), "LineWidth", 2, "Color", [1 1 0]); 
            semilogx(w_fft, abs(H_w4), "LineWidth", 2, "Color", [1 0 1]); 
            semilogx(w_fft, abs(H_w5), "LineWidth", 2, "Color", [0 1 0]); 
            plot(w_c, abs(w_c./(w_c + 1i*w_c)), 'ro', "MarkerSize", 8, "LineWidth", 2); title("Butterworth low pass filter Amplitude - Frequency Response for 5 orders"); xlabel('Frequency [Hz]'); ylabel('|H(w)|'); legend("n = 1", "n = 2", "n = 3", "n = 4", "n = 5", "Cutoff frequency");

%Transfer function characteristics obtained from given formulas

        subplot(2, 1, 2)
            semilogx(w_tf, abs(H_s1), "LineWidth", 2, "Color", [0 0 1]); grid on; hold on; 
            semilogx(w_tf, abs(H_s2), "LineWidth", 2, "Color", [1 0 0]);
            semilogx(w_tf, abs(H_s3), "LineWidth", 2, "Color", [1 1 0]); 
            semilogx(w_tf, abs(H_s4), "LineWidth", 2, "Color", [1 0 1]);  
            semilogx(w_tf, abs(H_s5), "LineWidth", 2, "Color", [0 1 0]); 
            plot(w_c, abs(w_c./(w_c + 1i*w_c)), 'ro', "MarkerSize", 8, "LineWidth", 2); title('Butterworth lowpass filter Transfer Function characteristics for 5 orders'); xlabel('Frequency [Hz]'); ylabel('|H(s)|'); legend("n = 1", "n = 2", "n = 3", "n = 4", "n = 5", "Cutoff frequency");

%End of plots
%EOF