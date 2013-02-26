munin-packages:
  pkg.installed:
    - pkgs:
      - munin-common
      - munin-node

/etc/munin/plugins/multimemory:
  file.managed:
    - mode: 0755
    - user: root
    - group: root
    - source: salt://munin/plugins/multimemory
    - require:
      - pkg: munin-packages

/etc/munin/plugin-conf.d/multimemory:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - source: salt://munin/plugins/multimemory.conf
    - require:
      - pkg: munin-packages

munin-node-service:
  service.running:
    - name: munin-node
    - require:
      - pkg: munin-packages
