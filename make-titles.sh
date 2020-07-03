# creates a csv file from an assembly

assembly=$(sed 's/^.*\/\(.*\).adoc/\1/'<<< "$1")
dir=$1
dir="$(dirname $dir)"   # Returns "/from/here/to"
dir="$(basename $dir)"  # Returns just "to"


while read module; do sed -n 's/^include.*\/\(.*\).adoc.*/\1/p' $modules;done <$1 | sed -e "s/^/$assembly,/" > "$dir-$assembly.adoc"
