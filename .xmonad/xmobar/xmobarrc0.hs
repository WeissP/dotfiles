Config
  { font = "xft:FiraCode Nerd Font Mono:weight=bold:pixelsize=16",
    bgColor = "#2e3440",
    fgColor = "#d0d0d0",
    position = TopSize L 450 24,
    -- border = TopB,
    -- borderWidth = 20,
    persistent = True,
    hideOnStart = False,
    allDesktops = False,
    lowerOnStart = True,
    sepChar = "%",
    alignSep = "}{",
    commands = [Run StdinReader],
    template = "%StdinReader%"
  }
