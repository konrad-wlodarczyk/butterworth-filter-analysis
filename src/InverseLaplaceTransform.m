function [h_t] = InverseLaplaceTransform(r, p, t)
        
    %Function m - file: InverseLaplaceTransform.m
    %
    %Function that calculates the inverse Laplace transform in order
    %to obtain the impulse response h(t) having the residues and poles 
    %of transfer function H(s).
    %
    %Konrad Włodarczyk
    %Date: 19.12.2023
    %Computational Techniques Laboratory Project 
    %AGH - University of science
    
    h_t = zeros(size(t)); %Initializing the impulse response as vector of zeros

    for i = 1:length(r)
        h_t = h_t + r(i).*exp(p(i).*t); %Calculating the ILT from formula
    end
end