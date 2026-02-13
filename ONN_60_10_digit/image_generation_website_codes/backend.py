from flask import Flask, request, jsonify, render_template
import os
import numpy as np
from PIL import Image

app = Flask(__name__)

SAVE_DIR = r"C:\Users\chinm\OneDrive\Desktop\ONN SRIP\WEIGHT TRAIN\no images"
GRID_SIZE = (10, 6)  # 10 rows × 6 columns

# Make sure folders 0-9 exist
for i in range(10):
    os.makedirs(os.path.join(SAVE_DIR, str(i)), exist_ok=True)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/save', methods=['POST'])
def save_image():
    data = request.json
    label = data['label']  # '0'–'9'
    grid_values = data['data']  # flat list of 60 grayscale values
    is_new = data.get('isNew', False)

    folder = os.path.join(SAVE_DIR, label)
    existing_files = sorted([
        f for f in os.listdir(folder)
        if f.startswith(f'{label}_') and f.endswith('.png')
    ])

    if existing_files and not is_new:
        filename = existing_files[-1]  # Overwrite last image
    else:
        count = len(existing_files) + 1
        filename = f"{label}_{count:03}.png"

    filepath = os.path.join(folder, filename)

    # Save image
    arr = np.array(grid_values, dtype=np.uint8).reshape(GRID_SIZE)
    img = Image.fromarray(arr, mode='L')
    img.save(filepath)

    return jsonify({"message": f"Saved as {filename} in folder {label}."})

if __name__ == '__main__':
    app.run(debug=True)
