require "opencv"
require 'carray'
require 'carray/carray_opencv'

class OpenCV::CvMat
  
  def to_ca
    return self.ca.to_ca
  end

  def from_ca (ca)
    self.ca[] = ca
    return self
  end
  
end

class CArray
  
  def to_cvmat (type = nil)
    if type
      case type
      when :cv8u
        ca_type = CA_UINT8
      when :cv8s
        ca_type = CA_INT8
      when :cv16u
        ca_type = CA_UINT16
      when :cv16s
        ca_type = CA_INT16
      when :cv32s
        ca_type = CA_INT32
      when :cv32f
        ca_type = CA_FLOAT32
      when :cv64f
        ca_type = CA_FLOAT64
      else
        raise "invalid CvMat type"
      end
      case self.rank
      when 2
        obj = OpenCV::CvMat.new(self.dim0, self.dim1, type, 1)
      when 3
        obj = OpenCV::CvMat.new(self.dim0, self.dim1, type, self.dim2)    
      else
        raise "invalid CArray rank"
      end
      obj.ca[] = self.as_type(ca_type)
      return obj
    else
      case data_type
      when CA_UINT8
        type = :cv8u
      when CA_INT8
        type = :cv8s
      when CA_UINT16
        type = :cv16u
      when CA_INT16
        type = :cv16s
      when CA_INT32
        type = :cv32s
      when CA_FLOAT32
        type = :cv32f
      when CA_FLOAT64
        type = :cv64f
      else
        raise "invalid CArray type"
      end
      case self.rank
      when 2
        obj = OpenCV::CvMat.new(self.dim0, self.dim1, type, 1)
      when 3
        obj = OpenCV::CvMat.new(self.dim0, self.dim1, type, self.dim2)    
      else
        raise "invalid CArray rank"
      end
      obj.ca[] = self
      return obj
    end
    
  end
  
  def to_iplimage (type=nil)
    if type
      case type
      when :cv8u
        ca_type = CA_UINT8
      when :cv8s
        ca_type = CA_INT8
      when :cv16u
        ca_type = CA_UINT16
      when :cv16s
        ca_type = CA_INT16
      when :cv32s
        ca_type = CA_INT32
      when :cv32f
        ca_type = CA_FLOAT32
      when :cv64f
        ca_type = CA_FLOAT64
      else
        raise "invalid CvMat type"
      end
      case self.rank
      when 2
        obj = OpenCV::IplImage.new(self.dim1, self.dim0, type, 1)
      when 3
        obj = OpenCV::IplImage.new(self.dim1, self.dim0, type, self.dim2)    
      else
        raise "invalid CArray rank"
      end
      obj.ca[] = self.as_type(ca_type)
      return obj
    else
      case data_type
      when CA_UINT8
        type = :cv8u
      when CA_INT8
        type = :cv8s
      when CA_UINT16
        type = :cv16u
      when CA_INT16
        type = :cv16s
      when CA_INT32
        type = :cv32s
      when CA_FLOAT32
        type = :cv32f
      when CA_FLOAT64
        type = :cv64f
      else
        raise "invalid CArray type"
      end
      case self.rank
      when 2
        obj = OpenCV::IplImage.new(self.dim1, self.dim0, type, 1)
      when 3
        obj = OpenCV::IplImage.new(self.dim0, self.dim1, type, self.dim2)    
      else
        raise "invalid CArray rank"
      end
      obj.ca[] = self.transposed
      return obj
    end    
  end
  
end


__END__
win = GUI::Window.new("test")

img = CvMat.load("hibari.png")
ca = img.to_ca
ca[100..150,100..150,nil] = 255
img.fill!(255)
img.from_ca(ca)
win.show img

STDIN.gets
