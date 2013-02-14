{% if 'template_roles' in pillar -%}
include:
  {% for role in pillar['template_roles'] -%}
  - {{ role }}
  {% endfor -%}
{% endif -%}
