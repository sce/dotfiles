#!/bin/bash

USER=$(whoami)
pgrep -u $USER -f $@ > /dev/null || ($@ &)
