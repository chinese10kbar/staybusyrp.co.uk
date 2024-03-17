var video;
var audio;
var playing = false;

function randomNumber(min, max) { return Math.floor(Math.random() * (max - min + 1)) + min; }

function setup() {
	// Video
	video = document.getElementById('bgVid');

	// Audio
	audio = new Audio();
	if (audio) {
		if (randomNumber(1, 100) <= Config.easterEggChance) audio.src = "assets/music/easteregg.mp3";
		else audio.src = `assets/music/${Config.theme}.mp3`;

		let prevVol = window.localStorage.getItem('loading_vol');
		audio.volume = prevVol != null ? prevVol : 0.2;
		if (audio.volume < 0.00) audio.volume = 0.00;

		var audioAllowed = false;

		var startPlayPromise = audio.play();
        if (startPlayPromise !== undefined) {
            startPlayPromise
            .then(() => {
				audioAllowed = true;
				playing = true;
				if (video) video.play();
            })
            .catch(() => {});
        }

		document.addEventListener("click", function (e) {
			if (audioAllowed == false) {
				audio.play();
				audioAllowed = true;
				playing = true;
				if (video) video.play();
			}
		});

		window.addEventListener("keydown", function (e) {
            if (e.key == "ArrowUp") {
                audio.volume = Math.min(audio.volume + 0.01, 1).toFixed(2);
				window.localStorage.setItem('loading_vol', audio.volume);
            } else if (e.key == "ArrowDown") {
                audio.volume = Math.max(audio.volume - 0.01, 0.00).toFixed(2);
				window.localStorage.setItem('loading_vol', audio.volume);
            } else if (e.key == " ") {
				if (playing) {
					playing = false;
					if (audio) audio.pause();
					if (video) video.pause();
				} else {
					playing = true;
					if (audio) audio.play();
					if (video) video.play();
				}
			}
        });

		window.addEventListener("keyup", function (e) {
            if (e.key == "r") {
				if (window.invokeNative) {
					window.invokeNative('openUrl', "https://discord.gg/J7BdSFC5jm");
				} else {
					window.open("https://discord.gg/J7BdSFC5jm")
				}
			} else if (e.key == "d") {
				if (window.invokeNative) {
					window.invokeNative('openUrl', "");
				} else {
					window.open("")
				}
			}
        });
	}

	// Stats
	const commaFormatter = (value) => (value || 0).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	const moneyFormatter = (value) => `£${commaFormatter(value)}`;

	var STATS = {};
	if (Config.theme === 'halloween') {
		STATS = {
			total_bets: { name: 'Total Ghosts Roaming', icon: 'fa-solid fa-ghost', formatter: commaFormatter },
			owned_houses: { name: 'Total Houses Egged', icon: 'fa-solid fa-egg', formatter: commaFormatter },
			total_characters: { name: 'Total Zombies Alive', icon: 'fa-solid fa-skull-crossbones', formatter: commaFormatter },
			paid_fines: { name: 'Total Spiders Squashed', icon: 'fa-solid fa-spider', formatter: commaFormatter },
			total_tweedles: { name: 'Total Pumpkin Sales', icon: 'fa-solid fa-money-bill', formatter: moneyFormatter },
		}
	} else if (Config.theme === 'christmas') {
		STATS = {
			total_bets: { name: 'Letters To Santa', icon: 'fa-solid fa-envelope', formatter: commaFormatter },
			owned_houses: { name: 'Houses Santa Will Visit', icon: 'fas fa-home', formatter: commaFormatter },
			total_characters: { name: 'Total Elves', icon: 'fa-solid fa-wand-magic', formatter: commaFormatter },
			paid_fines: { name: 'Money Spent On Gifts', icon: 'fas fa-money-bill-wave', formatter: moneyFormatter },
			total_tweedles: { name: 'Reindeers Ready For Action', icon: 'fa-solid fa-horse', formatter: commaFormatter },
		}
	} else {
		STATS = {
			total_bets: { name: 'Total Casino Bets', icon: 'fas fa-coins', formatter: moneyFormatter },
			owned_houses: { name: 'Total Tenancy Agreements', icon: 'fas fa-home', formatter: commaFormatter },
			total_characters: { name: 'Total Population (Characters)', icon: 'fas fa-users', formatter: commaFormatter },
			paid_fines: { name: 'Total Fines Paid', icon: 'fas fa-money-bill-wave', formatter: moneyFormatter },
			total_tweedles: { name: 'Total Tweedle Posts', icon: 'fab fa-twitter', formatter: commaFormatter },
		}
	}

	function loadStats(statData) {
		const stats = Object.entries(STATS)
			.map(([key, { name, icon, formatter }]) =>
				({ name, icon, value: formatter ? formatter(statData[key]) : statData[key] }));


		let statsBlock = document.getElementById('stats')
		let statIndex = 0
		let maxStat = Object.keys(stats).length
		statsBlock.style.display = 'block';

		showStat = (stat) => {
			document.getElementById('stats-table').innerHTML = `
				<tr>
					<td><i class="${stat.icon}"></i></td>
					<td>${stat.name}</td>
					<td>- ${stat.value}</td>
				</tr>
			`;
		}

		showStat(stats[statIndex])
		statsBlock.style.height = statsBlock.scrollHeight + "px"

		setInterval(() => {
			statIndex++
			if(statIndex >= maxStat) statIndex = 0
			statsBlock.style.height = "0px"

			setTimeout(() => {
				showStat(stats[statIndex])
				statsBlock.style.height = statsBlock.scrollHeight + "px"
			}, 1250);
		}, 5500);
	}

	window.addEventListener('DOMContentLoaded', () => {
		const handOver = window.nuiHandoverData;

		if (handOver) {
			if (handOver.stats) {
				loadStats(handOver.stats)
			}
		}

		document.body.classList.add(Config.theme);
		document.querySelector('.filled-logo').src = `assets/img/logo_${Config.theme}_colour.png`;
		document.querySelector('.transparent-logo').src = `assets/img/logo_${Config.theme}.png`;

		if (Config.themes[Config.theme]?.particlesJS) {
			var script = document.createElement("script");
			script.src = "https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js";
			script.onload = function () {
				particlesJS("snow", Config.themes[Config.theme].particlesJS);
			};
			document.head.append(script);
		}
	});


	if (!window.invokeNative) { // Loading Progress On Dev Enviroment
		loadStats({});

		let devProgress = 0;
		setInterval(() => {
			if (devProgress < 100) {
				devProgress++;
				window.postMessage({ eventName: "loadProgress", loadFraction: devProgress/100 });

				if (devProgress === 20) window.postMessage({ type: "INIT_BEFORE_MAP_LOADED" });
				else if (devProgress === 40) window.postMessage({ type: "MAP" });
				else if (devProgress === 60) window.postMessage({ type: "INIT_AFTER_MAP_LOADED" });
				else if (devProgress === 80) window.postMessage({ type: "INIT_SESSION" });
				else if (devProgress === 100) window.postMessage({ message: "Initializing session" });
			}
		}, 200);
	}
}

