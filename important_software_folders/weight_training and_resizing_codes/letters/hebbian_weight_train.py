import numpy as np
from PIL import Image
import os

class ONN:
    def __init__(self, image_shape=(11,8)):
        self.weights = None
        self.train_patterns = []
        self.image_shape = image_shape
        self.num_pixels = image_shape[0] * image_shape[1]

    def grayscale_to_bipolar(self, image_path, threshold=128):
        """Convert image to bipolar (-1, +1) format."""
        img = Image.open(image_path).convert('L').resize(self.image_shape[::-1])
        img_array = np.array(img)
        img_binary = (img_array < threshold).astype(int)  # Black = +1, White = -1
        return 2 * img_binary - 1
 
    def train(self, dataset_folder):
        # """Train the ONN using Hebbian learning from a folder of images (no labels)."""
        self.train_patterns = []
        self.weights = np.zeros((self.num_pixels, self.num_pixels))

        for filename in os.listdir(dataset_folder):
            if filename.endswith(".png"):
                path = os.path.join(dataset_folder, filename)
                pattern = self.grayscale_to_bipolar(path).flatten()
                self.train_patterns.append(pattern)
                self.weights += np.outer(pattern, pattern)

        # Remove self-connections
        np.fill_diagonal(self.weights, 0)
        print(f"Training complete. Total patterns: {len(self.train_patterns)}")


    def save_weights(self, save_path):
        np.save(save_path, {
            "weights": self.weights,
            # "train_patterns": self.train_patterns,
            "train_patterns": list(self.train_patterns),
            "image_shape": self.image_shape
        })
        print(f"Weights saved to {save_path}")

    def load_weights(self, load_path):
        data = np.load(load_path, allow_pickle=True).item()
        self.weights = data["weights"]
        self.train_patterns = data["train_patterns"]
        self.image_shape = tuple(data["image_shape"])
        self.num_pixels = self.image_shape[0] * self.image_shape[1]
        print(f"Weights loaded from {load_path}")
        
        
        
dataset_path = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN letter\letter img\letters\train multiple ig"
weights_path = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\ONN letter\weights\weights_ig.npy"

onn = ONN(image_shape=(11,8))
onn.train(dataset_path)
onn.save_weights(weights_path)
