#!/usr/bin/env bash

set -xe
export CUR_DIR="`pwd`"
export LOCAL_TMP="`pwd`/tmp"
export PREFIX="$LOCAL_TMP/miniconda"
export CONDA="$PREFIX/bin/conda"
export CONSTRUCTOR="$PREFIX/bin/constructor"
export INSTALLER_DIR="$LOCAL_TMP/installer"
export MODIN_VERSION=0.11
export MODIN_INSTALLER="Intel-AIkit-2021.4.1-Linux-x86_64.sh"
export OMNISCIDB_VERSION="5.7.1"
export MINICONDA_INSTALLER="$LOCAL_TMP/Miniconda3-latest-Linux-x86_64.sh"
mkdir -p "$LOCAL_TMP"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --output-document="$MINICONDA_INSTALLER"
bash "$MINICONDA_INSTALLER" -p "$PREFIX" -b -f -u
"$CONDA" install --yes constructor #python=3.6
mkdir -p "$INSTALLER_DIR"
cat <<EOF > "$INSTALLER_DIR/construct.yaml"
name: Intel-AIkit
version: 2021.4.1
channels:
  - defaults

specs:
  - dpcpp_cpp_rt
  - python=3.7
  - modin-core=$MODIN_VERSION
  - modin-omnisci=$MODIN_VERSION
  - pyomniscidbe=$OMNISCIDB_VERSION
  - numpy
  - scikit-learn-intelex
  - xgboost
  - intel::intel-aikit-tensorflow
  - intel::intel-aikit-pytorch
  - lpot
  - conda
  - bzip2
  - icc_rt
  - intel-openmp
  - intelpython
  - libffi
  - libgcc-ng
  - libstdcxx-ng
  - mkl
  - mkl-service
  - mkl_fft
  - mkl_random
  - numpy
  - numpy-base
  - openssl
  - pip
  - pyyaml
  - scipy
  - setuptools
  - six
  - sqlite
  - tbb
  - tbb4py
  - tk
  - wheel
  - yaml
  - zlib
  - libgdal
  - opencl_rt
  - intel-opencl-rt
  - libclang-cpp
EOF
( cd "$INSTALLER_DIR" && "$CONSTRUCTOR" . && mv "$MODIN_INSTALLER" "$CUR_DIR" )
