# Kubernetes setup

Useful aspects on [GCP machine-type](https://cloud.google.com/compute/docs/machine-types) choices,

> All VMs are categorized by machine family. The second generation of general-purpose VMs includes E2, E2 shared-core, N2, and N2D. N1, and N1 shared-core VMs are in the first generation. All machine families support preemptible VMs, with the exception of M2 memory-optimized VMs.

> You are billed for the resources that a VM uses. When you create a VM, you select a machine type for the instance and are billed as described in the VM instance pricing page. Specifically, you are billed for each vCPU and GB of memory individually, as described in resource-based billing model. Applicable discounts, such as sustained use discounts and committed use discounts apply.

> N1 machine types can receive a sustained use discount up to 30%. N2 machine types can receive a sustained use discount up to 20%. E2 machine types do not offer sustained use discounts but provide larger savings directly through the on-demand and committed-use prices. E2 machine types provide consistently predictable pricing without the requirement to run a VM for a specific portion of the month.

Current machine-type prices for `europe-west3` in Frankfurt/Germany according to the [GCP VM price list](https://cloud.google.com/compute/vm-instance-pricing) (July 14th, 2021),

```
Machine type	vCPUs	Memory	Price (USD)	Preemptible price (USD)
e2-standard-2	2	8GB	$0.086334	$0.025894
n2-standard-2	2	8GB	$0.125124	$0.02876
n2d-standard-2	2	8GB	$0.108854	$0.02502
n1-standard-2	2	7.5GB	$0.122400	$0.02460

e2-standard-2	2	8GB	$63.02		$18.90
n2-standard-2	2	8GB	$73.07		$20.99 (with 20% sustained use discount)
n2d-standard-2	2	8GB	$63.57		$18.26 (with 20% sustained use discount)
n1-standard-2	2	7.5GB	$62.55		$17.96 (with 30% sustained use discount)
```

> If your ideal machine shape is in between two predefined types, using a custom ... machine type could save you as much as 40%.

For the test setup use the `e2-standard-2` machine-type for now. (Which differs from the example in the [JupyterHub GCP deployment docs](https://zero-to-jupyterhub.readthedocs.io/en/latest/kubernetes/google/step-zero-gcp.html).)
Note, a Kubernetes cluster can be "stopped" without deleting it by rescaling the number of (core) nodes to zero.
Any storage location that was created will still produce costs.

