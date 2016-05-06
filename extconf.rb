require "mkmf"
require "carray/mkmf"

dir_config("opencv", possible_includes, possible_libs)

if have_carray() and have_header("opencv2/core/core_c.h")
  create_makefile("carray/carray_opencv")
end
