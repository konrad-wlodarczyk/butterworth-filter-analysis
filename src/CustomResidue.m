function [r, p] = CustomResidue(num, denom)

        %Function m - file: CustomResidue.m
        %
        %Function that obtains the residues and poles of the transfer
        %function H(s).
        %
        %Konrad Włodarczyk
        %Date: 19.12.2023
        %Computational Techniques Laboratory Project 
        %AGH - University of science

        p = roots(denom); %We obtain the poles of the denominator 

        num_val = polyval(num, p); %Evaluates the value of the numerator at the poles of the denominator
        denom_der = (length(denom)-1:-1:1) .* denom(1:end-1); %Calculates the derivative of the denominator
        denom_val = polyval(denom_der, p); %Evaluates the value of the derivative of the denominator at the poles of the denominator
        r = num_val ./ denom_val; %Calculates the residues 
end