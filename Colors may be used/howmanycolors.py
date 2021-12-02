from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import os

colors = []


# for root, dirs, files in os.walk(r"Pictures may used\bmp"):
#     for file in files:
#         file_name, file_extension = os.path.splitext(file)
#         if file_extension == '.bmp':
#             img = Image.open(os.path.join(root, file))
#             pixel_values = list(img.getdata())
#             img.close()
#             for item in pixel_values:
#                 if item not in colors:
#                     colors.append(item)

img = Image.open(os.path.join(r"Pictures may used\bmp", "BedRock.bmp"))
pixel_values = list(img.getdata())
img.close()
for item in pixel_values:
    if item not in colors:
        colors.append(item)

img = Image.open(os.path.join(r"Pictures may used\bmp", "Chest.bmp"))
pixel_values = list(img.getdata())
img.close()
for item in pixel_values:
    if item not in colors:
        colors.append(item)

img = Image.open(os.path.join(r"Pictures may used\bmp", "Coal_Ore.bmp"))
pixel_values = list(img.getdata())
img.close()
for item in pixel_values:
    if item not in colors:
        colors.append(item)

img = Image.open(os.path.join(r"Pictures may used\bmp", "Cobblestone.bmp"))
pixel_values = list(img.getdata())
img.close()
for item in pixel_values:
    if item not in colors:
        colors.append(item)
        
img = Image.open(os.path.join(r"Pictures may used\bmp", "Crafting_Table.bmp"))
pixel_values = list(img.getdata())
img.close()
for item in pixel_values:
    if item not in colors:
        colors.append(item)
print(len(colors))
print(colors)

