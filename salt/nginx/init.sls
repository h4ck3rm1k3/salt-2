nginx:
  pkg:
    - installed

  {% if 'parameters' in pillar -%}
  {% if 'nginx' in pillar['parameters'] -%}
  {% if 'running' in pillar['parameters']['nginx'] -%}
  service.running:
    - require:
      - pkg: nginx
  {% endif -%}
  {% endif -%}
  {% endif -%}
