# OctoPrint

This repository is a multi-arch Docker image for OctoPrint.

[![Build Status](https://travis-ci.org/heptoprint/docker-octoprint.svg?branch=master)](https://travis-ci.org/heptoprint/docker-octoprint)

## Usage

To get started, run:
```shell
docker run --rm -it -p 5000:5000 heptoprint/octoprint
```

Now, point a browser to [http://127.0.0.1:5000](http://127.0.0.1:5000) to access OctoPrint.

*Note*: by default, the container runs as the non-root `octoprint` user.
