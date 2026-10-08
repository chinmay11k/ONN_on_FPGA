import cv2
import os

def process_image(filepath):
    gray = cv2.imread(filepath, cv2.IMREAD_GRAYSCALE)
    if gray is None:
        raise FileNotFoundError(f"Image not found: {filepath}")
    if gray.shape != (10, 10):
        raise ValueError(f"Image {filepath} is not 10x10 pixels")

    phase_vals = []
    for row in gray:
        for val in row:
            phase = int(val / 31)  # Map 0–255 to 0–8
            if phase > 8:
                phase = 8  # Cap at 8
            phase_vals.append(str(phase))

    joined_phase = ''.join(phase_vals)  # 100 characters for 10x10
    return joined_phase

# ==== CONFIG ====
folder_path = r"C:\Users\chinm\OneDrive\Desktop\ONN_all folders\ONN SRIP\ONN EMNIST 10X10\single image train\test"
# Process all image files in the folder
i=0
for filename in sorted(os.listdir(folder_path)):
    if filename.lower().endswith('.png'):
        filepath = os.path.join(folder_path, filename)
        try:
            phase_string = process_image(filepath)
            print(f"{i}: state <= 400'h{phase_string};")
            i=i+1
        except Exception as e:
            print(f"Error processing {filename}: {e}")
