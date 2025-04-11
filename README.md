# LVDS2FMC-LPC-data-capture

**LVDS to FMC-LPC Synchronization Project**

This project enables synchronization and data capture from LVDS signals through the FMC-LPC interface using an FPGA. It provides a reliable data path by implementing new clock and frame alignment techniques. Below is a summary of the main design files and their functions.

## 📁 Design Files Overview

| **Design File Name**         | **File Type** | **Description**                                                                 |
|-----------------------------|---------------|---------------------------------------------------------------------------------|
| `top_adc_data_capturing`    | VHDL          | Top-level wrapper for `adc_data_capturing`. Contains the buffer to receive LVDS signals. |
| `adc_data_capturing`        | VHDL          | Main FPGA module integrating MMCM, bit clock synchronization, frame alignment, and data reception. |
| `bit_clock_synchronyzation` | VHDL          | Implements the new clock phase shift alignment algorithm.                      |
| `phase_shift_alignment`     | VHDL          | Submodule of `bit_clock_synchronyzation`, controlling phase shift alignment.   |
| `frame_alignment`           | VHDL          | Implements the new frame alignment algorithm.                                  |
| `frame_arrange`             | VHDL          | Submodule of `frame_alignment`, managing bit slip control across ISERDES.      |
| `data_receive`              | VHDL          | Implements logic for receiving and processing LVDS data.                       |
| `adc_data_capture_constain` | XDC           | Constraint file defining clock, timing, I/O direction, and pin standards.      |
| `readme`                    | Text          | This file with instructions and an overview of the design.                     |

## 🛠 How to Build

1. Open the project in Vivado.
2. Add all source files listed above.
3. Apply constraints from `adc_data_capture_constain.xdc`.
4. Synthesize and implement the design.
5. Generate bitstream and program the FPGA.

---

If you encounter any issues or need support, feel free to open an issue or contact the maintainer.
