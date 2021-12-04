from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import os

temp = []

for root, dirs, files in os.walk(r"Pictures\Map\bmp"):
    for file in files:
        file_name, file_extension = os.path.splitext(file)
        if file_extension == '.bmp':
            img = Image.open(os.path.join(root, file))
            pixel_values = list(img.getdata())
            img.close()
            txt_name = file_name + '.txt'
            f = open(os.path.join(r'Pictures\Map\txt', txt_name), 'w')
            for item in pixel_values:
                temp_str = "24'h"
                for i in range(len(item)):
                    add_str = str(hex(item[i])[2:])
                    if len(add_str) == 1:
                        add_str = '0' + add_str
                    temp_str = temp_str + add_str
                f.write(temp_str + ',\n')
            f.close()