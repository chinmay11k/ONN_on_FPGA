import numpy as np
import cv2

def phase_to_image(phase_string, output_path='output_500x500.png'):
    if len(phase_string) != 100:
        raise ValueError("Phase string must be exactly 196 characters long for a 14x14 image.")

    # Convert each character to grayscale value
    gray_vals = [int(ch) * 31 for ch in phase_string]
    
    # Convert to 14x14 NumPy array
    img_array = np.array(gray_vals, dtype=np.uint8).reshape((10, 10))

    # Resize to 140x140 using nearest neighbor interpolation
    resized_img = cv2.resize(img_array, (500, 500), interpolation=cv2.INTER_NEAREST)

    # Save image
    cv2.imwrite(output_path, resized_img)

    # Show image (optional)
    cv2.imshow("Reconstructed 500x500 Image", resized_img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

# === Example usage ===
phase_string ="8888888888888884488888887168888888448888888836888888871788888884288888888428888888864888888888888888"
phase_to_image(phase_string, "reconstructed_500x500.png")
