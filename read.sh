# process a yaml file

name="$(cat $1|shyaml get-value metadata.name)"
target_branch="$(cat $1|shyaml get-value metadata.target_branch)"
target_repo="$(cat $1|shyaml get-value metadata.target_repo)"
target_docs="$(cat $1|shyaml get-value metadata.target_docs)"
git_host="$(cat $1|shyaml get-value metadata.git_host)"
assemblies="$(cat $1|shyaml get-value metadata.assemblies)"
attributes_dir="$(cat $1|shyaml get-value metadata.attributes_dir)"
images="$(cat $1|shyaml get-value metadata.images)"
modules="$(cat $1|shyaml get-value metadata.modules)"
org="$(cat $1|shyaml get-value metadata.org)"
title_dir="$(cat $1|shyaml get-value metadata.title_dir)"

hygen create-makefile generic --name $name --target_branch $target_branch --target_repo $target_repo --target_docs $target_docs --git_host $git_host --assemblies $assemblies --attributes_dir $attributes_dir --images $images --modules $modules --org $org --title_dir $title_dir


