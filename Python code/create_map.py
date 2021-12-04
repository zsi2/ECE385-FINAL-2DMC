import random
import os
import numpy as np
import scipy.stats as st

#For search block
blocks_dict = {
    "__Air__": '0000',
    "Bedrock": '0001',
    "_Chest_": '0010',
    "CoalOre": '0011',
    "Crafting_Table": '0100',
    "Dia_Ore": '0101',
    "Furnace": '0110',
    "GoldOre": '0111',
    "_Grass_": '1000',
    "IronOre": '1001',
    "_Leaves": '1010',
    "__Rock_": '1011',
    "__Soil_": '1100',
    "_Water_": '1101',
    "__Wood_": '1110',
}

#Creating Air in the map
rows = 100
columns = 128
ndarray_map = np.array([['Bedrock'] * rows for i in range(columns)])
for column_index in range(columns):
    for row_index in range(rows):
        ndarray_map[column_index][row_index] = '__Air__'

# f = open(os.path.join(r'Pictures\Map\txt', 'Create_Air.txt'), 'w')
# for row_index in range(rows):
#     for column_index in range(columns):
#         f.write(ndarray_map[column_index][99 - row_index])
#         f.write(',')
#     f.write('\n')
# f.close()

Soil_Heights = [47 + random.randint(1,5)]

#Creating Soil change varaibles
p_high = (0.04, 0.06, 0.12, 0.18, 0.6)
c_high = (2, -2, 1, -1, 0)
soil_change_high = st.rv_discrete(values = (c_high, p_high))
p_low = (0.04, 0.06, 0.12, 0.18, 0.6)
c_low = (-2, 2, -1, 1, 0)
soil_change_low = st.rv_discrete(values = (c_low, p_low))
p_medium = (0.05, 0.05, 0.15, 0.15, 0.6)
c_medium = (-2, 2, -1, 1, 0)
soil_change_medium = st.rv_discrete(values = (c_medium, p_medium))

for i in range(1, columns):
    past_height = Soil_Heights[i - 1]
    if past_height > 60:
        Soil_Heights.append(past_height + soil_change_high.rvs())
    elif past_height > 40:
        Soil_Heights.append(past_height + soil_change_medium.rvs())
    else:
        Soil_Heights.append(past_height + soil_change_low.rvs())

#Creating Bedrock, Rock and Soil in the map
for column_index in range(columns):
    ndarray_map[column_index][0] = "Bedrock"
    bias = random.randint(1,5)
    for row_index in range(1, Soil_Heights[column_index] - bias):
        ndarray_map[column_index][row_index] = "__Rock_"
    for row_index in range(Soil_Heights[column_index] - bias, Soil_Heights[column_index]):
        ndarray_map[column_index][row_index] = "__Soil_"
    ndarray_map[column_index][Soil_Heights[column_index]] = "_Grass_"

#Creating Trees in the map
Trees = [0]
for i in range(0, columns):
    if i < Trees[-1] + 5:
        continue
    if random.randint(0, 20) == 0:
        Trees.append(i)
Trees.remove(0)

for column_index in Trees:
    soil_height = Soil_Heights[column_index]
    for i in range(-3, 4):
        ndarray_map[column_index + i][soil_height + 4] = "_Leaves"
    for i in range(-2, 3):
        ndarray_map[column_index + i][soil_height + 5] = "_Leaves"
    for i in range(-1, 2):
        ndarray_map[column_index + i][soil_height + 6] = "_Leaves"
    ndarray_map[column_index][soil_height + 7] = "_Leaves"
    for i in range(1, 6):
        ndarray_map[column_index][soil_height + i] = "__Wood_"

#Creating Ores in the map
for column_index in range(columns):
    for row_index in range(1, Soil_Heights[column_index] - 5):
        if ndarray_map[column_index][row_index] != "__Rock_":
            continue
        if random.randint(0, 16) == 0:
            ndarray_map[column_index][row_index] = "CoalOre"
        if row_index < 60 and random.randint(0, 24) == 0:
            ndarray_map[column_index][row_index] = "IronOre"
        if row_index < 40 and random.randint(0, 36) == 0:
            ndarray_map[column_index][row_index] = "GoldOre"
        if row_index < 20 and random.randint(0, 54) == 0:
            ndarray_map[column_index][row_index] = "Dia_Ore"

f = open(os.path.join(r'Pictures\Map', 'Map.txt'), 'w')
g = open(os.path.join(r'Pictures\Map', 'MapIndex.txt'), 'w')
for row_index in range(rows):
    temp = "512'b"
    for column_index in range(columns):
        f.write(ndarray_map[column_index][99 - row_index])
        temp += str(blocks_dict[ndarray_map[column_index][99 - row_index]])
        f.write(',')
    g.write(temp + ',\n')
    f.write('\n')
f.close()