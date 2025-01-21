#!/usr/bin/env bash

#Note: Requires Python 3
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar -xf google-cloud-cli-linux-x86_64.tar.gz

#Install interactive, requires user inputs
./google-cloud-sdk/install.sh
