---
inject: true
to: Makefile
before: Template
sh: make list
---
#// tag::attributes.adoc[]

name := registry
git_host := github.com
org := Apicurio
target_repo := apicurio-registry
#target_branch := HEAD
target_branch := master
target_docs := /docs
target := $(target_repo)$(target_docs)

assemblies := assemblies
modules := modules
images := images
attributes := shared
titles := getting-started

#// end::attributes.adoc[]
