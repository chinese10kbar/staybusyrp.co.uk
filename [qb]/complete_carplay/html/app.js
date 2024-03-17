//var data = null;
var mouse_over_map = false;
var message_receiver = null
var player;
var saved;
var saved_contacts;
var phone_type;
var max_speed;
var playing = false;
var music_queue = [];
var radio_name;
var radio_playing = false;
var hour;
var minutes;
var weather;
var use_km;
var apps;
var blacklist;
var draggable;
var draggable_key;
var interval;

var last_transform;
var last_datax;
var last_datay;
var last_width;
var last_height;
var responsive_changed = false;

var current_music_time;
var current_music_url;
var current_coords;
var model_name;
var status_raw;
var prev_log = '';
var prev_stats = Array(10).fill(0);
var saved_songs;
var current_waypoint;
var current_waypoint_street;
var configured_measure;
var configured_measure_h;


var radio_list = {
    "OFF": "Off",
    "RADIO_01_CLASS_ROCK": "Los Santos Rock Radio",
    "RADIO_02_POP": "Non-Stop-Pop FM",
    "RADIO_03_HIPHOP_NEW": "Radio Los Santos",
    "RADIO_04_PUNK": "Channel X",
    "RADIO_05_TALK_01": "WCTR",
    "RADIO_06_COUNTRY": "Rebel Radio",
    "RADIO_07_DANCE_01": "Soulwax FM",
    "RADIO_08_MEXICAN": "East Los FM",
    "RADIO_09_HIPHOP_OLD": "West Coast Classics",
    "RADIO_11_TALK_02": "Blaine County Radio",
    "RADIO_12_REGGAE": "Blue Ark",
    "RADIO_13_JAZZ": "WorldWide FM",
    "RADIO_14_DANCE_02": "FlyLo FM",
    "RADIO_15_MOTOWN": "The Lowdown 91.1",
    "RADIO_16_SILVERLAKE": "Radio Mirror Park",
    "RADIO_17_FUNK": "Space 103.2",
    "RADIO_18_90S_ROCK": "Vinewood Boulevard Radio",
    "RADIO_20_THELAB": "The Lab",
    "RADIO_21_DLC_XM17": "blonded Los Santos 97.8 FM",
    "RADIO_22_DLC_BATTLE_MIX1_RADIO": "Los Santos Underground Radio",
    "RADIO_23_DLC_XM19_RADIO": "iFruit Radio",
    "RADIO_27_DLC_PRHEI4": "Still Slipping Los Santos",
    "RADIO_34_DLC_HEI4_KULT": "Kult FM",
    "RADIO_35_DLC_HEI4_MLR": "The Music Locker",
    "RADIO_36_AUDIOPLAYER": "Media Player"
}

var weather_types = {
    '-1750463879': "EXTRASUNNY",
    '916995460': "CLEAR",
    '-1530260698': "NEUTRAL",
    '282916021': "SMOG",
    '-1368164796': "FOGGY",
    '-1148613331': "OVERCAST",
    '821931868': "CLOUDS",
    '1840358669': "CLEARING",
    '1420204096': "RAIN",
    '-1233681761': "THUNDER",
    '-273223690': "SNOW",
    '669657108': "BLIZZARD",
    '603685163': "SNOWLIGHT",
    '-1429616491': "XMAS",
    '-921030142': "HALLOWEEN"
}

window.addEventListener('message', function (event) {
    var data = event.data;
    
    if (data.type == "carplay") {
        document.getElementById("waypoint_content").hidden = true
        RemoveTrunkCamera();
        $("#main_content").hide().fadeIn("slow");
        saved = data.settings;
        saved_contacts = data.contacts;
        phone_type = data.phone_type;
        current_music_url = data.url;
        playing = data.playing;
        radio_name = data.radio_name;
        radio_playing = data.radio_playing;
        music_queue = JSON.parse(data.music_queue);
        max_speed = data.max_speed;
        hour = data.hour;
        minutes = data.minutes;
        weather = data.weather;
        current_coords = data.coords
        model_name = data.model_name
        saved_songs = data.saved_songs
        current_waypoint = data.current_waypoint
        InitializeUI(hour, minutes);
        MainMenu();
    } else if (data.type == "refresh_main") {
        UpdateMain(data.current_fuel, data.waypoint_street, data.waypoint_time, data.waypoint_avg, data.current_time, data.waypoint_distance, data.ui_open)
    } else if (data.type == "iframe") {
        CreateIframe();
    } else if (data.type == "speed") {
        SetSpeed(data.speed);
    } else if (data.type == "queue") {
        var next_url = data.url;
        music_queue = JSON.parse(data.queue);
        UpdateQueue();
        InitializePlaySound(next_url);
        //PlaySound(next_url);
    } else if (data.type == "refresh_queue") {
        music_queue = JSON.parse(data.queue);
        UpdateQueue();
    } else if (data.type == "stop_music") {
        music_queue = [];
        playing = false;
        current_music_url = null;
        UpdateQueue();
        ResetMusicPlayer();
    } else if (data.type == "refresh_timestamp") {
        UpdateTimestamp(data.time, data.max_time)
    } else if (data.type == "trunk_camera") {
        if (data.open == true) {
            TrunkCamera();
        } else {
            RemoveTrunkCamera();
        }
    } else if (data.type == "refresh_radio") {
        UpdateRadio(data.radio_name, data.radio_playing)
    } else if (data.type == "set_position") {
        if (document.getElementById('waypoint_div_position') != null) {
            document.getElementById('waypoint_div_position').removeAttribute('class');
            document.getElementById('waypoint_div_position').classList.add(data.position);
        }
    } else if (data.type == "refresh_direction") {
        if (data.ui_open == false) {
            UpdateDirection(data.waypoint_direction)
            if (document.getElementById('waypoint_current_street') != null) {
                document.getElementById('waypoint_current_street').innerHTML = data.current_street
            }
        } else {
            if (document.getElementById('main_current_street') != null) {
                document.getElementById('main_current_street').innerHTML = data.current_street
            }
        }
    } else if (data.type == "setCStreetWaypoint") {
        if (document.getElementById("waypoint_card_1") != null) {
            if (data.bool == true) {
                document.getElementById("waypoint_card_1").hidden = false
            } else {
                document.getElementById("waypoint_card_1").hidden = true
            }
        }
    } else if (data.type == "hideNavigator") {
        if (data.bool == true) {
            document.getElementById("waypoint_card_2").hidden = true
        } else {
            document.getElementById("waypoint_card_2").hidden = false
        }
    } else if (data.type == "useKm") {
        if (data.bool == true) {
            use_km = true
            configured_measure = 'km'
            configured_measure_h = 'km/h'
        } else {
            use_km = false
            configured_measure = 'mph'
            configured_measure_h = 'mph/h'
        }
    } else if (data.type == "setApps") {
        apps = data.apps
        blacklist = data.blacklist
        draggable = data.draggable
        draggable_key = data.draggable_key
    } else if (data.type == "updateSettings") {
        saved = data.settings
    } else if (data.type == "updateStatus") {
        status_raw = [data.status_engine_temp, data.status_oil_temp, data.status_tank_healt, data.status_body_healt, data.status_lowest_wheel, data.status_dirt_level]
        
        if (prev_stats.every(item => item === 0)) {
            prev_stats = status_raw
            const temp_curr_date = new Date()
            var seconds = temp_curr_date.getSeconds();
            var minutes = temp_curr_date.getMinutes();
            var hour = temp_curr_date.getHours();
            var curr_date = hour + ":" + minutes + ":" + seconds
            var update = "<strong style='color: rgb(var(--main-color));'>Update</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style='color: rgb(var(--main-color));'>Initialization...</strong>"
            prev_log = prev_log + update + '<br><br>'
        } else {
            if (document.getElementById('status_app_container') != null) {   
                StatusUpdate(status_raw)
            } else {
                const temp_curr_date = new Date()
                var seconds = temp_curr_date.getSeconds();
                var minutes = temp_curr_date.getMinutes();
                var hour = temp_curr_date.getHours();
                var curr_date = hour + ":" + minutes + ":" + seconds
                var update = "<strong style='color: rgb(var(--main-color));'>Update</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style='color: rgb(var(--main-color));'>"+curr_date+"</strong>"
                if (prev_stats[0] != status_raw[0]) {
                    update = update + "<br>Engine Temperature&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[0] + " --> " + status_raw[0]
                } 
                if (prev_stats[1] != status_raw[1]) {
                    update = update + "<br>Oil Level&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[1] + " --> " + status_raw[1]
                }
                if (prev_stats[2] != status_raw[2]) {
                    update = update + "<br>Petrol Tank Healt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[2] + " --> " + status_raw[2]
                }
                if (prev_stats[3] != status_raw[3]) {
                    update = update + "<br>Body Healt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[3] + " --> " + status_raw[3]
                }
                if (prev_stats[4] != status_raw[4]) {
                    update = update + "<br>Tyre Burst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[4] + " --> " + status_raw[4]
                }
                if (prev_stats[5] != status_raw[5]) {
                    update = update + "<br>Dirt Level&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[5] + " --> " + status_raw[5]
                }
                
                prev_stats = status_raw
    
                if (update != "<strong style='color: rgb(var(--main-color));'>Update</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style='color: rgb(var(--main-color));'>"+curr_date+"</strong>") {
                    prev_log = prev_log + update + '<br><br>'
                }
            }
        }
        
    } else if (data.type == "updateSavedSongs") {
        saved_songs = data.saved_songs
    }
});

$(document).keyup(function (e) {
    if (e.keyCode === 27) {
        RemoveTrunkCamera();
        $.post('https://complete_carplay/close', JSON.stringify({}));
        $("#main_content").fadeOut("slow", function () {
            $("#main_content").html("").fadeIn();
        });
    }
    if (e.keyCode === draggable_key) {
        if (draggable == true) {
            $.post('https://complete_carplay/removeFocus', JSON.stringify({}));
        }
    }
});

function InitializeUI(hour, minutes) {
    var time_string = ''
    if (hour < 10) {
        time_string = '0' + hour + ':'
    } else {
        time_string = hour + ':'
    }
    
    if (minutes < 10) {
        time_string = time_string + '0' + minutes
    } else {
        time_string += minutes
    }

    var initialize = `<div class="tablet theme-light" id="tablet_div" style="transform: translate(-50%, -50%);" data-x="0" data-y="0">
        <div class="page" style="cursor: default; height: 100%; min-height: auto; color: #ffffff;">
            <header id="aside_bar" class="navbar navbar-vertical navbar-expand-lg navbar-dark" style="border-radius: 20px; background-color: #000000; z-index:1040; overflow-x: hidden; display: flex; align-content: space-between;">
                <div class="" style="display: flex; flex-wrap: inherit; align-items: center; align-content: center; justify-content: flex-start; margin-left: auto; margin-right: auto;">
                    <button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-menu" aria-expanded="false">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="navbar-collapse collapse" id="navbar-menu">
                        <ul class="navbar-nav pt-lg-3" id="navbar_apps_ul">
                                
                        </ul>
                    </div>
                </div>
                <div class="" style="display: flex; flex-wrap: inherit; flex-direction: column; align-items: center; align-content: center; justify-content: center; margin-left: auto; margin-right: auto;">
                    <h1 class="navbar-brand navbar-brand-autodark" style="font-size: 24px; padding: 0.5rem 0 0 0" id="main_current_hour">${time_string}</h1>
                    <div style="display: flex; align-content: center;">
                        <h1 class="navbar-brand navbar-brand-autodark" style="font-size: 24px; padding: 0.2rem 0">
                            5G
                        </h1>
                        <span class="nav-link-icon d-md-none d-lg-inline-block" style="opacity: 1; margin-right: 0; width: 2.25rem; height: 2.25rem;">
                            <svg style="width: 2.25rem; height: 2.25rem;" xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-antenna-bars-5" width="64" height="64" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                <line x1="6" y1="18" x2="6" y2="15"></line>
                                <line x1="10" y1="18" x2="10" y2="12"></line>
                                <line x1="14" y1="18" x2="14" y2="9"></line>
                                <line x1="18" y1="18" x2="18" y2="6"></line>
                            </svg>
                        </span>
                    </div>
                    <a class="nav-link" onclick="MainMenu()" id="submit-button">
                        <svg class="navbar-brand-image" style="display: inline-block; width: 4rem; height: 4rem; background-color: #ffffff; border-radius: 50px; padding: 8px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="2" stroke="black" fill="none" stroke-linecap="round" stroke-linejoin="round">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                            <path d="M12 3c7.2 0 9 1.8 9 9s-1.8 9 -9 9s-9 -1.8 -9 -9s1.8 -9 9 -9z"></path>
                        </svg>
                    </a>
                </div>
            </header>
            <div class="card page-wrapper" style="padding: 1rem 1.5rem 1.5rem 1.5rem; position: relative; background-color: #272727; position: fixed; top: 0; left: 0; bottom: 0; z-index: 1030; align-items: flex-start; transition: .3s transform; overflow-x: hidden; min-width: -webkit-fill-available; height: 100%">
                <div class="page-body" style="margin-top: 0rem; margin-bottom: 0; min-width: -webkit-fill-available; height: 100%">
                    <div class="" style="height: 100%;" id="app_container">
                        
                    </div>
                </div>
            </div>
        </div>
    </div>`;

    if (document.getElementById('tablet_div') == null) {
        $('#main_content').append(initialize);

        document.getElementById('main_current_hour').innerHTML = time_string
        if (draggable == true) {
            $('#tablet_div').addClass('tablet-drag');
            
            if (last_datax != null && last_datay != null) {
                $('#tablet_div').attr('data-x', last_datax);
                $('#tablet_div').attr('data-y', last_datay);
                $('#tablet_div').css('transform', last_transform);
                $('#tablet_div').css('width', last_width);
                $('#tablet_div').css('height', last_height);
            } else {
                const rect = document.getElementById('tablet_div').getBoundingClientRect();
                $('#tablet_div').attr('data-x', "-" + rect.width/2);
                $('#tablet_div').attr('data-y', "-" + rect.height/2);
            }
            
            interval = setInterval(Responsive, 200);
        }

        var apps_display = JSON.parse(apps)
        if (apps_display["messages"] == true) {
            var messages = `<li class="nav-item mb-2">
                <a class="nav-link" onclick="MessageApp()" style="justify-content: center;">
                    <img src="./img/messages.png" class="navbar-brand-image" style="height: 4rem;">
                </a>
            </li>`;
            $('#navbar_apps_ul').append(messages);
        }
        if (apps_display["music"] == true) {
            var music = `<li class="nav-item mb-2">
                <a class="nav-link" onclick="MusicApp()" style="justify-content: center;">
                    <img src="./img/music.png" class="navbar-brand-image" style="height: 4rem;">
                </a>
            </li>`;
            $('#navbar_apps_ul').append(music);
        }
        if (apps_display["actions"] == true) {
            var actions = `<li class="nav-item mb-2">
                <a class="nav-link" onclick="ActionsApp()" style="justify-content: center;">
                    <img src="./img/actions.png" class="navbar-brand-image" style="height: 4rem;">
                </a>
            </li>`;
            $('#navbar_apps_ul').append(actions);
        }
        if (apps_display["status"] == true) {
            var healt = `<li class="nav-item mb-2">
                <a class="nav-link" onclick="StatusApp()" style="justify-content: center;">
                    <img src="./img/healt.png" class="navbar-brand-image" style="height: 4rem;">
                </a>
            </li>`;
            $('#navbar_apps_ul').append(healt);
        }
        if (apps_display["trunk"] == true) {
            var app_menu = `<li class="nav-item mb-2">
                <a class="nav-link" onclick="TrunkPost()" style="justify-content: center;">
                    <img src="./img/camera.png" class="navbar-brand-image" style="height: 4rem;">
                </a>
            </li>`;
            $('#navbar_apps_ul').append(app_menu);
        }
    }
}

function Responsive() {
    if (document.getElementById("tablet_div") != null) {
        if (document.getElementById("tablet_div").clientWidth < 1200) {
            if (responsive_changed == false) {
                if (document.getElementById("main_row") != null) {
                    $('#main_row_1').removeClass('col-lg-4');
                    $('#main_row_1').addClass('col-lg-6');
                    $('#main_row_1').css('margin-bottom', '3rem');
                    $('#main_row_2').removeClass('col-lg-3');
                    $('#main_row_2').addClass('col-lg-6');
                    $('#main_row_3').removeClass('col-lg-5');
                    $('#main_row_3').addClass('col-lg-12');
    
                    responsive_changed = true
                } else if (document.getElementById("message_app_container") != null) {
                    $('#message_contact_list').children().each(function() {
                        $(this).removeClass('col-lg-4');
                        $(this).addClass('col-lg-6');
                    });
    
                    responsive_changed = true
                } else if (document.getElementById("music_app_container") != null) {
                    $('#saved_songs_row').children().each(function() {
                        $(this).removeClass('col-lg-3');
                        $(this).addClass('col-lg-6');
                    });
        
                    $('#saved_songs_col').removeClass('col-lg-8');
                    $('#saved_songs_col').addClass('col-lg-12');
                    0
                    $('#queue_songs_col').removeClass('col-lg-4');
                    $('#queue_songs_col').addClass('col-lg-12');
    
                    $('#music_player_div_row').children().each(function() {
                        if ($(this).index() == 0) {
                            $(this).removeClass('col-auto');
                            $(this).addClass('col-2');
                            $(this).css('margin-bottom', '0.7rem');
                        } else if ($(this).index() == 1) {
                            $(this).removeClass('col-auto');
                            $(this).addClass('col-10');
                            $(this).css('margin-bottom', '0.7rem');
                        }
                    });
                    
                    $('.data-title-queue-song').each(function() {
                        $(this).css('white-space', 'normal');
                    });

                    $('#music_app_main_col').css('height', '85%');

                    responsive_changed = true
                } else if (document.getElementById("status_app_container") != null) {
                    $('#status_app_cards_col').removeClass('col-lg-8');
                    $('#status_app_cards_col').addClass('col-lg-12');
                    $('#status_div_log').removeClass('col-lg-4');
                    $('#status_div_log').addClass('col-lg-12');
    
                    responsive_changed = true
                }
            }

        } else if (responsive_changed == true) {
            if (document.getElementById("main_row") != null) {
                $('#main_row_1').removeClass('col-lg-6');
                $('#main_row_1').addClass('col-lg-4');
                $('#main_row_1').css('margin-bottom', '0');
                $('#main_row_2').removeClass('col-lg-6');
                $('#main_row_2').addClass('col-lg-3');
                $('#main_row_3').removeClass('col-lg-12');
                $('#main_row_3').addClass('col-lg-5');

                responsive_changed = false
            } else if (document.getElementById("message_app_container") != null) {
                $('#message_contact_list').children().each(function() {
                    $(this).removeClass('col-lg-6');
                    $(this).addClass('col-lg-4');
                });

                responsive_changed = false
            } else if (document.getElementById("music_app_container") != null) {
                $('#saved_songs_row').children().each(function() {
                    $(this).removeClass('col-lg-6');
                    $(this).addClass('col-lg-3');
                });

                
                $('#saved_songs_col').removeClass('col-lg-12');
                $('#saved_songs_col').addClass('col-lg-8');

                $('#queue_songs_col').removeClass('col-lg-12');
                $('#queue_songs_col').addClass('col-lg-4');

                $('#music_player_div_row').children().each(function() {
                    if ($(this).index() == 0) {
                        $(this).removeClass('col-2');
                        $(this).addClass('col-auto');
                        $(this).css('margin-bottom', '0');
                    } else if ($(this).index() == 1) {
                        $(this).removeClass('col-10');
                        $(this).addClass('col-auto');
                        $(this).css('margin-bottom', '0');
                    }
                });

                $('.data-title-queue-song').each(function() {
                    $(this).css('white-space', 'nowrap');
                });

                $('#music_app_main_col').css('height', '90%');

                responsive_changed = false
            } else if (document.getElementById("status_app_container") != null) {
                $('#status_app_cards_col').removeClass('col-lg-12');
                $('#status_app_cards_col').addClass('col-lg-8');
                $('#status_div_log').removeClass('col-lg-12');
                $('#status_div_log').addClass('col-lg-4');

                responsive_changed = false
            }
        }
        
        last_width = document.getElementById("tablet_div").clientWidth
    }
}

