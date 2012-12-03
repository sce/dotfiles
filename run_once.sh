#!/bin/bash

USER=$(whoami)
pgrep -u $USER $@ > /dev/null || ($@ &)
