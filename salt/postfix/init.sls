postfix:
  debconf.set:
    - name: postfix
    - data:
        'postfix/mailname': {'type':'string','value': '{{ grains['fqdn'] }}'}
        'postfix/main_mailer_type': {'type':'select','value':'Internet Site'}
  pkg.installed:
    - require:
      - debconf: postfix
  service.running:
    - require:
      - pkg: postfix
