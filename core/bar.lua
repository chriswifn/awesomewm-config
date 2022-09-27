-- widget and layout library
local wibox = require("wibox")
-- standard awesome library
local awful = require("awful")
local gears = require("gears")
-- my theme library (colors, border_width, ...)
local theme = require("theme.modus-vivendi.theme")
-- Theme handling library
local beautiful = require("beautiful")

-- draws the wallpaper (a black screen)
local function set_wallpaper(s)
   gears.wallpaper.set("#000000")
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
      -- custom layoutbox with dwm inspired "icons"
      local function update_txt_layoutbox(s)
         local txt_l = beautiful["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
         s.mytxtlayoutbox:set_text(txt_l)
      end
      -- set the wallpaper
      set_wallpaper(s)
      -- tag declaration
      awful.tag({ 
            "[1:WWW]", 
            "[2:EMACS]",
            "[3:TERM]",
            "[4:FILE]", 
            "[5:NVIM]",
            "[6:DOC]",
            "[7:MUS]",
            "[8:VID]",
            "[9:VIRT]" 
                }, s, awful.layout.layouts[1])
      s.mypromptbox = awful.widget.prompt()

      -- systray widget (toggled by default, toggle on with super + b + s)
      s.systray = wibox.widget.systray()
      s.systray.visible = false

      -- time widget (toggled by default, toggle on with super + b + c)
      s.mytextclock = wibox.widget.textclock("[%a %b %d, %H:%M] ")
      s.mytextclock.visible = false

      -- internet widget (shows wifi, eth, and vpn, toggle on with super + b + w)
      s.internet = awful.widget.watch("sb-internet", 1)
      s.internet.visible = false

      -- volume and microphone widget
      s.volmic = awful.widget.watch("sb-volmic", 1)
      s.volmic.visible = false

      -- battery widget (toggled by default, toggle on with super + b + b)
      s.battery = awful.widget.watch("sb-battery", 1000)
      s.battery.visible = false

      -- layout widget (inspired by dwm)
      s.mytxtlayoutbox = wibox.widget.textbox(beautiful["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
      awful.tag.attached_connect_signal(s, "property::selected", function () update_txt_layoutbox(s) end)
      awful.tag.attached_connect_signal(s, "property::layout", function () update_txt_layoutbox(s) end)

      s.mytaglist = awful.widget.taglist {
         screen  = s,
         filter  = awful.widget.taglist.filter.noempty,
      }
      s.mytasklist = awful.widget.tasklist {
         screen  = s,
         filter  = awful.widget.tasklist.filter.currenttags,
         buttons = tasklist_buttons,
         style = {
            tasklist_disable_icon = true,
         },
      }
      s.mylayoutbox = awful.widget.layoutbox(s)

      s.mywibox = awful.wibar({ position = "top", screen = s, height = 26, border_width = 0, border_color = "#f4f4f4", visible = true})
      s.mywibox:setup {
         layout = wibox.layout.align.horizontal,
         {
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
         },
         s.mytasklist,
         {
            layout = wibox.layout.fixed.horizontal,
            s.volmic,
            s.internet,
            s.battery,
            s.mytextclock,
            s.systray,
            s.mytxtlayoutbox,
         },
      }
end)
