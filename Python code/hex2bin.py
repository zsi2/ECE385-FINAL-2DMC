import os


for root, dirs, files in os.walk(r"temp"):
    for file in files:
        file_name, file_extension = os.path.splitext(file)
        if file_extension == '.txt':
            f = open(os.path.join(root, file), 'r')
            g = open(os.path.join(root, file_name + 'bin.txt'), 'w')
            for line in f:
                line = bin(int(line[0:-1], 16))[2:]
                while len(line) < 24:
                    line = '0' + line
                g.write(line + '\n')
                # if line != '\n':
                #     temp = bin(int(line[0:-1],16))[2:]
            # img = Image.open(os.path.join(root, file))
            # pixel_values = list(img.getdata())
            # img.close()
            # for item in pixel_values:
            #     if item not in colors:
            #         colors.append(item)