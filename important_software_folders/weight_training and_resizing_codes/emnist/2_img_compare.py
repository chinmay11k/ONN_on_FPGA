import numpy as np
import cv2

def phase_to_image_array(phase_string, size=(10, 10), scale=400):
    if len(phase_string) != size[0] * size[1]:
        raise ValueError(f"Phase string must be exactly {size[0]*size[1]} characters long for a {size[0]}x{size[1]} image.")

    # gray_vals = [(val if val <= 8 else 16 - val) * 31 for val in [int(ch, 16)] for ch in phase_string]
    gray_vals = [(val if val <= 8 else 16 - val) * 31 for ch in phase_string for val in [int(ch, 16)]]

    # gray_vals = [(ch if int(ch)<= 8 else 16 -int(ch)) * 31 for ch in phase_string]
    # gray_vals = [int(ch) * 31 for ch in phase_string]  # Map 0-8 to 0-248
    img_array = np.array(gray_vals, dtype=np.uint8).reshape(size)
    resized_img = cv2.resize(img_array, (scale, scale), interpolation=cv2.INTER_NEAREST)
    return resized_img

def compare_phase_images(original_phase, new_phase, output_path='comparison.png'):
    # Final image size
    final_width, final_height =1200, 650
    image_scale = 400
    gap = 100  # space between the two images

    # Create images
    img1 = phase_to_image_array(original_phase, scale=image_scale)
    img2 = phase_to_image_array(new_phase, scale=image_scale)

    # Create black background
    background = np.zeros((final_height, final_width), dtype=np.uint8)

    # Calculate positions to center images with spacing
    total_image_width = 2 * image_scale + gap
    start_x = (final_width - total_image_width) // 2
    start_y = (final_height - image_scale) // 2

    # Paste first image
    background[start_y:start_y+image_scale, start_x:start_x+image_scale] = img1
    # Paste second image
    background[start_y:start_y+image_scale, start_x+image_scale+gap:start_x+2*image_scale+gap] = img2

    # Save and display
    cv2.imwrite(output_path, background)
    cv2.imshow("Original vs New Phase Image", background)
    cv2.waitKey(0)
    
state = "8888888888888800888888880088888888008888888800888888880088888888008888888800888888880088888888888888"
phi_out = "8888888888888000088888000000088000000008800088800880088800088000800088800000008888800088888888888888"


compare_phase_images(state,phi_out , "phase_comparison_black_bg.png")
