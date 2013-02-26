{% if 'template_packages' in pillar %}
template_packages:
  pkg.installed:
    - pkgs:
        {% for package in pillar['template_packages'] %}
        - {{ package }}
        {% endfor %}
{% endif %}

{% if 'packages' in pillar %}
packages:
  pkg.installed:
    - refresh: False
    - pkgs:
        {% for package in pillar['packages'] %}
        - {{ package }}
        {% endfor %}
{% endif %}
