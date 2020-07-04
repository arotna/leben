#// tag::attributes.adoc[]

name := registry
git_host := github.com
org := Apicurio
target_repo := apicurio-registry
target_branch := master
target_docs := /docs
target := $(target_repo)$(target_docs)

assemblies := assemblies
modules := modules
images := images
attributes := shared
titles := getting-started

#// end::attributes.adoc[]

mkfile_path :=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
#mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#cur_path := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))


.NOTPARALLEL:

export PYTHONPATH := python

.PHONY: clean
clean:
		rm -rf playground/*
		rm -rf temp/*

.PHONY: init
init:
		
		echo $(mkfile_path)
		rm -rf temp/*
		mkdir -p playground/$(name)/html
		if [ "$(target_branch)" = "HEAD" ]; then \
			echo local $(target_branch); \
			rsync -arv --exclude=.git ../$(target) playground/$(name); \
		else \
			echo remote $(target_branch); \
			cd temp; \
			git clone https://$(git_host)/$(org)/$(target_repo); \
			rsync -arv --exclude=.git $(target) $(mkfile_path)/playground/$(name); \
			cd ..; \
		fi
		cd playground/$(name); tree --prune -H '.' -P '*.adoc' > html/adoc-list.html
		cd playground/$(name); tree --prune -l -H '.' -P '*.adoc' > html/adoc-list-sym.html
		cd playground/$(name);for f in $$(find .$(target_docs)/$(titles) -name 'master.adoc'); do ls -1 $$f; done > html/titles.list
		cd playground/$(name);for f in $$(find .$(target_docs)/$(assemblies) -name '*.adoc'); do ls -1 $$f; done > html/assemblies.list
		#cd playground/$(name);while read ass;do sed -n 's/^include.*\/\(.*\).adoc.*/\1/p' $${ass}; done <  html/assemblies.list
		cd playground/$(name);while read ass;do ../../make-csv.sh $${ass}; done <  html/assemblies.list
		cd playground/$(name);while read ass;do ../../make-titles.sh $${ass}; done <  html/titles.list
		cd playground/$(name);while read ass;do ../../make-manifest.sh $${ass}; done <  html/titles.list
		cd playground/$(name)$(target_docs)/$(modules);find . -name \*.adoc -print > $(mkfile_path)/playground/$(name)/html/modules.list


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
