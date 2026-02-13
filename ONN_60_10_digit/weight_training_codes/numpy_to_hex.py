# import numpy as np

# # Load data
# data = np.load("C:\\Users\\chinm\\OneDrive\\Desktop\\ONN SRIP\\WEIGHT TRAIN\\onn_weight_balenced.npy", allow_pickle=True).item()

# # data = np.load("/content/drive/MyDrive/ONN Database/weights.npy", allow_pickle=True)
# # onn_data = data.item()
# weights = onn_data['weights']

# # Reshape to 15x15 (critical!)
# weights = weights.reshape(60, 60)

# # Clip to valid 5-bit signed range
# weights_clipped = np.clip(weights.astype(np.int32), -16, 15)

# # Save as proper 15x15 hex
# with open("/content/drive/MyDrive/ONN Database/weights_hex.hex", "w") as f:
#     for i in range(60):
#         for j in range(60):
#             val = weights_clipped[i, j]
#             val_5bit = val & 0x1F  # 5-bit mask
#             f.write(f"{val_5bit:02X}\n")
import numpy as np

# Load data
data = np.load(r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\WEIGHT TRAIN\new weights\onn_weight_09_new.npy", allow_pickle=True).item()
weights = data['weights']

# Reshape to 60x60
weights = weights.reshape(60, 60)

# Clip to valid 5-bit signed range
weights_clipped = np.clip(weights.astype(np.int32), -16, 15)

# Save as proper hex format (5-bit two's complement)
with open("C:\\Users\\chinm\\OneDrive\\Desktop\\ONN SRIP\\WEIGHT TRAIN\\new weights\\weights_09_new_5bit_hex.hex", "w") as f:
    for i in range(60):
        for j in range(60):
            val = weights_clipped[i, j]
            val_5bit = val & 0x1F  # Convert to 5-bit unsigned (two's complement representation)
            f.write(f"{val_5bit:02X}\n")
# import numpy as np

# # Load data
# data = np.load(r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\WEIGHT TRAIN\new weights\onn_weight_09_new.npy", allow_pickle=True).item()
# weights = data['weights']

# # Reshape to 60x60
# weights = weights.reshape(60, 60)

# # Clip to valid 9-bit signed range
# weights_clipped = np.clip(weights.astype(np.int32), -256, 255)

# # Save as proper 9-bit hex format (two's complement)
# with open("C:\\Users\\chinm\\OneDrive\\Desktop\\ONN SRIP\\WEIGHT TRAIN\\new weights\\weights_9bit_09_new_hex.hex", "w") as f:
#     for i in range(60):
#         for j in range(60):
#             val = weights_clipped[i, j]
#             val_9bit = val & 0x1FF  # Convert to 9-bit two's complement representation
#             f.write(f"{val_9bit:03X}\n")  # 3-digit hex