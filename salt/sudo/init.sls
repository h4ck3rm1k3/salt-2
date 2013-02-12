sudo:
  pkg.installed

/etc/sudoers:
  file.managed:
    - user: root
    - group: root
    - mode: 0440
    - source: salt://sudo/sudoers
    - require:
      - pkg: sudo

/etc/sudoers.d:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: sudo
