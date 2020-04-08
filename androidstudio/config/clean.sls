# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}

{%- if 'config' in androidstudio and androidstudio.config %}

    {%- if androidstudio.pkg.use_upstream_archive %}
        {%- set sls_package_clean = tplroot ~ '.archive.clean' %}
    {%- else %}
        {%- set sls_package_clean = tplroot ~ '.package.clean' %}
    {%- endif %}
include:
  - {{ sls_package_clean }}

androidstudio-config-clean-file-absent:
  file.absent:
    - names:
      - {{ androidstudio.environ_file }}
    - require:
      - sls: {{ sls_package_clean }}
