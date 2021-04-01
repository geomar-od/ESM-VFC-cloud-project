FROM jupyter/base-notebook

RUN mamba install \
    git \
    netcdf4 zarr \
    dask graphviz python-graphviz distributed bokeh dask-jobqueue \
    xarray xgcm \
    matplotlib \
 && pip install git+https://github.com/willirath/xorca.git@master \
 && pip cache purge && mamba clean --all

ENV JUPYTER_ENABLE_LAB=true

