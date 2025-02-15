Core.Scenes = {}

Core.Scenes.Synchronised = {
  Defaults = {
    SceneConfig = {
      position      = vector3(0.0,0.0,0.0),
      rotation      = vector3(0.0,0.0,0.0),
      rotOrder      = 2,
      useOcclusion  = false,
      loop          = false,
      unk1          = 1.0,
      animTime      = 0,
      animSpeed     = 1.0,
    },

    PedConfig = {
      blendIn       = 1.0,
      blendOut      = 1.0,
      duration      = 0,
      flag          = 0,
      speed         = 1.0,
      unk1          = 0,
    },

    EntityConfig = {
      blendIn       = 1.0,
      blendOut      = 1.0,
      flags         = 1,
    }
  },

  Create = function(sceneConfig)
    return NetworkCreateSynchronisedScene(sceneConfig.position,sceneConfig.rotation,sceneConfig.rotOrder,sceneConfig.useOcclusion,sceneConfig.loop,sceneConfig.unk1,sceneConfig.animTime,sceneConfig.animSpeed)
  end,

  SceneConfig = function(pos,rot,rotOrder,useOcclusion,loop,unk1,animTime,animSpeed)

    local _D = function(v1,v2) if v1 ~= nil then return v1 else return Core.Scenes.Synchronised.Defaults["SceneConfig"][v2]; end; end

    local conObj = {}
    conObj.position     = _D(pos,"position")
    conObj.rotation     = _D(rot,"rotation")
    conObj.rotOrder     = _D(rotOrder,"rotOrder")
    conObj.useOcclusion = _D(useOcclusion,"useOcclusion")
    conObj.loop         = _D(loop,"loop")
    conObj.unk1         = _D(p9,"unk1")
    conObj.animTime     = _D(animTime,"animTime")
    conObj.animSpeed    = _D(animSpeed,"animSpeed")
    return conObj
  end,

  AddPed = function(pedConfig)
    return NetworkAddPedToSynchronisedScene(pedConfig.ped,pedConfig.scene,pedConfig.animDict,pedConfig.animName,pedConfig.blendIn,pedConfig.blendOut,pedConfig.duration,pedConfig.flag,pedConfig.speed,pedConfig.unk1)
  end,

  PedConfig = function(ped,scene,animDict,animName,blendIn,blendOut,duration,flag,speed,unk1)
    local _D = function(v1,v2) if v1 ~= nil then return v1 else return Core.Scenes.Synchronised.Defaults["PedConfig"][v2]; end; end
    local conObj = {}
    conObj.ped          = ped
    conObj.scene        = scene
    conObj.animDict     = animDict
    conObj.animName     = animName
    conObj.blendIn      = _D(blendIn,"blendIn")
    conObj.blendOut     = _D(blendOut,"blendOut")
    conObj.duration     = _D(duration,"duration")
    conObj.flag         = _D(flag,"flag")
    conObj.speed        = _D(speed,"speed")
    conObj.unk1         = _D(unk1,"unk1")
    return conObj
  end,

  AddEntity = function(entityConfig)
    return NetworkAddEntityToSynchronisedScene(entityConfig.entity,entityConfig.scene,entityConfig.animDict,entityConfig.animName,entityConfig.blendIn,entityConfig.blendOut,entityConfig.flags)
  end,

  EntityConfig = function(entity,scene,animDict,animName,blendIn,blendOut,flags)
    local _D = function(v1,v2) if v1 ~= nil then return v1 else return Core.Scenes.Synchronised.Defaults["EntityConfig"][v2]; end; end
    local conObj = {}
    conObj.entity       = entity
    conObj.scene        = scene
    conObj.animDict     = animDict
    conObj.animName     = animName
    conObj.blendIn      = _D(blendIn,"blendIn")
    conObj.blendOut     = _D(blendOut,"blendOut")
    conObj.flags        = _D(flags,"flags")
    return conObj
  end,

  Start = function(scene)
    NetworkStartSynchronisedScene(scene)
  end,

  Stop = function(scene)
    NetworkStopSynchronisedScene(scene)
  end,
}