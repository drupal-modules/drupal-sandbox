SHELL   := /bin/bash -x
DOCROOT := "docroot"
HOST 	  := $(shell hostname)
all: check make install run

check:
	@type drush

make:	docroot

docroot:
	drush make make-d7.yml $(DOCROOT)

update:
	drush make --no-core make-d7.yml $(DOCROOT)

install:
	drush -r $(DOCROOT) si -vy --db-url="sqlite://.db.sqlite" --account-pass=admin drupal7

run:
	drush -r $(DOCROOT) rs --dns ${HOST}:8888/admin

devel:
	drush -r $(DOCROOT) make --yes --no-core drush-includes/contrib-devel.yml

vm:
	vagrant up

clean:
	chmod -R u+w $(DOCROOT)
	drush -r $(DOCROOT) archive-backup --tar-options="--remove-files" && rm -vfr "$(DOCROOT)"
	kill $(shell pgrep -f runserver)
