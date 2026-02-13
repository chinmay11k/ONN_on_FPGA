import cv2

# Load image (grayscale)
img = cv2.imread(r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\WEIGHT TRAIN\main img\9_001.png", cv2.IMREAD_GRAYSCALE)

# Resize to 60x100
resized_img = cv2.resize(img, (60, 100), interpolation=cv2.INTER_NEAREST)  # or cv2.INTER_LINEAR

# Save or display
cv2.imwrite(r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\WEIGHT TRAIN\main img\resized_digits\9_001_new.png", resized_img)
# cv2.imshow('Resized Image', resized_img)
# cv2.waitKey(0)
# cv2.destroyAllWindows()
