{% if 'packages' in pillar or 'base_packages' in pillar %}
packages:
  pkg.installed:
    - names:
      {% if 'packages' in pillar %}
      {% for pkg in pillar['packages'] %}
      - {{ pkg }}
      {% endfor %}
      {% endif %}
      {% if 'base_packages' in pillar %}
      {% for pkg in pillar['base_packages'] %}
      - {{ pkg }}
      {% endfor %}
      {% endif %}
{% endif %}
