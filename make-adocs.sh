# ./make-adocs.sh source-file [destination-directory]
# eg ./make-adocs.sh test.md will create files from any matching asciidoc tags
# Alway suffix destination directory with a slash, eg temp/
# requires template.adoc with the following content uncommented:
# include::{include-file}[tags={include-tags}]

echo "include::{include-file}[tags={include-tags}]">leben-template.log

SOURCE=$1
DEST=$2


while read line; 

do 

filename=$(sed -n 's/.*tag::\(.*\)\[.*/\1/p'<<<"$line")
#filename=$(sed 's/.*tag::\(.*\)\[.*/\1/p')

if [[ $filename != "" ]]
then
echo $filename
./asciidoc-coalescer.rb  -a include-tags="$filename" -a include-file=$SOURCE leben-template.log >"$DEST$filename"
fi




done <$SOURCE
