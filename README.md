# Digital Oscillatory Neural Network (ONN) on FPGA

Digital implementation of an **Oscillatory Neural Network (ONN)** for image and pattern recognition on the **Xilinx Nexys 4 DDR FPGA**.

The project explores phase-based neuromorphic computing using coupled digital oscillators and Hebbian-trained synaptic weights.

## Architecture

![ONN Architecture](Reports_and_presentations/ONN%20Blocks%20img2.png)

The system consists of:

- **Synapse Block** – stores learned coupling weights and generates neuron inputs.
- **Neuron Bank** – parallel digital oscillators representing image pixels.
- **ONN Controller FSM** – controls initialization, synchronization and convergence.
- **Phase Processing** – calculates and updates oscillator phases.
- **Hamming Distance Comparator** – compares the final phase pattern with stored patterns.

Each neuron uses a **16-bit circular oscillator** with a **4-bit phase representation**, providing 16 possible phase states.

![Phase Waveforms](Reports_and_presentations/phase%20waves.png)

# Project Evolution

### 3×5 Digit Recognition

- 15 neurons
- 15×15 synaptic matrix
- Recognition of digits **0, 1 and 2**
- Initial ONN implementation

### 10×6 Digit Recognition

- 60 neurons
- 60×60 synaptic matrix
- Custom digit patterns for **0–9**
- Investigation of network scaling and weight precision

### 10×10 EMNIST Recognition

- 100 neurons
- 100×100 synaptic matrix
- Reduced **28×28 EMNIST images to 10×10**
- Experiments focused on digits **0 and 1**
- Tested different weight precisions and image preprocessing

### Letter Recognition

Recognition experiments using:

- **I**
- **T**
- **G**
- **N**

# Repository Structure

```text
ONN_on_FPGA/
│
├── RTL_codes/
│   ├── ONN_complete.v
│   ├── control_fsm.v
│   ├── control_to_neuron_v2.v
│   ├── edge detector.v
│   ├── freq_divd.v
│   ├── img_load.v
│   ├── neuron.v
│   ├── neuron bank.v
│   ├── pco.v
│   ├── phase diff calculator.v
│   ├── phase_reg.v
│   ├── synapse_block.v
│   ├── top_module.v
│   └── uart_out.v
│
├── test_benches/
│   ├── 5x3_digits/
│   ├── 10x6_digit/
│   ├── EMNIST_digit/
│   └── letters/
│
├── weights_hex_files/
│   ├── 3x5 digit/
│   ├── 10x6 digit/
│   ├── 10x10 emnist/
│   └── letter/
│
├── Some_images_used_for_training/
├── Output_images/
├── important_software_folders/
└── Reports_and_presentations/
```

## RTL Modules

| Module | Function |
|---|---|
| `ONN_complete.v` | Main ONN integration |
| `control_fsm.v` | ONN control and synchronization |
| `control_to_neuron_v2.v` | Controller–neuron interface |
| `neuron.v` | Digital ONN neuron |
| `neuron bank.v` | Parallel neuron array |
| `pco.v` | Digital oscillator |
| `phase diff calculator.v` | Phase difference calculation |
| `phase_reg.v` | Phase storage and update |
| `synapse_block.v` | Weight storage and coupling |
| `img_load.v` | Image/state loading |
| `freq_divd.v` | Clock divider |
| `uart_out.v` | UART output |
| `top_module.v` | FPGA top-level module |

## FPGA Platform

**Board:** Xilinx Nexys 4 DDR

The architecture exploits FPGA parallelism to implement multiple coupled oscillators and synaptic computations concurrently.

## Author

**Chinmay Kulkarni**  
IIT Gandhinagar
