munin-packages:
  pkg.installed:
    - names:
      - munin-common
      - munin-node

/etc/munin/plugins/multimemory:
  file.managed:
    - mode: 0755
    - user: root
    - group: root
    - source: salt://munin/plugins/multimemory
    - require:
      - pkg: munin-node

/etc/munin/plugin-conf.d/multimemory:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - source: salt://munin/plugins/multimemory.conf
    - require:
      - pkg: munin-node

munin-node-service:
  service.running:
    - name: munin-node
    - require:
      - pkg: munin-node
