from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import os


color_dict = {
    (139, 139, 139): '0\n',
    (0, 0, 0): '1\n',
    #(139, 139, 139): '10\n',
    #(139, 139, 139): '11\n',
}


temp = []

for root, dirs, files in os.walk(r"temp"):
    for file in files:
        file_name, file_extension = os.path.splitext(file)
        if file_extension == '.bmp':
            img = Image.open(os.path.join(root, file))
            pixel_values = list(img.getdata())
            img.close()
            txt_name = file_name + '.txt'
            f = open(os.path.join(r'temp', txt_name), 'w')
            for item in pixel_values:
                f.write(color_dict[item])
                # temp_str = "24'h"
                # temp_str = ""
                # for i in range(len(item)):
                #     #print(bin(item[i])[2:])
                #     add_str = str(bin(item[i])[2:])
                #     while len(add_str) < 8:
                #         add_str = '0' + add_str
                #     #print(add_str)
                #     temp_str = temp_str + add_str
                # f.write(temp_str + '\n')
            f.close()