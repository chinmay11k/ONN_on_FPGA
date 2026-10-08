import numpy as np

# ---------- CONFIGURATION ----------
input_npy = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN EMNIST 10X10\constrained weights\weight_con_10x10_emnist.npy"
DIM = 100

# Output file paths
hex_5bit_file = "onn_weights_10x10_5bit_hex.hex"
hex_9bit_file = "onn_weights_10x10_9bit_hex.hex"
decimal_txt_file = "onn_weights_10x10_txt.txt"
verilog_assign_5bit = "onn_weights_10x10_5bit_assign.txt"
verilog_assign_9bit = "onn_weights_10x10_9bit_assign.txt"
# -----------------------------------

# Load data
data = np.load(input_npy, allow_pickle=True).item()
weights = data["weights"].reshape(DIM, DIM)

# ----- Save 5-bit signed hex -----
weights_clipped_5bit = np.clip(weights.astype(np.int32), -16, 15)
with open(hex_5bit_file, "w") as f:
    for i in range(DIM):
        for j in range(DIM):
            val = weights_clipped_5bit[i, j] & 0x1F  # 5-bit two's complement
            f.write(f"{val:02X}\n")

# ----- Save 9-bit signed hex -----
weights_clipped_9bit = np.clip(weights.astype(np.int32), -256, 255)
with open(hex_9bit_file, "w") as f:
    for i in range(DIM):
        for j in range(DIM):
            val = weights_clipped_9bit[i, j] & 0x1FF  # 9-bit two's complement
            f.write(f"{val:03X}\n")

# ----- Save decimal matrix -----
np.savetxt(decimal_txt_file, weights, fmt="%d")

# ----- Helper functions -----
def hex_to_bin_nbit(hex_str, bits):
    val = int(hex_str, 16)
    return format(val & ((1 << bits) - 1), f'0{bits}b')

# ----- Generate Verilog assignment (5-bit) -----
with open(hex_5bit_file, "r") as f:
    hex_data_5bit = f.read().split()

if len(hex_data_5bit) != DIM * DIM:
    raise ValueError("5-bit hex file size mismatch.")

with open(verilog_assign_5bit, "w") as f:
    f.write("initial begin\n")
    for i in range(DIM):
        f.write("\n")
        for j in range(DIM):
            idx = i * DIM + j
            bin_val = hex_to_bin_nbit(hex_data_5bit[idx], 5)
            f.write(f"    w5[{i}][{j}] = 5'b{bin_val};\n")
    f.write("end\n")

# ----- Generate Verilog assignment (9-bit) -----
with open(hex_9bit_file, "r") as f:
    hex_data_9bit = f.read().split()

if len(hex_data_9bit) != DIM * DIM:
    raise ValueError("9-bit hex file size mismatch.")

with open(verilog_assign_9bit, "w") as f:
    f.write("initial begin\n")
    for i in range(DIM):
        f.write("\n")
        for j in range(DIM):
            idx = i * DIM + j
            bin_val = hex_to_bin_nbit(hex_data_9bit[idx], 9)
            f.write(f"    w9[{i}][{j}] = 9'b{bin_val};\n")
    f.write("end\n")
