from PIL import Image
import sys

file = sys.argv[1]
pix = Image.open(file+".bmp")

x = int(pix.width/32)
y = int(pix.height/32)

c64Colours = [(0, 0, 0), (255, 255, 255), (193, 80, 80), (132, 197, 204),
              (147, 81, 182), (114, 177, 75), (53, 40, 121), (213, 223, 124),
              (111, 79, 37), (67, 57, 0), (193, 129, 120), (96, 96, 96),
              (108, 108, 108), (179, 236, 145), (134, 122, 222), (179, 179, 179)
              ]

allChars = []
for tileY in range(y):
    baseY = tileY*32
    for tileX in range(x):
        baseX = tileX*32
        cxCharData = []
        for line in range(32):
            for pixel in range(32):
                p = pix.getpixel((baseX+pixel, baseY+line))
                if p in c64Colours:
                    cxCharData.append(c64Colours.index(p))
                else:
                    cxCharData.append(0)
        allChars.append(cxCharData)

final_chars = [0, 0]
for char in allChars:
    charOutData = []
    i = 0
    while i < 32:
        j = 0
        while j < 32:
            first_half = char[(i*32)+j]
            j = j + 1
            second_half = char[(i*32)+j]
            j = j + 1
            final_chars.append((first_half << 4) | second_half)
        i = i + 1
    # final_chars.append(charOutData)

#line = 9010
#for cxTile in final_chars:
#    strlist = [str(x) for x in cxTile]
#    for i in range(0, len(cxTile), 16):
#        print(str(line)+" DATA " + ','.join(strlist[i: i + 16]))
#        line = line + 10

data = bytearray(final_chars)
newFile = open(file+".ver", "wb")
newFile.write(data)
