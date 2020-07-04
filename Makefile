.PHONY: openshift
openshift:
		mkdir -p ../openshift-docs/ass
		mv ../openshift-docs/modules/common-attributes.adoc ../openshift-docs/_snippets
		
		mv ../openshift-docs/administering_a_cluster ../openshift-docs/ass
		mv ../openshift-docs/applications ../openshift-docs/ass
		mv ../openshift-docs/applications_and_projects ../openshift-docs/ass
		mv ../openshift-docs/architecture ../openshift-docs/ass
		mv ../openshift-docs/authentication ../openshift-docs/ass
		mv ../openshift-docs/backup_and_restore ../openshift-docs/ass
		mv ../openshift-docs/builds ../openshift-docs/ass
		mv ../openshift-docs/cli_reference ../openshift-docs/ass
		mv ../openshift-docs/cloud_infrastructure_access ../openshift-docs/ass
		mv ../openshift-docs/cloud_providers ../openshift-docs/ass
		mv ../openshift-docs/getting_started ../openshift-docs/ass
		mv ../openshift-docs/installing ../openshift-docs/ass
		mv ../openshift-docs/jaeger ../openshift-docs/ass
		mv ../openshift-docs/logging ../openshift-docs/ass
		mv ../openshift-docs/machine_management ../openshift-docs/ass
		mv ../openshift-docs/metering ../openshift-docs/ass
		mv ../openshift-docs/metrics ../openshift-docs/ass
		mv ../openshift-docs/migration ../openshift-docs/ass
		mv ../openshift-docs/monitoring ../openshift-docs/ass
		mv ../openshift-docs/networking ../openshift-docs/ass
		mv ../openshift-docs/nodes ../openshift-docs/ass
		mv ../openshift-docs/openshift_images ../openshift-docs/ass
		mv ../openshift-docs/operators ../openshift-docs/ass
		mv ../openshift-docs/pipelines ../openshift-docs/ass
		mv ../openshift-docs/registry ../openshift-docs/ass
		mv ../openshift-docs/release_notes ../openshift-docs/ass
		mv ../openshift-docs/rest_api ../openshift-docs/ass
		mv ../openshift-docs/router ../openshift-docs/ass
		mv ../openshift-docs/scalability_and_performance ../openshift-docs/ass
		mv ../openshift-docs/security ../openshift-docs/ass
		mv ../openshift-docs/serverless ../openshift-docs/ass
		mv ../openshift-docs/service_mesh ../openshift-docs/ass
		mv ../openshift-docs/storage ../openshift-docs/ass
		mv ../openshift-docs/support ../openshift-docs/ass
		mv ../openshift-docs/updating ../openshift-docs/ass
		mv ../openshift-docs/virt ../openshift-docs/ass
		mv ../openshift-docs/web_console ../openshift-docs/ass
		mv ../openshift-docs/welcome ../openshift-docs/ass
		mv ../openshift-docs/whats_new ../openshift-docs/ass

#// tag::attributes.adoc[]

name := openshift
git_host := github.com
org := openshift
target_repo := openshift-docs
target_branch := HEAD
#target_branch := master
target_docs := /
target := $(target_repo)$(target_docs)

assemblies := /ass
modules := modules
images := images
attributes := _artifacts
titles := titles-enterprise

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

.PHONY: init
init:
		
		# rm -rf temp/*
		mkdir -p playground/$(name)/html
		if [ "$(target_branch)" = "HEAD" ]; then \
			echo local $(target_branch); \
			rsync -arv --exclude=.git ../$(target) playground/$(name); \
		else \
			echo remote $(target_branch); \
			cd temp; \
			git clone https://$(git_host)/$(org)/$(target_repo); \
			cd $(target_repo); \
			# git checkout $(target_branch); \
			cd $(mkfile_path)/temp; \
			rsync -arv --exclude=.git $(target) $(mkfile_path)/playground/$(name); \
			cd ..; \
		fi

		echo creating html of file trees - with and without symlinks
		cd playground/$(name); tree --prune -H '.' -P '*.adoc' > html/adoc-list.html
		cd playground/$(name); tree --prune -l -H '.' -P '*.adoc' > html/adoc-list-sym.html

		echo creating enterprise title list
		cd playground/$(name);for f in $$(find .$(target_docs)/$(titles) -name 'master.adoc'); do ls -1 $$f; done > html/titles.list

		echo creating assembly list
		cd playground/$(name);for f in $$(find .$(target_docs)/$(assemblies) -name '*.adoc'); do ls -1 $$f; done > html/assemblies.list

		echo creating module list
		cd playground/$(name)$(target_docs)/$(modules);find . -name \*.adoc -print > $(mkfile_path)/playground/$(name)/html/modules.list

		echo creating csv files
		
		cd playground/$(name);while read ass;do ../../make-csv.sh $${ass}; done <  html/assemblies.list

		echo creating titles
		cd playground/$(name);while read ass;do ../../make-titles.sh $${ass}; done <  html/titles.list

		echo creating manifest
		cd playground/$(name);while read ass;do ../../make-manifest.sh $${ass}; done <  html/titles.list


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

# Template-end
