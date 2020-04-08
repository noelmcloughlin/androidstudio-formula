# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}

androidstudio-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ androidstudio.pkg.archive.name }}
      - {{ androidstudio.dir.tmp }}
