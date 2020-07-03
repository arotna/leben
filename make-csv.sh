# creates a csv file from an assembly

assembly=$(sed 's/^.*\/\(.*\).adoc/\1/'<<< "$1")


while read module; do sed -n 's/^include.*\/\(.*\).adoc.*/\1/p' $modules;done <$1 | sed -e "s/^/$assembly,/" > "$assembly.csv"
