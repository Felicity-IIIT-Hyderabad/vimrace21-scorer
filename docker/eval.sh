#!/bin/sh

cd /scorer/files

err=0
corr=0

for f in *.in; do
    q="$( echo $f | cut -d. -f1 )"
    echo "Test $q"

    vim -u NONE -Z -n +0 -s solve "$f" >/dev/null

    if diff -a "${q}.out" "${q}.in"; then
        echo "Passed"
        corr="$( echo "${corr}+1" | bc )"
    else
        echo "Failed"
        err="$( echo "${err}+1" | bc )"
    fi

done

echo "+${corr} -${err}"
