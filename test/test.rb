require "opencv"
require "carray"
#require "carray/graphics/opencv"

include OpenCV

win = GUI::Window.new("")
img = CvMat.new(640,480)
#img = IplImage.new(640,480)


ca = img.ca


loop do
  ca.fill(0)
  ca[nil,[100..150,5],2] = 255
  ca[[100..150,5],nil,0] = 255

  win.show img
  GUI.wait_key(1000)

  ca[] = 255
  ca[nil,[100..150,5],2] = 0
  ca[[100..150,5],nil,0] = 0
  win.show img.image

  GUI.wait_key(1000)
end

