--## Translate the script here.
Labels = {
  ENG = {
    CannotPlantSoClose = "You cannot plant so close to another plant",
    YouHaveNothingForThis = "You have nothing for this",
    SuccessfullyApplied   = "You have successfully added %s to this plant",
    AlreadyStrain         = "This pot already has a seed in it",
    AlreadySoil           = "This pot already has soil in it",
    NeedScissors          = "You need scissors to do this",
    TrimAmount            = "You need %s untrimmed_bud in order to begin trimming",
    HarvestPlant          = "Harvest Plant",
    InteractPlant         = "View Stats",
    DestroyPlant          = "Destroy Plant",
    AlreadyTrimming       = "You are already trimming a bud",
    PlacePot       = "Place Pot",
    PickUpPlant    = "Pickup Plant",
    DropPlant      = 'Place Plant',
    PlaceEquipment = "Place Equipment",
    Cancel         = "Cancel",
    PickUpProp     = "Pick up Prop",
    PickupPot      = "Pickup Pot",
    TurnOn         = "Turn On",
    TurnOff        = "Turn Off",
    DestroyProp    = "Destroy Prop",
    DestroyPot     = "Destroy Pot",
    ConfirmPickup  = "Confirm Pickup",
    AreYouSurePickup = "Are you sure you want to pickup this pot/plant? This will destroy the pot/plant and return the pot to your inventory.",
    
  }
}



setmetatable(Labels, {
  __index = function(t, label)
    return Labels[Settings.Language] and Labels[Settings.Language][label] or label
  end
})
