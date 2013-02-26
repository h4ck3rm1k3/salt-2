include:
  - postgres.client

postgresql-9.1:
  pkg.installed

postgresql-contrib-9.1:
  pkg.installed

postgresql-common:
  pkg.installed

postgresql:
  service.running:
    - require:
      - pkg: postgresql-9.1
      - pkg: postgresql-contrib-9.1
      - pkg: postgresql-common
