#!/usr/bin/env bash

# export C_INCLUDE_PATH=${PREFIX}/include:${C_INCLUDE_PATH}  # required as fftw3.h installed here
# export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
# define STATIC_FFTW_DIR so the patched setup.py will statically link FFTW
# export STATIC_FFTW_DIR=$PREFIX/lib

if [[ `uname` == 'Linux' ]]; then
    # -Bsymbolic link flag to ensure MKL FFT routines don't shadow FFTW ones.
    # see:  https://github.com/pyFFTW/pyFFTW/issues/40
    export CFLAGS="$CFLAGS -Wl,-Bsymbolic"
fi

echo "Prefix"
echo ${PREFIX}

ls ${PREFIX}

echo "LDFLAGS"
echo $LDFLAGS

echo "C_INCLUDE_PATH"
echo $C_INCLUDE_PATH

echo "Contents of C_INCLUDE_PATH"
# ls $C_INCLUDE_PATH

echo "Contents of prefix/lib"
ls ${PREFIX}/lib

$PYTHON setup.py build
$PYTHON setup.py install --single-version-externally-managed --record=record.txt
