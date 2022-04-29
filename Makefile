NFS_SERVER := 192.168.8.8

##############################################################################
# Targets

.PHONY: mkdir
mkdir:
	for index in $$(seq 0 9); do \
		mkdir -p "export/pv-$$(printf '%02d' $$index)"; \
	done
	chmod -R a+rwx export


.PHONY: up
up:
	docker compose up -d


.PHONY: down
down:
	docker compose down


.PHONY: pv
pv:
	mkdir -p manifest
	truncate -s 0 manifest/pv.yml
	for index in $$(seq 0 9); do \
		PV_INDEX="$$(printf '%02d' $$index)" NFS_SERVER=$(NFS_SERVER) envsubst < persistent-volume-template.yml >> manifest/pv.yml; \
	done
