#!/bin/bash

# from https://bbs.archlinux.org/viewtopic.php?pid=1558932#p1558932

echo Clock modulation:
rdmsr -a 0x19a

wrmsr -a 0x19a 0x0

echo Clock modulation:
rdmsr -a 0x19a
