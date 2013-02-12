include:
  - users

admin1:
  user.present:
    - fullname: Admin User 1
    - shell: /bin/bash
    - home: /home/admin1
    - groups:
      - admin
  ssh_auth:
    - present
    - user: admin1
    - enc: ssh-rsa
    - comment: admin1
    - names:
      - REPLACE_WITH_SSH_PUB_KEY
    - password: '!REPLACE_WITH_PASSWORD_HASH'
