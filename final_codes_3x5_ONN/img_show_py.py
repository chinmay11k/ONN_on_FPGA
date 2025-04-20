import serial
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image

# --- Serial Setup ---
ComPort = serial.Serial('COM9')  # Change COM port if needed
ComPort.baudrate = 9600
ComPort.bytesize = 8
ComPort.parity = 'N'
ComPort.stopbits = 1

# --- Receive 15 bytes (5x3 image) ---
arr = []
for i in range(15):
    byte = ComPort.read(size=1)
    arr.append(int.from_bytes(byte, byteorder='little'))
    print(f"Pixel {i}: {arr[-1]}")

print("Completed transmission")

# --- Save raw pixel data ---
with open("obtained_image.txt", 'w') as f:
    for pixel in arr:
        f.write(f"{pixel}\n")

# --- Convert to 5x3 image (5 rows, 3 columns) ---
img_5x3 = np.array(arr, dtype=np.uint8).reshape((5, 3))

# --- Resize to 150x250 using PIL ---
img_pil = Image.fromarray(img_5x3, mode='L')  # 'L' mode = grayscale
# img_resized = img_pil.resize((250, 150), Image.NEAREST)  # resize to 150 (height) x 250 (width)
img_resized = img_pil.resize((150, 250), Image.NEAREST)  # resize to 150 (height) x 250 (width)

# --- Display ---
plt.imshow(img_resized, cmap='gray', vmin=0, vmax=255)
plt.title("Upscaled Image (150x250)")
plt.axis('off')
plt.show()

# --- Optional: Save the upscaled image ---
img_resized.save("received_image_150x250.png")
