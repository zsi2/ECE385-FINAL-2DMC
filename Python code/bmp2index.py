from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import os

def block2index(block):
    blocks_dict = {
        "Air": '0000',
        "BedRock": '0001',
        "Wood": '0010',
        "Rock": '0011',
        "Soil": '0100',
        "Diamond_Ore": '0101',
        "Furnace": '0110',
        "Gold_Ore": '0111',
        "Grass": '1000',
        "Iron_Ore": '1001',
        "Leaves": '1010',
        "Coal_Ore": '1011',
        "Crafting_Table": '1100',
        "Water": '1101',
        "Chest": '1110',
    }
    return blocks_dict[block]


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