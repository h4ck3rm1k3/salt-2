{% if 'template_users' in pillar %}
include:
  {% for user in pillar['template_users'] -%}
  - users.{{ user }}
  {% endfor %}
{% endif %}
