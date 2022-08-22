#!/bin/bash
wmst="/Users/alexteal/Documents/school/womens_studies/"
ds="/Users/alexteal/Documents/school/datastructures_and_algorithms/"
theory="/Users/alexteal/Documents/school/intro_to_theory/"
stats="/Users/alexteal/Documents/school/stats/"
echo $0 script
echo $1 ds
echo $2 file
if [ "$2" == "" ]; then
    echo "No file provided"
    exit 1
fi
filename=$(basename "$2")
case $1 in
    wmst)
        echo "moving to wmst"
        mv "$2" "$wmst"
        ;;
    theory)
        echo "moving to theory"
        mv "$2" "$theory"
        ;;
    stats)
        echo "moving to stats"
        mv "$2" "$stats"
        ;;
    ds)
        echo "moving to datastructures & algorithms"
        mv "$2" "$ds"
        ;;
    *)
        echo -n "Move a file directly to the specified class."
        echo -n "\$ classify [class tag] [file]"
        echo -n "tags:"
        echo -n "wmst   - Women's Studies                   $wmst"
        echo -n "theory - Theory of Computing               $theory"
        echo -n "stats  - Stats 2000                        $stats"
        echo -n "ds     - Datastructures and Algorithms     $ds"
        exit 1
        ;;
esac
