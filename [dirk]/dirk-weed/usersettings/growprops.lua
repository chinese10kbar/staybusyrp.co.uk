Config.GrowProps = {
  ['Light'] = {
    IntDist      = 2.5, --# How far away from prop to interact with it
    Model        = "bkr_prop_grow_lamp_02a", --## The model of the prop that will be created when item used.
    InvItem      = "weed_grow_light1", -- Item that can be used to place this and will be returned when picking it up.
    InvLabel     = "Grow Light",
    InvDescrip   = "A light used to grow tomateos",
    Offset       = vector3(0,0,0.5), --## Use this if you want the prop to spawn above the ground e.g a light
    EffectRadius = 5.0, --## Will effect plants within this radius.
    StatEffects  = {
      Temp  = 5.0, --## Will increase temperature by x %.
      Light = 10.0,  --## Will increase temperature by x %.

    },
  },

  ['Fan'] = {
    IntDist      = 2.5, --# How far away from prop to interact with it
    Model        = "bkr_prop_weed_fan_floor_01a",
    InvItem      = "weed_grow_fan1", -- Item that can be used to place this and will be returned when picking it up.
    InvLabel     = "Grow Fan",
    InvDescrip   = "A fan used to cool things",
    EffectRadius = 10.0, --## Will effect plants within this radius.
    StatEffects  = {
      Temp  = -5.0,  --## Will increase temperature by x %.
    },
  },
}

