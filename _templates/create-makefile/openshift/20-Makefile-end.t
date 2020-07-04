---
inject: true
to: Makefile
after: Tempalate-end
---
.PHONY: openshift
openshift:
		mkdir -p ../openshift-docs/ass
		mv ../openshift-docs/modules/common-attributes.adoc ../openshift-docs/_snippets
		
		mv ../openshift-docs/administering_a_cluster ../openshift-docs/ass
		mv ../openshift-docs/applications ../openshift-docs/ass
		mv ../openshift-docs/applications_and_projects ../openshift-docs/ass
		mv ../openshift-docs/architecture ../openshift-docs/ass
		mv ../openshift-docs/authentication ../openshift-docs/ass
		mv ../openshift-docs/backup_and_restore ../openshift-docs/ass
		mv ../openshift-docs/builds ../openshift-docs/ass
		mv ../openshift-docs/cli_reference ../openshift-docs/ass
		mv ../openshift-docs/cloud_infrastructure_access ../openshift-docs/ass
		mv ../openshift-docs/cloud_providers ../openshift-docs/ass
		mv ../openshift-docs/getting_started ../openshift-docs/ass
		mv ../openshift-docs/installing ../openshift-docs/ass
		mv ../openshift-docs/jaeger ../openshift-docs/ass
		mv ../openshift-docs/logging ../openshift-docs/ass
		mv ../openshift-docs/machine_management ../openshift-docs/ass
		mv ../openshift-docs/metering ../openshift-docs/ass
		mv ../openshift-docs/metrics ../openshift-docs/ass
		mv ../openshift-docs/migration ../openshift-docs/ass
		mv ../openshift-docs/monitoring ../openshift-docs/ass
		mv ../openshift-docs/networking ../openshift-docs/ass
		mv ../openshift-docs/nodes ../openshift-docs/ass
		mv ../openshift-docs/openshift_images ../openshift-docs/ass
		mv ../openshift-docs/operators ../openshift-docs/ass
		mv ../openshift-docs/pipelines ../openshift-docs/ass
		mv ../openshift-docs/registry ../openshift-docs/ass
		mv ../openshift-docs/release_notes ../openshift-docs/ass
		mv ../openshift-docs/rest_api ../openshift-docs/ass
		mv ../openshift-docs/router ../openshift-docs/ass
		mv ../openshift-docs/scalability_and_performance ../openshift-docs/ass
		mv ../openshift-docs/security ../openshift-docs/ass
		mv ../openshift-docs/serverless ../openshift-docs/ass
		mv ../openshift-docs/service_mesh ../openshift-docs/ass
		mv ../openshift-docs/storage ../openshift-docs/ass
		mv ../openshift-docs/support ../openshift-docs/ass
		mv ../openshift-docs/updating ../openshift-docs/ass
		mv ../openshift-docs/virt ../openshift-docs/ass
		mv ../openshift-docs/web_console ../openshift-docs/ass
		mv ../openshift-docs/welcome ../openshift-docs/ass
		mv ../openshift-docs/whats_new ../openshift-docs/ass
