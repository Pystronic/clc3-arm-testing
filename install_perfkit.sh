#!/usr/bin/env bash

# Note: Requires Python 3 to be installed
# Download and create venv
git clone https://github.com/GoogleCloudPlatform/PerfKitBenchmarker.git
python -m venv PerfKitBenchmarker/.venv
source PerfKitBenchmarker/.venv/bin/activate

# Install generall and AWS dependencies
pip install -r PerfKitBenchmarker/requirements.txt
pip install -r PerfKitBenchmarker/perfkitbenchmarker/providers/aws/requirements.txt
