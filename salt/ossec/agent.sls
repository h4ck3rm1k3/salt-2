{% set version = '2.6' -%}
{% set ossecdir = 'ossec-hids-{0}'.format(version) -%}

ossec-install-working-dir:
  file.directory:
    - name: /tmp/ossec-install

ossec-download-installer:
  file.managed:
    - source: salt://ossec/files/{{ ossecdir }}.tar.gz
    - name: /tmp/ossec-install/{{ ossecdir }}.tar.gz
    - require:
      - file: ossec-install-working-dir

ossec-extract-installer:
  cmd.run:
    - name: 'tar -xf {{ ossecdir }}.tar.gz'
    - cwd: '/tmp/ossec-install/'
    - unless: stat /var/ossec/bin/ossec-control
    - watch:
      - file: ossec-download-installer

ossec-installer-preloaded-vars:
  file.managed:
    - name: '/tmp/ossec-install/{{ ossecdir }}/etc/preloaded-vars.conf'
    - source: 'salt://ossec/files/preloaded-vars.conf'
    - unless: stat /var/ossec/bin/ossec-control
    - watch:
      - cmd: ossec-extract-installer

ossec-install:
  cmd.run:
    - name: '/tmp/ossec-install/{{ ossecdir }}/install.sh'
    - unless: stat /var/ossec/bin/ossec-control
    - watch:
      - file: ossec-installer-preloaded-vars

ossec-service:
  service.running:
    - name: ossec
    - require:
      - cmd.run: ossec-install
