# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}

androidstudio-macos-app-clean-files:
  file.absent:
    - names:
      - {{ androidstudio.dir.tmp }}
      - /Applications/Android Studio.app

    {%- else %}

androidstudio-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The androidstudio macpackage is only available on MacOS

    {%- endif %}
