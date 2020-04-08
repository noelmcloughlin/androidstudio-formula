# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if androidstudio.environ or androidstudio.config.path %}

    {%- if androidstudio.pkg.use_upstream_archive %}
        {%- set sls_package_install = tplroot ~ '.archive.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.package.install' %}
    {%- endif %}
include:
  - {{ sls_package_install }}

androidstudio-config-file-managed-environ_file:
  file.managed:
    - name: {{ androidstudio.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='androidstudio-config-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ androidstudio.rootuser }}
    - group: {{ androidstudio.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        path: {{ androidstudio.config.path|json }}
        environ: {{ androidstudio.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
