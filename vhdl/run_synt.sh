#!/bin/bash


set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)


cleanup() {
    trap - SIGINT SIGTERM ERR EXIT
    exit

}

if [ "$#" -ne 2 ]; then
      echo "Set <test_dir> <top_module_name>"
    exit
fi



current_dir=$(pwd)
files_path=${current_dir}/${1}/files
cd ${1}

rm -f *.dot
touch ${2}.txt
chmod 777 ${2}.txt
echo 'tcl '${script_dir}'/run_synt_cmos.tcl '${files_path}' '${2}'' > ${2}.txt
cat ${2}.txt
yosys < ${2}.txt

for file in $(ls *.dot); do
    gvpr -f $script_dir/split $file
done
rm -f *.png

for file in $(ls *.dot); do 
    echo $file; dot -Tpng $file -O
done

cd ${current_dir}

