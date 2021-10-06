#!/usr/bin/env bash
export _CONDA_ROOT="$PREFIX"
\. "$_CONDA_ROOT/etc/profile.d/conda.sh" || return $?
conda activate "$@"
conda install modin-all -y
conda deactivate
