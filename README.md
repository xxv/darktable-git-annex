git annex darktable integration
===============================

This integrates git annex into darktable, using the following workflow:

* The photos you wish to use this for must already be in an initialized git
  annex repository. They don't need to be added, however.
* Tags are automatically added to files, to reflect the git annex state in
  darktable. These tags are:

    * git-annex|here
    * git-annex|dropped
    * git-annex|annexed

This plugin creates shortcuts that can be bound to keys. You can find these
shortcuts in the settings → shortcuts → lua menu. I recommend the following
configuration:

* git annex: add images `<Primary><Shift>plus`
* git annex: drop images `<Primary>minus`
* git annex: get images `<Primary>equal`

Installation
------------

To use, place `git-annex.lua` in your `~/.config/darktable/lua/` directory
(creating it if necessary). Then add:

    require "git-annex"

to your `~/.config/darktable/luarc` file, creating it if necessary.


