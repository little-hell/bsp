BSP=../build/src/bsp
MD5=md5sum
OUT=built

mkdir ${OUT}

${BSP} conduits.unbuiltwad -o ${OUT}/conduits.unbuiltwad.built > /dev/null
echo "conduits.wad   -> `md5sum ${OUT}/conduits.unbuiltwad.built | awk '{ print $1 }'` == 703bc4d19cbb06db23d9f264d86febbd"

${BSP} transdor.unbuiltwad -o ${OUT}/transdor.unbuiltwad.built > /dev/null
echo "transdor.wad   -> `md5sum ${OUT}/transdor.unbuiltwad.built | awk '{ print $1 }'` == aa79ab02c8a6413b6d24f8149578953d"

${BSP} visarea.unbuiltwad -o ${OUT}/visarea.unbuiltwad.built > /dev/null
echo "visarea.wad    -> `md5sum ${OUT}/visarea.unbuiltwad.built | awk '{ print $1 }'` == e7fa3cac54e7d4c2387e042198cc2368"

rm -r ${OUT}
