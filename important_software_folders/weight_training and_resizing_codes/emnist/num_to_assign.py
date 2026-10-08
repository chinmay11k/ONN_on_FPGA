import numpy as np

# Load weights
data = np.load(r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN EMNIST 10X10\single image train\weight\weight120.npy", allow_pickle=True).item()
weights = data['weights']

# Reshape to 100x100
weights = weights.reshape(100, 100)

# Clip to valid 5-bit signed range [-16, 15]
weights_clipped = np.clip(weights.astype(np.int32), -16, 15)

# Convert signed int to 5-bit two's complement binary string
def to_5bit_binary(val):
    if val < 0:
        val = (1 << 5) + val  # Convert negative to 2's complement
    return format(val, '05b')

# Generate Verilog assignments
output_file = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN EMNIST 10X10\single image train\weight\weight120_assign.txt"

with open(output_file, "w") as f:
    f.write("initial begin\n")
    for i in range(100):
        for j in range(100):
            bin_str = to_5bit_binary(weights_clipped[i][j])
            f.write(f"w[{i}][{j}] = 5'b{bin_str}; ")
        f.write("\n")

    f.write("end\n")
