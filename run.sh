#!/usr/bin/env bash

echo Convert into bw image
convert -type grayscale lena.png gray.png
convert -scale 25% gray.png foo.png
convert -scale 400% foo.png gray.png

echo Convert into red image
convert gray.png -color-matrix "1 0 0 0 0 0 0 0 0" red.png

echo Generate column images
convert red.png -crop 4x512 redtest_%03d.png

echo Generate progressive scanning demo
convert -delay 1x50 -loop 0 redtest_*.png progressive.gif
ffmpeg -i 'progressive.gif' -pix_fmt yuv420p progressive.mp4

echo Generate single-line scanning demo
convert -delay 1x50 -loop 0 -page +0+0 red_*.png single_line.gif
ffmpeg -i 'single_line.gif' -pix_fmt yuv420p single_line.mp4
