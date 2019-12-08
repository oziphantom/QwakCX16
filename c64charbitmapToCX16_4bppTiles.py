from PIL import Image
import sys

file = sys.argv[1]
pix = Image.open(file+".bmp")

x = int(pix.width/8)
y = int(pix.height/8)

c64Colours = [(0, 0, 0), (255, 255, 255), (104, 55, 43), (112, 164, 178),
              (111, 61, 134), (88, 141, 67), (53, 40, 121), (184, 199, 111),
              (111, 79, 37), (67, 57, 0), (154, 103, 89), (68, 68, 68),
              (108, 108, 108), (154, 210, 132), (108, 94, 181), (149, 149, 149)
              ]

allChars = []
for tileY in range(y):
    baseY = tileY*8
    for tileX in range(x):
        baseX = tileX*8
        cxCharData = []
        for line in range(8):
            for pixel in range(8):
                p = pix.getpixel((baseX+pixel, baseY+line))
                if p in c64Colours:
                    cxCharData.append(c64Colours.index(p))
                else:
                    cxCharData.append(0)
        allChars.append(cxCharData)

final_chars = []
for char in allChars:
    charOutData = []
    i = 0
    while i < 8:
        j = 0
        while j < 8:
            first_half = char[(i*8)+j]
            j = j + 1
            second_half = char[(i*8)+j]
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