function MainMenu() {
    if (use_km == true) {
        measure = "km/h";
    } else {
        measure = "mph";
    }
    var main_div = `<div class="row row-deck row-cards" id="main_row" style="height: 100%; --tblr-gutter-y: 0;">
        <div class="col-lg-4 col-sm-12" style="display:flex; margin-top: 0px; min-height: 100%; flex-direction: column;" id="main_row_1">
            <div class="h1 mt-0" id="main_model_name"></div>
            <div style="display: flex; align-items: center; flex-direction: column;">
                <div id="main_speedometer" style="display: flex; text-align: center; justify-content: center; align-items: center; transform: scale(0.8, 0.8);">
                    <div id="circles_container">

                    </div>
                    <span id="main_speedometer_text" class="speed-text" style="opacity: 1; transition: all 1.2s cubic-bezier(0.57, 0.13, 0.18, 0.98) 0s; left: unset; top: unset; transform: none;">0</span>
                    <h3 id="main_speedometer_measure" class="text-muted" style="left: unset; top: 17vh; transform: none;">km/h</h3>
                </div>
                <div class="w-100" style="display: flex; text-align: center; justify-content: center; align-items: center;">
                    <img src="./img/car2.png" height="450vh" alt="">
                    <div style="position: absolute;">
                        <a>
                            <svg id="lock" onclick="ActionActiveMain(this)" class="action-icons" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="1.3" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                <path d="M5 13a2 2 0 0 1 2 -2h10a2 2 0 0 1 2 2v6a2 2 0 0 1 -2 2h-10a2 2 0 0 1 -2 -2v-6z"></path>
                                <path d="M11 16a1 1 0 1 0 2 0a1 1 0 0 0 -2 0"></path>
                                <path d="M8 11v-4a4 4 0 1 1 8 0v4"></path>
                            </svg>
                        </a>
                    </div>
                    <div id="trunk" class="p-1 action-icons" onclick="ActionActiveMain(this)" style="height: auto; position: absolute; margin-top: 440px; border-radius: 30px;">
                        <a id="main_trunk_text">Open</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-12" style="margin-top: 0px; flex-direction: column; align-items: center; max-height: 100%;" id="main_row_2">
            <div class="row w-100 h-100" style="align-content: space-between;">
                <div class="col-12 mb-3">
                    <div class="card" style="border-radius: 10px;">
                        <div class="card-body p-3" style="">
                            <h3 class="lh-1" style="margin-bottom: 1rem; color: #e7e7e7; transition: all 0.2s cubic-bezier(0.57, 0.13, 0.18, 0.98) 0s;">Fuel</h3>

                            <div class="row text-center" style="align-items: center;">
                                <div class="col-6">
                                    <div id="fuel_container" style="display: flex; align-items: center; justify-content: center;">

                                    </div>
                                </div>
                                <div class="col-6">
                                    <div style="display: flex; margin-bottom: 0.7rem; flex-direction: column;">
                                        <h3 class="lh-1" style="font-size:x-large; margin-bottom: 0.15rem; color: #e7e7e7; display: flex; justify-content: flex-end;" id="main_waypoint_distance"></h3>
                                        <small style="color: rgb(var(--main-color)); display: flex; justify-content: flex-end;">Waypoint distance</small>
                                    </div>
                                    <div style="display: flex; flex-direction: column;">
                                        <h3 class="lh-1" style="display: flex; justify-content: flex-end; margin-bottom: 0.15rem; color: #e7e7e7; font-size:x-large;" id="main_waypoint_avg_speed">---</h3>
                                        <small style="display: flex; justify-content: flex-end; color: rgb(var(--main-color));">Waypoint avg. speed</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 mb-3">
                    <div class="card" style="border-radius: 10px;">
                        <div class="card-body p-3">
                            <h3 class="lh-1" style="margin-bottom: 1rem; color: #e7e7e7;">Weather</h3>
                            <div class="row" style="align-items: center;">
                                <div class="col-lg-6 col-sm-12">
                                    <img src="" height="100vh" id="main_weather_img">
                                </div>
                                <div class="col-lg-6 col-sm-12" style="display: grid; justify-content: flex-end;">
                                    <h1 class="lh-1" style="margin-bottom: 0.3rem; font-size:x-large; display: flex; justify-content: flex-end;" id="main_weather_name"></h1>
                                    <small style="display: flex; justify-content: flex-end; color: rgb(var(--main-color));">Upcoming weather</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 mb-3">
                    <div class="card w-100" style="border-radius: 10px;">
                        <div class="card-body" style="display: flex; justify-content: center; flex-direction: column;">
                            <h3 class="lh-1" style="margin-bottom: 1rem; color: #e7e7e7;">Radio</h3>
                            <div class="w-100 text-center" style="display: flex; align-items: center; justify-content: center; flex-direction: column;">
                                <span class="avatar avatar-tra avatar-xl avatar-rounded mb-2" style="background-image: url(./img/radio.png)" id="player_image"></span>
                                <h3 class="mb-0" id="menu_radio_name">OFF</h3>
                                <div class="row mt-3" style="justify-content: center;">
                                    <div class="col-auto">
                                        <a href='#' class="btn btn-outline-primary btn-pill w-100 btn-icon" id="menu_radio_prev_button">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-track-prev" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M21 5v14l-8 -7z"></path><path d="M10 5v14l-8 -7z"></path></svg>
                                        </a>
                                    </div>
                                    <div class="col-auto">
                                        <a href='#' class="btn btn-outline-primary btn-pill w-100 btn-icon" id="menu_radio_play_button">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-square" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                <rect x="4" y="4" width="16" height="16" rx="2"></rect>
                                            </svg>
                                        </a>
                                    </div>
                                    <div class="col-auto">
                                        <a href='#' class="btn btn-outline-primary btn-pill w-100 btn-icon" id="menu_radio_next_button">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-track-next" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M3 5v14l8 -7z"></path><path d="M14 5v14l8 -7z"></path></svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card" style="border-radius: 10px;">
                        <div class="card-body" style="display: flex; flex-direction: column;">
                            <h3 class="lh-1" style="margin-bottom: 1rem; color: #e7e7e7;">Music volume</h3>
                            <div class="row">
                                <div class="col-6">
                                        <a href='#' class="btn btn-outline-primary btn-pill w-100 btn-icon" id="main_downVolume_btn" style="padding: 0.7rem 0.7rem; --tblr-btn-border-color: var(--main-color);">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-volume-2" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M15 8a5 5 0 0 1 0 8"></path><path d="M6 15h-2a1 1 0 0 1 -1 -1v-4a1 1 0 0 1 1 -1h2l3.5 -4.5a0.8 .8 0 0 1 1.5 .5v14a0.8 .8 0 0 1 -1.5 .5l-3.5 -4.5"></path></svg>
                                        </a>
                                    </div>
                                <div class="col-6">
                                    <a href='#' class="btn btn-outline-primary btn-pill w-100 btn-icon" id="main_upVolume_btn" style="padding: 0.7rem 0.7rem; --tblr-btn-border-color: var(--main-color);">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-volume" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M15 8a5 5 0 0 1 0 8"></path><path d="M17.7 5a9 9 0 0 1 0 14"></path><path d="M6 15h-2a1 1 0 0 1 -1 -1v-4a1 1 0 0 1 1 -1h2l3.5 -4.5a0.8 .8 0 0 1 1.5 .5v14a0.8 .8 0 0 1 -1.5 .5l-3.5 -4.5"></path></svg>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-5 col-md-12 col-sm-12" style="margin-top: 0px; height: 100%; display: flex; justify-content: center;" id="main_row_3">
            <div class="card h-100" style="max-width: 511px;">
                <div id="map" style="position:relative; height: 1000px; width: 100%; border-radius: 15px; max-width: 511px;"></div>
            </div>
        </div>
    </div>`;
    document.getElementById('app_container').innerHTML = main_div;

    const center_x = 117.3;
    const center_y = 172.8;
    const scale_x = 0.02072;
    const scale_y = 0.0205;

    CUSTOM_CRS = L.extend({}, L.CRS.Simple, {
        projection: L.Projection.LonLat,
        scale: function(zoom) {
            return Math.pow(2, zoom);
        },
        zoom: function(sc) {
            return Math.log(sc) / 0.6931471805599453;
        },
        distance: function(pos1, pos2) {
            var x_difference = pos2.lng - pos1.lng;
            var y_difference = pos2.lat - pos1.lat;
            return Math.sqrt(x_difference * x_difference + y_difference * y_difference);
        },
        transformation: new L.Transformation(scale_x, center_x, -scale_y, center_y),
        infinite: true
    });

    var SateliteStyle = L.tileLayer('https://gtamap.xyz/mapStyles/styleSatelite/{z}/{x}/{y}.jpg', {minZoom: 0,maxZoom: 8,noWrap: true,continuousWorld: false,id: 'SateliteStyle map',}),
        AtlasStyle	= L.tileLayer('https://gtamap.xyz/mapStyles/styleAtlas/{z}/{x}/{y}.jpg', {minZoom: 0,maxZoom: 5,noWrap: true,continuousWorld: false,id: 'styleAtlas map',})

    var ExampleGroup = L.layerGroup();

    var Icons = {
        "Example" :ExampleGroup,
    };

    var mymap = L.map('map', {
        crs: CUSTOM_CRS,
        minZoom: 3,
        maxZoom: 5,
        Zoom: 5,
        maxNativeZoom: 5,
        preferCanvas: true,
        layers: [AtlasStyle, Icons["Example"]],
        center: [0, 0],
        zoom: 5,
    });
    document.getElementsByClassName('leaflet-control-attribution')[0].style.display = "none"
    L.control.layers({ "Satelite": SateliteStyle,"Atlas": AtlasStyle}).addTo(mymap);


    const current_location = `<div style="display:flex; background-color: rgb(63, 63, 63); padding: 0.75rem; border-radius: 15px; margin-bottom:0.5rem; margin-left:0.5rem;">
        <div class="d-flex align-items-center">
            <div class="p-1" style="margin-right:0.5rem; transition: all 0.2s cubic-bezier(0.57, 0.13, 0.18, 0.98) 0s;" id="main_waypoint_direction">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-map-pin-filled" style="width:1.5rem;height:1.5rem;" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                    <path d="M18.364 4.636a9 9 0 0 1 .203 12.519l-.203 .21l-4.243 4.242a3 3 0 0 1 -4.097 .135l-.144 -.135l-4.244 -4.243a9 9 0 0 1 12.728 -12.728zm-6.364 3.364a3 3 0 1 0 0 6a3 3 0 0 0 0 -6z" stroke-width="0" fill="currentColor"></path>
                </svg>
            </div>
            <div>
                <h3 class="lh-1" style="margin-bottom: 0.05rem; color: #e7e7e7; transition: all 0.2s cubic-bezier(0.57, 0.13, 0.18, 0.98) 0s;" id="main_current_street"></h3>
                <small style="color: rgb(var(--main-color));">Current location</small>
            </div>
        </div>
    </div>`
    document.getElementsByClassName('leaflet-bottom leaflet-left')[0].innerHTML = current_location


    var car_icon = L.icon({
        iconUrl: './img/navigator.png',
        
        iconSize: [32, 32], // size of the icon
        iconAnchor: [16, 16], // point of the icon which will correspond to marker's location
        popupAnchor: [-10,-15] // point from which the popup should open relative to the iconAnchor
    });

    var waypoint_icon = L.icon({
        iconUrl: './img/radar_waypoint.png',
        
        iconSize: [32, 32], // size of the icon
        iconAnchor: [16, 16], // point of the icon which will correspond to marker's location
        popupAnchor: [-10,-15] // point from which the popup should open relative to the iconAnchor
    });

    const lng = current_coords.x 
    const lat = current_coords.y
    var marker2 = new L.marker([lat,lng], {icon: car_icon}).addTo(Icons["Example"]).bindPopup("<b style='color:#fff'>X: "+lng.toFixed(3)+" | Y: "+lat.toFixed(3)+"</b>");
    mymap.setView([lat, lng], 16);

    var marker;
    mymap.on('click', function (e) {
        if (marker) {
            mymap.removeLayer(marker); 
        }
        var coord = e.latlng;
        var lat = coord.lat;
        var lng = coord.lng;
        var zoom = 16;
        marker = new L.marker([lat,lng]).addTo(Icons["Example"]).bindPopup(`<a onclick="NavigateButton()" id="main_navigate_mark" class='btn btn-info btn-pill w-100' lng="${lng.toFixed(3)}" lat="${lat.toFixed(3)}" style="color: white;">Navigate</a>`);
        mymap.setView([lat, lng], zoom);
    });

    if (current_waypoint_street != null) {
        var waypoint_marker = new L.marker([current_waypoint[1], current_waypoint[0]], {icon: waypoint_icon}).addTo(Icons["Example"]).bindPopup("<b style='color:#fff'>Current Waypoint</b>");
    }
    
    document.getElementById('map').addEventListener("mouseleave", function (event) {
        mouse_over_map = false
    }, false);

    document.getElementById('map').addEventListener("mouseover", function (event) {
        mouse_over_map = true
    }, false);

    UpdateRadio(radio_name, radio_playing);
    
    document.getElementById('main_weather_img').src = './img/weather/' + weather_types[weather] + '.png'
    var temp_weather = weather_types[weather].toLowerCase()
    document.getElementById('main_weather_name').innerHTML = temp_weather.charAt(0).toUpperCase() + temp_weather.slice(1)

    var temp_model = model_name.toLowerCase()
    document.getElementById('main_model_name').innerHTML = temp_model.charAt(0).toUpperCase() + temp_model.slice(1)

    const smsettings = JSON.parse(saved);
    for (let i = 0; i < smsettings.length; i++) {
        var setting = smsettings[i];

        if (setting.trunk == true) {
            InitializeActionsMain('trunk')
        }
        if (setting.lock == true) {
            InitializeActionsMain('lock')
        }
    }

    document.getElementById('main_upVolume_btn').onclick = function () {
        $.post('https://complete_carplay/volumeSound', JSON.stringify({
            change: 'up'
        }));
    };

    document.getElementById('main_downVolume_btn').onclick = function () {
        $.post('https://complete_carplay/volumeSound', JSON.stringify({
            change: 'down'
        }));
    };
    
    document.getElementById('menu_radio_prev_button').onclick = function () {
        $.post('https://complete_carplay/setRadio', JSON.stringify({
            change: 'prev'
        }));
    };
    document.getElementById('menu_radio_next_button').onclick = function () {
        $.post('https://complete_carplay/setRadio', JSON.stringify({
            change: 'next'
        }));
    };
    document.getElementById('menu_radio_play_button').onclick = function () {
        if (radio_playing == true) {
            $.post('https://complete_carplay/playPauseRadio', JSON.stringify({
                change: 'pause' 
            }));
        } else {
            document.getElementById("menu_radio_play_button").classList.add('btn-active');
            $.post('https://complete_carplay/playPauseRadio', JSON.stringify({
                change: 'play' 
            }));
        }
    };
}

function NavigateButton() {
    var lng2 = document.getElementById('main_navigate_mark').getAttribute("lng")
    var lat2 = document.getElementById('main_navigate_mark').getAttribute("lat")
    
    $.post('https://complete_carplay/setNavigator', JSON.stringify({
        lng: lng2,
        lat: lat2
    }));
}

function InitializeActionsMain(action) {
    var actions_a = document.getElementById(action);
    actions_a.classList.add('action-icons-active');
    actions_a.classList.remove('action-icons');
    if (action == 'trunk') {
        document.getElementById('main_trunk_text').innerHTML = 'Close'
    }
}

function ActionActiveMain(target) {
    var target_id = target.id;
    var element = target
    if (!element.classList.contains('action-icons-active')) {
        element.classList.remove('action-icons');
        element.classList.add('action-icons-active');

        $.post('https://complete_carplay/setSetting', JSON.stringify({
            setting: target_id,
            bool: true
        }));

        if (target_id == 'trunk') {
            document.getElementById('main_trunk_text').innerHTML = 'Close'
        }
    } else {
        element.classList.remove('action-icons-active');
        element.classList.add('action-icons');

        $.post('https://complete_carplay/setSetting', JSON.stringify({
            setting: target_id,
            bool: false
        }));

        if (target_id == 'trunk') {
            document.getElementById('main_trunk_text').innerHTML = 'Open'
        }
    }
}

function UpdateVelocityCircle(percent) {
    var radius = 125
    const strokeWidth = radius * 0.13;
    const innerRadius = radius - strokeWidth;
    const circumference = innerRadius * 2 * Math.PI;
    const arc = circumference * 0.75;
    const dashArray = `${arc} ${circumference}`;
    const transform = `rotate(135, ${radius}, ${radius})`;
    const offset = arc - (percent / 100) * arc;

    var circles = `<svg height="${radius * 2}" width="${radius * 2}">
        <defs></defs>
        <lineargradient id="grad" x1="0" y1="0" x2="1" y2="1">
            <stop offset="15%" stop-color="#1267ff" stop-opacity="1"></stop>
            <stop offset="85%" stop-color="#98c0ff" stop-opacity="1"></stop>
        </lineargradient>
        <circle style="transition: stroke-dashoffset 0.3s"
            cx="${radius}"
            cy="${radius}"
            fill="transparent"
            r="${innerRadius}"
            stroke="gray"
            stroke-dasharray="${dashArray}"
            stroke-linecap="round"
            stroke-width="${strokeWidth}"
            transform="${transform}"
        />
        
        <circle style="transition: stroke-dashoffset 0.3s"
            cx="${radius}"
            cy="${radius}"
            fill="transparent"
            r="${innerRadius}"
            stroke="url(#grad)"
            stroke-dasharray="${dashArray}"
            stroke-dashoffset="${offset}"
            stroke-linecap="round"
            stroke-width="${strokeWidth}"
            transform="${transform}"
        />
    </svg>`

    document.getElementById('circles_container').innerHTML = circles
}

