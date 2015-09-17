åll: make install run

make:
	drush make make-d7.yml docroot/

update:
	drush make --no-core make-d7.yml docroot/

install:
	drush -r docroot/ si -y --db-url="sqlite://.db.sqlite" --account-pass=admin

run:
	drush -r docroot/ rs

devel:
	drush -r docroot/ make --yes --no-core drush-includes/contrib-devel.yml
