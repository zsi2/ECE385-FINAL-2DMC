import random
import os
import numpy as np
import scipy.stats as st

#For search block
blocks_dict = {
    "__Air__": "0000",
    "Bedrock": "0001",
    "_Chest_": "1110",
    "CoalOre": "1011",
    "Crafting_Table": "1100",
    "Dia_Ore": "0101",
    "Furnace": "0110",
    "GoldOre": "0111",
    "_Grass_": "1000",
    "IronOre": "1001",
    "_Leaves": "1010",
    "__Rock_": "0011",
    "__Soil_": "0100",
    "CobRock": "1101",
    "__Wood_": "0010",
    "WoodPlk": "1111",
}

blocks_dict_2 = {
    "__Air__": 0x0,
    "Bedrock": 0x1,
    "_Chest_": 0x2,
    "CoalOre": 0x3,
    "Crafting_Table": 0x4,
    "Dia_Ore": 0x5,
    "Furnace": 0x6,
    "GoldOre": 0x7,
    "_Grass_": 0x8,
    "IronOre": 0x9,
    "_Leaves": 0xA,
    "__Rock_": 0xB,
    "__Soil_": 0xC,
    "_Water_": 0xD,
    "__Wood_": 0xE,
}

blocks_dict_3 = {
    "__Air__": "0",
    "Bedrock": "1",
    "_Chest_": "E",
    "CoalOre": "B",
    "Crafting_Table": "C",
    "Dia_Ore": "5",
    "Furnace": "6",
    "GoldOre": "7",
    "_Grass_": "8",
    "IronOre": "9",
    "_Leaves": "A",
    "__Rock_": "3",
    "__Soil_": "4",
    "CobRock": "D",
    "__Wood_": "2",
    "WoodPlk": "F",
}

#Creating Air in the map
rows = 64
columns = 256
ndarray_map = np.array([['Bedrock'] * rows for i in range(columns)])
for column_index in range(columns):
    for row_index in range(rows):
        ndarray_map[column_index][row_index] = '__Air__'

# f = open(os.path.join(r'Pictures\Map\txt', 'Create_Air.txt'), 'w')
# for row_index in range(rows):
#     for column_index in range(columns):
#         f.write(ndarray_map[column_index][rows - 1 - row_index])
#         f.write(',')
#     f.write('\n')
# f.close()

Soil_Heights = [30 + random.randint(1,5)]

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
    if past_height > 56:
        Soil_Heights.append(past_height - 2)
    elif past_height > 48:
        Soil_Heights.append(past_height + soil_change_high.rvs())
    elif past_height > 16:
        Soil_Heights.append(past_height + soil_change_medium.rvs())
    elif past_height > 8:
        Soil_Heights.append(past_height + soil_change_low.rvs())
    else:
        Soil_Heights.append(past_height + 2)

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
for i in range(5, columns - 5):
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
for column_index in range(2, columns - 2):
    for row_index in range(2, Soil_Heights[column_index] - 5):
        if ndarray_map[column_index][row_index] != "__Rock_":
            continue
        if random.randint(0, 16) == 0:
            ndarray_map[column_index][row_index] = "CoalOre"
            if random.randint(0, 3) == 0:
                ndarray_map[column_index][row_index - 1] = "CoalOre"
            if random.randint(0, 3) == 0:
                ndarray_map[column_index - 1][row_index] = "CoalOre"
                if random.randint(0, 2) == 0:
                    ndarray_map[column_index][row_index - 1] = "CoalOre"
        if row_index < 32 and random.randint(0, 24) == 0:
            ndarray_map[column_index][row_index] = "IronOre"
            if random.randint(0, 3) == 0:
                ndarray_map[column_index][row_index - 1] = "IronOre"
            if random.randint(0, 3) == 0:
                ndarray_map[column_index - 1][row_index] = "IronOre"
                if random.randint(0, 2) == 0:
                    ndarray_map[column_index][row_index - 1] = "IronOre"
        if row_index < 16 and random.randint(0, 36) == 0:
            ndarray_map[column_index][row_index] = "GoldOre"
            if random.randint(0, 3) == 0:
                ndarray_map[column_index][row_index - 1] = "GoldOre"
            if random.randint(0, 3) == 0:
                ndarray_map[column_index - 1][row_index] = "GoldOre"
                if random.randint(0, 2) == 0:
                    ndarray_map[column_index][row_index - 1] = "GoldOre"
        if row_index < 8 and random.randint(0, 54) == 0:
            ndarray_map[column_index][row_index] = "Dia_Ore"
            if random.randint(0, 3) == 0:
                ndarray_map[column_index][row_index - 1] = "Dia_Ore"
            if random.randint(0, 3) == 0:
                ndarray_map[column_index - 1][row_index] = "Dia_Ore"
                if random.randint(0, 2) == 0:
                    ndarray_map[column_index][row_index - 1] = "Dia_Ore"


f = open(os.path.join(r'Pictures\Map', 'Map.txt'), 'w')
for row_index in range(rows):
    for column_index in range(columns):
        f.write(ndarray_map[column_index][rows - 1 - row_index])
    f.write('\n')
f.close()


# g = open(os.path.join(r'Pictures\Map', 'MapIndex.bin'), 'wb')
# dx = dy = 15
# g.write(dx.to_bytes(1, byteorder = 'big'))
# g.write(dy.to_bytes(1, byteorder = 'big'))
# temp = ""
# for row_index in range(rows):
#     for column_index in range(columns):
#         temp += blocks_dict_3[ndarray_map[column_index][rows - 1 - row_index]]
#         if len(temp) == 2:
#             print(temp)
#             temp = int(temp, 16)
#             print(temp)
#             g.write(temp.to_bytes(1, byteorder = 'big'))
#             temp = ""
# g.close()

# i = j = 0
# g = open(os.path.join(r'Pictures\Map', 'MapIndex' + str(j) + '.txt'), 'w')
# for row_index in range(rows):
#     temp = "32'h"
#     for column_index in range(columns):
#         temp += blocks_dict_3[ndarray_map[column_index][rows - 1 - row_index]]
#         if i == 400:
#             g.close()
#             i = 0
#             j += 1
#             g = open(os.path.join(r'Pictures\Map', 'MapIndex' + str(j) + '.txt'), 'w')
#         if len(temp) == 12:
#             g.write(temp + ',\n')
#             i += 1
#             temp = "32'h"
# g.close()

# g = open(os.path.join(r'Pictures\Map', 'mapindex.txt'), 'w')
# for row_index in range(rows):
#     temp = ""
#     for column_index in range(columns):
#         temp += blocks_dict_3[ndarray_map[column_index][rows - 1 - row_index]]
#         #temp += blocks_dict[ndarray_map[columns - 1 - column_index][row_index]]
#     g.write(temp + '\n')
# g.close()

# i = j = 0

for i in range(0, 8):
    g = open(os.path.join(r'Pictures\Map', 'mapindex' + str(i) + '.txt'), 'w')
    for row_index in range(rows):
        temp = ""
        for column_index in range(32 * i, 32 * i + 32):
            temp += blocks_dict[ndarray_map[column_index][rows - 1 - row_index]]
        g.write(temp + '\n')
    g.close()