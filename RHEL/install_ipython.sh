#!/bin/sh
#
pip3 install --upgrade --force-reinstall ipykernel ipywidgets jupyterhub notebook traitlets tornado jinja2 jupyter-client jupyter-core nbconvert nbformat tornado jinja2 tornado jupyter-client tornado --no-cache-dir
python36 -m ipykernel install
python27 /usr/bin/pip27 install --upgrade --force-reinstall ipykernel traitlets jupyter-client tornado jupyter-core futures path.py --no-cache-dir
python27 -m ipykernel install
/usr/local/bin/jupyter nbextension enable --py --sys-prefix widgetsnbextension
