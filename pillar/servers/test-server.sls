include:
  - base

users:
  - user1

packages:
  - python-dev

firewall_rules:
  - '-A INPUT -m tcp -p tcp --dport 5555 -j ACCEPT'
