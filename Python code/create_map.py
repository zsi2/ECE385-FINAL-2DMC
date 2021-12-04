import random
import os
 
print(random.randint(0,9))
list1 = []
dict1 = {0: '0001', 1: '0010', 2: '0101', 3: '1100', 4: '1001'}

for i in range(100):
    temp = "96'b"
    if i < 50:
        for j in range(24):
            if j ==12:
                temp += '0010'
            else:
                temp += '0000'
    elif i == 50 or i == 49:
        for j in range(24):
            temp += '0100'
    else:
        for j in range(24):
            temp += '0011'
    list1.append(temp)
    print(list1)

f = open('1.txt', 'w')
for i in range(len(list1)):
    f.write(list1[i] + ',\n')