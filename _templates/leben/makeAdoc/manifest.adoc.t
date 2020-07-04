---
to: <%= dirName %>/modules/ROOT/pages/manifest.adoc

sh: ln -s  <%= dirName %>/manifest.csv  <%= dirName %>/modules/ROOT/pages/manifest.adoc
---
= Manifest of docs

[%header,format=csv]
|===
include::manifest.csv[]
|===