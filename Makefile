target_repo := ../kie-docs
target_docs := 
target := $(target_repo)$(target_docs)

.NOTPARALLEL:

export PYTHONPATH := python

.PHONY: clean
clean:
		rm -rf temp/*

.PHONY: init
init:
		
		rsync -arv --exclude=.git $(target) temp
		cd temp; tree --prune -H '.' -P '*.adoc' > adoc-list.html
		cd temp; tree --prune -l -H '.' -P '*.adoc' > adoc-list-sym.html



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
