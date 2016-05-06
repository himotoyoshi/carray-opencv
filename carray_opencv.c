#include "opencv2/core/core_c.h"
#include "carray.h"

static VALUE mOpenCV;
static VALUE cCvMat, cIplImage;

static VALUE
rb_iplimage_ca (VALUE self)
{
  IplImage *image;
  int dim[3];
  int data_type = CA_UINT8;

  Data_Get_Struct(self, IplImage, image);

  switch (image->depth) {
  case IPL_DEPTH_8U:
    data_type = CA_UINT8;
    break;
  case IPL_DEPTH_8S:
    data_type = CA_INT8;
    break;
  case IPL_DEPTH_16U:
    data_type = CA_UINT16;
    break;
  case IPL_DEPTH_16S:
    data_type = CA_INT16;
    break;
  case IPL_DEPTH_32S:
    data_type = CA_INT32;
    break;
  case IPL_DEPTH_32F:
    data_type = CA_FLOAT32;
    break;
  case IPL_DEPTH_64F:
    data_type = CA_FLOAT64;
    break;
  }
  
  dim[0] = image->height;
  dim[1] = image->widthStep/image->nChannels;
  dim[2] = image->nChannels;

  return rb_carray_wrap_ptr(data_type, 3, dim, 0, NULL, image->imageData, self);
}

static VALUE
rb_cvmat_ca (VALUE self)
{
  CvMat *mat;
  int dim[3];
  int data_type = CA_UINT8;

  Data_Get_Struct(self, CvMat, mat);

  switch (CV_MAT_TYPE(mat->type)) {
  case CV_8U:
    data_type = CA_UINT8;
    break;
  case CV_8S:
    data_type = CA_INT8;
    break;
  case CV_16U:
    data_type = CA_UINT16;
    break;
  case CV_16S:
    data_type = CA_INT16;
    break;
  case CV_32S:
    data_type = CA_INT32;
    break;
  case CV_32F:
    data_type = CA_FLOAT32;
    break;
  case CV_64F:
    data_type = CA_FLOAT64;
    break;
  }

  dim[0] = mat->rows;
  dim[1] = mat->cols;
  dim[2] = CV_MAT_CN(mat->type);  

  return rb_carray_wrap_ptr(data_type, 3, dim, 0, NULL, (char *) mat->data.ptr, self);
}


static VALUE
rb_cvmat_image (VALUE self)
{
  volatile VALUE obj;
  IplImage *image;
  CvMat *mat;
  int type;
  int channels;

  Data_Get_Struct(self, CvMat, mat);

  type = CV_MAT_TYPE(mat->type);
  channels = CV_MAT_CN(mat->type);

  obj = rb_funcall(cIplImage, rb_intern("new"), 3, 
                    INT2FIX(mat->cols), INT2FIX(mat->rows), INT2FIX(type), INT2FIX(channels));
  Data_Get_Struct(obj, IplImage, image);

  cvCopy(mat, image, NULL);
            
  return obj;
}


void
Init_carray_opencv ()
{
  mOpenCV   = rb_const_get(rb_cObject,    rb_intern("OpenCV"));
  cCvMat    = rb_const_get(mOpenCV,       rb_intern("CvMat"));
  cIplImage = rb_const_get(mOpenCV,       rb_intern("IplImage"));

  rb_define_method(cIplImage, "ca", rb_iplimage_ca, 0);
  rb_define_method(cCvMat, "ca", rb_cvmat_ca, 0);
  rb_define_method(cCvMat, "image", rb_cvmat_image, 0);

}