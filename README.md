# Jiri's Helm charts

This repository contains Helm charts created by Jiri Tyr.

## Usage

Helm charts are published into the GHCR registry. Every Helm chart in this
repository has a `README.md` file that contains information about its usage.

## Contribution

All contributions are checks by [`pre-commit`](https://pre-commit.com/). You can
run it locally after you install it like this:

```bash
# MacOS
brew install pre-commit

# Arch Linux
pacman -S pre-commit
```

Then it needs to be activated in your clone of this repository like this:

```bash
gh repo clone jtyr/helm-charts
cd helm-charts
pre-commit install
```

This needs to be done only once.

## Author

Jiri Tyr
