required_groups:
  group.present:
    - names:
      - admin

{% if 'template_users' in pillar %}
include:
  {% for user in pillar['template_users'] -%}
  - users.{{ user }}
  {% endfor %}
{% endif %}

{% if 'users' in pillar %}
include:
  {% for user in pillar['users'] -%}
  - users.{{ user }}
  {% endfor %}
{% endif %}
