colors = [(87, 87, 87), (151, 151, 151), (0, 0, 0), (33, 29, 23), (164, 114, 39), (188, 152, 98), (67, 54, 33), (93, 236, 245), (255, 255, 255), (183, 71, 0), (252, 238, 75), (60, 
152, 19), (121, 85, 58), (185, 133, 92), (15, 38, 5)]



for item in colors:
    temp = ''
    for number in item:
        temp2 = str(hex(number))[2:]
        if len(temp2) == 1:
            temp2 = '0' + temp2
        temp = temp + temp2
    print(str(item) +': ' + temp)
