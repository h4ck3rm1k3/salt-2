denyhosts-package:
  pkg.installed:
    - name: denyhosts

/etc/denyhosts.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://denyhosts/denyhosts.conf
    - template: jinja
    - require:
      - pkg: denyhosts

denyhosts-service:
  service.running:
    - name: denyhosts
    - watch:
      - file: /etc/denyhosts.conf
      - pkg: denyhosts
