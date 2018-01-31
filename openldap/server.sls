{% from 'openldap/map.jinja' import openldap with context %}
ldap-server:
  pkg.installed:
    - name: {{ openldap.server_pkg }}
  file.managed:
    - name: {{ openldap.server_config }}
{%- if openldap.custom_server_config_source is defined %}
    - source: {{ openldap.custom_server_config_source }}
{%- else %}
    - source: salt://openldap/files/slapd.conf
{%- endif %}
    - template: jinja
    - user: root
    - group: {{ openldap.su_group }}
    - mode: 644
    - makedirs: True
    - require:
      - pkg: ldap-server
  service.running:
    - name: {{ openldap.service }}
    - enable: True
