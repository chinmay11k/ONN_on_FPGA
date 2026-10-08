import numpy as np
from PIL import Image

class ONN:
    def __init__(self):
        self.weights = None
        self.train_patterns = []  # Stores tuples of (bipolar_pattern, label)

    def grayscale_to_bipolar(self, image_path, threshold=128):
        """Convert image to bipolar array (white=-1, black=+1)."""
        img = Image.open(image_path).convert('L')
        img_array = np.array(img)
        img_binary = (img_array < threshold).astype(int)  # Inverted threshold
        return 2 * img_binary - 1

    def train(self, train_folder, labels):
        """Train ONN with labeled images."""
        self.train_patterns = []
        for label in labels:
            image_path = f"{train_folder}/{label}_a.png"
            pattern = self.grayscale_to_bipolar(image_path)
            self.train_patterns.append((pattern.flatten(), label))

        num_neurons = self.train_patterns[0][0].size
        self.weights = np.zeros((num_neurons, num_neurons))

        for pattern, _ in self.train_patterns:
            self.weights += np.outer(pattern, pattern)

        np.fill_diagonal(self.weights, 0)

    def stabilize(self, test_image_path, max_iter=10):
        """Stabilize a test image and return the predicted label."""
        test_pattern = self.grayscale_to_bipolar(test_image_path).flatten()
        current_state = test_pattern.copy()

        for _ in range(max_iter):
            new_state = np.sign(self.weights @ current_state)
            new_state[new_state == 0] = 1
            if np.array_equal(new_state, current_state):
                break
            current_state = new_state

        print("Stabilized Output:\n", current_state.reshape(5, 3))

        # Find closest stored pattern and its label
        min_error = float('inf')
        predicted_label = None
        for stored_pattern, label in self.train_patterns:
            error = np.sum(np.abs(stored_pattern - current_state))
            print(f"Error for label {label}: {error}")
            if error < min_error:
                min_error = error
                predicted_label = label

        return predicted_label

    def save_weights(self, save_path):
        """Save weights AND training patterns."""
        np.save(save_path, {
            "weights": self.weights,
            "train_patterns": self.train_patterns
        })

    def load_weights(self, load_path):
        """Load weights AND training patterns."""
        data = np.load(load_path, allow_pickle=True).item()
        self.weights = data["weights"]
        self.train_patterns = data["train_patterns"]

# Example usage in Google Colab:
if __name__ == "__main__":
    # Mount Google Drive (run once per session)
    from google.colab import drive
    drive.mount('/content/drive')

    # Define paths (hardcoded)
    train_folder = "/content/drive/MyDrive/ONN Database/Train"
    test_folder = "/content/drive/MyDrive/ONN Database/Test"
    weights_path = "/content/drive/MyDrive/ONN Database/weights.npy"
    labels = [0, 1, 2]  # Labels for digits 0, 1, 2

    # Initialize ONN
    onn = ONN()

    # Try to load weights; train if they don't exist
    try:
        onn.load_weights(weights_path)
        print("Loaded pre-trained weights and patterns!")
    except FileNotFoundError:
        print("Weights not found. Training...")
        onn.train(train_folder, labels)
        onn.save_weights(weights_path)
        print("Training complete. Weights saved!")

    # Test a corrupted image
    test_image_path = f"{test_folder}/0_test_a.png"
    predicted_label = onn.stabilize(test_image_path)
    print(f"Predicted digit: {predicted_label}")

    test_image_path_1 = f"{test_folder}/1_test_a.png"
    predicted_label_1 = onn.stabilize(test_image_path_1)
    print(f"Predicted digit: {predicted_label_1}")
