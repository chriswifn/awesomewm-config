-- widget and layout library
local wibox = require("wibox")
-- standard awesome library
local awful = require("awful")
local gears = require("gears")
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
            "*1:WWW*", 
            "*2:EMACS*",
            "*3:TERM*",
            "*4:FILE*", 
            "*5:NVIM*",
            "*6:DOC*",
            "*7:MUS*",
            "*8:VID*",
            "*9:NULL*" 
                },
	 s,
	 {awful.layout.layouts[2],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[2],
      })
      s.mypromptbox = awful.widget.prompt()

      -- systray widget (toggled by default, toggle on with super + b + s)
      s.systray = wibox.widget.systray()
      s.systray.visible = false

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

      s.mywibox = awful.wibar({ position = "top", screen = s, border_width = 0, border_color = "#f4f4f4", visible = false})
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

