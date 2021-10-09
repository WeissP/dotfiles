Config
  {
    font = "xft: Source Han Sans CN:weight=bold:pixelsize=16",
    additionalFonts = ["xft: Source Han Sans CN:weight=bold:pixelsize=19", "xft: symbola:weight=bold:pixelsize=24", "xft:FiraCode Nerd Font Mono:weight=bold:pixelsize=16"],
    bgColor = "#2e3440",
    fgColor = "#d0d0d0",
    position = TopSize L 450 28,
    -- border = TopB,
    -- borderWidth = 20,
    persistent = True,
    hideOnStart = False,
    allDesktops = False,
    lowerOnStart = True,
    sepChar = "%",
    alignSep = "}{",
    -- commands = [Run StdinReader],
    -- template = "f%StdinReader%"
    commands = [Run XMonadLog],
    template = "%XMonadLog%"
  }
