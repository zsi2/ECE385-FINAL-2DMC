from scipy.io import wavfile
from scipy.io.wavfile import write
import numpy as np

def dec2bin(dec):
    if dec >= 0 and dec <= 32767:
        return '%.*x' % (4, int(bin(dec), 0))
    elif dec >= -32768:
        return '%.*x' % (4, int(bin(dec & 0b1111111111111111), 0))
    return 'error'

filename = "Music\example.wav"

samplerate, data = wavfile.read(filename)

samplerate, data = wavfile.read(filename)
left = data[:,0]
right = data[:,1]

# f = open(r"Music\Minecraft_left.txt", 'w')
# g = open(r"Music\Minecraft_right.txt", 'w')
# for i in range(len(left)):
#     #data_l = "16'h" + dec2bin(left[i])
#     data_l = left[i]
#     #data_r = "16'h" + dec2bin(right[i])
#     data_r = right[i]
#     f.write(str(data_l) + ',')
#     g.write(str(data_r) + ',')
# f.close()
# g.close()

print(len(left))