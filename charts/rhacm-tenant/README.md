rhacm-tenant
============

This is a Helm chart that helps to onboard a new Git repo into an existing ACM
Hub.

The deployment is intended to create two ACM chanels - the `git` and the `helm`
channel. The `git` channel points to a Git repository and is used in the ACM
subscription deployed by this Helm chart. The `helm` channel points to a Helm
registry used by apps targetted by the `git` channel.

Usage
-----

Install the Helm chart like this:

```shell
helm repo add jtyr https://jtyr.github.io/helm-charts
helm upgrade --install --values /path/to/tenants_values.yaml tenants jtyr/rhacm-tenant
```

where the `tenants_values.yaml` looks like this:

```yaml
# Override of the Helm chart name
name: tenants

# Map of channels to be created
channels:
  # Git channel tracks Git repository
  git:
    type: Git
    pathname: https://github.com/jtyr/rhacm-tenants.git
    subscriptionAnnotations:
      # Specify which Git branch should be tracked by ACM
      apps.open-cluster-management.io/git-branch: main
      # Make it reconcile every 2 mins
      apps.open-cluster-management.io/reconcile-rate: high
  # Helm channel provides access to a Helm registry
  helm:
    type: HelmRepo
    pathname: https://jtyr.github.io/helm-charts

# Map of placement rules to be created
placementRules:
  # This is the name of the placement
  cloud-azure:
    # This is the spec of the placement
    clusterSelector:
      matchLabels:
        cloud: Azure
```

Or another example with no placement rules:

```yaml
# Override of the Helm chart name
name: tenant-a

# Map of channels to be created
channels:
  # Git channel tracks Git repository
  git:
    type: Git
    pathname: https://github.com/jtyr/rhacm-tenant-a.git
    subscriptionAnnotations:
      # Specify which Git branch should be tracked by ACM
      apps.open-cluster-management.io/git-branch: main
      # Make it reconcile every 2 mins
      apps.open-cluster-management.io/reconcile-rate: high
  # Helm channel provides access to a Helm registry
  helm:
    type: HelmRepo
    pathname: https://chartmuseum.github.io/charts
```

Author
------

Jiri Tyr
