from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import os

temp = []


img = Image.open(r'Pictures may used\Heart.bmp')
pixel_values = list(img.getdata())
img.close()
txt_name = 'Heart.txt'
f = open(os.path.join(r'Pictures may used\txt', txt_name), 'w')
for item in pixel_values:
    temp_str = "24'h"
    for i in range(len(item)):
        add_str = str(hex(item[i])[2:])
        if len(add_str) == 1:
            add_str = '0' + add_str
        temp_str = temp_str + add_str
    f.write(temp_str)
    f.write(',')
    f.write('\n')
f.close()