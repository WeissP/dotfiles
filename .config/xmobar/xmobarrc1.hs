Config
  {
    font = "xft: Source Han Sans CN:weight=bold:pixelsize=17",
    additionalFonts = ["xft: symbola:weight=bold:pixelsize=24", "xft:FiraCode Nerd Font Mono:weight=bold:pixelsize=16"],
    bgColor = "#2e3440",
    fgColor = "#d0d0d0",

    -- position = Static {xpos = 709, ypos = 1468, width = 1900, height = 24},
    persistent = True,
    hideOnStart = False,
    allDesktops = True,
    lowerOnStart = True,
    commands =
      [ Run Network "wlan0" ["-t", "<fn=2>\xf0aa</fn> <tx>kb <fn=2>\xf0ab</fn> <rx>kb", "-m", "4"] 20,
        Run Cpu ["-t", "CPU:<bar>", "-H", "50", "--high", "red"] 20,
        Run Memory ["-t", "MEM:<usedbar>(<used>M)"] 20,
        Run DiskU [("/", "ROOT:<free>"), ("/home", "USER:<free> free")] [] 60,
        -- Run Wireless "wlan0" ["-t", "<ssid>"] 10,
        Run Weather
          "EDFM"
          [ "--template",
            "<tempC>°C <weather>",
            "-L",
            "0",
            "-H",
            "25",
            "--low",
            "lightblue",
            "--normal",
            "#f8f8f2",
            "--high",
            "red"
          ]
          36000,
        Run XPropertyLog "_XMONAD_LOG_Hori"
      ],
    sepChar = "%",
    alignSep = "}{",
    template =
      " <fc=#ecbe7b>%cpu%</fc> \
      \ <fc=#ecbe7b>%memory%</fc>\
      \ <fc=#666666>|</fc>\
      \ <fc=#51afef>%disku%</fc>\
      \ <fc=#666666>|</fc>\
      \ <fc=#98be65>%wlan0wi%</fc>\
      \ <fc=#98be65>%wlan0%</fc>\
      \ <fc=#666666>|</fc>\
      \ %_XMONAD_LOG_Hori% \
      \"
  }
