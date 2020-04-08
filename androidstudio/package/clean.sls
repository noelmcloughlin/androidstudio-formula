# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import androidstudio with context %}

    {%- if grains.os_family == 'Debian' and androidstudio.pkg.use_upstream_repo %}

include:
  - .repo.clean

androidstudio-package-remove-pkg-removed:
  pkg.removed:
    - name: {{ androidstudio.pkg.name }}
    - reload_modules: true

    {%- elif grains.os_family == 'MacOS' %}

androidstudio-package-remove-cmd-run-cask:
  cmd.run:
    - name: brew cask remove {{ androidstudio.pkg.name }}
    - runas: {{ androidstudio.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- elif grains.kernel|lower == 'linux' %}

androidstudio-package-remove-cmd-run-snap:
  cmd.run:
    - name: snap remove {{ androidstudio.pkg.name }}
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap

    {%- endif %}
