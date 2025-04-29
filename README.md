# Butterworth Filter Analysis (MATLAB)

![MATLAB](https://img.shields.io/badge/MATLAB-R2023a-orange)
![Project](https://img.shields.io/badge/Filter-Type--I%20Butterworth-blue)

MATLAB-based analysis of Butterworth low-pass filters (orders 1–5) with visualization of frequency response, impulse response, and signal convolution.

---

## Features

- Analyze Butterworth filters of orders 1 to 5
- Derive transfer functions and FIR using Laplace Transforms
- Calculate frequency response using Fourier Transform
- Simulate the effect of filtering on cosine input signals
- Graphical comparison of transfer and frequency characteristics

---

## Technology Stack

- **Language**: MATLAB (R2023a)
- **Concepts**: 
  - Signal Processing
  - Laplace and Fourier Transforms
  - Convolution
  - Filter Analysis and Visualization

---

## Installation

### Prerequisities

- MATLAB (version R2023a or compatible)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/konrad-wlodarczyk/butterworth-filter-analysis.git
   cd butterworth-filter-analysis

2. Open the **`project.m`** script in MATLAB and run it to start the analysis.

### File Structure

- **`project.m`**
  Main script that runs the entire analysis.
  
- **`CustomResidue.m`**
  Computes residues and poles for Laplace domain inversion.
  
- **`InverseLaplaceTransform.m`**
  Generates the FIR from poles and residues.
  
- **`FourierTransform.m`**
  Approximates the continuous-time Fourier Transform.

---

## Project Documentation

For in-depth theoretical background, methodology, and visual results, see the full [Project Report](docs/COMPUTATIONAL_TECHNIQUES_PROJECT_FINAL_REPORT.docx).

---

## Future Development

- Extend the system to analyze other filter types (Chebyshev, Bessel)
- Improve numerical stability and performance
- Add GUI-based interaction for ease of use
- Export results to external formats

---

## License

This project is licensed under the **MIT License**.  
See the [LICENSE](LICENSE) file for details.

--- 

## Contact

For questions or suggestions, feel free to reach out!



