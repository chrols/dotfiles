#!/usr/bin/env python3

import subprocess
import os
import random

bg_path="/home/chrols/Media/themes/background/nice/nicest"
files = [ bg_path+"/"+f for f in os.listdir(path=bg_path) if os.path.isfile(bg_path+"/"+f) ]

random_int = random.randint(0,len(files)-1)
random_file = files[random_int]

subprocess.call(["feh","--bg-scale",random_file])