function UpdateFuelCircle(percent) {
    var percent = percent
    if (percent == undefined) {
        percent = 0
    }

    var fuel_radius = 50
    const fuel_strokeWidth = fuel_radius * 0.13;
    const fuel_innerRadius = fuel_radius - fuel_strokeWidth;
    const fuel_circumference = fuel_innerRadius * 2 * Math.PI;
    const fuel_arc = fuel_circumference * 0.75;
    const fuel_dashArray = `${fuel_arc} ${fuel_circumference}`;
    const fuel_transform = `rotate(135, ${fuel_radius}, ${fuel_radius})`;
    const fuel_offset = fuel_arc - (percent / 100) * fuel_arc;

    var circles = `<svg height="${fuel_radius * 2}" width="${fuel_radius * 2}">
        <defs></defs>
        <lineargradient id="grad2" x1="0" y1="0" x2="1" y2="1">
            <stop offset="15%" stop-color="#1267ff" stop-opacity="1"></stop>
            <stop offset="85%" stop-color="#98c0ff" stop-opacity="1"></stop>
        </lineargradient>
        <circle style="transition: stroke-dashoffset 0.3s"
            cx="${fuel_radius}"
            cy="${fuel_radius}"
            fill="transparent"
            r="${fuel_innerRadius}"
            stroke="gray"
            stroke-dasharray="${fuel_dashArray}"
            stroke-linecap="round"
            stroke-width="${fuel_strokeWidth}"
            transform="${fuel_transform}"
        />
        
        <circle style="transition: stroke-dashoffset 0.3s"
            cx="${fuel_radius}"
            cy="${fuel_radius}"
            fill="transparent"
            r="${fuel_innerRadius}"
            stroke="url(#grad2)"
            stroke-dasharray="${fuel_dashArray}"
            stroke-dashoffset="${fuel_offset}"
            stroke-linecap="round"
            stroke-width="${fuel_strokeWidth}"
            transform="${fuel_transform}"
        />
    </svg>
    <h3 class="lh-1" style="position:absolute; margin-bottom: 0.05rem; color: #e7e7e7; transition: all 0.2s cubic-bezier(0.57, 0.13, 0.18, 0.98) 0s;">${percent}%</h3>`

    document.getElementById('fuel_container').innerHTML = circles
}

function UpdateMain(current_fuel, waypoint_street, waypoint_time, waypoint_avg, current_time, waypoint_distance, ui_open) {
    current_waypoint_street = waypoint_street
    if (ui_open == true) {
        if (document.getElementById('main_current_hour') != null) {
            document.getElementById('main_current_hour').innerHTML = current_time;
        }
        if (document.getElementById('main_row') != null) {
            UpdateFuelCircle(Math.round(current_fuel))
            if (waypoint_street != null && waypoint_street != "") {
                var replaced_dist = waypoint_distance.toString();
                document.getElementById('main_waypoint_distance').innerHTML = replaced_dist.replace(".", ",") + ' ' + configured_measure;
                if (waypoint_time != null) {                          
                    document.getElementById('main_waypoint_avg_speed').innerHTML = Math.round(waypoint_avg)  + ' ' + configured_measure_h
                } else {
                    document.getElementById('main_waypoint_avg_speed').innerHTML = "---";
                }
            } else {
                document.getElementById('main_waypoint_avg_speed').innerHTML = "---";
                document.getElementById('main_waypoint_distance').innerHTML = "---";
            }
        }
    } else {
        if (waypoint_street != null && waypoint_street != "") {
            if (document.getElementById('waypoint_div_position') != null) {
                document.getElementById('waypoint_div_position').style.width = "20%"
            }
            if (document.getElementById("waypoint_card_2") != null) {
                document.getElementById("waypoint_card_2").hidden = false
            }
            document.getElementById("waypoint_content").hidden = false
            var replaced_dist = waypoint_distance.toString();
            document.getElementById('main_waypoint_distance').innerHTML = replaced_dist.replace(".", ",") + ' ' + configured_measure
            if (waypoint_time != null && waypoint_time != 0) {
                var seconds = Math.round(waypoint_time * 60)
                if (seconds >= 3600) {
                    document.getElementById('main_waypoint_time').innerHTML = secondsToFormatHours(seconds) 
                } else {
                    document.getElementById('main_waypoint_time').innerHTML = secondsToFormat(seconds) 
                }
                document.getElementById('main_waypoint_avg_speed').innerHTML = Math.round(waypoint_avg) + ' ' + configured_measure_h
            } else {
                document.getElementById('main_waypoint_time').innerHTML = "-";
                document.getElementById('main_waypoint_avg_speed').innerHTML = "-";
            }
        } else {
            if (document.getElementById('waypoint_div_position') != null) {
                document.getElementById('waypoint_div_position').style.width = "15%"
            }
            document.getElementById("waypoint_card_2").hidden = true
            document.getElementById("waypoint_content").hidden = false

            document.getElementById('main_waypoint_time').innerHTML = "-";
            document.getElementById('main_waypoint_avg_speed').innerHTML = "-";
            document.getElementById('main_waypoint_distance').innerHTML = "-";
        }
    }
}

function UpdateDirection(dir) {
    switch (dir) {
        case 0:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-loader icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <line x1="12" y1="6" x2="12" y2="3"></line>
                <line x1="16.25" y1="7.75" x2="18.4" y2="5.6"></line>
                <line x1="18" y1="12" x2="21" y2="12"></line>
                <line x1="16.25" y1="16.25" x2="18.4" y2="18.4"></line>
                <line x1="12" y1="18" x2="12" y2="21"></line>
                <line x1="7.75" y1="16.25" x2="5.6" y2="18.4"></line>
                <line x1="6" y1="12" x2="3" y2="12"></line>
                <line x1="7.75" y1="7.75" x2="5.6" y2="5.6"></line>
            </svg>`;
            break;
        case 1:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-corner-left-down icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M18 6h-6a3 3 0 0 0 -3 3v10l-4 -4m8 0l-4 4"></path>
            </svg>`;
            break;
        case 2:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-narrow-up icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <line x1="12" y1="5" x2="12" y2="19"></line>
                <line x1="16" y1="9" x2="12" y2="5"></line>
                <line x1="8" y1="9" x2="12" y2="5"></line>
            </svg>`;
            break;
        case 3:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-corner-up-left icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M18 18v-6a3 3 0 0 0 -3 -3h-10l4 -4m0 8l-4 -4"></path>
            </svg>`;
            break;
        case 4:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-corner-up-right icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M6 18v-6a3 3 0 0 1 3 -3h10l-4 -4m0 8l4 -4"></path>
            </svg>`;
            break;
        case 5:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-narrow-up icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <line x1="12" y1="5" x2="12" y2="19"></line>
                <line x1="16" y1="9" x2="12" y2="5"></line>
                <line x1="8" y1="9" x2="12" y2="5"></line>
            </svg>`;
            break;
        case 6:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-bear-left icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M13 3h-5v5"></path>
                <path d="M8 3l7.536 7.536a5 5 0 0 1 1.464 3.534v6.93"></path>
            </svg>`;
            break;
        case 7:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-bear-right icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M12 3h5v5"></path>
                <path d="M17 3l-7.536 7.536a5 5 0 0 0 -1.464 3.534v6.93"></path>
            </svg>`;
            break;
        case 8:
            document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-loader icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <line x1="12" y1="6" x2="12" y2="3"></line>
                <line x1="16.25" y1="7.75" x2="18.4" y2="5.6"></line>
                <line x1="18" y1="12" x2="21" y2="12"></line>
                <line x1="16.25" y1="16.25" x2="18.4" y2="18.4"></line>
                <line x1="12" y1="18" x2="12" y2="21"></line>
                <line x1="7.75" y1="16.25" x2="5.6" y2="18.4"></line>
                <line x1="6" y1="12" x2="3" y2="12"></line>
                <line x1="7.75" y1="7.75" x2="5.6" y2="5.6"></line>
            </svg>`;
            break;
        default:
            if (document.getElementById('main_waypoint_direction') != null) {
                document.getElementById('main_waypoint_direction').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-md" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#e7e7e7" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M4 19l4 -14"></path><path d="M16 5l4 14"></path><path d="M12 8v-2"></path><path d="M12 13v-2"></path><path d="M12 18v-2"></path></svg>`;
            }
            break;
    }
}

