DOCROOT="docroot"
åll: make install run

make:
	drush make make-d7.yml $(DOCROOT)

update:
	drush make --no-core make-d7.yml $(DOCROOT)

install:
	drush -r $(DOCROOT) si -vy --db-url="sqlite://.db.sqlite" --account-pass=admin drupal7

run:
	drush -r $(DOCROOT) rs :8888/admin

devel:
	drush -r $(DOCROOT) make --yes --no-core drush-includes/contrib-devel.yml

clean:
	chmod -R u+w $(DOCROOT)
