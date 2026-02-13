# File paths
# input_file = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN EMNIST\weights\onn_weights_14x14_5bit_hex.hex"
# output_file = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN EMNIST\weights\onn_weights_14x14_5bit_assign.txt"

# # Helper: Convert hex string to 5-bit binary string
# def hex_to_bin_5bit(hex_str):
#     val = int(hex_str, 16)
#     bin_str = format(val & 0x1F, '05b')  # Ensure 5-bit
#     return bin_str

# # Read hex data
# with open(input_file, "r") as f:
#     data = f.read().split()

# # Matrix dimensions
# DIM = 196
# expected_entries = DIM * DIM

# # Validate size
# if len(data) != expected_entries:
#     raise ValueError(f"Hex file must contain exactly {expected_entries} values for a {DIM}x{DIM} matrix, but got {len(data)}.")

# # Write Verilog assignment code
# with open(output_file, "w") as f:
#     f.write("initial begin\n")
#     for i in range(DIM):
#         f.write("\n")
#         for j in range(DIM):
#             idx = i * DIM + j
#             bin_val = hex_to_bin_5bit(data[idx])
#             f.write(f"w[{i}][{j}] = 5'b{bin_val};")
#     f.write("end\n")

# Input hex file
# input_file = "C:\\Users\\chinm\\OneDrive\\Desktop\\ONN SRIP\\WEIGHT TRAIN\\new weights\\weights_9bit_09_new_hex.hex"
# # Output Verilog init file
# output_file ="C:\\Users\\chinm\\OneDrive\\Desktop\\ONN SRIP\\WEIGHT TRAIN\\new weights\\weights_9bit_09_new_assign.txt"
input_file = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN EMNIST\weights\onn_weights_14x14_9bit_hex.hex"
output_file = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN EMNIST\weights\onn_weights_14x14_9bit_assign.txt"

# Convert hex string to 9-bit binary string
def hex_to_bin_9bit(hex_str):
    val = int(hex_str, 16)
    bin_str = format(val & 0x1FF, '09b')  # Mask and convert to 9-bit binary
    return bin_str

# Read hex values
with open(input_file, "r") as f:
    data = f.read().split()

# Validate size
# if len(data) != 3600:
#     raise ValueError("Hex file must contain exactly 3600 values for a 60x60 matrix.")

# Write Verilog initialization
with open(output_file, "w") as f:
    f.write("initial begin\n")
    for i in range(196):
        line = ""
        for j in range(196):
            idx = i * 196 + j
            bin_val = hex_to_bin_9bit(data[idx])
            line += f"w[{i}][{j}]=9'b{bin_val}; "
        f.write("  " + line.strip() + "\n")
    f.write("end\n")
