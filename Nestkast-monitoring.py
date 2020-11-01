from gpiozero import MotionSensor
from time import sleep
from picamera import PiCamera
pir = MotionSensor(4) #pin nr
import datetime

camera = PiCamera()
teller = 0
recording = 0

while True:
        while pir.motion_detected:
                if recording == 0:
                        x = datetime.datetime.now()
                        camera.start_recording('/home/pi/scriptJordi/Vogelkast/video %s.h264' %x)
                        print("Start Recording")
                        recording = 1
                if recording == 1:
                        sleep(1)
                        teller = teller + 1
                        print(teller)
                if teller == 30 and recording == 1:
                        camera.stop_recording()
                        x = datetime.datetime.now()
                        camera.start_recording('/home/pi/scriptJordi/Vogelkast/video %s.h264' %x)
                        teller = 0
        if pir.motion_detected == False and recording == 1:
                camera.stop_recording()
                print("Stop Recording")
                recording = 0
                teller = 0
