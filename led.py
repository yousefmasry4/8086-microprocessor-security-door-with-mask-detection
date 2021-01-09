import cv2
import time
def l():
    file =open("C:/Users/Yousseff EL Masry/AppData/Local/VirtualStore/emu8086.io","rb")

    byte = file.read(1)
    i=0
    a=[]
    while byte:
        a.append(byte)
        i+=1
        byte = file.read(1)
    return a

while(1):

    img=cv2.imread('g.png'if l()[1] != b'\x00' else 'r.png')
    cv2.imshow('image',img)
    if cv2.waitKey(250) & 0xFF == ord('q'):
        break