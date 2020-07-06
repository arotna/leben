---
inject: true
to: Makefile
before: Template
---
#// tag::attributes.adoc[]

name := enmasse-head
git_host := github.com
org := EnMasseProject
target_repo := enmasse
target_branch := HEAD
#target_branch := master
target_docs := /documentation
target := $(target_repo)$(target_docs)

assemblies := assemblies
modules := modules
images := _images
attributes := common
titles := openshift

#// end::attributes.adoc[]
