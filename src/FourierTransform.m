function H_w = FourierTransform(h_t, w_fft)
    %Function m-file: FourierTransform.m
    %
    %Function that approximates the Continuous Fourier Transform
    %of a given signal (in our case, the impulse responses h(t)).
    %
    %Konrad Włodarczyk
    %Date: 29.12.2023
    %Computational Techniques Laboratory Project
    %AGH - University of Science

    N = length(h_t); % Obtaining the length of the input signal
    H_w = zeros(size(w_fft)); % Initializing the Continuous Fourier Transform as a vector of zeros

    for k = 1:N
        H_w = H_w + h_t(k) * exp(-1i * 2 * pi * (k-1) * (w_fft*2.39)/ N); %Calculating the Fourier Transform from the formula
    end
end