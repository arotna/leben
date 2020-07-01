---
to: local-antora-playbook.yml
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
    start_path: antora



ui:
  bundle:
    url: ./ui-bundle.zip
    snapshot: true

output:
  dir: <%= htmlDir %>

asciidoc:
  attributes:
    plantuml-server-url: 'http://www.plantuml.com/plantuml'
    plantuml-fetch-diagram: true
    mod-loc: partial$
    registry: Apicurio Registry
    apicurio-registry: true
    page-pagination: true
  extensions:
    - asciidoctor-plantuml
    - ./lib/tab-block.js
