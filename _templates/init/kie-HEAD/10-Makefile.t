---
inject: true
to: Makefile
before: Template
---
#// tag::attributes.adoc[]

name := <%= action %>
git_host := github.com
org := sterobin
target_repo := kie-docs
target_branch := HEAD
#target_branch := master-kogito-test-split-B
target_docs := /
target := $(target_repo)$(target_docs)

assemblies := assemblies
modules := modules
images := _images
attributes := _snippets
titles := titles-enterprise

#// end::attributes.adoc[]
