include:
  - users

user1:
  user.present:
    - fullname: Normal User 1
    - shell: /bin/bash
    - home: /home/user1
    - groups:
      - fed
  ssh_auth:
    - present
    - user: user1
    - enc: ssh-rsa
    - comment: user1
    - names:
      - REPLACE_WITH_SSH_PUB_KEY
    - password: '!REPLACE_WITH_PASSWORD_HASH'
