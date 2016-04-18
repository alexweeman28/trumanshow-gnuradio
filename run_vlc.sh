#!/bin/bash

cvlc wmea.mp3 --sout '#transcode{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100}:http{dst=:8080/wbpr.mp3}'


