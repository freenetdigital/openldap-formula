{% from 'openldap/map.jinja' import openldap with context %}
ldap-client:
  pkg.installed:
    - name: {{ openldap.client_pkg }}
  file.managed:
    - name: {{ openldap.client_config }}
{%- if openldap.custom_client_config_source is defined %}
    - source: {{ openldap.custom_client_config_source }}
{%- else %}
    - source: salt://openldap/files/ldap.conf
{%- endif %}
    - template: jinja
    - user: root

    - group: {{ openldap.su_group }}
    - mode: 644
    - makedirs: True
    - require:
      - pkg: ldap-client

