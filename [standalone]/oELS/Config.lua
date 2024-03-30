Config = {}

Config.Debug = false

Config.VersionCheck = true

Config.UIEnabled = true
Config.UIDefaultOn = false
Config.UICommand = "toggleELSUI"

Config.DefaultKeybinds = {} -- Intentionally left empty, edit tables below.

Config.DefaultKeybinds.Keyboard = {
    PrimaryLights = "Q",
    SecondaryLights = "K",
    WarningLights = "L",
    SirensToggle = "LMENU",
    SirensSwitch = "R",
    Bullhorn = "X",
    LeftAlleyLight = "",
    RightAlleyLight = "",
    IndicatorsLeft = "LEFT",
    IndicatorsRight = "RIGHT",
    Hazards = "BACK",
    SecondSirenToggle = "",
    SecondSirenSwitch = ""
}

Config.DefaultKeybinds.Controller = {
    PrimaryLights = "LLEFT_INDEX",
    SirensToggle = "LDOWN_INDEX",
    SirensSwitch = "RRIGHT_INDEX",
    SecondSirenToggle = "",
    SecondSirenSwitch = "",
    Bullhorn = "RDOWN_INDEX",
    IndicatorsLeft = "",
    IndicatorsRight = "",
    Hazards = ""
}

Config.Soundpacks = {
    "DLC_LGMODS_LONDONSIRENS\\sirenpack_one",
    "DLC_LGMODS_LONDONSIRENS\\sirenpack_two",
    "DLC_LGMODS_LONDONSIRENS\\sirenpack_three"
}

Config.Optilink = {
    Enabled = false,
    Use999Sound = {
        -- Marked
        `rpPolice1`,
        `rpPolice2`,
        `rpPolice3`,
        `rpPolice4`,
        `rpPolice5`,
        `rpPolice6`,
        `rpPolice7`,
        `rpPolice8`,
        `rpPolice9`,
        `rpPolice10`,
        `rpPolice11`,
        `rpPolice12`,
        `rpPolice13`,
        `rpPolice14`,
        `rpPolice15`,
        `rpPolice16`,
        -- Boats
        `rpPoliceB1`,
        `rpPoliceB2`,
        -- Riot
        `rpPoliceR1`,
        `rpPoliceR2`,
        -- Unmarked
        `rpPoliceUC1`,
        `rpPoliceUC2`,
        `rpPoliceUC3`,
        `rpPoliceUC4`,
        `rpPoliceUC5`,
        `rpPoliceUC6`,
        `rpPoliceUC7`,
        `rpPoliceUC8`,
        `rpPoliceUC9`,
        `rpPoliceUC10`,
        `rpPoliceUC11`,
        `sheriff2`
    }
}



Config.NonELS = {
    -- `Vehicle Spawn Code` (ENSURE YOU ARE USING `` AROUND THE SPAWN CODE AND NOT "")
    [`NONELS`] = {
        PrimaryLights = {1},
        SecondaryLights = {3},
        WarningLights = {4},
        OnSceneLights = {2}
    }
}

Config.WigWags = true

Config.PrimaryPatterns = {
    ["leds"] = {{{1, 2}, 75}, {{}, 75}, {{1, 2}, 75}, {{3, 4}, 75}, {{}, 75}, {{3, 4}, 75}},
    ["btp"] = {{{1, 2}, 75}, {{}, 75}, {{1, 2}, 75}, {{3, 4}, 75}, {{}, 75}, {{3, 4}, 75}},
    ["rotator"] = {{{1}, 75}, {{2}, 75}, {{3}, 75}, {{4}, 75}},
}

Config.OnScenePatterns = {
    ["leds"] = {{{1}, 75}, {{}, 75}, {{1}, 75}, {{4}, 75}, {{}, 75}, {{4}, 75}},
    ["btp"] = {{{1,9}, 75}, {{}, 75}, {{1,9}, 75}, {{4,7}, 75}, {{}, 75}, {{4,7}, 75}},
    ["rotator"] = {{{}, 75}},
}

Config.SecondaryPatterns = {
    ["leds"] = {{{9}, 120}, {{}, 120}, {{7}, 120}, {{}, 120}},
    ["btp"] = {{{9}, 120}, {{}, 120}, {{7}, 120}, {{}, 120}},
    ["rotator"] = {{{9}, 240}, {{}, 240}, {{7}, 240}, {{}, 240}}
}

Config.WarningPatterns = {
    ["leds"] = {{{6}, 280}, {{}, 160}, {{5}, 280}, {{}, 160}},
    ["btp"] = {{{6}, 280}, {{}, 160}, {{5}, 280}, {{}, 160}},
    ["rotator"] = {{{6}, 280}, {{}, 160}, {{5}, 280}, {{}, 160}}
}
