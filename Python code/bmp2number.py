from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import os

colors = [(87, 87, 87), (151, 151, 151), (0, 0, 0), (33, 29, 23), (164, 114, 39), (188, 152, 98), (67, 54, 33), (93, 236, 245), (255, 255, 255), (183, 71, 0), (252, 238, 75), (60, 
152, 19), (121, 85, 58), (185, 133, 92), (15, 38, 5)]


def color2index(color):
    colors = {
        (87, 87, 87): '0001',
        (151, 151, 151): '0010',
        (0, 0, 0): '0011',
        (33, 29, 23): '0100',
        (164, 114, 39): '0101',
        (188, 152, 98): '0110',
        (67, 54, 33): '0111',
        (93, 236, 245): '1000',
        (255, 255, 255): '1001',
        (183, 71, 0): '1010',
        (252, 238, 75): '1011',
        (60, 152, 19): '1100',
        (121, 85, 58): '1101',
        (185, 133, 92): '1110',
        (15, 38, 5): '1111'
    }
    return colors[color]


temp = []

for root, dirs, files in os.walk(r"Pictures may used\bmp"):
    for file in files:
        file_name, file_extension = os.path.splitext(file)
        if file_extension == '.bmp':
            img = Image.open(os.path.join(root, file))
            pixel_values = list(img.getdata())
            img.close()
            txt_name = file_name + '.txt'
            f = open(os.path.join(r'Pictures may used\indextxt', txt_name), 'w')
            for item in pixel_values:
                f.write("4'b" + color2index(item) + ',\n')
            f.close()