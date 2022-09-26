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

-- limit garbage collection
local gears = require("gears")

collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

gears.timer.start_new(
   10,
   function()
      collectgarbage("step", 20000)
      return true
end)
