from PIL import Image
import matplotlib.pyplot as plt
import numpy as np

img = Image.open('Pictures may used\grass.png')
pixel_values = list(img.getdata())
print(len(pixel_values))

with open(r'Pictures may used\txt\grass.txt', 'w') as f:
    for item in pixel_values:
        temp = str(item)
        # f.write(temp)
        # f.write('\n')