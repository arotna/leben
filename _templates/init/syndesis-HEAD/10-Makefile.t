---
inject: true
to: Makefile
before: Template
---
#// tag::attributes.adoc[]

name := <%= action %>
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