function UpdateRadio(name, bool) {
    radio_name = name
    document.getElementById('menu_radio_name').innerHTML = radio_list[radio_name];
    radio_playing = bool
    if (radio_playing == true) {
        if (radio_name != "OFF") {
            document.getElementById("menu_radio_play_button").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-square-off" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M8 4h10a2 2 0 0 1 2 2v10m-.584 3.412a1.994 1.994 0 0 1 -1.416 .588h-12a2 2 0 0 1 -2 -2v-12c0 -.552 .224 -1.052 .586 -1.414"></path>
                <path d="M3 3l18 18"></path>
            </svg>`;
            document.getElementById("menu_radio_play_button").classList.add('btn-active');
        }
    } else {
        document.getElementById("menu_radio_play_button").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-square" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
            <rect x="4" y="4" width="16" height="16" rx="2"></rect>
        </svg>`;
        document.getElementById("menu_radio_play_button").classList.remove('btn-active');
        document.getElementById('menu_radio_name').innerHTML = 'OFF';
    }
}

function SetSpeed(speed) {
    if (document.getElementById('main_row') != null) {
        var speed_perc = (speed / max_speed) * 100
        UpdateVelocityCircle(Math.round(speed_perc))
        document.getElementById('main_speedometer_text').innerHTML = speed;
    }
    /*
    if (document.getElementById('main_speedometer_stroke') != null) {
        if (speed == 0) {
            document.getElementById('main_speedometer_stroke').setAttribute('stroke-width', '0');
        } else {
            document.getElementById('main_speedometer_stroke').setAttribute('stroke-width', '45');
        }
    
        var speed_perc = (speed / max_speed) * 100;
        var speed_stroke, speed_stroke_dasharray
        if (speed_perc >= 100) {
            speed_stroke = 495;
        } else {
            speed_stroke = (495 * speed_perc) / 100;
        }
        speed_stroke_dasharray = speed_stroke.toString() + " 1000";
        document.getElementById('main_speedometer_stroke').setAttribute('stroke-dasharray', speed_stroke_dasharray);
        document.getElementById('main_speedometer_text').innerHTML = speed;
    }
    */
}

function MessageApp() {
    var message_div = `<div class="row row-deck row-cards mt-2" style="--tblr-gutter-x: 2rem; --tblr-gutter-y: 0.5rem;" id="message_app_container">
        <div class="col-lg-6" style="margin-top: 0px; flex-direction: column;">
            <h2 class="mb-3">Contacts</h2>
            <div id="message_card_body">
                <div class="row row-cards" id="message_contact_list">
                    
                </div>
            </div>
        </div>
        <div class="col-lg-6" style="margin-top: 0px; flex-direction: column;">
            <h2 class="mb-3">Message</h2>
            <div class="card" id="message2_card" style="border-radius: 10px;">
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label" id="message_to_label">To:</label>
                        <textarea id="message_textarea" class="form-control theme-dark" style="background-color: #262626; max-height: 50vh;" data-bs-toggle="autosize" name="example-textarea-input" rows="6" placeholder="Content.."></textarea>
                    </div>
                    <div class="btn-list justify-content-end">
                        <a href="#" class="btn" id="message_cancel_btn">Cancel</a>
                        <a href="#" class="btn btn-primary" id="message_send_btn">Send</a>
                    </div>
                </div>
            </div>
        </div>
    </div>`;
    document.getElementById('app_container').innerHTML = message_div;
    //var height = document.getElementById("tablet_div").clientHeight;
    //document.getElementById('message1_card').style.height = (height - 1) + "px";
    //document.getElementById('message2_card').style.height = (height - 1) + "px";

    const contacts = JSON.parse(saved_contacts);
    for (let i = 0; i < contacts.length; i++) {
        var contact = contacts[i];
        var contact_name;
        var display_name;
        if (phone_type == 'gcphone' || phone_type == 'gksphone' || phone_type == 'npwd') {
            display_name = contact.display;
            contact_name = contact.display;
        } else if (phone_type == 'quasar' || phone_type == 'dphone' || phone_type == "highphone" || phone_type == "chezza") {
            display_name = contact.name;
            contact_name = contact.name;
        } else if (phone_type == 'roadphone'  || phone_type == 'lbphone') {
            display_name = contact.firstname + " " + contact.lastname;
            contact_name = contact.firstname + " " + contact.lastname;
        }


        if (contact_name.indexOf(' ') >= 0) {
            var name_array = contact_name.split(" ");
            contact_name = name_array[0].charAt(0) + name_array[1].charAt(0)
        } else {
            contact_name = contact_name.charAt(0);
        }
        
        var contact_div = `<div class="col-md-6 col-lg-4">
            <div class="card" style="height: 100%; border-radius: 10px;">
                <div class="card-body p-4 text-center" style="display: flex; align-items: center; justify-content: center; flex-direction: column;">
                    <span class="avatar avatar-xl mb-3 rounded">${contact_name}</span>
                    <h3 class="m-0 mb-1">${display_name}</h3>
                    <div class="text-muted">${contact.number}</div>
                </div>
                <div class="d-flex">
                    <a href="#" onclick="SetToLabel('${display_name}', '${contact.number}')" class="card-btn">
                        <svg xmlns="http://www.w3.org/2000/svg" class="icon me-2 text-muted" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M3 7a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v10a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-10z"></path><path d="M3 7l9 6l9 -6"></path></svg>
                        Send message
                    </a>
                </div>
            </div>
        </div>`;

        $('#message_contact_list').append(contact_div);
    }

    document.getElementById('message_send_btn').onclick = function () {
        var message = document.getElementById('message_textarea').value;
        if (message != null && message != "" && message_receiver != null) {
            document.getElementById('message_textarea').value = '';
            $.post('https://complete_carplay/send_message', JSON.stringify({
                message: message,
                receiver: message_receiver
            }));
        }
    };

    document.getElementById('message_cancel_btn').onclick = function () {
        document.getElementById('message_textarea').value = '';
    };
}

function SetToLabel(name, number) {
    message_receiver = number;
    document.getElementById('message_to_label').innerHTML = 'To: ' + name;
}

function MusicApp() {
    var music_div = `<div class="row row-deck" style="--tblr-gutter-x: 0.5rem; --tblr-gutter-y: 0.5rem; height: 100%;" id="music_app_container">
        <div class="col-lg-12" style="margin-top: 0px; flex-direction: column; height: 90%; overflow-x: hidden;" id="music_app_main_col">
            <h2 class="mb-3">Music</h2>
            <div class="input-icon mb-4">
                <input id="music_url_input" type="text" autocomplete="on" value="" style="background-color: #262626; padding: 0.75rem .75rem;" class="form-control form-control-rounded theme-dark music_search_btn" placeholder="Add your link here...">
                <span class="input-icon-addon">
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0"></path><path d="M21 21l-6 -6"></path></svg>
                </span>
            </div>
            <div id="music_card">
                <div class="row" style="--tblr-gutter-x: 2rem;">
                    <div class="col-lg-8 overflow-auto" id="saved_songs_col">
                        <label class="form-label">Saved songs</label>
                        <div class="row" style="--tblr-gutter-y: 1rem;" id="saved_songs_row">
                            
                        </div>
                    </div>
                    <div class="col-lg-4" id="queue_songs_col">
                        <div style="position: relative; display: flex; justify-content: center; margin-bottom: 0.5rem;" id="music_iframe">
                            
                        </div>
                        <label class="form-label">Queue</label>
                        <div class="list-group list-group-flush overflow-auto" id="music_queue_list" style="padding-right: 0.5rem;">
                            
                        </div>
                    </div>
                </div>
            </div>
            <div style="height: 100%; display: flex; align-items: flex-end;">
                <div class="card fixed-bottom" style="position: absolute;">
                    <div class="card-body">
                        <div style="color: #fff" class="p-1" id="music_player_div">
                            <div class="row" style="align-items: center;" id="music_player_div_row">
                                <div class="col-auto">
                                    <span id="music_player_img" class="avatar avatar-md mb-1" style="background-image: url()"></span>
                                </div>
                                <div class="col-auto">
                                    <h3 class="mb-0" id="music_player_song_name" style="max-width: 29rem;">---</h3>
                                    <small class="text-muted" id="music_player_author">---</small>
                                </div>
                                <div class="col-auto" style="display: inline-flex;">
                                    <div class="row">
                                        <div class="col-auto">
                                            <a href='#' class="btn btn-ghost-primary w-100 btn-icon" id="music_prev_btn">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-rotate-2" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M15 4.55a8 8 0 0 0 -6 14.9m0 -4.45v5h-5"></path><line x1="18.37" y1="7.16" x2="18.37" y2="7.17"></line><line x1="13" y1="19.94" x2="13" y2="19.95"></line><line x1="16.84" y1="18.37" x2="16.84" y2="18.38"></line><line x1="19.37" y1="15.1" x2="19.37" y2="15.11"></line><line x1="19.94" y1="11" x2="19.94" y2="11.01"></line></svg>
                                            </a>
                                        </div>
                                        <div class="col-auto">
                                            <a href='#' class="btn btn-ghost-primary w-100 btn-icon" id="music_play_btn">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-xl icon-tabler icon-tabler-player-play" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M7 4v16l13 -8z"></path></svg>
                                            </a>
                                        </div>
                                        <div class="col-auto">
                                            <a href='#' class="btn btn-ghost-primary w-100 btn-icon" id="music_forw_btn">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-rotate-clockwise-2" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M9 4.55a8 8 0 0 1 6 14.9m0 -4.45v5h5"></path><line x1="5.63" y1="7.16" x2="5.63" y2="7.17"></line><line x1="4.06" y1="11" x2="4.06" y2="11.01"></line><line x1="4.63" y1="15.1" x2="4.63" y2="15.11"></line><line x1="7.16" y1="18.37" x2="7.16" y2="18.38"></line><line x1="11" y1="19.94" x2="11" y2="19.95"></line></svg>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="row g-2 align-items-center">
                                        <div class="col-auto">
                                            <p id="music_player_current_time" style="color: #d3d3d3; margin-bottom: 0;">00:00</p>
                                        </div>
                                        <div class="col">
                                            <div class="progress progress-sm">
                                                <div class="progress-bar" id="music_player_progressbar" style="width: 0%" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <p id="music_player_max_time" style="color: #d3d3d3; margin-bottom: 0;">00:00</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <div class="row" style="justify-content: center;">
                                        <div class="col-auto">
                                            <a href='#' class="btn btn-ghost-primary w-100 btn-icon" id="music_downVolume_btn">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-volume-2" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M15 8a5 5 0 0 1 0 8"></path><path d="M6 15h-2a1 1 0 0 1 -1 -1v-4a1 1 0 0 1 1 -1h2l3.5 -4.5a0.8 .8 0 0 1 1.5 .5v14a0.8 .8 0 0 1 -1.5 .5l-3.5 -4.5"></path></svg>
                                            </a>
                                        </div>
                                        <div class="col-auto">
                                            <a href='#' class="btn btn-ghost-primary w-100 btn-icon" id="music_upVolume_btn">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-volume" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M15 8a5 5 0 0 1 0 8"></path><path d="M17.7 5a9 9 0 0 1 0 14"></path><path d="M6 15h-2a1 1 0 0 1 -1 -1v-4a1 1 0 0 1 1 -1h2l3.5 -4.5a0.8 .8 0 0 1 1.5 .5v14a0.8 .8 0 0 1 -1.5 .5l-3.5 -4.5"></path></svg>
                                            </a>
                                        </div>
                                        <div class="col-auto">
                                            <a href='#' class="btn btn-ghost-primary w-100 btn-icon" id="music_saved_btn">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M19.5 12.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572"></path></svg></a>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>`;
    document.getElementById('app_container').innerHTML = music_div;
    //var height = document.getElementById("tablet_div").clientHeight;
    //document.getElementById('music_card').style.height = (height - 1) + "px";

    //const player_offset = document.getElementById("music_player_div").offsetHeight;
    //document.getElementById('music_queue_list').style.maxHeight = "" + player_offset + "px";
    //document.getElementById('music_queue_list').style.overflowY = "auto";
    
    UpdateQueue();

    if (current_music_url != null) {
        InitializePlaySound(current_music_url)
    }

    $("#music_url_input").keyup(function(event) {
        if (event.keyCode === 13) {
            var url = document.getElementById('music_url_input').value
            PlaySound(url);
        }
    });


    var unpacked_saved_songs = JSON.parse(saved_songs)

    if (unpacked_saved_songs != null) {
        for (let i = 0; i < unpacked_saved_songs.length; i++) {
            const song_url = unpacked_saved_songs[i];

            $.getJSON('https://noembed.com/embed',
                {format: 'json', url: song_url}, function (data) {
                    if (data.title != undefined) {
                        var title = data.title
                        if (title.length > 40) {
                            title = title.slice(0, 38) + '...'
                        }
                        var div = `<div class="col-sm-6 col-lg-3">
                            <div class="card card-sm" style="background-color: transparent;">
                                <a onClick="PlaySound('${song_url}')" style="display: flex; align-items: center; justify-content: center; border-radius: 10px;">
                                    <img src="${data.thumbnail_url}" style="object-fit: cover; max-height: 200px; max-width: 307px; border-radius: 10px;" class="card-img-top">
                                </a>
                                <div class="d-flex align-items-center p-2">
                                    <div>
                                        <div>${title}</div>
                                        <div class="text-muted">${data.author_name}</div>
                                    </div>
                                    <div class="ms-auto">
                                        <a onClick="RemoveSavedSong(this)" song_url="${song_url}" class="ms-3 text-muted">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-heart-filled" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                <path d="M6.979 3.074a6 6 0 0 1 4.988 1.425l.037 .033l.034 -.03a6 6 0 0 1 4.733 -1.44l.246 .036a6 6 0 0 1 3.364 10.008l-.18 .185l-.048 .041l-7.45 7.379a1 1 0 0 1 -1.313 .082l-.094 -.082l-7.493 -7.422a6 6 0 0 1 3.176 -10.215z" stroke-width="0" fill="#fff"></path>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>`
                        document.getElementById('saved_songs_row').insertAdjacentHTML('beforeend', div);
                    }
                }
            );
        }
    }

    document.getElementById('music_saved_btn').onclick = function () {
        if (!document.getElementById("music_saved_btn").classList.contains('btn-active')) {
            document.getElementById("music_saved_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-heart-filled" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M6.979 3.074a6 6 0 0 1 4.988 1.425l.037 .033l.034 -.03a6 6 0 0 1 4.733 -1.44l.246 .036a6 6 0 0 1 3.364 10.008l-.18 .185l-.048 .041l-7.45 7.379a1 1 0 0 1 -1.313 .082l-.094 -.082l-7.493 -7.422a6 6 0 0 1 3.176 -10.215z" stroke-width="0" fill="#fff"></path>
            </svg>`
            document.getElementById("music_saved_btn").classList.add('btn-active');
            
            $.post('https://complete_carplay/saveSong', JSON.stringify({
                song: current_music_url
            }));
    
            $.getJSON('https://noembed.com/embed',
                {format: 'json', url: current_music_url}, function (data) {
                    if (data.title != undefined) {
                        var title = data.title
                        if (title.length > 40) {
                            title = title.slice(0, 38) + '...'
                        }
                        var div = `<div class="col-sm-6 col-lg-3">
                            <div class="card card-sm" style="background-color: transparent;">
                                <a onClick="PlaySound('${current_music_url}')" style="display: flex; align-items: center; justify-content: center; border-radius: 10px;">
                                    <img src="${data.thumbnail_url}" style="object-fit: cover; max-height: 200px; max-width: 307px; border-radius: 10px;" class="card-img-top">
                                </a>
                                <div class="d-flex align-items-center p-2">
                                    <div>
                                        <div>${title}</div>
                                        <div class="text-muted">${data.author_name}</div>
                                    </div>
                                    <div class="ms-auto">
                                        <a onClick="RemoveSavedSong(this)" song_url="${current_music_url}" class="ms-3 text-muted">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-heart-filled" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                <path d="M6.979 3.074a6 6 0 0 1 4.988 1.425l.037 .033l.034 -.03a6 6 0 0 1 4.733 -1.44l.246 .036a6 6 0 0 1 3.364 10.008l-.18 .185l-.048 .041l-7.45 7.379a1 1 0 0 1 -1.313 .082l-.094 -.082l-7.493 -7.422a6 6 0 0 1 3.176 -10.215z" stroke-width="0" fill="#fff"></path>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>`                    
                        document.getElementById('saved_songs_row').insertAdjacentHTML('beforeend', div);
                    }
                }
            );
        } else {
            var elements = document.querySelectorAll('[song_url]');
            for (var i = 0; i < elements.length; i++) {
                if (elements[i].getAttribute('song_url') == current_music_url) {
                    elements[i].parentElement.parentElement.parentElement.parentElement.innerHTML = ''
                }
            }
            
            $.post('https://complete_carplay/removeSavedSong', JSON.stringify({
                soung_url: current_music_url
            }));

            document.getElementById("music_saved_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M19.5 12.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572"></path></svg></a>`
            document.getElementById("music_saved_btn").classList.remove('btn-active');
        }
    };

    document.getElementById('music_play_btn').onclick = function () {
        if (playing == true) {
            document.getElementById("music_play_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-play" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M7 4v16l13 -8z"></path>
            </svg>`;
            document.getElementById("music_play_btn").classList.remove('btn-active');
            playing = false;
            $.post('https://complete_carplay/stopSound', JSON.stringify({}));
        } else {
            document.getElementById("music_play_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-pause" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <rect x="6" y="5" width="4" height="14" rx="1"></rect>
                <rect x="14" y="5" width="4" height="14" rx="1"></rect>
            </svg>`;
            document.getElementById("music_play_btn").classList.add('btn-active');
            playing = true;
            $.post('https://complete_carplay/resumeSound', JSON.stringify({}));
        }
    };

    document.getElementById('music_upVolume_btn').onclick = function () {
        $.post('https://complete_carplay/volumeSound', JSON.stringify({
            change: 'up'
        }));
    };

    document.getElementById('music_downVolume_btn').onclick = function () {
        $.post('https://complete_carplay/volumeSound', JSON.stringify({
            change: 'down'
        }));
    };

    document.getElementById('music_prev_btn').onclick = function () {
        $.post('https://complete_carplay/changeTime', JSON.stringify({
            change: 'prev'
        }));

        /*
        if (request && request.transport) request.transport.abort();
        var url = current_music_url + '&t='+(current_music_time-10)+'s'
        var query = { url : url.trim() };
        request = $.ajax({
            url: " https://noembed.com/embed",
            type: "GET",
            data: query,
            dataType: "json",
            success: function(res) {
            if (res.html) {
                $('#music_iframe').html(res.html);
                $('#music_iframe:first-child').removeAttr("width").removeAttr("height");
                document.getElementById('music_iframe').firstChild.style.cssText = `pointer-events: none; aspect-ratio: 16 / 9; border-radius: 10px; max-width: 960px; max-height: 540px;" width="100%`
                document.getElementById('music_iframe').firstChild.src += '&autoplay=1&showinfo=0&controls=0'
            }
            else {
                var error = "<span class='status error'>"+(res.error || "Unknown error. :-(")+"</span>";
                $('#music_iframe').html(error);
            }
            },
            error: function() {
                $('#music_iframe').html('Error connecting to noembed server. :-(');
            }
        });
        */
    };

    document.getElementById('music_forw_btn').onclick = function () {
        $.post('https://complete_carplay/changeTime', JSON.stringify({
            change: 'forw'
        }));

        /*
        if (request && request.transport) request.transport.abort();
        var url = current_music_url + '&t='+(current_music_time+10)+'s'
        var query = { url : url.trim() };
        request = $.ajax({
            url: " https://noembed.com/embed",
            type: "GET",
            data: query,
            dataType: "json",
            success: function(res) {
            if (res.html) {
                $('#music_iframe').html(res.html);
                $('#music_iframe:first-child').removeAttr("width").removeAttr("height");
                document.getElementById('music_iframe').firstChild.style.cssText = `pointer-events: none; aspect-ratio: 16 / 9; border-radius: 10px; max-width: 960px; max-height: 540px;" width="100%`
                document.getElementById('music_iframe').firstChild.src += '&autoplay=1&showinfo=0&controls=0'
            }
            else {
                var error = "<span class='status error'>"+(res.error || "Unknown error. :-(")+"</span>";
                $('#music_iframe').html(error);
            }
            },
            error: function() {
                $('#music_iframe').html('Error connecting to noembed server. :-(');
            }
        });
        */
    };
}

function RemoveSavedSong(target) {
    var soung_url = target.getAttribute('song_url')

    $.post('https://complete_carplay/removeSavedSong', JSON.stringify({
        soung_url: soung_url
    }));

    target.parentElement.parentElement.parentElement.parentElement.innerHTML = ''

    if (current_music_url == soung_url) {
        document.getElementById("music_saved_btn").classList.remove('btn-active');
    }
}

function secondsToFormat(totalSeconds) {
    const minutes = Math.floor(totalSeconds / 60);
    const seconds = totalSeconds % 60;
    function padTo2Digits(num) {
        return num.toString().padStart(2, '0');
    }
    const result = `${minutes}:${padTo2Digits(seconds)}`;
    return result;
}

function secondsToFormatHours(totalSeconds) {
    var date = new Date(0);
    date.setSeconds(totalSeconds);
    var timeString = date.toISOString().substr(11, 8);
    return timeString;
}

function UpdateTimestamp(time, max_time) {
    if (document.getElementById('music_player_current_time') != null) {
        if (max_time >= 3600) {
            document.getElementById('music_player_current_time').innerHTML = secondsToFormatHours(time);
            document.getElementById('music_player_max_time').innerHTML = secondsToFormatHours(max_time);
        } else {
            document.getElementById('music_player_current_time').innerHTML = secondsToFormat(time);
            document.getElementById('music_player_max_time').innerHTML = secondsToFormat(max_time);
        }
        current_music_time = time
        var time_perc = Math.round((time / max_time) * 100)
        document.getElementById('music_player_progressbar').style.width = time_perc + "%";
        document.getElementById('music_player_progressbar').setAttribute('aria-valuenow', time_perc);
    }
}

function ResetMusicPlayer() {
    document.getElementById("music_play_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-play" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
        <path d="M7 4v16l13 -8z"></path>
    </svg>`;
    document.getElementById("music_play_btn").classList.remove('btn-active');
    document.getElementById('music_player_song_name').innerHTML = "Track";
    document.getElementById('music_player_img').style.backgroundImage = "url(./img/youtube.jpg)";
    document.getElementById('music_url_input').value = "";
    document.getElementById('music_player_current_time').innerHTML = "00:00";
    document.getElementById('music_player_max_time').innerHTML = "00:00";
    document.getElementById('music_player_progressbar').style.width = "0%";
    document.getElementById('music_player_progressbar').setAttribute('aria-valuenow', '0');
}

function UpdateQueue() {
    var song_divs = new Map();

    if (music_queue.length > 0) {
        for (let i = 0; i < music_queue.length; i++) {
            const song = music_queue[i];

            $.getJSON('https://noembed.com/embed',
                {format: 'json', url: song}, function (data) {
                    if (data.title != undefined) {
                        var song_div = `<div id="${song}" class="list-group-item music-queue-group-item animate__animated animate__fadeIn">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <span class="avatar avatar-md" style="background-image: url(${data.thumbnail_url})"></span>
                                </div>
                                <div class="col text-truncate data-title-queue-song">
                                    <h3 class="d-block" style="color: #FFF; margin-bottom: 0;">${data.title}</h3>
                                    <div class="text-muted">${data.author_name}</div>
                                </div>
                                <div class="col-auto">    
                                    <a onclick="PlaySoundFromQueue('${song}')">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-play" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M7 4v16l13 -8z"></path></svg>
                                    </a>
                                </div>
                            </div>
                        </div>`;
                        
                        song_divs.set(song, song_div);
                    }
                }
            );
        }
        
        setTimeout(() => {
            document.getElementById('music_queue_list').innerHTML = "";
            for (let i = 0; i < music_queue.length; i++) {
                const song = music_queue[i];
                document.getElementById('music_queue_list').insertAdjacentHTML('beforeend', song_divs.get(song));
            }
        }, 500);

        responsive_changed = false
    } else {
        document.getElementById('music_queue_list').innerHTML = "";
    }
}

function PlaySoundFromQueue(url) {
    if (playing == true) {
        document.getElementById("music_play_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-play" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
            <path d="M7 4v16l13 -8z"></path>
        </svg>`;
        document.getElementById("music_play_btn").classList.remove('btn-active');
    }

    setTimeout(function () {
        var song_index = 0;
        for (let i = 0; i < music_queue.length; i++) {
            const song = music_queue[i];
            if (song == url) {
                song_index = i;
            }
        }
        
        if (music_queue.length > 1) {
            music_queue = music_queue.slice(song_index + 1, music_queue.length);
        } else {
            music_queue = [];
        }
        
        $.post('https://complete_carplay/setQueue', JSON.stringify({
            queue: music_queue,
            url: url
        }));

        document.getElementById("music_play_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-pause" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
            <rect x="6" y="5" width="4" height="14" rx="1"></rect>
            <rect x="14" y="5" width="4" height="14" rx="1"></rect>
        </svg>`;
        document.getElementById("music_play_btn").classList.add('btn-active');
        
        if (saved_songs.includes(url)) {
            document.getElementById("music_saved_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-heart-filled" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M6.979 3.074a6 6 0 0 1 4.988 1.425l.037 .033l.034 -.03a6 6 0 0 1 4.733 -1.44l.246 .036a6 6 0 0 1 3.364 10.008l-.18 .185l-.048 .041l-7.45 7.379a1 1 0 0 1 -1.313 .082l-.094 -.082l-7.493 -7.422a6 6 0 0 1 3.176 -10.215z" stroke-width="0" fill="#fff"></path>
            </svg>`
            document.getElementById("music_saved_btn").classList.add('btn-active');
        } else {
            document.getElementById("music_saved_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M19.5 12.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572"></path></svg></a>`
            document.getElementById("music_saved_btn").classList.remove('btn-active');
        }

        current_music_url = url;
        playing = true;
        $.post('https://complete_carplay/resumeSound', JSON.stringify({}));
    }, 1000);
}

var request = null;
function PlaySound(url) {
    if (url != null && music_queue.includes(url) == false && blacklist.includes(url) == false) {
        if (playing == true) {
            $.getJSON('https://noembed.com/embed',
                {format: 'json', url: url}, function (data) {
                    if (data.title != undefined) {
                        $.post('https://complete_carplay/addToQueue', JSON.stringify({
                            url: url
                        }));
                        document.getElementById('music_url_input').value = '';
                    }
                }
            );
        } else {
            $.getJSON('https://noembed.com/embed',
                {format: 'json', url: url}, function (data) {
                    if (data.title != undefined) {
                        document.getElementById('music_player_song_name').innerHTML = data.title;
                        document.getElementById('music_player_author').innerHTML = data.author_name;
                        document.getElementById('music_player_img').style.backgroundImage = "url('"+data.thumbnail_url+"')";
                        playing = true;
                        current_music_url = url;
                        
                        $.post('https://complete_carplay/playSound', JSON.stringify({
                            url: url
                        }));

                        document.getElementById("music_play_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-pause" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                            <rect x="6" y="5" width="4" height="14" rx="1"></rect>
                            <rect x="14" y="5" width="4" height="14" rx="1"></rect>
                        </svg>`;
                        document.getElementById("music_play_btn").classList.add('btn-active');

                        if (saved_songs.includes(current_music_url)) {
                            document.getElementById("music_saved_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-heart-filled" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                <path d="M6.979 3.074a6 6 0 0 1 4.988 1.425l.037 .033l.034 -.03a6 6 0 0 1 4.733 -1.44l.246 .036a6 6 0 0 1 3.364 10.008l-.18 .185l-.048 .041l-7.45 7.379a1 1 0 0 1 -1.313 .082l-.094 -.082l-7.493 -7.422a6 6 0 0 1 3.176 -10.215z" stroke-width="0" fill="#fff"></path>
                            </svg>`
                            document.getElementById("music_saved_btn").classList.add('btn-active');
                        } else {
                            document.getElementById("music_saved_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M19.5 12.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572"></path></svg></a>`
                            document.getElementById("music_saved_btn").classList.remove('btn-active');
                        }

                        document.getElementById('music_url_input').value = '';
                        /*
                        if (request && request.transport) request.transport.abort();
                        var query = { url : url.trim() };
                        request = $.ajax({
                            url: " https://noembed.com/embed",
                            type: "GET",
                            data: query,
                            dataType: "json",
                            success: function(res) {
                            if (res.html) {
                                $('#music_iframe').html(res.html);
                                $('#music_iframe:first-child').removeAttr("width").removeAttr("height");
                                document.getElementById('music_iframe').firstChild.style.cssText = `pointer-events: none; aspect-ratio: 16 / 9; border-radius: 10px; max-width: 960px; max-height: 540px;" width="100%`
                                document.getElementById('music_iframe').firstChild.src += '&autoplay=1&showinfo=0&controls=0'
                                document.getElementById('music_iframe').firstChild.muted = true
                                $('audio,video').each(function(){
                                    $(this).volume = 0.0;
                                });
                            }
                            else {
                                var error = "<span class='status error'>"+(res.error || "Unknown error. :-(")+"</span>";
                                $('#music_iframe').html(error);
                            }
                            },
                            error: function() {
                                $('#music_iframe').html('Error connecting to noembed server. :-(');
                            }
                        });
                        */
                    }
                }
            );
        }
    }
}

function InitializePlaySound(url) {
    $.getJSON('https://noembed.com/embed',
        {format: 'json', url: url}, function (data) {
            document.getElementById('music_player_song_name').innerHTML = data.title;
            document.getElementById('music_player_author').innerHTML = data.author_name;
            document.getElementById('music_player_img').style.backgroundImage = "url('"+data.thumbnail_url+"')";

            /*
            if (request && request.transport) request.transport.abort();
            current_music_url = url
            var query = { url : url.trim() };
            request = $.ajax({
                url: " https://noembed.com/embed",
                type: "GET",
                data: query,
                dataType: "json",
                success: function(res) {
                if (res.html) {
                    $('#music_iframe').html(res.html);
                    $('#music_iframe:first-child').removeAttr("width").removeAttr("height");
                    document.getElementById('music_iframe').firstChild.style.cssText = `pointer-events: none; aspect-ratio: 16 / 9; border-radius: 10px; max-width: 960px; max-height: 540px;" width="100%`
                    document.getElementById('music_iframe').firstChild.src += '&autoplay=1&showinfo=0&controls=0'
                    document.getElementById('music_iframe').firstChild.muted = true
                }
                else {
                    var error = "<span class='status error'>"+(res.error || "Unknown error. :-(")+"</span>";
                    $('#music_iframe').html(error);
                }
                },
                error: function() {
                    $('#music_iframe').html('Error connecting to noembed server. :-(');
                }
            });
            */
        }
    );

    if (playing == true) {
        document.getElementById("music_play_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-player-pause" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
            <rect x="6" y="5" width="4" height="14" rx="1"></rect>
            <rect x="14" y="5" width="4" height="14" rx="1"></rect>
        </svg>`;
        document.getElementById("music_play_btn").classList.add('btn-active');
    }

    if (saved_songs.includes(current_music_url)) {
        document.getElementById("music_saved_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-heart-filled" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
            <path d="M6.979 3.074a6 6 0 0 1 4.988 1.425l.037 .033l.034 -.03a6 6 0 0 1 4.733 -1.44l.246 .036a6 6 0 0 1 3.364 10.008l-.18 .185l-.048 .041l-7.45 7.379a1 1 0 0 1 -1.313 .082l-.094 -.082l-7.493 -7.422a6 6 0 0 1 3.176 -10.215z" stroke-width="0" fill="#fff"></path>
        </svg>`
        document.getElementById("music_saved_btn").classList.add('btn-active');
    } else {
        document.getElementById("music_saved_btn").innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#fff" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M19.5 12.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572"></path></svg></a>`
        document.getElementById("music_saved_btn").classList.remove('btn-active');
    }
}

function ActionsApp() {
    var actions_div = `<div class="row row-deck row-cards" style="--tblr-gutter-x: 0.5rem; --tblr-gutter-y: 0.5rem;" id="actions_app_container">
        <h3>Actions</h3>
        <div class="col-lg-12">
            <div id="actions_card" class="w-100">
                <div class="row" id="actions_row" style="--tblr-gutter-y: 2rem;">
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="headlight" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a>
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none" stroke="none"></path><g fill="#ffffff"><path d="M83.54953,30.78c-15.0961,0 -33.7725,5.93156 -49.0957,15.55031c-15.3232,9.63211 -27.61383,23.20523 -27.61383,39.16969c0,15.96445 12.29062,29.53758 27.61383,39.16969c15.3232,9.61875 33.99961,15.55031 49.0957,15.55031c3.94101,0 7.38773,-2.23102 9.79242,-5.38383c2.40469,-3.13945 4.10133,-7.2675 5.43727,-12.15703c2.67188,-9.80578 3.82078,-22.83117 3.82078,-37.17914c0,-14.34797 -1.1489,-27.37336 -3.82078,-37.17914c-1.33594,-4.88953 -3.03258,-9.01758 -5.43727,-12.15703c-2.40469,-3.15281 -5.85141,-5.38383 -9.79242,-5.38383zM83.54953,37.62c1.54969,0 2.79211,0.64125 4.35515,2.68523c1.56305,2.04399 3.07266,5.43727 4.275,9.81914c2.39133,8.77711 3.58031,21.40172 3.58031,35.37563c0,13.97391 -1.18898,26.59852 -3.58031,35.37563c-1.20234,4.38187 -2.71195,7.77516 -4.275,9.81914c-1.56305,2.04398 -2.80547,2.68523 -4.35515,2.68523c-13.2525,0 -31.22086,-5.5575 -45.4486,-14.50828c-14.24109,-8.95078 -24.42094,-21.02766 -24.42094,-33.37172c0,-12.34406 10.17985,-24.42094 24.42094,-33.37172c14.22773,-8.95078 32.1961,-14.50828 45.4486,-14.50828zM107.16891,41.04c0.74813,2.09742 1.38938,4.4086 1.99055,6.84h55.00055v-6.84zM111.5775,61.56c0.25383,2.19094 0.48094,4.47539 0.65461,6.84h51.92789v-6.84zM112.80656,82.08c0.01336,1.14891 0.05344,2.24438 0.05344,3.42c0,1.17562 -0.04008,2.2711 -0.05344,3.42h51.35344v-6.84zM112.23211,102.6c-0.17367,2.36461 -0.40078,4.64906 -0.65461,6.84h52.5825v-6.84zM109.17281,123.12c-0.60117,2.43141 -1.25578,4.74258 -2.0039,6.84h56.99109v-6.84z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Headlight</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="interior" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a>
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none" stroke="none"></path><g fill="#ffffff" stroke="none"><path d="M85.17938,3.31313c-0.14695,0.02672 -0.2939,0.0668 -0.4275,0.10688c-1.58977,0.3607 -2.71195,1.79016 -2.67187,3.42v13.68c-0.01336,1.22906 0.62789,2.37797 1.69664,3.00586c1.06875,0.61453 2.37797,0.61453 3.44672,0c1.06875,-0.62789 1.71,-1.7768 1.69664,-3.00586v-13.68c0.04008,-0.98859 -0.3607,-1.93711 -1.06875,-2.60508c-0.7214,-0.68133 -1.69664,-1.01531 -2.67187,-0.9218zM34.30688,24.3675c-0.10687,0.02672 -0.21375,0.0668 -0.32062,0.10687c-1.22906,0.25383 -2.21765,1.17563 -2.57836,2.37797c-0.3607,1.20234 -0.02672,2.51156 0.86836,3.39328l9.72563,9.72562c0.82828,1.01531 2.15086,1.48289 3.43336,1.18898c1.26914,-0.2939 2.2711,-1.29586 2.565,-2.565c0.29391,-1.2825 -0.17367,-2.60508 -1.18898,-3.43336l-9.72563,-9.72563c-0.64125,-0.68133 -1.52297,-1.05539 -2.45813,-1.06875c-0.10687,0 -0.21375,0 -0.32062,0zM135.945,24.3675c-0.14695,0.02672 -0.2939,0.0668 -0.4275,0.10687c-0.61453,0.16031 -1.16227,0.4943 -1.60312,0.96188l-9.72563,9.72563c-1.01531,0.82828 -1.48289,2.15086 -1.18898,3.43336c0.2939,1.26914 1.29586,2.2711 2.565,2.565c1.2825,0.29391 2.60508,-0.17367 3.43336,-1.18898l9.72563,-9.72562c1.06875,-1.01531 1.37602,-2.60508 0.74812,-3.94102c-0.64125,-1.3493 -2.05734,-2.12414 -3.52687,-1.93711zM85.5,30.78c-26.39812,0 -47.88,21.48187 -47.88,47.88c0,16.72594 7.49461,27.96117 14.535,36.23063c3.52687,4.12805 6.93352,7.6282 9.29812,10.6875c2.36461,3.0593 3.52688,5.50406 3.52688,7.80187v12.07688c-0.45422,0.94852 -0.45422,2.04398 0,2.9925v2.03062c0,5.6243 4.6357,10.26 10.26,10.26h2.67188c1.88367,2.08406 4.56891,3.42 7.58813,3.42c3.01922,0 5.70445,-1.33594 7.58813,-3.42h2.67187c5.6243,0 10.26,-4.6357 10.26,-10.26v-2.77875c0.09352,-0.45422 0.09352,-0.93515 0,-1.38938v-12.93187c0,-2.29781 1.16227,-4.7693 3.52688,-7.80187c2.36461,-3.03258 5.77125,-6.46594 9.29812,-10.58062c7.04039,-8.22938 14.535,-19.46461 14.535,-36.3375c0,-26.39812 -21.48187,-47.88 -47.88,-47.88zM85.5,37.62c22.71094,0 41.04,18.32906 41.04,41.04c0,14.90906 -6.18539,24.20719 -12.825,31.95563c-3.31312,3.87422 -6.74648,7.25414 -9.51188,10.79438c-2.03063,2.60508 -3.4868,5.45063 -4.275,8.55h-28.85625c-0.7882,-3.09938 -2.24437,-5.93156 -4.275,-8.55c-2.76539,-3.56695 -6.19875,-7.00031 -9.51188,-10.90125c-6.63961,-7.78852 -12.825,-17.1 -12.825,-31.84875c0,-22.71094 18.32906,-41.04 41.04,-41.04zM12.71813,75.24c-1.88367,0.26719 -3.20625,2.01727 -2.93906,3.90094c0.26719,1.88367 2.01727,3.20625 3.90094,2.93906h13.68c1.22906,0.01336 2.37797,-0.62789 3.00586,-1.69664c0.61453,-1.06875 0.61453,-2.37797 0,-3.44672c-0.62789,-1.06875 -1.7768,-1.71 -3.00586,-1.69664h-13.68c-0.10688,0 -0.21375,0 -0.32062,0c-0.10688,0 -0.21375,0 -0.32062,0c-0.10688,0 -0.21375,0 -0.32062,0zM142.67813,75.24c-1.88367,0.26719 -3.20625,2.01727 -2.93906,3.90094c0.26719,1.88367 2.01727,3.20625 3.90094,2.93906h13.68c1.22906,0.01336 2.37797,-0.62789 3.00586,-1.69664c0.61453,-1.06875 0.61453,-2.37797 0,-3.44672c-0.62789,-1.06875 -1.7768,-1.71 -3.00586,-1.69664h-13.68c-0.10688,0 -0.21375,0 -0.32062,0c-0.10688,0 -0.21375,0 -0.32063,0c-0.10688,0 -0.21375,0 -0.32063,0zM44.0325,116.28c-0.77484,0.10688 -1.49625,0.4943 -2.03063,1.06875l-9.72563,9.72563c-1.01531,0.82828 -1.48289,2.15086 -1.18898,3.43336c0.2939,1.26914 1.29586,2.2711 2.565,2.565c1.2825,0.29391 2.60508,-0.17367 3.43336,-1.18898l9.72563,-9.72562c1.01531,-0.97523 1.32258,-2.48484 0.77485,-3.7807c-0.53438,-1.29586 -1.83024,-2.12414 -3.23297,-2.09742c-0.10688,0 -0.21375,0 -0.32062,0zM125.89875,116.28c-1.2825,0.22711 -2.31117,1.16227 -2.67187,2.40469c-0.3607,1.25578 0.01336,2.59172 0.96188,3.47344l9.72563,9.72562c0.82828,1.01531 2.15086,1.48289 3.43336,1.18898c1.26914,-0.2939 2.2711,-1.29586 2.565,-2.565c0.29391,-1.2825 -0.17367,-2.60508 -1.18898,-3.43336l-9.72563,-9.72563c-0.64125,-0.68133 -1.52297,-1.05539 -2.45812,-1.06875c-0.10687,0 -0.21375,0 -0.32062,0c-0.10688,0 -0.21375,0 -0.32063,0zM71.82,136.8h27.36v6.84h-17.1c-0.10688,0 -0.21375,0 -0.32063,0c-0.10687,0 -0.21375,0 -0.32062,0c-1.88367,0.17367 -3.27305,1.85695 -3.09937,3.74063c0.17367,1.88367 1.85695,3.27305 3.74062,3.09937h17.1c0,1.93711 -1.48289,3.42 -3.42,3.42h-20.52c-1.93711,0 -3.42,-1.48289 -3.42,-3.42c1.22906,0.01336 2.37797,-0.62789 3.00586,-1.69664c0.61453,-1.06875 0.61453,-2.37797 0,-3.44672c-0.62789,-1.06875 -1.7768,-1.71 -3.00586,-1.69664z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Interior lights</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="windows" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a>
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M85.5,6.84c-32.07586,0 -58.14,26.06414 -58.14,58.14v41.04c0,32.07586 26.06414,58.14 58.14,58.14c32.07586,0 58.14,-26.06414 58.14,-58.14v-41.04c0,-32.07586 -26.06414,-58.14 -58.14,-58.14zM85.5,13.68c28.37531,0 51.3,22.92469 51.3,51.3v41.04c0,28.37531 -22.92469,51.3 -51.3,51.3c-28.37531,0 -51.3,-22.92469 -51.3,-51.3v-41.04c0,-28.37531 22.92469,-51.3 51.3,-51.3zM85.5,20.52c-24.51445,0 -44.46,19.94555 -44.46,44.46v41.04c0,24.51445 19.94555,44.46 44.46,44.46c24.51445,0 44.46,-19.94555 44.46,-44.46v-41.04c0,-24.51445 -19.94555,-44.46 -44.46,-44.46zM85.5,27.36c15.97781,0 29.48414,9.92602 34.94813,23.94h-69.89625c5.46398,-14.01398 18.97031,-23.94 34.94813,-23.94zM74.59875,37.62c-1.88367,0.17367 -3.27305,1.85695 -3.09937,3.74063c0.17367,1.88367 1.85695,3.27305 3.74062,3.09938h20.52c1.22906,0.01336 2.37797,-0.62789 3.00586,-1.69664c0.61453,-1.06875 0.61453,-2.37797 0,-3.44672c-0.62789,-1.06875 -1.7768,-1.71 -3.00586,-1.69664h-20.52c-0.10688,0 -0.21375,0 -0.32062,0c-0.10688,0 -0.21375,0 -0.32063,0zM48.52125,58.14h73.9575c0.40078,2.21766 0.64125,4.50211 0.64125,6.84v22.55062c-1.68328,-0.97523 -3.54023,-1.61648 -5.5575,-1.81687c-1.37602,-2.36461 -3.29977,-4.26164 -5.77125,-5.45063c-2.24437,-6.84 -8.46984,-11.86312 -16.03125,-11.86312c-6.94687,0 -12.73148,4.26164 -15.39,10.26c-5.33039,0 -9.37828,3.80742 -10.90125,8.65688c-4.48875,2.23102 -7.90875,6.51937 -7.90875,11.86312c0,7.52133 6.15867,13.68 13.68,13.68h41.04c2.33789,0 4.48875,-0.66797 6.4125,-1.71c-2.4982,18.36914 -18.12867,32.49 -37.1925,32.49c-20.8139,0 -37.62,-16.80609 -37.62,-37.62v-41.04c0,-2.33789 0.24047,-4.62234 0.64125,-6.84zM95.76,75.24c4.95633,0 9.0443,3.50016 10.04625,8.1225l0.4275,1.92375l1.81687,0.53437c2.05735,0.65461 3.67383,2.25773 4.38188,4.275l0.855,2.45812l2.565,-0.10688c0.58781,-0.04008 0.74813,-0.10687 0.4275,-0.10687c3.82078,0 6.84,3.01922 6.84,6.84c0,3.82078 -3.01922,6.84 -6.84,6.84h-41.04c-3.82078,0 -6.84,-3.01922 -6.84,-6.84c0,-3.01922 1.89703,-5.4907 4.59562,-6.4125l2.03063,-0.74813l0.32062,-2.03063c0.33398,-2.53828 2.39133,-4.48875 5.02313,-4.48875c0.34735,0 0.77485,0.08016 1.2825,0.21375l3.31312,0.855l0.855,-3.42c1.06875,-4.52883 5.04985,-7.90875 9.93937,-7.90875z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Windows</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="trunk" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a>
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none" stroke="none"></path><g fill="#ffffff" stroke="none"><path d="M52.04145,41.04c-5.89007,0 -11.37894,3.03769 -14.5016,8.03566l-8.71031,13.94051l-5.07656,-5.83137c-2.78315,-3.20084 -6.55359,-5.14329 -10.51383,-5.70445c-3.96024,-0.56117 -8.11272,0.25449 -11.67609,2.55832c-1.03542,0.65939 -1.63807,1.82309 -1.57913,3.04923c0.05894,1.22614 0.77044,2.32666 1.86434,2.88369c1.0939,0.55703 2.40241,0.48514 3.42869,-0.18839c4.30973,-2.78637 9.94588,-1.98833 13.31262,1.88367l6.15199,7.07379l-10.05961,1.43613c-8.3972,1.20204 -14.68195,8.44318 -14.68195,16.92633v22.33688c0,5.6258 4.6342,10.26 10.26,10.26h3.73395c1.64239,9.67354 10.08054,17.1 20.20605,17.1c10.12551,0 18.56366,-7.42646 20.20605,-17.1h62.18789c1.64239,9.67354 10.08055,17.1 20.20605,17.1c10.12551,0 18.56366,-7.42646 20.20605,-17.1h3.73395c5.6258,0 10.26,-4.6342 10.26,-10.26v-19.19074c0,-8.33517 -6.06815,-15.49342 -14.28785,-16.86621l-28.25508,-4.70918l-15.59707,-20.79387c-3.22671,-4.30371 -8.30032,-6.84 -13.68,-6.84zM52.04145,47.88h47.13855c3.23188,0 6.27185,1.51716 8.20934,4.10133l17.23359,22.9848l30.96703,5.1634c4.96782,0.82969 8.57004,5.08269 8.57004,10.11973v19.19074c0,1.9324 -1.4876,3.42 -3.42,3.42h-6.26555c-1.00158,-0.17064 -2.02717,0.11283 -2.79895,0.77361c-0.77178,0.66078 -1.20984,1.63048 -1.1955,2.64639c0,7.5986 -6.0814,13.68 -13.68,13.68c-7.5986,0 -13.68,-6.0814 -13.68,-13.68c0.01266,-0.92443 -0.34944,-1.81461 -1.0038,-2.46771c-0.65436,-0.6531 -1.54523,-1.01349 -2.46963,-0.99905c-0.16568,0.00359 -0.33088,0.01922 -0.4943,0.04676h-67.27781c-1.00158,-0.17064 -2.02717,0.11283 -2.79895,0.77361c-0.77178,0.66078 -1.20984,1.63048 -1.1955,2.64639c0,7.5986 -6.0814,13.68 -13.68,13.68c-7.5986,0 -13.68,-6.0814 -13.68,-13.68c0.01266,-0.92443 -0.34944,-1.81461 -1.0038,-2.46771c-0.65436,-0.6531 -1.54523,-1.01349 -2.46963,-0.99905c-0.16568,0.00359 -0.33088,0.01922 -0.4943,0.04676h-6.29227c-1.9324,0 -3.42,-1.4876 -3.42,-3.42v-22.33688c0,-5.12845 3.73291,-9.43296 8.81051,-10.1598l13.76684,-1.96383l13.92715,-22.27676c1.87737,-3.00482 5.15467,-4.82273 8.69695,-4.82273z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Trunk</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="door1" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a>
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M85.5,6.84c-12.41086,0 -23.41898,1.62985 -31.51477,3.31312c-9.49851,1.99055 -16.36523,10.38023 -16.36523,20.10586v29.88492l-29.77805,29.77805c-0.89508,0.855 -1.25578,2.1375 -0.93516,3.32648c0.30727,1.20235 1.24242,2.1375 2.44477,2.44477c1.18898,0.32063 2.47148,-0.04008 3.32648,-0.93516l24.94195,-24.94195v76.8164c0,6.13195 4.11469,11.55586 10.04625,13.1857c7.30758,2.01727 19.70508,4.3418 37.83375,4.3418c18.12867,0 30.52617,-2.32453 37.83375,-4.3418c5.93156,-1.62985 10.04625,-7.05375 10.04625,-13.1857v-76.8164l24.94195,24.94195c0.855,0.89508 2.1375,1.25578 3.32648,0.93516c1.20235,-0.30727 2.1375,-1.24242 2.44477,-2.44477c0.32063,-1.18898 -0.04008,-2.47148 -0.93516,-3.32648l-29.77805,-29.77805v-29.88492c0,-9.72563 -6.86672,-18.11531 -16.36523,-20.10586c-8.09578,-1.68328 -19.10391,-3.31312 -31.51477,-3.31312zM85.5,13.68c11.80969,0 22.37695,1.56305 30.11203,3.17953c6.39914,1.33594 10.92797,6.88008 10.92797,13.39945v30.83344c-0.04008,0.30727 -0.04008,0.60117 0,0.90844v84.63164c0,3.09938 -2.01727,5.77125 -5.00977,6.58617h-0.01336c-6.7064,1.85695 -18.46265,4.10133 -36.01687,4.10133c-17.55422,0 -29.31047,-2.24437 -36.01687,-4.10133h-0.01336c-2.9925,-0.81492 -5.00977,-3.4868 -5.00977,-6.58617v-84.645c0.04008,-0.30727 0.04008,-0.62789 0,-0.93515v-30.79336c0,-6.51938 4.52883,-12.07687 10.92797,-13.39945c7.74844,-1.61649 18.30234,-3.17953 30.11203,-3.17953zM85.5,54.72c-17.26031,0 -30.78,3.42 -30.78,3.42l13.68,17.1h34.2l13.68,-17.1c0,0 -13.51969,-3.42 -30.78,-3.42zM54.72,69.94969v58.0732l10.26,-10.26v-35.68289zM116.28,69.94969l-10.26,12.13031v35.68289l10.26,10.26zM68.4,123.12l-13.68,13.68c0,0 10.47375,3.42 30.76664,3.42c20.29289,0 30.79336,-3.42 30.79336,-3.42l-13.68,-13.68z"></path></g></g></svg>                            </a>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Door 1</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="door2" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a>
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M85.5,6.84c-12.41086,0 -23.41898,1.62985 -31.51477,3.31312c-9.49851,1.99055 -16.36523,10.38023 -16.36523,20.10586v29.88492l-29.77805,29.77805c-0.89508,0.855 -1.25578,2.1375 -0.93516,3.32648c0.30727,1.20235 1.24242,2.1375 2.44477,2.44477c1.18898,0.32063 2.47148,-0.04008 3.32648,-0.93516l24.94195,-24.94195v76.8164c0,6.13195 4.11469,11.55586 10.04625,13.1857c7.30758,2.01727 19.70508,4.3418 37.83375,4.3418c18.12867,0 30.52617,-2.32453 37.83375,-4.3418c5.93156,-1.62985 10.04625,-7.05375 10.04625,-13.1857v-76.8164l24.94195,24.94195c0.855,0.89508 2.1375,1.25578 3.32648,0.93516c1.20235,-0.30727 2.1375,-1.24242 2.44477,-2.44477c0.32063,-1.18898 -0.04008,-2.47148 -0.93516,-3.32648l-29.77805,-29.77805v-29.88492c0,-9.72563 -6.86672,-18.11531 -16.36523,-20.10586c-8.09578,-1.68328 -19.10391,-3.31312 -31.51477,-3.31312zM85.5,13.68c11.80969,0 22.37695,1.56305 30.11203,3.17953c6.39914,1.33594 10.92797,6.88008 10.92797,13.39945v30.83344c-0.04008,0.30727 -0.04008,0.60117 0,0.90844v84.63164c0,3.09938 -2.01727,5.77125 -5.00977,6.58617h-0.01336c-6.7064,1.85695 -18.46265,4.10133 -36.01687,4.10133c-17.55422,0 -29.31047,-2.24437 -36.01687,-4.10133h-0.01336c-2.9925,-0.81492 -5.00977,-3.4868 -5.00977,-6.58617v-84.645c0.04008,-0.30727 0.04008,-0.62789 0,-0.93515v-30.79336c0,-6.51938 4.52883,-12.07687 10.92797,-13.39945c7.74844,-1.61649 18.30234,-3.17953 30.11203,-3.17953zM85.5,54.72c-17.26031,0 -30.78,3.42 -30.78,3.42l13.68,17.1h34.2l13.68,-17.1c0,0 -13.51969,-3.42 -30.78,-3.42zM54.72,69.94969v58.0732l10.26,-10.26v-35.68289zM116.28,69.94969l-10.26,12.13031v35.68289l10.26,10.26zM68.4,123.12l-13.68,13.68c0,0 10.47375,3.42 30.76664,3.42c20.29289,0 30.79336,-3.42 30.79336,-3.42l-13.68,-13.68z"></path></g></g></svg>                            </a>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Door 2</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="door3" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a >
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M85.5,6.84c-12.41086,0 -23.41898,1.62985 -31.51477,3.31312c-9.49851,1.99055 -16.36523,10.38023 -16.36523,20.10586v29.88492l-29.77805,29.77805c-0.89508,0.855 -1.25578,2.1375 -0.93516,3.32648c0.30727,1.20235 1.24242,2.1375 2.44477,2.44477c1.18898,0.32063 2.47148,-0.04008 3.32648,-0.93516l24.94195,-24.94195v76.8164c0,6.13195 4.11469,11.55586 10.04625,13.1857c7.30758,2.01727 19.70508,4.3418 37.83375,4.3418c18.12867,0 30.52617,-2.32453 37.83375,-4.3418c5.93156,-1.62985 10.04625,-7.05375 10.04625,-13.1857v-76.8164l24.94195,24.94195c0.855,0.89508 2.1375,1.25578 3.32648,0.93516c1.20235,-0.30727 2.1375,-1.24242 2.44477,-2.44477c0.32063,-1.18898 -0.04008,-2.47148 -0.93516,-3.32648l-29.77805,-29.77805v-29.88492c0,-9.72563 -6.86672,-18.11531 -16.36523,-20.10586c-8.09578,-1.68328 -19.10391,-3.31312 -31.51477,-3.31312zM85.5,13.68c11.80969,0 22.37695,1.56305 30.11203,3.17953c6.39914,1.33594 10.92797,6.88008 10.92797,13.39945v30.83344c-0.04008,0.30727 -0.04008,0.60117 0,0.90844v84.63164c0,3.09938 -2.01727,5.77125 -5.00977,6.58617h-0.01336c-6.7064,1.85695 -18.46265,4.10133 -36.01687,4.10133c-17.55422,0 -29.31047,-2.24437 -36.01687,-4.10133h-0.01336c-2.9925,-0.81492 -5.00977,-3.4868 -5.00977,-6.58617v-84.645c0.04008,-0.30727 0.04008,-0.62789 0,-0.93515v-30.79336c0,-6.51938 4.52883,-12.07687 10.92797,-13.39945c7.74844,-1.61649 18.30234,-3.17953 30.11203,-3.17953zM85.5,54.72c-17.26031,0 -30.78,3.42 -30.78,3.42l13.68,17.1h34.2l13.68,-17.1c0,0 -13.51969,-3.42 -30.78,-3.42zM54.72,69.94969v58.0732l10.26,-10.26v-35.68289zM116.28,69.94969l-10.26,12.13031v35.68289l10.26,10.26zM68.4,123.12l-13.68,13.68c0,0 10.47375,3.42 30.76664,3.42c20.29289,0 30.79336,-3.42 30.79336,-3.42l-13.68,-13.68z"></path></g></g></svg>                            </a>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Door 3</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="door4" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a >
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M85.5,6.84c-12.41086,0 -23.41898,1.62985 -31.51477,3.31312c-9.49851,1.99055 -16.36523,10.38023 -16.36523,20.10586v29.88492l-29.77805,29.77805c-0.89508,0.855 -1.25578,2.1375 -0.93516,3.32648c0.30727,1.20235 1.24242,2.1375 2.44477,2.44477c1.18898,0.32063 2.47148,-0.04008 3.32648,-0.93516l24.94195,-24.94195v76.8164c0,6.13195 4.11469,11.55586 10.04625,13.1857c7.30758,2.01727 19.70508,4.3418 37.83375,4.3418c18.12867,0 30.52617,-2.32453 37.83375,-4.3418c5.93156,-1.62985 10.04625,-7.05375 10.04625,-13.1857v-76.8164l24.94195,24.94195c0.855,0.89508 2.1375,1.25578 3.32648,0.93516c1.20235,-0.30727 2.1375,-1.24242 2.44477,-2.44477c0.32063,-1.18898 -0.04008,-2.47148 -0.93516,-3.32648l-29.77805,-29.77805v-29.88492c0,-9.72563 -6.86672,-18.11531 -16.36523,-20.10586c-8.09578,-1.68328 -19.10391,-3.31312 -31.51477,-3.31312zM85.5,13.68c11.80969,0 22.37695,1.56305 30.11203,3.17953c6.39914,1.33594 10.92797,6.88008 10.92797,13.39945v30.83344c-0.04008,0.30727 -0.04008,0.60117 0,0.90844v84.63164c0,3.09938 -2.01727,5.77125 -5.00977,6.58617h-0.01336c-6.7064,1.85695 -18.46265,4.10133 -36.01687,4.10133c-17.55422,0 -29.31047,-2.24437 -36.01687,-4.10133h-0.01336c-2.9925,-0.81492 -5.00977,-3.4868 -5.00977,-6.58617v-84.645c0.04008,-0.30727 0.04008,-0.62789 0,-0.93515v-30.79336c0,-6.51938 4.52883,-12.07687 10.92797,-13.39945c7.74844,-1.61649 18.30234,-3.17953 30.11203,-3.17953zM85.5,54.72c-17.26031,0 -30.78,3.42 -30.78,3.42l13.68,17.1h34.2l13.68,-17.1c0,0 -13.51969,-3.42 -30.78,-3.42zM54.72,69.94969v58.0732l10.26,-10.26v-35.68289zM116.28,69.94969l-10.26,12.13031v35.68289l10.26,10.26zM68.4,123.12l-13.68,13.68c0,0 10.47375,3.42 30.76664,3.42c20.29289,0 30.79336,-3.42 30.79336,-3.42l-13.68,-13.68z"></path></g></g></svg>                            </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Door 4</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="lock" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a >
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M85.5,10.26c-22.69758,0 -41.04,18.34242 -41.04,41.04v17.1h-13.68c-5.6243,0 -10.26,4.6357 -10.26,10.26v82.08c0,5.6243 4.6357,10.26 10.26,10.26h109.44c5.6243,0 10.26,-4.6357 10.26,-10.26v-82.08c0,-5.6243 -4.6357,-10.26 -10.26,-10.26h-13.68v-17.1c0,-22.69758 -18.34242,-41.04 -41.04,-41.04zM85.5,17.1c19.03711,0 34.2,15.16289 34.2,34.2v17.1h-68.4v-17.1c0,-19.03711 15.16289,-34.2 34.2,-34.2zM30.78,75.24h109.44c1.89703,0 3.42,1.52297 3.42,3.42v82.08c0,1.89703 -1.52297,3.42 -3.42,3.42h-109.44c-1.89703,0 -3.42,-1.52297 -3.42,-3.42v-82.08c0,-1.89703 1.52297,-3.42 3.42,-3.42zM85.5,102.6c-5.81133,0 -10.26,4.44867 -10.26,10.26c0,3.07266 1.36266,5.77125 3.42,7.48125v9.61875c0,3.76735 3.07266,6.84 6.84,6.84c3.76735,0 6.84,-3.07265 6.84,-6.84v-9.61875c2.05735,-1.71 3.42,-4.40859 3.42,-7.48125c0,-5.81133 -4.44867,-10.26 -10.26,-10.26z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Lock doors</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="cruise" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a >
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M85.5,13.68c-39.4839,0 -71.82,32.3361 -71.82,71.82c0,39.4839 32.3361,71.82 71.82,71.82c5.89608,0 11.60406,-0.80306 17.1,-2.16422v-6.43254c-5.46516,1.4877 -11.17998,2.35125 -17.1,2.35125c-36.081,0 -65.57449,-29.49349 -65.57449,-65.57449c0,-36.081 29.49349,-65.57449 65.57449,-65.57449c36.081,0 65.57449,29.49349 65.57449,65.57449c0,1.87074 -0.12665,3.70776 -0.28055,5.53746c2.1204,0.8892 4.08898,2.05868 5.89816,3.42668c0.36936,-2.94462 0.62789,-5.92034 0.62789,-8.96414c0,-39.4839 -32.3361,-71.82 -71.82,-71.82zM85.5,30.78c-30.18492,0 -54.72,24.53508 -54.72,54.72c0,30.18492 24.53508,54.72 54.72,54.72c5.97474,0 11.7135,-0.99709 17.1,-2.77207v-21.16793c0,-7.2846 6.3954,-13.68 13.68,-13.68h0.26719c1.49112,-2.57868 3.39136,-4.88376 5.61094,-6.84h-5.87812c-11.1834,0 -20.52,9.3366 -20.52,20.52v16.00453c-3.3174,0.7182 -6.7374,1.09547 -10.26,1.09547c-3.5226,0 -6.9426,-0.37727 -10.26,-1.09547v-16.00453c0,-11.286 -8.8578,-20.52 -20.52,-20.52h-16.00453c-0.7182,-3.3174 -1.09547,-6.7374 -1.09547,-10.26c0,-2.4624 0.17153,-4.88766 0.54773,-7.24746c10.9098,-1.2312 18.12787,-5.06668 24.14707,-8.62348c7.3188,-4.3434 12.7542,-8.06906 23.1852,-8.06906c10.431,0 16.3492,3.79326 23.8732,8.10246c6.0876,3.4884 13.23326,7.2504 23.45906,8.55c0.342,2.394 0.54773,4.82514 0.54773,7.28754c0,1.48086 -0.10383,2.93196 -0.23379,4.3752c2.2059,-0.58824 4.50954,-0.93484 6.90012,-0.94852c0.0684,-1.13886 0.17367,-2.27072 0.17367,-3.42668c0,-30.18492 -24.53508,-54.72 -54.72,-54.72zM85.5,37.62c21.4092,0 39.53386,14.0538 45.65566,33.4452c-7.6266,-1.3338 -12.95806,-4.20126 -18.39586,-7.34766c-7.353,-4.2408 -15.1188,-8.99754 -27.2598,-8.99754c-12.141,0 -19.53087,4.82434 -26.67867,9.03094c-5.3694,3.1806 -10.76819,6.12233 -19.01039,7.38773c6.1218,-19.4256 24.24566,-33.51867 45.68906,-33.51867zM85.5,68.4c-9.405,0 -17.1,7.695 -17.1,17.1c0,9.405 7.695,17.1 17.1,17.1c9.405,0 17.1,-7.695 17.1,-17.1c0,-9.405 -7.695,-17.1 -17.1,-17.1zM85.5,75.24c5.70456,0 10.26,4.55544 10.26,10.26c0,5.70456 -4.55544,10.26 -10.26,10.26c-5.70456,0 -10.26,-4.55544 -10.26,-10.26c0,-5.70456 4.55544,-10.26 10.26,-10.26zM140.22,95.76c-11.286,0 -20.52,9.57333 -20.52,21.20133v6.15867h-3.76066c-3.762,0 -6.49934,3.07934 -6.49934,6.49934v34.54066c0,3.762 2.73734,6.84 6.49934,6.84h48.56133c3.42,0 6.49934,-3.07934 6.49934,-6.49934v-34.88133c0,-3.42 -2.73734,-6.49934 -6.49934,-6.49934h-3.76066v-6.15867c0,-11.628 -9.234,-21.20133 -20.52,-21.20133zM40.79953,102.6h13.92047c8.1738,0 13.68,5.814 13.68,13.68v13.92047c-12.6882,-4.8222 -22.77827,-14.91227 -27.60047,-27.60047zM140.22,102.6c7.524,0 13.68,6.49533 13.68,14.36133v6.15867h-27.36v-6.15867c0,-7.866 6.156,-14.36133 13.68,-14.36133zM116.28,129.96h47.88v34.2h-47.88zM140.22,140.22c-2.736,0 -4.78934,2.05334 -4.78934,4.78934c0,1.368 0.684,2.394 1.71,3.42v4.44199c0,1.71 1.36934,3.07933 3.07934,3.07933c1.71,0 3.07934,-1.36933 3.07934,-3.07933v-4.44199c1.026,-1.026 1.71,-2.052 1.71,-3.42c0,-2.736 -2.05334,-4.78934 -4.78934,-4.78934z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Cruise control</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="seat1" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a >
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M66.48961,3.42c-4.40371,0 -8.34056,2.84 -9.7323,7.02035l-2.28445,6.84c-2.17927,6.54792 2.83745,13.49965 9.73899,13.49965h4.18816v10.26h-8.6168c-9.18097,0 -17.29989,6.07353 -20.0257,14.90906v0.00668l-7.93547,25.76355c-3.83162,12.44156 -5.27562,19.26114 -3.97441,32.47664l0.89508,9.09773c-0.85532,-0.10184 -1.71541,-0.17367 -2.58504,-0.17367c-7.46007,0 -13.38412,6.6118 -12.3641,13.97391l1.45617,10.45371c0.5518,3.9625 3.02514,7.4048 6.59285,9.23801l18.28898,9.39832c1.78094,0.91631 3.75744,1.39605 5.76457,1.39605h79.20773c2.00713,0 3.98415,-0.47759 5.76457,-1.39605l18.2823,-9.39832c3.56771,-1.83321 6.04773,-5.27551 6.59953,-9.23801l1.44949,-10.45371c1.02485,-7.36285 -4.89735,-13.97391 -12.35742,-13.97391c-0.86963,0 -1.72952,0.07194 -2.58504,0.17367l0.8884,-9.09773c1.30121,-13.21551 -0.14279,-20.03508 -3.97442,-32.47664l-7.93547,-25.76355c-2.71868,-8.83877 -10.84473,-14.91574 -20.0257,-14.91574h-8.61012v-10.26h4.18816c6.90153,0 11.91825,-6.95173 9.73899,-13.49965l-2.28445,-6.84v-0.00668c-1.39253,-4.17505 -5.33047,-7.01367 -9.7323,-7.01367zM66.48961,10.26h38.02078c1.48552,0 2.7768,0.92758 3.24633,2.33789l2.27777,6.84c0.76877,2.30988 -0.81126,4.50211 -3.24633,4.50211h-42.57633c-2.43507,0 -4.0151,-2.19223 -3.24633,-4.50211l2.27777,-6.84c0.46873,-1.40793 1.7608,-2.33789 3.24633,-2.33789zM75.24,30.78h20.52v10.26h-20.52zM59.7832,47.88h51.42691c6.17483,0 11.62902,4.0481 13.48629,10.08633l7.93547,25.76355c3.78131,12.2782 4.94366,17.24047 3.70723,29.79808l-1.16226,11.84309c-1.75794,0.86804 -3.4007,1.9761 -4.87617,3.30645l-1.70332,1.52965c-1.37548,1.23363 -3.24228,1.73355 -5.04984,1.32926h-0.00668c-7.94525,-1.77313 -22.1026,-5.28363 -38.03414,-5.28363c-15.93204,0 -30.09806,3.51444 -38.04082,5.28363c-1.81517,0.40551 -3.68743,-0.0906 -5.05652,-1.32258l-1.71,-1.54301v0.00668c-1.47875,-1.33069 -3.1231,-2.43792 -4.88285,-3.30645l-1.16227,-11.84309c-1.23643,-12.55761 -0.07408,-17.51989 3.70723,-29.79808l7.93547,-25.76355c1.86383,-6.04163 7.31146,-10.08633 13.48629,-10.08633zM85.52672,58.14c-9.13341,-0.0106 -18.46986,1.86121 -23.25867,8.10246c-0.9998,1.30273 -1.37208,2.52078 -1.84359,4.10133c-0.47152,1.58055 -0.90144,3.45755 -1.3159,5.59758c-0.82891,4.28005 -1.58309,9.59939 -2.23102,15.26309c-1.29584,11.32739 -2.15754,23.93579 -2.15754,31.91555h6.84c0,-7.47522 0.8483,-20.0399 2.11746,-31.13402c0.63458,-5.54706 1.37664,-10.75112 2.15086,-14.74875c0.38711,-1.99881 0.78546,-3.6956 1.15559,-4.93629c0.37012,-1.24069 0.85284,-2.0857 0.70805,-1.89703c2.15721,-2.81149 9.89911,-5.43305 17.82808,-5.42391c7.92897,0.00923 15.66727,2.65946 17.78801,5.42391c-0.1448,-0.18868 0.33793,0.65634 0.70805,1.89703c0.37013,1.24069 0.76848,2.93748 1.15559,4.93629c0.77422,3.99763 1.51628,9.20169 2.15086,14.74875c1.26916,11.09413 2.11746,23.6588 2.11746,31.13402h6.84c0,-7.97976 -0.8617,-20.58815 -2.15754,-31.91555c-0.64792,-5.6637 -1.40211,-10.98304 -2.23102,-15.26309c-0.41446,-2.14003 -0.84438,-4.01703 -1.3159,-5.59758c-0.47151,-1.58054 -0.8438,-2.79859 -1.84359,-4.10133c-4.76372,-6.20964 -14.07183,-8.09194 -23.20524,-8.10246zM26.15766,129.96c3.69988,0 7.25611,1.36231 9.96609,3.80074h0.00668l1.70332,1.53633c1.86293,1.67635 4.19732,2.48095 6.62625,2.83219v22.2634c-0.39946,-0.10589 -0.8271,-0.09762 -1.19566,-0.28723h-0.00668l-18.28899,-9.39832c-1.62385,-0.83439 -2.7041,-2.36611 -2.94574,-4.10133l-1.45617,-10.45371c-0.45742,-3.30145 2.07961,-6.19207 5.5909,-6.19207zM144.84234,129.96c3.51129,0 6.04365,2.89135 5.58422,6.19207l-1.45617,10.45371c-0.24166,1.73522 -1.32189,3.26694 -2.94574,4.10133l-18.28899,9.39832h-0.00668c-0.36464,0.1881 -0.79168,0.18162 -1.18898,0.28723v-22.27008c2.43024,-0.35091 4.76135,-1.15293 6.62625,-2.82551l1.71668,-1.53633c2.7015,-2.43561 6.25954,-3.80074 9.95941,-3.80074zM85.50668,133.09277c13.80769,0 25.95898,2.77773 34.19332,4.6357v23.01152h-68.4v-23.01152c8.2362,-1.85608 20.399,-4.6357 34.20668,-4.6357z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Seat 1</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="seat2" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a >
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M66.48961,3.42c-4.40371,0 -8.34056,2.84 -9.7323,7.02035l-2.28445,6.84c-2.17927,6.54792 2.83745,13.49965 9.73899,13.49965h4.18816v10.26h-8.6168c-9.18097,0 -17.29989,6.07353 -20.0257,14.90906v0.00668l-7.93547,25.76355c-3.83162,12.44156 -5.27562,19.26114 -3.97441,32.47664l0.89508,9.09773c-0.85532,-0.10184 -1.71541,-0.17367 -2.58504,-0.17367c-7.46007,0 -13.38412,6.6118 -12.3641,13.97391l1.45617,10.45371c0.5518,3.9625 3.02514,7.4048 6.59285,9.23801l18.28898,9.39832c1.78094,0.91631 3.75744,1.39605 5.76457,1.39605h79.20773c2.00713,0 3.98415,-0.47759 5.76457,-1.39605l18.2823,-9.39832c3.56771,-1.83321 6.04773,-5.27551 6.59953,-9.23801l1.44949,-10.45371c1.02485,-7.36285 -4.89735,-13.97391 -12.35742,-13.97391c-0.86963,0 -1.72952,0.07194 -2.58504,0.17367l0.8884,-9.09773c1.30121,-13.21551 -0.14279,-20.03508 -3.97442,-32.47664l-7.93547,-25.76355c-2.71868,-8.83877 -10.84473,-14.91574 -20.0257,-14.91574h-8.61012v-10.26h4.18816c6.90153,0 11.91825,-6.95173 9.73899,-13.49965l-2.28445,-6.84v-0.00668c-1.39253,-4.17505 -5.33047,-7.01367 -9.7323,-7.01367zM66.48961,10.26h38.02078c1.48552,0 2.7768,0.92758 3.24633,2.33789l2.27777,6.84c0.76877,2.30988 -0.81126,4.50211 -3.24633,4.50211h-42.57633c-2.43507,0 -4.0151,-2.19223 -3.24633,-4.50211l2.27777,-6.84c0.46873,-1.40793 1.7608,-2.33789 3.24633,-2.33789zM75.24,30.78h20.52v10.26h-20.52zM59.7832,47.88h51.42691c6.17483,0 11.62902,4.0481 13.48629,10.08633l7.93547,25.76355c3.78131,12.2782 4.94366,17.24047 3.70723,29.79808l-1.16226,11.84309c-1.75794,0.86804 -3.4007,1.9761 -4.87617,3.30645l-1.70332,1.52965c-1.37548,1.23363 -3.24228,1.73355 -5.04984,1.32926h-0.00668c-7.94525,-1.77313 -22.1026,-5.28363 -38.03414,-5.28363c-15.93204,0 -30.09806,3.51444 -38.04082,5.28363c-1.81517,0.40551 -3.68743,-0.0906 -5.05652,-1.32258l-1.71,-1.54301v0.00668c-1.47875,-1.33069 -3.1231,-2.43792 -4.88285,-3.30645l-1.16227,-11.84309c-1.23643,-12.55761 -0.07408,-17.51989 3.70723,-29.79808l7.93547,-25.76355c1.86383,-6.04163 7.31146,-10.08633 13.48629,-10.08633zM85.52672,58.14c-9.13341,-0.0106 -18.46986,1.86121 -23.25867,8.10246c-0.9998,1.30273 -1.37208,2.52078 -1.84359,4.10133c-0.47152,1.58055 -0.90144,3.45755 -1.3159,5.59758c-0.82891,4.28005 -1.58309,9.59939 -2.23102,15.26309c-1.29584,11.32739 -2.15754,23.93579 -2.15754,31.91555h6.84c0,-7.47522 0.8483,-20.0399 2.11746,-31.13402c0.63458,-5.54706 1.37664,-10.75112 2.15086,-14.74875c0.38711,-1.99881 0.78546,-3.6956 1.15559,-4.93629c0.37012,-1.24069 0.85284,-2.0857 0.70805,-1.89703c2.15721,-2.81149 9.89911,-5.43305 17.82808,-5.42391c7.92897,0.00923 15.66727,2.65946 17.78801,5.42391c-0.1448,-0.18868 0.33793,0.65634 0.70805,1.89703c0.37013,1.24069 0.76848,2.93748 1.15559,4.93629c0.77422,3.99763 1.51628,9.20169 2.15086,14.74875c1.26916,11.09413 2.11746,23.6588 2.11746,31.13402h6.84c0,-7.97976 -0.8617,-20.58815 -2.15754,-31.91555c-0.64792,-5.6637 -1.40211,-10.98304 -2.23102,-15.26309c-0.41446,-2.14003 -0.84438,-4.01703 -1.3159,-5.59758c-0.47151,-1.58054 -0.8438,-2.79859 -1.84359,-4.10133c-4.76372,-6.20964 -14.07183,-8.09194 -23.20524,-8.10246zM26.15766,129.96c3.69988,0 7.25611,1.36231 9.96609,3.80074h0.00668l1.70332,1.53633c1.86293,1.67635 4.19732,2.48095 6.62625,2.83219v22.2634c-0.39946,-0.10589 -0.8271,-0.09762 -1.19566,-0.28723h-0.00668l-18.28899,-9.39832c-1.62385,-0.83439 -2.7041,-2.36611 -2.94574,-4.10133l-1.45617,-10.45371c-0.45742,-3.30145 2.07961,-6.19207 5.5909,-6.19207zM144.84234,129.96c3.51129,0 6.04365,2.89135 5.58422,6.19207l-1.45617,10.45371c-0.24166,1.73522 -1.32189,3.26694 -2.94574,4.10133l-18.28899,9.39832h-0.00668c-0.36464,0.1881 -0.79168,0.18162 -1.18898,0.28723v-22.27008c2.43024,-0.35091 4.76135,-1.15293 6.62625,-2.82551l1.71668,-1.53633c2.7015,-2.43561 6.25954,-3.80074 9.95941,-3.80074zM85.50668,133.09277c13.80769,0 25.95898,2.77773 34.19332,4.6357v23.01152h-68.4v-23.01152c8.2362,-1.85608 20.399,-4.6357 34.20668,-4.6357z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Seat 2</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="seat3" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a >
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M66.48961,3.42c-4.40371,0 -8.34056,2.84 -9.7323,7.02035l-2.28445,6.84c-2.17927,6.54792 2.83745,13.49965 9.73899,13.49965h4.18816v10.26h-8.6168c-9.18097,0 -17.29989,6.07353 -20.0257,14.90906v0.00668l-7.93547,25.76355c-3.83162,12.44156 -5.27562,19.26114 -3.97441,32.47664l0.89508,9.09773c-0.85532,-0.10184 -1.71541,-0.17367 -2.58504,-0.17367c-7.46007,0 -13.38412,6.6118 -12.3641,13.97391l1.45617,10.45371c0.5518,3.9625 3.02514,7.4048 6.59285,9.23801l18.28898,9.39832c1.78094,0.91631 3.75744,1.39605 5.76457,1.39605h79.20773c2.00713,0 3.98415,-0.47759 5.76457,-1.39605l18.2823,-9.39832c3.56771,-1.83321 6.04773,-5.27551 6.59953,-9.23801l1.44949,-10.45371c1.02485,-7.36285 -4.89735,-13.97391 -12.35742,-13.97391c-0.86963,0 -1.72952,0.07194 -2.58504,0.17367l0.8884,-9.09773c1.30121,-13.21551 -0.14279,-20.03508 -3.97442,-32.47664l-7.93547,-25.76355c-2.71868,-8.83877 -10.84473,-14.91574 -20.0257,-14.91574h-8.61012v-10.26h4.18816c6.90153,0 11.91825,-6.95173 9.73899,-13.49965l-2.28445,-6.84v-0.00668c-1.39253,-4.17505 -5.33047,-7.01367 -9.7323,-7.01367zM66.48961,10.26h38.02078c1.48552,0 2.7768,0.92758 3.24633,2.33789l2.27777,6.84c0.76877,2.30988 -0.81126,4.50211 -3.24633,4.50211h-42.57633c-2.43507,0 -4.0151,-2.19223 -3.24633,-4.50211l2.27777,-6.84c0.46873,-1.40793 1.7608,-2.33789 3.24633,-2.33789zM75.24,30.78h20.52v10.26h-20.52zM59.7832,47.88h51.42691c6.17483,0 11.62902,4.0481 13.48629,10.08633l7.93547,25.76355c3.78131,12.2782 4.94366,17.24047 3.70723,29.79808l-1.16226,11.84309c-1.75794,0.86804 -3.4007,1.9761 -4.87617,3.30645l-1.70332,1.52965c-1.37548,1.23363 -3.24228,1.73355 -5.04984,1.32926h-0.00668c-7.94525,-1.77313 -22.1026,-5.28363 -38.03414,-5.28363c-15.93204,0 -30.09806,3.51444 -38.04082,5.28363c-1.81517,0.40551 -3.68743,-0.0906 -5.05652,-1.32258l-1.71,-1.54301v0.00668c-1.47875,-1.33069 -3.1231,-2.43792 -4.88285,-3.30645l-1.16227,-11.84309c-1.23643,-12.55761 -0.07408,-17.51989 3.70723,-29.79808l7.93547,-25.76355c1.86383,-6.04163 7.31146,-10.08633 13.48629,-10.08633zM85.52672,58.14c-9.13341,-0.0106 -18.46986,1.86121 -23.25867,8.10246c-0.9998,1.30273 -1.37208,2.52078 -1.84359,4.10133c-0.47152,1.58055 -0.90144,3.45755 -1.3159,5.59758c-0.82891,4.28005 -1.58309,9.59939 -2.23102,15.26309c-1.29584,11.32739 -2.15754,23.93579 -2.15754,31.91555h6.84c0,-7.47522 0.8483,-20.0399 2.11746,-31.13402c0.63458,-5.54706 1.37664,-10.75112 2.15086,-14.74875c0.38711,-1.99881 0.78546,-3.6956 1.15559,-4.93629c0.37012,-1.24069 0.85284,-2.0857 0.70805,-1.89703c2.15721,-2.81149 9.89911,-5.43305 17.82808,-5.42391c7.92897,0.00923 15.66727,2.65946 17.78801,5.42391c-0.1448,-0.18868 0.33793,0.65634 0.70805,1.89703c0.37013,1.24069 0.76848,2.93748 1.15559,4.93629c0.77422,3.99763 1.51628,9.20169 2.15086,14.74875c1.26916,11.09413 2.11746,23.6588 2.11746,31.13402h6.84c0,-7.97976 -0.8617,-20.58815 -2.15754,-31.91555c-0.64792,-5.6637 -1.40211,-10.98304 -2.23102,-15.26309c-0.41446,-2.14003 -0.84438,-4.01703 -1.3159,-5.59758c-0.47151,-1.58054 -0.8438,-2.79859 -1.84359,-4.10133c-4.76372,-6.20964 -14.07183,-8.09194 -23.20524,-8.10246zM26.15766,129.96c3.69988,0 7.25611,1.36231 9.96609,3.80074h0.00668l1.70332,1.53633c1.86293,1.67635 4.19732,2.48095 6.62625,2.83219v22.2634c-0.39946,-0.10589 -0.8271,-0.09762 -1.19566,-0.28723h-0.00668l-18.28899,-9.39832c-1.62385,-0.83439 -2.7041,-2.36611 -2.94574,-4.10133l-1.45617,-10.45371c-0.45742,-3.30145 2.07961,-6.19207 5.5909,-6.19207zM144.84234,129.96c3.51129,0 6.04365,2.89135 5.58422,6.19207l-1.45617,10.45371c-0.24166,1.73522 -1.32189,3.26694 -2.94574,4.10133l-18.28899,9.39832h-0.00668c-0.36464,0.1881 -0.79168,0.18162 -1.18898,0.28723v-22.27008c2.43024,-0.35091 4.76135,-1.15293 6.62625,-2.82551l1.71668,-1.53633c2.7015,-2.43561 6.25954,-3.80074 9.95941,-3.80074zM85.50668,133.09277c13.80769,0 25.95898,2.77773 34.19332,4.6357v23.01152h-68.4v-23.01152c8.2362,-1.85608 20.399,-4.6357 34.20668,-4.6357z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Seat 3</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 text-center">
                        <div id="seat4" onclick="ActionActive(this)" class="card action-icons-app" style="border-radius: 10px;">
                            <div class="card-body">
                                <a>
                                    <svg style="height: 3rem; margin-bottom: 0.5rem;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 170"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,171.99654v-171.99654h171.99654v171.99654z" fill="none"></path><g fill="#ffffff"><path d="M66.48961,3.42c-4.40371,0 -8.34056,2.84 -9.7323,7.02035l-2.28445,6.84c-2.17927,6.54792 2.83745,13.49965 9.73899,13.49965h4.18816v10.26h-8.6168c-9.18097,0 -17.29989,6.07353 -20.0257,14.90906v0.00668l-7.93547,25.76355c-3.83162,12.44156 -5.27562,19.26114 -3.97441,32.47664l0.89508,9.09773c-0.85532,-0.10184 -1.71541,-0.17367 -2.58504,-0.17367c-7.46007,0 -13.38412,6.6118 -12.3641,13.97391l1.45617,10.45371c0.5518,3.9625 3.02514,7.4048 6.59285,9.23801l18.28898,9.39832c1.78094,0.91631 3.75744,1.39605 5.76457,1.39605h79.20773c2.00713,0 3.98415,-0.47759 5.76457,-1.39605l18.2823,-9.39832c3.56771,-1.83321 6.04773,-5.27551 6.59953,-9.23801l1.44949,-10.45371c1.02485,-7.36285 -4.89735,-13.97391 -12.35742,-13.97391c-0.86963,0 -1.72952,0.07194 -2.58504,0.17367l0.8884,-9.09773c1.30121,-13.21551 -0.14279,-20.03508 -3.97442,-32.47664l-7.93547,-25.76355c-2.71868,-8.83877 -10.84473,-14.91574 -20.0257,-14.91574h-8.61012v-10.26h4.18816c6.90153,0 11.91825,-6.95173 9.73899,-13.49965l-2.28445,-6.84v-0.00668c-1.39253,-4.17505 -5.33047,-7.01367 -9.7323,-7.01367zM66.48961,10.26h38.02078c1.48552,0 2.7768,0.92758 3.24633,2.33789l2.27777,6.84c0.76877,2.30988 -0.81126,4.50211 -3.24633,4.50211h-42.57633c-2.43507,0 -4.0151,-2.19223 -3.24633,-4.50211l2.27777,-6.84c0.46873,-1.40793 1.7608,-2.33789 3.24633,-2.33789zM75.24,30.78h20.52v10.26h-20.52zM59.7832,47.88h51.42691c6.17483,0 11.62902,4.0481 13.48629,10.08633l7.93547,25.76355c3.78131,12.2782 4.94366,17.24047 3.70723,29.79808l-1.16226,11.84309c-1.75794,0.86804 -3.4007,1.9761 -4.87617,3.30645l-1.70332,1.52965c-1.37548,1.23363 -3.24228,1.73355 -5.04984,1.32926h-0.00668c-7.94525,-1.77313 -22.1026,-5.28363 -38.03414,-5.28363c-15.93204,0 -30.09806,3.51444 -38.04082,5.28363c-1.81517,0.40551 -3.68743,-0.0906 -5.05652,-1.32258l-1.71,-1.54301v0.00668c-1.47875,-1.33069 -3.1231,-2.43792 -4.88285,-3.30645l-1.16227,-11.84309c-1.23643,-12.55761 -0.07408,-17.51989 3.70723,-29.79808l7.93547,-25.76355c1.86383,-6.04163 7.31146,-10.08633 13.48629,-10.08633zM85.52672,58.14c-9.13341,-0.0106 -18.46986,1.86121 -23.25867,8.10246c-0.9998,1.30273 -1.37208,2.52078 -1.84359,4.10133c-0.47152,1.58055 -0.90144,3.45755 -1.3159,5.59758c-0.82891,4.28005 -1.58309,9.59939 -2.23102,15.26309c-1.29584,11.32739 -2.15754,23.93579 -2.15754,31.91555h6.84c0,-7.47522 0.8483,-20.0399 2.11746,-31.13402c0.63458,-5.54706 1.37664,-10.75112 2.15086,-14.74875c0.38711,-1.99881 0.78546,-3.6956 1.15559,-4.93629c0.37012,-1.24069 0.85284,-2.0857 0.70805,-1.89703c2.15721,-2.81149 9.89911,-5.43305 17.82808,-5.42391c7.92897,0.00923 15.66727,2.65946 17.78801,5.42391c-0.1448,-0.18868 0.33793,0.65634 0.70805,1.89703c0.37013,1.24069 0.76848,2.93748 1.15559,4.93629c0.77422,3.99763 1.51628,9.20169 2.15086,14.74875c1.26916,11.09413 2.11746,23.6588 2.11746,31.13402h6.84c0,-7.97976 -0.8617,-20.58815 -2.15754,-31.91555c-0.64792,-5.6637 -1.40211,-10.98304 -2.23102,-15.26309c-0.41446,-2.14003 -0.84438,-4.01703 -1.3159,-5.59758c-0.47151,-1.58054 -0.8438,-2.79859 -1.84359,-4.10133c-4.76372,-6.20964 -14.07183,-8.09194 -23.20524,-8.10246zM26.15766,129.96c3.69988,0 7.25611,1.36231 9.96609,3.80074h0.00668l1.70332,1.53633c1.86293,1.67635 4.19732,2.48095 6.62625,2.83219v22.2634c-0.39946,-0.10589 -0.8271,-0.09762 -1.19566,-0.28723h-0.00668l-18.28899,-9.39832c-1.62385,-0.83439 -2.7041,-2.36611 -2.94574,-4.10133l-1.45617,-10.45371c-0.45742,-3.30145 2.07961,-6.19207 5.5909,-6.19207zM144.84234,129.96c3.51129,0 6.04365,2.89135 5.58422,6.19207l-1.45617,10.45371c-0.24166,1.73522 -1.32189,3.26694 -2.94574,4.10133l-18.28899,9.39832h-0.00668c-0.36464,0.1881 -0.79168,0.18162 -1.18898,0.28723v-22.27008c2.43024,-0.35091 4.76135,-1.15293 6.62625,-2.82551l1.71668,-1.53633c2.7015,-2.43561 6.25954,-3.80074 9.95941,-3.80074zM85.50668,133.09277c13.80769,0 25.95898,2.77773 34.19332,4.6357v23.01152h-68.4v-23.01152c8.2362,-1.85608 20.399,-4.6357 34.20668,-4.6357z"></path></g></g></svg>
                                </a>
                                <div style="line-height: 15px;">
                                    <div><strong>Seat 4</strong></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="margin-top:1rem;">
                    <h3 class="lh-1 mb-0" style="color: #e7e7e7;">Headlight color</h3>
                    <div class="row g-2 align-items-center">
                        <div class="col-6 col-sm-4 col-md-2 col-xl-auto py-3">
                            <div class="card action-icons-app btn-headlight" style="border-radius: 10px;" onclick="ActionActive(this)" color_id="1">
                                <div class="card-body">
                                    <a href="#" class="btn btn-blue w-100">
                                        Blue
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-2 col-xl-auto py-3">
                            <div class="card action-icons-app btn-headlight" style="border-radius: 10px;" onclick="ActionActive(this)" color_id="2">
                                <div class="card-body">
                                    <a href="#" class="btn btn-azure w-100">
                                        Azure
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-2 col-xl-auto py-3">
                            <div class="card action-icons-app btn-headlight" style="border-radius: 10px;" onclick="ActionActive(this)" color_id="11">
                                <div class="card-body">
                                    <a href="#" class="btn btn-purple w-100">
                                        Purple
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-2 col-xl-auto py-3">
                            <div class="card action-icons-app btn-headlight" style="border-radius: 10px;" onclick="ActionActive(this)" color_id="9">
                                <div class="card-body">
                                    <a href="#" class="btn btn-pink w-100">
                                        Pink
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-2 col-xl-auto py-3">
                            <div class="card action-icons-app btn-headlight" style="border-radius: 10px;" onclick="ActionActive(this)" color_id="8">
                                <div class="card-body">
                                    <a href="#" class="btn btn-red w-100">
                                        Red
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-2 col-xl-auto py-3">
                            <div class="card action-icons-app btn-headlight" style="border-radius: 10px;" onclick="ActionActive(this)" color_id="7">
                                <div class="card-body">
                                    <a href="#" class="btn btn-orange w-100">
                                        Orange
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-2 col-xl-auto py-3">
                            <div class="card action-icons-app btn-headlight" style="border-radius: 10px;" onclick="ActionActive(this)" color_id="5">
                                <div class="card-body">
                                    <a class="btn btn-yellow w-100">
                                        Yellow
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-sm-4 col-md-2 col-xl-auto py-3">
                            <div class="card action-icons-app btn-headlight" style="border-radius: 10px;" onclick="ActionActive(this)" color_id="4">
                                <div class="card-body">
                                    <a class="btn btn-green w-100">
                                        Green
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>`;

    document.getElementById('app_container').innerHTML = actions_div;

    var settings = JSON.parse(saved);
    for (let i = 0; i < settings.length; i++) {
        var setting = settings[i];

        if (setting.headlight == true) {
            InitializeActions('headlight')
        }
        if (setting.interior == true) {
            InitializeActions('interior')
        }
        if (setting.windows == true) {
            InitializeActions('windows')
        }
        if (setting.trunk == true) {
            InitializeActions('trunk')
        }
        if (setting.door1 == true) {
            InitializeActions('door1')
        }
        if (setting.door2 == true) {
            InitializeActions('door2')
        }
        if (setting.door3 == true) {
            InitializeActions('door3')
        }
        if (setting.door4 == true) {
            InitializeActions('door4')
        }
        if (setting.lock == true) {
            InitializeActions('lock')
        }
        if (setting.cruise == true) {
            InitializeActions('cruise')
        }
        if (setting.hColor > 0) {
            var actions_a = document.getElementsByClassName('btn-headlight');
            for (let i = 0; i < actions_a.length; i++) {
                const element = actions_a[i];
                if (element.getAttribute('color_id') == setting.hColor) {
                    element.classList.add('action-icons-app-active');
                    element.classList.remove('action-icons-app');
                }
            }
        }
    }
}

function InitializeActions(action) {
    var actions_a = document.getElementById(action);
    actions_a.classList.add('action-icons-app-active');
    actions_a.classList.remove('action-icons-app');
}

function ActionActive(target) {
    var target_id = target.id;

    if (target_id == "seat1" || target_id == "seat2" || target_id == "seat3" || target_id == "seat4") {
        $.post('https://complete_carplay/setSetting', JSON.stringify({
            setting: target_id,
            bool: true
        }));
    } else if (!target.hasAttribute('id')) {
        var element = target

        if (!element.classList.contains('action-icons-app-active')) {
            var actions_a = document.getElementsByClassName('btn-headlight');
            for (let i = 0; i < actions_a.length; i++) {
                const element = actions_a[i];
                if (element.classList.contains('action-icons-app-active')) {
                    element.classList.remove('action-icons-app-active');
                    element.classList.add('action-icons-app');
                }
            }

            element.classList.remove('action-icons-app');
            element.classList.add('action-icons-app-active');

            $.post('https://complete_carplay/setSetting', JSON.stringify({
                setting: 'hColor',
                bool: element.getAttribute('color_id')
            }));
        } else {
            element.classList.remove('action-icons-app-active');
            element.classList.add('action-icons-app');

            $.post('https://complete_carplay/setSetting', JSON.stringify({
                setting: 'hColor',
                bool: 0
            }));
        }
    } else {
        var element = target

        if (!element.classList.contains('action-icons-app-active')) {
            element.classList.remove('action-icons-app');
            element.classList.add('action-icons-app-active');

            $.post('https://complete_carplay/setSetting', JSON.stringify({
                setting: target_id,
                bool: true
            }));
        } else {
            element.classList.remove('action-icons-app-active');
            element.classList.add('action-icons-app');

            $.post('https://complete_carplay/setSetting', JSON.stringify({
                setting: target_id,
                bool: false
            }));
        }
    }
}

function TrunkPost() {
    $.post('https://complete_carplay/trunkCamera', JSON.stringify({}));
}

function TrunkCamera() {
    document.getElementById('main_content').innerHTML = "";
    document.body.style.backgroundImage = "url('img/guide_lines.png')";
    document.body.style.backgroundSize = "contain";
    document.body.style.backgroundRepeat = "no-repeat";
    document.body.style.backgroundPosition = "center center";
}

function RemoveTrunkCamera() {
    if (document.getElementById('main_content').innerHTML == "") {
        document.body.style.backgroundImage = null;
        document.body.style.backgroundSize = null;
        document.body.style.backgroundRepeat = null;
        document.body.style.backgroundPosition = null;
    }
}


function StatusApp() {
    const status_div = `<div style="display: flex; flex-direction: column; justify-content: space-between; height: 100%;" id="status_app_container">
        <h2 class="mb-3">Status</h2>
        <div class="text-center">
            <img src="./img/side.png" width="550rem">
        </div>
        <div class="row" style="--tblr-gutter-y: 1.5rem;">
            <div class="col-lg-8 col-sm-12" style="max-height: 50rem;" id="status_app_cards_col">
                <div class="row" style="--tblr-gutter-y: 0.5rem;--tblr-gutter-x: 0.5rem;">
                    <div class="col-lg-4 col-sm-6">
                        <div class="card" style="border-radius: 13px;">
                            <div class="card-body">
                                <h4 style="display: block; margin: 0 0 1rem; font-weight: 400; color: #e7e7e7;">Engine Temperature</h4>
                                <div class="row">
                                    <div class="col-auto" style="display: flex; align-items: center;">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon-tabler icon-tabler-temperature" style="--tblr-icon-size: 4rem; stroke-width: 1.5;" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                            <path d="M10 13.5a4 4 0 1 0 4 0v-8.5a2 2 0 0 0 -4 0v8.5"></path>
                                            <path d="M10 9l4 0"></path>
                                        </svg>
                                    </div>
                                    <div class="col" style="display: flex; align-items: center;">
                                        <h1 style="font-size: 3rem; margin-bottom: 0;" id="status_eng_temp">--</h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="card" style="border-radius: 13px;">
                            <div class="card-body">
                                <h4 style="display: block; margin: 0 0 1rem; font-weight: 400; color: #e7e7e7;">Oil Level</h4>
                                <div class="row">
                                    <div class="col-auto" style="display: flex; align-items: center;">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon-tabler icon-tabler-temperature" style="--tblr-icon-size: 4rem; stroke-width: 1.5;" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                            <path d="M10 13.5a4 4 0 1 0 4 0v-8.5a2 2 0 0 0 -4 0v8.5"></path>
                                            <path d="M10 9l4 0"></path>
                                        </svg>
                                    </div>
                                    <div class="col" style="display: flex; align-items: center;">
                                        <h1 style="font-size: 3rem; margin-bottom: 0;" id="status_oil_temp">--</h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="card" style="border-radius: 13px;">
                            <div class="card-body">
                                <h4 style="display: block; margin: 0 0 1rem; font-weight: 400; color: #e7e7e7;">Petrol Tank Healt</h4>
                                <div class="row">
                                    <div class="col-auto" style="display: flex; align-items: center;">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon-tabler icon-tabler-droplet" style="--tblr-icon-size: 4rem; stroke-width: 1.5;" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                            <path d="M7.502 19.423c2.602 2.105 6.395 2.105 8.996 0c2.602 -2.105 3.262 -5.708 1.566 -8.546l-4.89 -7.26c-.42 -.625 -1.287 -.803 -1.936 -.397a1.376 1.376 0 0 0 -.41 .397l-4.893 7.26c-1.695 2.838 -1.035 6.441 1.567 8.546z"></path>
                                        </svg>
                                    </div>
                                    <div class="col" style="display: flex; align-items: center;">
                                        <h1 style="font-size: 3rem; margin-bottom: 0;" id="status_oil_press">--</h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="card" style="border-radius: 13px;">
                            <div class="card-body">
                                <h4 style="display: block; margin: 0 0 1rem; font-weight: 400; color: #e7e7e7;">Body Health</h4>
                                <div class="row">
                                    <div class="col-auto" style="display: flex; align-items: center;">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon-tabler-heart-rate-monitor" style="--tblr-icon-size: 4rem; stroke-width: 1.5;" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                            <path d="M3 4m0 1a1 1 0 0 1 1 -1h16a1 1 0 0 1 1 1v10a1 1 0 0 1 -1 1h-16a1 1 0 0 1 -1 -1z"></path>
                                            <path d="M7 20h10"></path>
                                            <path d="M9 16v4"></path>
                                            <path d="M15 16v4"></path>
                                            <path d="M7 10h2l2 3l2 -6l1 3h3"></path>
                                        </svg>
                                    </div>
                                    <div class="col" style="display: flex; align-items: center;">
                                        <h1 style="font-size: 3rem; margin-bottom: 0;" id="status_body_healt">--</h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="card" style="border-radius: 13px;">
                            <div class="card-body">
                                <h4 style="display: block; margin: 0 0 1rem; font-weight: 400; color: #e7e7e7;">Tyre Burst</h4>
                                <div class="row">
                                    <div class="col-auto" style="display: flex; align-items: center;">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon-tabler icon-tabler-circle-number-0" style="--tblr-icon-size: 4rem; stroke-width: 1.5;" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                            <path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0"></path>
                                            <path d="M10 10v4a2 2 0 1 0 4 0v-4a2 2 0 1 0 -4 0z"></path>
                                        </svg>
                                    </div>
                                    <div class="col" style="display: flex; align-items: center;">
                                        <h1 style="font-size: 3rem; margin-bottom: 0;" id="status_wheels_healt">--</h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <div class="card" style="border-radius: 13px;">
                            <div class="card-body">
                                <h4 style="display: block; margin: 0 0 1rem; font-weight: 400; color: #e7e7e7;">Dirt Level</h4>
                                <div class="row">
                                    <div class="col-auto" style="display: flex; align-items: center;">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon-tabler icon-tabler-spray" style="--tblr-icon-size: 4rem; stroke-width: 1.5;" width="40" height="40" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                            <path d="M4 10m0 2a2 2 0 0 1 2 -2h4a2 2 0 0 1 2 2v7a2 2 0 0 1 -2 2h-4a2 2 0 0 1 -2 -2z"></path>
                                            <path d="M6 10v-4a1 1 0 0 1 1 -1h2a1 1 0 0 1 1 1v4"></path>
                                            <path d="M15 7h.01"></path>
                                            <path d="M18 9h.01"></path>
                                            <path d="M18 5h.01"></path>
                                            <path d="M21 3h.01"></path>
                                            <path d="M21 7h.01"></path>
                                            <path d="M21 11h.01"></path>
                                            <path d="M10 7h1"></path>
                                        </svg>
                                    </div>
                                    <div class="col" style="display: flex; align-items: center;">
                                        <h1 style="font-size: 3rem; margin-bottom: 0;" id="status_dirt_level">--</h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-sm-12" style="overflow-y: scroll; max-height: 17rem;" id="status_div_log">
                <div>
                    <pre style="background: #1c1c1c; margin-bottom: 0;" id="status_log"></pre>
                </div>
            </div>
        </div>
    </div>`

    document.getElementById('app_container').innerHTML = status_div;

    var stats = status_raw
    prev_stats = status_raw
    document.getElementById('status_eng_temp').innerHTML = stats[0] + '°';
    document.getElementById('status_oil_temp').innerHTML = stats[1] + '%';
    document.getElementById('status_oil_press').innerHTML = stats[2] + '%';
    document.getElementById('status_body_healt').innerHTML = stats[3] + '%';
    document.getElementById('status_wheels_healt').innerHTML = stats[4];
    document.getElementById('status_dirt_level').innerHTML = stats[5] + '%';
    document.getElementById('status_log').innerHTML = prev_log

    var element = document.getElementById('status_div_log')
    element.scrollTop = element.scrollHeight;
}

function StatusUpdate(stats) {
    const temp_curr_date = new Date()
    var seconds = temp_curr_date.getSeconds();
    var minutes = temp_curr_date.getMinutes();
    var hour = temp_curr_date.getHours();
    var curr_date = hour + ":" + minutes + ":" + seconds


    var update = "<strong style='color: rgb(var(--main-color));'>Update</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style='color: rgb(var(--main-color));'>"+curr_date+"</strong>"
    if (prev_stats[0] != stats[0]) {
        document.getElementById('status_eng_temp').innerHTML = stats[0] + '°';
        update = update + "<br>Engine Temperature&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[0] + " --> " + stats[0]
    } 
    if (prev_stats[1] != stats[1]) {
        document.getElementById('status_oil_temp').innerHTML = stats[1] + '%';
        update = update + "<br>Oil Level&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[1] + " --> " + stats[1]
    }
    if (prev_stats[2] != stats[2]) {
        document.getElementById('status_oil_press').innerHTML = stats[2] + '%';
        update = update + "<br>Petrol Tank Healt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[2] + " --> " + stats[2]
    }
    if (prev_stats[3] != stats[3]) {
        document.getElementById('status_body_healt').innerHTML = stats[3] + '%';
        update = update + "<br>Body Healt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[3] + " --> " + stats[3]
    }
    if (prev_stats[4] != stats[4]) {
        document.getElementById('status_wheels_healt').innerHTML = stats[4];
        update = update + "<br>Tyre Burst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[4] + " --> " + stats[4]
    }
    if (prev_stats[5] != stats[5]) {
        document.getElementById('status_dirt_level').innerHTML = stats[5] + '%';
        update = update + "<br>Dirt Level&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + prev_stats[5] + " --> " + stats[5]
    }

    prev_stats = stats

    if (update != "<strong style='color: rgb(var(--main-color));'>Update</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style='color: rgb(var(--main-color));'>"+curr_date+"</strong>") {
        document.getElementById('status_log').innerHTML = prev_log + update + '<br><br>'
        prev_log = prev_log + update + '<br><br>'
        var element = document.getElementById('status_div_log')
        element.scrollTop = element.scrollHeight;
    }
}

