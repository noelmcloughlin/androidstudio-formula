# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

androidstudio-package-archive-install-extract:
  pkg.installed:
    - names:
      - tar
      - gzip
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

    {%- if grains.kernel|lower == 'linux' and androidstudio.linux.altpriority|int == 0 %}

androidstudio-archive-install-file-symlink-androidstudio:
  file.symlink:
    - onlyif: {{ grains.kernel|lower == 'linux' }}
    - name: {{ androidstudio.dir.archive }}/bin/androidstudio
    - target: {{ androidstudio.config.path }}/bin/androidstudio
    - force: True
    - require:
      - archive: androidstudio-package-archive-install-extract
    {%- endif %}
