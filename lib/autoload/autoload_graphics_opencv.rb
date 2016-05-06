module OpenCV
  class CvMat
    autoload_method "ca", "carray/graphics/opencv"
    autoload_method "to_ca", "carray/graphics/opencv"
    autoload_method "from_ca", "carray/graphics/opencv"
    autoload_method "image", "carray/graphics/opencv"
  end
  class IplImage < CvMat
    autoload_method "ca", "carray/graphics/opencv"
  end
end

class CArray
  autoload_method "to_cvmat", "carray/graphics/opencv"
  autoload_method "to_iplimage", "carray/graphics/opencv"
end