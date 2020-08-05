#// tag::attributes.adoc[]

name := syndesis-HEAD
git_host := github.com
org := syndesisio
target_repo := syndesis
target_branch := HEAD
target_docs := /doc
target := $(target_repo)$(target_docs)

assemblies := assemblies
modules := modules
images := images
attributes := shared
titles := integrating-applications

#// end::attributes.adoc[]

# Template - Create Makefile using hygen template
mkfile_path :=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
#mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#cur_path := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))


.NOTPARALLEL:

export PYTHONPATH := python

.PHONY: clean
clean:
		rm -rf playground/*
		rm -rf temp/*


.PHONY: list
list:
		echo $(mkfile_path)
		echo $(name)
		echo $(target_repo)
		echo $(target_docs)
		echo $(target)

.PHONY: init
init:
		
		# rm -rf temp/*
		mkdir -p playground/$(name)/reports
		mkdir -p playground/$(name)/html
		mkdir -p playground/$(name)/$(target)
		if [ "$(target_branch)" = "HEAD" ]; then \
			echo local $(target_branch); \
			rsync -arv --exclude=.git ../$(target) playground/$(name)/$(target_repo); \
		else \
			echo remote $(target_branch); \
			cd temp; \
			git clone https://$(git_host)/$(org)/$(target_repo); \
			cd $(target_repo); \
			# git checkout $(target_branch); \
			cd $(mkfile_path)/temp; \
			rsync -arv --exclude=.git $(target) $(mkfile_path)/playground/$(name)/$(target_repo); \
			cd ..; \
		fi

		echo creating html of file trees - with and without symlinks
		cd playground/$(name); tree --prune -H '.' -P '*.adoc' > html/adoc-list.html
		cd playground/$(name); tree --prune -l -H '.' -P '*.adoc' > html/adoc-list-sym.html

		echo creating enterprise title list
		cd playground/$(name)/$(target_repo);for f in $$(find .$(target_docs)/$(titles) -name 'master.adoc'); do ls -1 $$f; done > ../html/titles.list

		echo creating assembly list
		cd playground/$(name)/$(target_repo);for f in $$(find .$(target_docs)/$(assemblies) -name '*.adoc'); do ls -1 $$f; done > ../html/assemblies.list

		echo creating module list
		cd playground/$(name)/$(target_repo)$(target_docs)/$(modules);find . -name \*.adoc -print > $(mkfile_path)/playground/$(name)/html/modules.list

		echo creating csv files
		
		cd playground/$(name)/$(target_repo);while read ass;do $(mkfile_path)/make-csv.sh $${ass}; done <  ../html/assemblies.list

		echo creating titles
		cd playground/$(name)/$(target_repo);while read ass;do $(mkfile_path)/make-titles.sh $${ass}; done <  ../html/titles.list

		echo creating manifest
		cd playground/$(name)/$(target_repo);while read ass;do $(mkfile_path)/make-manifest.sh $${ass}; done <  ../html/titles.list

		echo move csvs

		mv playground/$(name)/$(target_repo)/*.csv playground/$(name)/reports


.PHONY: docs
docs:
		./make-adocs.sh README-content.md modules/ROOT/pages/
		./asciidoc-coalescer.rb  -a include-tags="!goals.adoc;!background.adoc" README-template.adoc > README.md

.PHONY: adoc
adoc: 
		HYGEN_OVERWRITE=1 hygen leben makeAdoc --dirName playground/$(name) --compName $(name)

.PHONY: antora
antora:
		HYGEN_OVERWRITE=1 hygen leben antora --dirName playground/$(name) --htmlDir html --compName $(name) \
		--modules $(modules) --assemblies $(assemblies)

.PHONY: render
render:
		antora local-antora-playbook.yml

.PHONY: org
org:
		# only supports github
		curl -s https://api.github.com/orgs/$(org)/repos|jq -r '.[] | .name'|sed "s/\(.*\)/--output-document=\1.md https:\/\/raw.githubusercontent.com\/$(org)\/\1\/master\/README.md/p" > playground/$(name)/readmes.list

		cd playground/$(name);while read file; do wget $${file}; done < ./readmes.list

# Template-end
