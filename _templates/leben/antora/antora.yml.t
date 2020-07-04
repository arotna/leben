---
to: <%= dirName %>/antora.yml

sh: ln -nsf ../../../<%= assemblies %> <%= dirName %>/modules/ROOT/pages/assemblies
---
name: <%= compName %>
title: <%= compName %>
version: 'latest'
start_ROOT: ROOT:index.adoc
nav:
- modules/ROOT/nav.adoc
