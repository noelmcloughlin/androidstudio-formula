# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}
{%- from tplroot ~ "/macros.jinja" import format_kwargs with context %}

androidstudio-package-repo-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(androidstudio.pkg.repo) }}
    - onlyif: {{ androidstudio.pkg.repo and androidstudio.pkg.use_upstream_repo }}
