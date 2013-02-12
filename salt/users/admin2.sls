include:
  - users

admin2:
  user.present:
    - fullname: Admin User 2
    - shell: /bin/bash
    - home: /home/admin2
    - groups:
      - admin
  ssh_auth:
    - present
    - user: admin2
    - enc: ssh-rsa
    - comment: admin2
    - names:
      - REPLACE_WITH_SSH_PUB_KEY
    - password: '!REPLACE_WITH_PASSWORD_HASH'
