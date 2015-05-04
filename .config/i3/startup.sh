#!/bin/bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# ( http://stackoverflow.com/a/246128 )
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

for prog in $(find $dir/startup -type f -o -type l); do
  echo $prog && $prog &
done

wait
