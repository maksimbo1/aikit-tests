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
"$CONDA" install --yes --prefix "$PREFIX" constructor
mkdir -p "$INSTALLER_DIR"
cat <<EOF > "$INSTALLER_DIR/construct.yaml"
name: Intel-AIkit
version: 2021.4.1
channels:
  - intel
  - defaults

specs:
  - python=3.7
  - pyeditline
  - modin-core=$MODIN_VERSION
  - modin-omnisci=$MODIN_VERSION
  - pyomniscidbe=$OMNISCIDB_VERSION
  - numpy
  - scikit-learn-intelex >=2021.4
  - scikit-ipp
  - threadpoolctl
  - xgboost >=1.4.2
  - conda
  - bzip2
  - intel-openmp
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
  - intel-opencl-rt
  - libclang-cpp
  - tensorflow >=2.5.0
  - python-flatbuffers
  - impi-devel >=2021.4
  - pytorch >=1.8.0
  - intel-extension-for-pytorch >=1.8.0
  - torchvision
  - torch_ccl
  - lpot >=1.5.1
  - distributed
  - libthrift=0.14.*
  - thrift-cpp=0.14.*

EOF
( cd "$INSTALLER_DIR" && "$CONSTRUCTOR" . && mv "$MODIN_INSTALLER" "$CUR_DIR" )
