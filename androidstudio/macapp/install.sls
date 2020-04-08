# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}

androidstudio-macos-app-install-curl:
  file.directory:
    - name: {{ androidstudio.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ androidstudio.dir.tmp }}/androidstudio-{{ androidstudio.version }} {{ androidstudio.pkg.macapp.source }}
    - unless: test -f {{ androidstudio.dir.tmp }}/androidstudio-{{ androidstudio.version }}
    - require:
      - file: androidstudio-macos-app-install-curl
      - pkg: androidstudio-macos-app-install-curl
    - retry: {{ androidstudio.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
androidstudio-macos-app-install-checksum:
  module.run:
    - onlyif: {{ androidstudio.pkg.macapp.source_hash }}
    - name: file.check_hash
    - path: {{ androidstudio.dir.tmp }}/androidstudio-{{ androidstudio.version }}
    - file_hash: {{ androidstudio.pkg.macapp.source_hash }}
    - require:
      - cmd: androidstudio-macos-app-install-curl
    - require_in:
      - macpackage: androidstudio-macos-app-install-macpackage
  file.absent:
    - name: {{ androidstudio.dir.tmp }}/androidstudio-{{ androidstudio.version }}
    - onfail:
      - module: androidstudio-macos-app-install-checksum

androidstudio-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ androidstudio.dir.tmp }}/androidstudio-{{ androidstudio.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: androidstudio-macos-app-install-curl

    {%- else %}

androidstudio-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The androidstudio macpackage is only available on MacOS

    {%- endif %}
