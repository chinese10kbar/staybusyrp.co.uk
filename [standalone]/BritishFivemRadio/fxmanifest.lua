fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'ArcticWolf#5452'
description 'UK/British Radio Stations By ArcticWolf'
version '2.2.1'

-- Example custom radios
supersede_radio "RADIO_01_CLASS_ROCK" { url = "https://edge-bauerall-01-gos2.sharp-stream.com/planetrock.mp3", volume = 0.5, name = "Planet Rock" }
supersede_radio "RADIO_02_POP" { url = "https://icecast.thisisdax.com/HeartTeessideMP3", volume = 0.5, name = "Heart FM" }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "https://icecast.thisisdax.com/Heart80sMP3", volume = 0.5, name = "Heart 80's" }
supersede_radio "RADIO_04_PUNK" { url = "https://radio.virginradio.co.uk/stream?ref=rf", volume = 0.5, name = "Virgin Radio" }
supersede_radio "RADIO_05_TALK_01" { url = "https://icecast.thisisdax.com/LBCLondonMP3", volume = 0.5, name = "Leading Britians Converstaion" }
supersede_radio "RADIO_06_COUNTRY" { url = "https://edge-bauerall-01-gos2.sharp-stream.com/clyde1.mp3", volume = 0.5, name = "Clyde" }
supersede_radio "RADIO_07_DANCE_01" { url = "https://icecast.thisisdax.com/CapitalDance", volume = 0.5, name = "Capital Dance" }
supersede_radio "RADIO_08_MEXICAN" { url = "https://edge-bauerall-01-gos2.sharp-stream.com/forth1.mp3", volume = 0.5, name = "Forth" }
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "https://icecast.thisisdax.com/ClassicFMMP3", volume = 0.5, name = "Classic FM" }
supersede_radio "RADIO_11_TALK_02" { url = "https://stream.live.vc.bbcmedia.co.uk/bbc_radio_five_live?s=1617478203&e=1617492603&h=140ee6ea257bf1dc6a6f45eac5821d8c", volume = 0.5, name = "BBC Radio 5 Live" }
supersede_radio "RADIO_12_REGGAE" { url = "https://stream.simulatorradio.com/320", volume = 0.5, name = "Simulator Radio" }
supersede_radio "RADIO_13_JAZZ" { url = "https://icecast.thisisdax.com/CapitalMP3", volume = 0.5, name = "Capital UK" }
supersede_radio "RADIO_14_DANCE_02" { url = "https://n04a-eu.rcs.revma.com/hyyz8327ptzuv?rj-ttl=5&rj-tok=AAABeKQ63i4A6BuRmhKFNfDSgA", volume = 0.5, name = "Star FM" }
supersede_radio "RADIO_15_MOTOWN" { url = "https://stream.live.vc.bbcmedia.co.uk/bbc_radio_one", volume = 0.5, name = "BBC Radio 1" }
supersede_radio "RADIO_16_SILVERLAKE" { url = "https://edge-bauerall-01-gos2.sharp-stream.com/absoluteradiohigh.aac", volume = 0.5, name = "Absolute Radio" }
supersede_radio "RADIO_17_FUNK" { url = "https://n04.radiojar.com/v9srurnvty8uv?___cb=392695469630891&rj-ttl=5&rj-tok=AAABf44YDLMAO75KUdfhr9-1yA", volume = 0.5, name = "BRadio" }
supersede_radio "RADIO_18_90S_ROCK" { url = "https://stream.live.vc.bbcmedia.co.uk/bbc_radio_two?s=1617478323&e=1617492723&h=91df78cbf184354294a472f3649a6cfd", volume = 0.5, name = "BBC Radio 2" }
supersede_radio "RADIO_19_USER" { url = "https://stream.live.vc.bbcmedia.co.uk/bbc_1xtra?s=1617654990&e=1617669390&h=56f985a891870de2ab11d2fb8d46818f", volume = 0.5, name = "BBC Radio 1 Xtra" }
supersede_radio "RADIO_20_THELAB" { url = "https://icecast.thisisdax.com/CapitalXTRANationalMP3", volume = 0.5, name = "Capital XTRA" }
supersede_radio "RADIO_21_DLC_XM17" { url = "https://oreo.truckstopradio.co.uk/radio/8000/radio.mp3", volume = 0.5, name = "Truckstop Radio" }
supersede_radio "RADIO_22_DLC_BATTLE_MIX1_RADIO"  { url = "https://playoutonestreaming.com/proxy/essex?mp=/stream&=&&___cb=960754092070041", volume = 0.5, name = "Radio Essex" }
supersede_radio "RADIO_34_DLC_HEI4_KULT"  { url = "https://icecast.thisisdax.com/CapitalXTRANationalMP3", volume = 0.5, name = "Capital XTRA" }
supersede_radio "RADIO_35_DLC_HEI4_MLR"   { url = "https://icecast.thisisdax.com/CapitalXTRANationalMP3", volume = 0.5, name = "Capital XTRA" } 


files {
    "index.html"
}

ui_page "index.html"

client_scripts {
    "data.js",
    "client.js"
}
dependency '/assetpacks'