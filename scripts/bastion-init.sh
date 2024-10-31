#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y curl git

mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz

tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz

RUNNER_ALLOW_RUNASROOT=1 ./config.sh \
  --url https://github.com/alidevs/capstone \
  --token ACC7TVX7MZV7ZHUQW55XDX3HEQBN4 \
  --name "bastion-runner"

RUNNER_ALLOW_RUNASROOT=1 ./run.sh &
