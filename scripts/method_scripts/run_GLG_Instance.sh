#!/bin/sh
# script for execution of deployed applications
#
# Sets up the MATLAB Runtime environment for the current $ARCH and executes 
# the specified command.
#
exe_name=$0
exe_dir=`dirname "$0"`
tar xzf r2014b.tar.gz
rm r2014b.tar.gz
tar xzf SLIBS.tar.gz
rm SLIBS.tar.gz
mv libX11.so.6 SS
mv libxcb.so.1 SS
echo "------------------------------------------"
if [ "x$1" = "x" ]; then
  echo Usage:
  echo    $0 \<deployedMCRroot\> args
else
  echo Setting up environment variables
  MCRROOT="$1"
  echo ---
  LD_LIBRARY_PATH=.:${MCRROOT}/runtime/glnxa64 ;
  LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/bin/glnxa64 ;
  LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/sys/os/glnxa64;
  LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/sys/opengl/lib/glnxa64;
  LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$PWD/SS;
  export LD_LIBRARY_PATH;
  echo LD_LIBRARY_PATH is ${LD_LIBRARY_PATH};
  #echo ---
  #XAPPLRESDIR=${MCRROOT}/X11/app-defaults;
  #export XAPPLRESDIR
  shift 1
  args=
  while [ $# -gt 0 ]; do
      token=$1
      args="${args} \"${token}\"" 
      shift
  done
  eval "\"${exe_dir}/GLG_Instance\"" $args
  eval "rm X*.mat"
  eval "mv Output/*.mat ."
fi
exit

