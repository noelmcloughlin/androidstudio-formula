# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}

androidstudio-package-repo-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ androidstudio.pkg.repo.name }}
    - onlyif: {{ androidstudio.pkg.repo and androidstudio.pkg.use_upstream_repo }}
