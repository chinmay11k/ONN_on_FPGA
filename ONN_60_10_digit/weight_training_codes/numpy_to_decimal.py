import numpy as np

# Load the original .npy file
data = np.load("C:\\Users\\chinm\\OneDrive\\Desktop\\ONN SRIP\\WEIGHT TRAIN\\onn_weights.npy", allow_pickle=True).item()
weights = data["weights"]

# # Save to text file in decimal format
# np.savetxt("weight_decimal.txt", weights, fmt="%d")

# print("Weights saved in decimal format to weights_decimal.txt")
output_path = "C:\\Users\\chinm\\OneDrive\\Desktop\\ONN SRIP\\WEIGHT TRAIN\\weight_decimal.txt"
np.savetxt(output_path, weights, fmt="%d")
