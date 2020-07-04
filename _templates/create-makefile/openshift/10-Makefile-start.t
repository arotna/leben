---
inject: true
to: Makefile
before: Template
---
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
