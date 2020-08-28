#!/bin/bash

set -e

# all projects in one workspace
# usage:
# ./install_kernels_lab.sh beakerx_conda_env_name
#  conda activate beakerx_conda_env_name

if [ ! -z "$1" ]
then
	(conda env create -n $1 -f configuration-lab.yml)
	source ~/anaconda3/etc/profile.d/conda.sh
	conda activate $1
	(conda install -y -c conda-forge jupyterlab=1)
fi

(cd ../../beakerx_base; pip install -r requirements.txt --verbose)
(cd ../../beakerx_tabledisplay/beakerx_tabledisplay; pip install -r requirements.txt --verbose; beakerx_tabledisplay install)
(cd ../../beakerx_widgets/beakerx_widgets; pip install -r requirements.txt --verbose; beakerx install)
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
(cd ../../beakerx_widgets/js; jupyter labextension install . --no-build)
(cd ../../beakerx_tabledisplay/js; jupyter labextension install . --no-build)
jupyter lab build

if [ ! -z "$1" ]
then
	echo To activate this environment, use:
	echo
	echo      conda activate $1
	echo  
fi    
