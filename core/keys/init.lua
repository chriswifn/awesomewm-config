-- standard awesome library
local awful = require("awful")
local gears = require("gears")
local apps = require("core.apps")
require("awful.autofocus")

-- keys for emacs
local emacskeys = require("core.keys.emacs")

-- keys for gui programs 
local guikeys = require("core.keys.gui")

-- keys for terminal programs 
local terminalkeys = require("core.keys.terminal")

-- keys for dmenu scripts
local dmenukeys = require("core.keys.dmenu")

-- misc keys
local misckeys = require("core.keys.misc")

-- default awesome specific keys
local defaultkeys = require("core.keys.default")

-- client buttons
local myclientkeys = require("core.keys.client")

-- actual keybindings
globalkeys = gears.table.join(
   emacskeys,
   guikeys,
   terminalkeys,
   dmenukeys,
   misckeys,
   defaultkeys
)

-- keybindings for tags
for i = 1, 9 do
   globalkeys = gears.table.join(globalkeys,
				 awful.key({ apps.modkey }, "#" .. i + 9,
				    function ()
				       local screen = awful.screen.focused()
				       local tag = screen.tags[i]
				       if tag then
					  tag:view_only()
				       end
				    end,
				    {description = "view tag #"..i, group = "tag"}),
				 awful.key({ apps.modkey, "Control" }, "#" .. i + 9,
				    function ()
				       local screen = awful.screen.focused()
				       local tag = screen.tags[i]
				       if tag then
					  awful.tag.viewtoggle(tag)
				       end
				    end,
				    {description = "toggle tag #" .. i, group = "tag"}),
				 awful.key({ apps.modkey,           }, "0",
				    function ()
				       local screen = awful.screen.focused()
				       local current_tag = awful.screen.focused().selected_tags
				       for i = 1,9 do
					  local tag = screen.tags[i]
					  if #tag:clients() > 0
					  then
					     tag.selected = true
					  end
				       end
				       awful.layout.set(awful.layout.layouts[1])
				    end,
				    {description = "toggle all tags", group = "tag"}),
				 awful.key({ apps.modkey, "Shift" }, "#" .. i + 9,
				    function ()
				       if client.focus then
					  local tag = client.focus.screen.tags[i]
					  if tag then
					     client.focus:move_to_tag(tag)
					  end
				       end
				    end,
				    {description = "move focused client to tag #"..i, group = "tag"}),
				 awful.key({ apps.modkey, "Control", "Shift" }, "#" .. i + 9,
				    function ()
				       if client.focus then
					  local tag = client.focus.screen.tags[i]
					  if tag then
					     client.focus:toggle_tag(tag)
					  end
				       end
				    end,
				    {description = "toggle focused client on tag #" .. i, group = "tag"})
   )
end

root.keys(globalkeys)

-- client keybindings
clientkeys = myclientkeys

-- button on mouse
clientbuttons = gears.table.join(
   awful.button({ }, 1, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
   end),
   awful.button({ apps.modkey }, 1, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
         awful.mouse.client.move(c)
   end),
   awful.button({ apps.modkey }, 3, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
         awful.mouse.client.resize(c)
   end)
)

