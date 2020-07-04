---
inject: true
to: Makefile
after: Tempalate-end
---

.PHONY: openshift-antora
openshift-antora:
		HYGEN_OVERWRITE=1 hygen leben openshift --dirName playground/$(name) --htmlDir html --compName $(name) \
		--modules $(modules) --assemblies $(assemblies)


.PHONY: openshift
openshift:
		mkdir -p ../openshift/ass
		mv ../openshift/modules/common-attributes.adoc ../openshift/_snippets
		
		mv ../openshift/administering_a_cluster ../openshift/ass
		mv ../openshift/applications ../openshift/ass
		mv ../openshift/applications_and_projects ../openshift/ass
		mv ../openshift/architecture ../openshift/ass
		mv ../openshift/authentication ../openshift/ass
		mv ../openshift/backup_and_restore ../openshift/ass
		mv ../openshift/builds ../openshift/ass
		mv ../openshift/cli_reference ../openshift/ass
		mv ../openshift/cloud_infrastructure_access ../openshift/ass
		mv ../openshift/cloud_providers ../openshift/ass
		mv ../openshift/getting_started ../openshift/ass
		mv ../openshift/installing ../openshift/ass
		mv ../openshift/jaeger ../openshift/ass
		mv ../openshift/logging ../openshift/ass
		mv ../openshift/machine_management ../openshift/ass
		mv ../openshift/metering ../openshift/ass
		mv ../openshift/metrics ../openshift/ass
		mv ../openshift/migration ../openshift/ass
		mv ../openshift/monitoring ../openshift/ass
		mv ../openshift/networking ../openshift/ass
		mv ../openshift/nodes ../openshift/ass
		mv ../openshift/openshift_images ../openshift/ass
		mv ../openshift/operators ../openshift/ass
		mv ../openshift/pipelines ../openshift/ass
		mv ../openshift/registry ../openshift/ass
		mv ../openshift/release_notes ../openshift/ass
		mv ../openshift/rest_api ../openshift/ass
		mv ../openshift/router ../openshift/ass
		mv ../openshift/scalability_and_performance ../openshift/ass
		mv ../openshift/security ../openshift/ass
		mv ../openshift/serverless ../openshift/ass
		mv ../openshift/service_mesh ../openshift/ass
		mv ../openshift/storage ../openshift/ass
		mv ../openshift/support ../openshift/ass
		mv ../openshift/updating ../openshift/ass
		mv ../openshift/virt ../openshift/ass
		mv ../openshift/web_console ../openshift/ass
		mv ../openshift/welcome ../openshift/ass
		mv ../openshift/whats_new ../openshift/ass
