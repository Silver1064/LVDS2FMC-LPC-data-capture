# LVDS2FMC-LPC-data-capture

**LVDS to FMC-LPC Synchronization Project**

This project enables synchronization and data capture from LVDS signals through the FMC-LPC interface using an FPGA. It provides a reliable data path by implementing novel clock and frame alignment techniques.

## 📁 Design Files Overview

| **Design File**             | **Type** | **Description**                                                                 |
|----------------------------|----------|---------------------------------------------------------------------------------|
| `top_adc_data_capturing`   | VHDL     | Top-level wrapper for `adc_data_capturing`. Contains LVDS input buffers.       |
| `adc_data_capturing`       | VHDL     | Main module integrating MMCM, bit_clock_synchronization, frame_alignment, and data_receive.   |
| `bit_clock_synchronyzation`| VHDL     | Implements clock phase shift alignment.                                         |
| `phase_shift_alignment`    | VHDL     | Submodule for phase control in bit_clock_synchronization.                       |
| `frame_alignment`          | VHDL     | Implements the frame alignment mechanism.                                       |
| `frame_arrange`            | VHDL     | Submodule for bitslip control across ISERDES in frame_arrange.                  |
| `data_receive`             | VHDL     | Receives and processes LVDS data.                                               |
| `adc_data_capture_constain`| XDC      | Constraint file for clocks, timing, pinout, and I/O standards.                  |
| `README.md`                | Markdown | Project documentation and instructions.                                         |

## 🔧 Requirements

- **Vivado version:** 2024.2 (recommended) with Kintex-7 device support  
  👉 [Download Vivado](https://www.xilinx.com/support/download.html)

- **Board file:** Kintex-7 xc7k325t custom board  
  👉 [Board Files GitHub](https://github.com/rriggs/kintex-7-stlv7325t-board-files)

## 🛠 How to Build

### 🔁 Clone the Repository

- **Ubuntu:**
  ```bash
  git clone https://github.com/Silver1064/LVDS2FMC-LPC-data-capture.git
- **Windows:**
  ```bash
  download zip file and extract it.

### If you use VIVADO version 2024.2 or higher.
simplify run the project_adc_capture.xpr
### If you use VIVADO at older version .
1. Open the project in Vivado, choosen the board is xc7k325t
2. Add all source files listed above.
3. Apply constraints from `adc_data_capture_constain.xdc`.
4. Synthesize and implement the design.
5. Generate bitstream and program the FPGA.
---

If you encounter any issues or need support, feel free to open an issue or contact the maintainer.
