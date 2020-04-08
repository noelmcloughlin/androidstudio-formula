# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}
{%- from tplroot ~ "/macros.jinja" import format_kwargs with context %}

androidstudio-package-archive-install-extract:
  pkg.installed:
    - names:
      - curl
      - tar
      - gzip
  file.directory:
    - name: {{ androidstudio.pkg.archive.name }}
    - user: {{ androidstudio.rootuser }}
    - group: {{ androidstudio.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - archive: androidstudio-package-archive-install-extract
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(androidstudio.pkg.archive) }}
    - retry:
        attempts: 3
        until: True
        interval: 60
        splay: 10
    - user: {{ androidstudio.rootuser }}
    - group: {{ androidstudio.rootgroup }}
