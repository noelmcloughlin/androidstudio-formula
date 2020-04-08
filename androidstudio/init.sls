# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}

             {%- if grains.os_family in ('MacOS',) %}
include:
  - .macapp

             {%- elif androidstudio.use_upstream_archive %}
include:
  - .archive
  - .config

             {%- endif %}

