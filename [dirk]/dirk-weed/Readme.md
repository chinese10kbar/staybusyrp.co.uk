https://docs.dirkscripts.com/resources/weed-growing

--## If you dont use autoadd items in dirk-core(Config Setting) then depending on your framework or inventory the script will produce an items.sql/shared.lua


-- Changelog

2nd NOV 2023 
-- Adjustments made so installation files are constantly updated if you add new strains etc
-- Performance issue with props fixed
-- Added ability to add an interact distance on your growProps 

-- CONFIG CHANGES -- Add the line(s) below manually to your config to save reconfiguring 


29 Jan 2024 

:new: Converted the ugly menu to ox_lib menu system
https://streamable.com/35hccd

:hammer: Overhauled and fixed the temperature/lighting systems you now have min/max values for light/temp dependant on if the plant is inside/outside and the time of day

:new: Ability to turn grow-props on/off

:new: Added alertboxes to check if you're sure you want to pickup/destroy a plant

:new: Added a few more nice snippets to the weed trimming script
https://streamable.com/kgha5l

:hammer: Optimisations to the way growProps were working has removed some of the hitch issues severs with massive amounts of plant/props were getting


02 Feb 2024 

:hammer: BIG DUMB DUMB I FORGOT TO POST THE UPDATE but here have some other new stuff too 

:hammer:/:new: Using my object spawning system for spawning of entities should reduce already non existent load on clients even further down 

:hammer: Server-side optimisations 


12 Feb 2024
:hammer: Fixed the floating plant issue 
:hammer: Upped the outside lighting to make outdoor grows more viable 
:hammer: Stopped grow-fan floating slightly
:new: Added LocalPlayer.state.disablePlant checks so if you wish to disable planting in certain areas you can do so (ADVANCED)