setup();

const loadTypes = {
	"INIT_CORE": "Loading...",
	"INIT_BEFORE_MAP_LOADED": "Loading Pre-Map...",
	"MAP": "Loading Map...",
	"INIT_AFTER_MAP_LOADED": "Loading Post-Map...",
	"INIT_SESSION": "Loading Session..."
};

function loadProgress(progress) {
	document.querySelector('.loader .filled-logo').style.height = `${progress}%`;
	document.querySelector('.loader .progress').innerText = `${progress}%`;
}

window.addEventListener('message', function(e) {
    if(e.data.eventName === 'loadProgress') {
        loadProgress(parseInt(e.data.loadFraction * 100));
    } else if (e.data.type && loadTypes[e.data.type]) {
		document.getElementById('loadingtext').innerText = loadTypes[e.data.type];
    } else if (e.data.message === 'Initializing session') {
		document.getElementById('loadingtext').innerText = "Initialising Session...";
	}
});


var overlay = true;
window.addEventListener('keydown', function(e) {
    if(e.key == 'F1') {
		e.preventDefault();
        overlay = !overlay;
        if(!overlay) {
			document.getElementById('overlay').style.opacity = 0;
			document.getElementById('bgVid').style.filter = "blur(.0)";
        } else {
			document.getElementById('overlay').style.opacity = null;
			document.getElementById('bgVid').style.filter = "blur(.5vw)";
        }
    }
});