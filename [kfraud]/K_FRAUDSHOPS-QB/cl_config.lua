
KonfigCL = {}

KonfigCL.NPCEnable = true
KonfigCL.Banker = true -- enable/disable banker
KonfigCL.WhiteSlipNPC = "a_m_m_farmer_01"
KonfigCL.BlackMarketNPC = "a_m_m_socenlat_01"
KonfigCL.ElectronicNPC = "a_m_y_soucent_01"
KonfigCL.BankerNPC = "u_m_m_bankman"

--items to sell to banker


KonfigCL.ElectronicsBuyLocation = vector3(0,0,12321)
KonfigCL.BlackMarketBuyLocation = vector3(455.96, 5570.77, 781.18)
KonfigCL.WhiteSlipBuyLocation = vector3(0,0,12321)

KonfigCL.BankerLocation = vector3(264.68, 214.83, 110.29)

KonfigCL.QBTarget = true

KonfigCL.DrawMakers = true -- draw markers on locations ^^


KonfigCL.BlackmarketItems = {
    [1] = {
        name = "skimmer",
        price = 5000,
        amount = 1000,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "blankcard",
        price = 400,
        amount = 1000,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "infousb",
        price = 600,
        amount = 1000,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "stolencard",
        price = 600,
        amount = 1000,
        info = {},
        type = "item",
        slot = 4,
    },
    [5] = {
        name = "whiteslip",
        price = 500,
        amount = 1000,
        info = {},
        type = "item",
        slot = 5,
    },
}

KonfigCL.SlipItems = {
    [1] = {
        name = "whiteslip",
        price = 500,
        amount = 1000,
        info = {},
        type = "item",
        slot = 1,
    },
}

KonfigCL.ElectronicItems = {
    [1] = {
        name = "printer",
        price = 100,
        amount = 1,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "generator",
        price = 1250,
        amount = 1,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "laptop2",
        price = 750,
        amount = 1,
        info = {},
        type = "item",
        slot = 3,
    },
}



local QBCore = GetQBVersion()
function Notify(message)
    QBCore.Functions.Notify(message)
end
