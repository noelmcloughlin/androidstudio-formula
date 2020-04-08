# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}

             {%- if grains.os_family in ('MacOS',) %}
include:
  - .macapp.clean

             {%- else %}
include:
  - .archive.clean

             {%- endif %}

