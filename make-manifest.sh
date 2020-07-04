# creates a manifest from titles, assemblies and modules
assembly=$(sed 's/^.*\/\(.*\).adoc/\1/'<<< "$1")
dir=$1
dir="$(dirname $dir)"   # Returns "/from/here/to"
longtitle="$(basename $dir)"  # Returns just "to"

q -d , "select c2 from $assembly-$longtitle.csv"| xargs -I{} q -d , "select '$longtitle',* from {}.csv" >manifest.csv
