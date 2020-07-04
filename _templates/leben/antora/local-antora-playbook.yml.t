---
to:  <%= dirName %>/local-antora-playbook.yml

sh: ln -nsf ../../../<%= modules %> <%= dirName %>/modules/ROOT/partials/modules
---
site:
  title: <%= compName %>
  # the 404 page and sitemap files only get generated when the url property is set
  url: https://pwright.github.io/Waterworld/
  start_page: <%= compName %>::index.adoc
content:
  sources:
  - url: .
    branches: HEAD



ui:
  bundle:
    url: https://github.com/arotna/antora-ui/raw/master/build/ui-bundle.zip
    snapshot: true

output:
  dir: <%= htmlDir %>

asciidoc:
  attributes:
    plantuml-server-url: 'http://www.plantuml.com/plantuml'
    plantuml-fetch-diagram: true
    mod-loc: partial$
    compName: <%= compName %>
  extensions:
    - asciidoctor-plantuml
