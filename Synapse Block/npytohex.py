import numpy as np

# Load data
data = np.load("/content/drive/MyDrive/ONN Database/weights.npy", allow_pickle=True)
onn_data = data.item()
weights = onn_data['weights']

# Reshape to 15x15 (critical!)
weights = weights.reshape(15, 15)

# Clip to valid 5-bit signed range
weights_clipped = np.clip(weights.astype(np.int32), -16, 15)

# Save as proper 15x15 hex
with open("/content/drive/MyDrive/ONN Database/weights.hex", "w") as f:
    for i in range(15):
        for j in range(15):
            val = weights_clipped[i, j]
            val_5bit = val & 0x1F  # 5-bit mask
            f.write(f"{val_5bit:02X}\n")
