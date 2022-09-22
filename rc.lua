-- error handling in case something goes wrong during startup
require("core.error_handling")

-- layouts [tiling, monocle, floating]
require("core.layouts")

-- theme (modus-vivendi)
require("theme.init")

-- autostarted applications
require("core.autostart")

-- some variables to improve customization
require("core.apps")

-- keybindings
require("core.bindings")

-- window rules
require("core.rules")

-- configuration for wibar
require("core.bar")
