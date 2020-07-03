#// tag::attributes.adoc[]

name := registry
org := apicurio
target_repo := ../apicurio-registry
target_docs := /docs
target := $(target_repo)$(target_docs)

assemblies := assemblies
modules := modules
images := images
attributes := shared
titles := getting-started


#// end::attributes.adoc[]

.NOTPARALLEL:

export PYTHONPATH := python

.PHONY: clean
clean:
		rm -rf playground/*

.PHONY: init
init:
		mkdir -p playground/$(name)/html
		rsync -arv --exclude=.git $(target) playground/$(name)
			cd playground/$(name); tree --prune -H '.' -P '*.adoc' > html/adoc-list.html
		cd playground/$(name); tree --prune -l -H '.' -P '*.adoc' > html/adoc-list-sym.html
		cd playground/$(name);for f in $$(find .$(target_docs)/$(titles) -name 'master.adoc'); do ls -1 $$f; done > html/titles.list
		cd playground/$(name);for f in $$(find .$(target_docs)/$(assemblies) -name '*.adoc'); do ls -1 $$f; done > html/assemblies.list
		#cd playground/$(name);while read ass;do sed -n 's/^include.*\/\(.*\).adoc.*/\1/p' $${ass}; done <  html/assemblies.list
		cd playground/$(name);while read ass;do ../../make-csv.sh $${ass}; done <  html/assemblies.list
		cd playground/$(name);while read ass;do ../../make-titles.sh $${ass}; done <  html/titles.list


.PHONY: docs
docs:
		./make-adocs.sh README-content.md modules/ROOT/pages/
		./asciidoc-coalescer.rb  -a include-tags="!goals.adoc;!background.adoc" README-template.adoc > README.md

.PHONY: adoc
adoc: 
		HYGEN_OVERWRITE=1 hygen world makeAdoc --dirName antora --compName GitWorld

.PHONY: antora
antora:
		HYGEN_OVERWRITE=1 hygen world antora --dirName antora --htmlDir docs --compName GitWorld
		touch .nojekyll
		touch docs/.nojekyll

.PHONY: render
render:
		antora local-antora-playbook.yml

.PHONY: org
org:
		# only supports github
		curl -s https://api.github.com/orgs/$(org)/repos|jq -r '.[] | .name'|sed "s/\(.*\)/--output-document=\1.md https:\/\/raw.githubusercontent.com\/$(org)\/\1\/master\/README.md/p" > playground/$(name)/readmes.list

		cd playground/$(name);while read file; do wget $${file}; done < ./readmes.list
