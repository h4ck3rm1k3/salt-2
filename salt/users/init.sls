required_groups:
  group.present:
    - names:
      - admin

include:
  - users.templates
  {% if 'users' in pillar %}
  {% for user in pillar['users'] -%}
  - users.{{ user }}
  {% endfor %}
  {% endif %}
