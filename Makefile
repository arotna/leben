
.PHONY: openshift-antora
openshift-antora:
		HYGEN_OVERWRITE=1 hygen leben openshift --dirName playground/$(name) --htmlDir html --compName $(name) \
		--modules $(modules) --assemblies $(assemblies)


.PHONY: openshift
openshift:
		mkdir -p ../openshift/ass
		mv ../openshift/modules/common-attributes.adoc ../openshift/_snippets
		
		mv ../openshift/administering_a_cluster ../openshift/ass
		mv ../openshift/applications ../openshift/ass
		mv ../openshift/applications_and_projects ../openshift/ass
		mv ../openshift/architecture ../openshift/ass
		mv ../openshift/authentication ../openshift/ass
		mv ../openshift/backup_and_restore ../openshift/ass
		mv ../openshift/builds ../openshift/ass
		mv ../openshift/cli_reference ../openshift/ass
		mv ../openshift/cloud_infrastructure_access ../openshift/ass
		mv ../openshift/cloud_providers ../openshift/ass
		mv ../openshift/getting_started ../openshift/ass
		mv ../openshift/installing ../openshift/ass
		mv ../openshift/jaeger ../openshift/ass
		mv ../openshift/logging ../openshift/ass
		mv ../openshift/machine_management ../openshift/ass
		mv ../openshift/metering ../openshift/ass
		mv ../openshift/metrics ../openshift/ass
		mv ../openshift/migration ../openshift/ass
		mv ../openshift/monitoring ../openshift/ass
		mv ../openshift/networking ../openshift/ass
		mv ../openshift/nodes ../openshift/ass
		mv ../openshift/openshift_images ../openshift/ass
		mv ../openshift/operators ../openshift/ass
		mv ../openshift/pipelines ../openshift/ass
		mv ../openshift/registry ../openshift/ass
		mv ../openshift/release_notes ../openshift/ass
		mv ../openshift/rest_api ../openshift/ass
		mv ../openshift/router ../openshift/ass
		mv ../openshift/scalability_and_performance ../openshift/ass
		mv ../openshift/security ../openshift/ass
		mv ../openshift/serverless ../openshift/ass
		mv ../openshift/service_mesh ../openshift/ass
		mv ../openshift/storage ../openshift/ass
		mv ../openshift/support ../openshift/ass
		mv ../openshift/updating ../openshift/ass
		mv ../openshift/virt ../openshift/ass
		mv ../openshift/web_console ../openshift/ass
		mv ../openshift/welcome ../openshift/ass
		mv ../openshift/whats_new ../openshift/ass

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
