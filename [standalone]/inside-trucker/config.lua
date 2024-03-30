Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

cfg = {}
cfg.Prefix = QBCore -- Prefix of your Framework
cfg.TriggerPrefix = "QBCore" -- Prefix of your triggers Framework
cfg.ExportPrefix = "qb-core" -- Prefix of your Export
cfg.Colors = {r = 78, g = 255, b = 175} -- Colors of DrawTexts, Markers etc.
cfg.DepositPrice = 1500
cfg.Salary = "bank" -- ("bank"/"cash")Receipt of salary by a Bank or in Cash.
cfg.PoliceJobName = "police"
cfg.JobRequirement = false
cfg.ShowTransportInfo = true

cfg.Works = {
    [1] = {Name = "normal", Label = "Normal Transport", Veh = "hauler", Trailer = "trailers2", PricePerTon = 20},
    [2] = {Name = "wood", Label = "Wood Transport", Veh = "packer", Trailer = "trflat", PricePerTon = 30},
}

cfg.Coords = {
    Base = {x = -1161.38, y = -2163.77, z = 13.38},
    Spawn = {
        Vehicle = {
            [1] = {x = -1154.56, y = -2197.75, z = 13.43, h = 330.29},
            [2] = {x = -1159.40, y = -2194.95, z = 13.43, h = 330.29},
            [3] = {x = -1168.31, y = -2189.87, z = 13.43, h = 330.29},
            [4] = {x = -1173.28, y = -2187.00, z = 13.43, h = 330.29},
        },
        Trailer = {
            [1] = {x = -1159.87, y = -2207.06, z = 13.43, h = 330.32},
            [2] = {x = -1164.74, y = -2204.30, z = 13.43, h = 330.32},
            [3] = {x = -1173.65, y = -2199.23, z = 13.43, h = 330.32},
            [4] = {x = -1178.64, y = -2196.40, z = 13.43, h = 330.32},
        },
    },
    Loading = {
        Normal = {
            [1] = {LoadingBlip, vehicleX = -1066.91, vehicleY = -2014.03, vehicleZ = 13.38, trailerX = -1062.67, trailerY = -2009.70, trailerZ = 13.38},
            [2] = {LoadingBlip, vehicleX = -1063.22, vehicleY = -2017.64, vehicleZ = 13.38, trailerX = -1058.91, trailerY = -2013.38, trailerZ = 13.38},
            [3] = {LoadingBlip, vehicleX = -1055.77, vehicleY = -2024.96, vehicleZ = 13.38, trailerX = -1051.50, trailerY = -2020.65, trailerZ = 13.38},
            [4] = {LoadingBlip, vehicleX = -1051.64, vehicleY = -2028.11, vehicleZ = 13.38, trailerX = -1047.34, trailerY = -2023.83, trailerZ = 13.38},
            [5] = {LoadingBlip, vehicleX = 191.59, vehicleY = 6398.41, vehicleZ = 31.61, trailerX = 186.18, trailerY = 6395.67, trailerZ = 31.61},
            [6] = {LoadingBlip, vehicleX = 188.00, vehicleY = 6404.93, vehicleZ = 31.50, trailerX = 182.59, trailerY = 6402.20, trailerZ = 31.50},
            [7] = {LoadingBlip, vehicleX = 132.80, vehicleY = 6350.69, vehicleZ = 31.47, trailerX = 130.15, trailerY = 6356.14, trailerZ = 31.47},
            [8] = {LoadingBlip, vehicleX = 203.85, vehicleY = 6391.93, vehicleZ = 31.61, trailerX = 206.54, trailerY = 6386.51, trailerZ = 31.61},
            [9] = {LoadingBlip, vehicleX = 2673.48, vehicleY = 3514.83, vehicleZ = 52.93, trailerX = 2675.91, trailerY = 3520.40, trailerZ = 52.93},
            [10] = {LoadingBlip, vehicleX = 2664.19, vehicleY = 3518.92, vehicleZ = 53.01, trailerX = 2666.58, trailerY = 3524.58, trailerZ = 53.01},
            [11] = {LoadingBlip, vehicleX = 2688.78, vehicleY = 3452.51, vehicleZ = 56.00, trailerX = 2683.17, trailerY = 3454.84, trailerZ = 56.00},
            [12] = {LoadingBlip, vehicleX = 2698.30, vehicleY = 3444.34, vehicleZ = 56.04, trailerX = 2700.67, trailerY = 3449.94, trailerZ = 56.04},
        },
        Wood = {
            [1] = {LoadingBlip, vehicleX = -586.91, vehicleY = 5625.45, vehicleZ = 39.00, trailerX = -590.98, trailerY = 5618.74, trailerZ = 39.00},
            [2] = {LoadingBlip, vehicleX = -795.29, vehicleY = 5433.39, vehicleZ = 35.40, trailerX = -803.05, trailerY = 5434.32, trailerZ = 35.20},
            [3] = {LoadingBlip, vehicleX = -810.19, vehicleY = 5410.44, vehicleZ = 34.34, trailerX = -818.02, trailerY = 5410.90, trailerZ = 34.34},
            [4] = {LoadingBlip, vehicleX = -791.93, vehicleY = 5400.89, vehicleZ = 34.26, trailerX = -784.07, trailerY = 5401.07, trailerZ = 34.26},
            [5] = {LoadingBlip, vehicleX = 193.45, vehicleY = 4425.55, vehicleZ = 73.83, trailerX = 187.84, trailerY = 4420.09, trailerZ = 74.25},
            [6] = {LoadingBlip, vehicleX = 346.57, vehicleY = 4463.18, vehicleZ = 62.84, trailerX = 345.16, trailerY = 4470.91, trailerZ = 62.84},
            [7] = {LoadingBlip, vehicleX = 350.35, vehicleY = 4440.51, vehicleZ = 63.34, trailerX = 349.07, trailerY = 4448.26, trailerZ = 63.34},
        },
    },
    Unloading = {
        Normal = {
            [1] = {UnloadingBlip, vehicleX = -506.28, vehicleY = -2191.54, vehicleZ = 6.75, trailerX = -510.11, trailerY = -2196.28, trailerZ = 6.75},
            [2] = {UnloadingBlip, vehicleX = 794.04, vehicleY = -2928.68, vehicleZ = 6.07, trailerX = 800.09, trailerY = -2928.64, trailerZ = 6.07},
            [3] = {UnloadingBlip, vehicleX = -45.43, vehicleY = -2415.60, vehicleZ = 6.22, trailerX = -51.49, trailerY = -2415.63, trailerZ = 6.22},
            [4] = {UnloadingBlip, vehicleX = -2966.20, vehicleY = 400.67, vehicleZ = 15.31, trailerX = -2960.15, trailerY = 400.21, trailerZ = 15.31},
            [5] = {UnloadingBlip, vehicleX = -3144.59, vehicleY = 1148.50, vehicleZ = 21.13, trailerX = -3150.17, trailerY = 1150.82, trailerZ = 21.13},
            [6] = {UnloadingBlip, vehicleX = 1706.82, vehicleY = 4807.22, vehicleZ = 42.05, trailerX = 1712.90, trailerY = 4807.11, trailerZ = 42.05},
            [7] = {UnloadingBlip, vehicleX = 916.41, vehicleY = 3589.64, vehicleZ = 33.50, trailerX = 910.35, trailerY = 3589.71, trailerZ = 33.50},
        },
        Wood = {
            [1] = {UnloadingBlip, vehicleX = 1010.22, vehicleY = -2515.81, vehicleZ = 28.38, trailerX = 1009.59, trailerY = -2523.64, trailerZ = 28.38},
            [2] = {UnloadingBlip, vehicleX = 1190.79, vehicleY = -1406.62, vehicleZ = 35.23, trailerX = 1190.81, trailerY = -1398.77, trailerZ = 35.23},
            [3] = {UnloadingBlip, vehicleX = 1346.02, vehicleY = -728.38, vehicleZ = 66.97, trailerX = 1353.66, trailerY = -730.12, trailerZ = 66.97},
            [4] = {UnloadingBlip, vehicleX = -1153.32, vehicleY = 2662.07, vehicleZ = 18.17, trailerX = -1158.43, trailerY = 2668.03, trailerZ = 18.17},
            [5] = {UnloadingBlip, vehicleX = -82.11, vehicleY = 2804.69, vehicleZ = 53.41, trailerX = -89.30, trailerY = 2807.86, trailerZ = 53.41},
            [6] = {UnloadingBlip, vehicleX = 203.17, vehicleY = 2789.57, vehicleZ = 45.73, trailerX = 195.41, trailerY = 2788.35, trailerZ = 45.73},
            [7] = {UnloadingBlip, vehicleX = 1713.68, vehicleY = 4706.60, vehicleZ = 42.70, trailerX = 1721.41, trailerY = 4707.86, trailerZ = 42.70},
            [8] = {UnloadingBlip, vehicleX = 2307.12, vehicleY = 4915.39, vehicleZ = 41.49, trailerX = 2312.49, trailerY = 4921.11, trailerZ = 41.49},
        },
    },
    PlatformScale = {
        [1] = {PlatformScaleBlip, PlatformScaleInfoPos, Platform, ToolChest, Laptop, x = -1002.36, y = -2228.80, z = 9.00 - 1.15, h = 136.28, vehicleX = -1009.97, vehicleY = -2236.90, vehicleZ = 9.09, trailerX = -1004.56, trailerY = -2231.20, trailerZ = 9.09, MarkerAlpha = 50},
        [2] = {PlatformScaleBlip, PlatformScaleInfoPos, Platform, ToolChest, Laptop, x = -368.30, y = 6062.01, z = 31.50 - 1.15, h = 311.76, vehicleX = -359.99, vehicleY = 6069.40, vehicleZ = 31.57, trailerX = -365.89, trailerY = 6064.22, trailerZ = 31.57, MarkerAlpha = 50},
        [3] = {PlatformScaleBlip, PlatformScaleInfoPos, Platform, ToolChest, Laptop, x = 1981.10, y = 3779.43, z = 32.18 - 1.15, h = 208.13, vehicleX = 1986.32, vehicleY = 3769.67, vehicleZ = 32.26, trailerX = 1982.58, trailerY = 3776.58, trailerZ = 32.26, MarkerAlpha = 50},
    },
}

cfg.Blip = {
    Base = {
        Sprite = 473,
        Scale = 0.6,
        ShortRange = true,
        Color = 46,
        Label = "[TRUCKER] Base",
    },
    NormalLoading = {
        Sprite = 478,
        Scale = 0.6,
        ShortRange = true,
        Color = 46,
        Label = "[TRUCKER] Normal Transport loading place",
    },
    NormalUnloading = {
        Sprite = 479,
        Scale = 0.6,
        ShortRange = false,
        Color = 1,
        Label = "[TRUCKER] Normal Transport unloading place",
    },
    WoodLoading = {
        Sprite = 615,
        Scale = 0.6,
        ShortRange = true,
        Color = 46,
        Label = "[TRUCKER] Wood Transport loading place",
    },
    WoodUnloading = {
        Sprite = 615,
        Scale = 0.6,
        ShortRange = false,
        Color = 1,
        Label = "[TRUCKER] Wood Transport unloading place",
    },
    PlatformScale = {
        Sprite = 643,
        Scale = 0.6,
        ShortRange = true,
        Color = 46,
        Label = "[TRUCKER] Platform Scale",
    },
}