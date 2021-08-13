# Dask system testing workloads

Make sure the following

```shell
$ cat $HOME/.dask/config.yaml
distributed:
  dashboard:
    link: "{JUPYTERHUB_BASE_URL}user/{JUPYTERHUB_USER}/proxy/{port}/status"
```

is specified in the JupyterHub user persistent storage volume.

## References

* https://github.com/dask/dask-examples/pull/129
