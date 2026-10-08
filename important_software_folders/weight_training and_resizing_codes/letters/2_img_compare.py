import numpy as np
import cv2

def phase_to_image_array(phase_string, size=(11, 8), scale=20, border=4):
    if len(phase_string) != size[0] * size[1]:
        raise ValueError(f"Phase string must be {size[0]*size[1]} characters long for a {size[0]}x{size[1]} image.")

    # Convert each hex char to grayscale value
    gray_vals = [(val if val <= 8 else 16 - val) * 31 for ch in phase_string for val in [int(ch, 16)]]
    img_array = np.array(gray_vals, dtype=np.uint8).reshape(size)

    # Resize for display
    resized_img = cv2.resize(img_array, (size[1]*scale, size[0]*scale), interpolation=cv2.INTER_NEAREST)

    # Add white border around the image
    bordered_img = cv2.copyMakeBorder(resized_img, border, border, border, border, cv2.BORDER_CONSTANT, value=255)
    return bordered_img

def compare_vertical_phase_images(top_phase, bottom_phase, output_path='vertical_phase_comparison_final.png'):
    size = (11, 8)      # rows x columns
    scale = 20          # smaller image scale
    border = 4          # white border thickness
    gap = 10            # white gap between images
    bg_margin = 20      # black margin around entire canvas

    # Create bordered images
    img_top = phase_to_image_array(top_phase, size=size, scale=scale, border=border)
    img_bottom = phase_to_image_array(bottom_phase, size=size, scale=scale, border=border)

    # Get image dimensions
    h, w = img_top.shape

    # Final canvas size
    canvas_height = h * 2 + gap + 2 * bg_margin
    canvas_width = w + 2 * bg_margin
    canvas = np.zeros((canvas_height, canvas_width), dtype=np.uint8)  # black background

    # Place top image
    y_top = bg_margin
    x_center = bg_margin
    canvas[y_top:y_top+h, x_center:x_center+w] = img_top

    # White gap
    canvas[y_top+h:y_top+h+gap, x_center:x_center+w] = 255

    # Place bottom image
    y_bottom = y_top + h + gap
    canvas[y_bottom:y_bottom+h, x_center:x_center+w] = img_bottom

    # Save and show
    cv2.imwrite(output_path, canvas)
    cv2.imshow("Top: State | Bottom: Phi_out", canvas)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

# 88-character test strings
state = "2805008880000008000880000588880000828888508800000088000000888805000880008050000828005082"
phi_out = "8805008880000008000880000088880000828888008800000088000000888800000880008050000888005088"

compare_vertical_phase_images(state, phi_out)
