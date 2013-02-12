include:
  - ssh.client

openssh-server:
  pkg.installed:
    - require:
      - pkg: openssh-client

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: openssh-server

/etc/ssh/sshd_banner:
  file.managed:
    - source: salt://ssh/sshd_banner
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: openssh-server

ssh:
  service.running:
    - require:
      - file: /etc/ssh/sshd_config
      - pkg: openssh-server
