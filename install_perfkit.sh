#!/usr/bin/env bash

# Note: Requires Python 3.11+ to be installed
# Python version 3.13 is not supported, at the time of writing
# Download and create venv
git clone https://github.com/GoogleCloudPlatform/PerfKitBenchmarker.git
python3.12 -m venv PerfKitBenchmarker/.venv
source PerfKitBenchmarker/.venv/bin/activate

# Install generall and AWS dependencies
pip3.12 install -r PerfKitBenchmarker/requirements.txt
pip3.12 install -r PerfKitBenchmarker/perfkitbenchmarker/providers/aws/requirements.txt
