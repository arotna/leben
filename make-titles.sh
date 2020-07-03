# creates a csv file from an title, typically master
# uses directory name to make unique

assembly=$(sed 's/^.*\/\(.*\).adoc/\1/'<<< "$1")
dir=$1
dir="$(dirname $dir)"   # Returns "/from/here/to"
dir="$(basename $dir)"  # Returns just "to"


while read module; do sed -n 's/^include.*\/\(.*\).adoc.*/\1/p' $modules;done <$1 | sed -e "s/^/$assembly,/" > "$assembly-$dir.csv"
