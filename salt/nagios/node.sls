nagios-packages:
  pkg.installed:
    - names:
      - nagios-nrpe-server
      - nagios-plugins
      - nagios-plugins-basic
      - nagios-plugins-standard

/etc/nagios/nrpe.cfg:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://nagios/nrpe.cfg
    - watch:
      - pkg: nagios-nrpe-server

/etc/nagios/nrpe_local.cfg:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://nagios/nrpe_local.cfg
    - watch:
      - pkg: nagios-nrpe-server

nagios-nrpe-server-service:
  service.running:
    - name: nagios-nrpe-server
    - watch:
      - file: /etc/nagios/nrpe.cfg
      - file: /etc/nagios/nrpe_local.cfg
