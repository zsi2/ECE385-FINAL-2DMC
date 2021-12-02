from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import os


for root, dirs, files in os.walk(r"Pictures may used\bmp"):
    for file in files:
        file_name, file_extension = os.path.splitext(file)
        if file_extension == '.bmp':
            img = Image.open(os.path.join(root, file))
            pixel_values = list(img.getdata())
            img.close()
            txt_name = file_name + '.txt'
            f = open(os.path.join(r'Pictures may used\txt', txt_name), 'w')
            for item in pixel_values:
                temp = str(item)
                f.write(temp)
                f.write('\n')
            f.close()