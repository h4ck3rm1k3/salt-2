required_groups:
  group.present:
    - names:
      - admin

{% if 'admin_users' in pillar or 'users' in pillar %}
include:
  {% if 'admin_users' in pillar %}
  {% for user in pillar['admin_users'] -%}
  - users.{{ user }}
  {% endfor %}
  {% endif %}
  {% if 'users' in pillar %}
  {% for user in pillar['users'] -%}
  - users.{{ user }}
  {% endfor -%}
  {% endif %}
{% endif %}
