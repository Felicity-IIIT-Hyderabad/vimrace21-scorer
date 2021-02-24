#!/bin/sh

cd /scorer/files

err=0
corr=0

for f in *.in; do
    q="$( echo "$f" | cut -d. -f1 )"
    echo "Test $q"

    # change permissions for input file
    chown vimgolf:vimgolf "$f"

    # run vim as vimgolf user so they cant edit any other files
    su - vimgolf -c "vim -u NONE -Z -n +0 -s solve $f >/dev/null" &
    pid=$!

    # kill process after 3s
    sleep 3
    kill $pid

    # check if output/input are different
    if diff -a "${q}.out" "${q}.in"; then
        echo "Passed"
        corr="$( echo "${corr}+1" | bc )"
    else
        echo "Failed"
        err="$( echo "${err}+1" | bc )"
    fi

done

echo "+${corr} -${err}"
