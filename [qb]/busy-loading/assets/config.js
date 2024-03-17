const Config = {
	easterEggChance: 3,
	theme: "default", // default|christmas|halloween|remembrance - also dont forget to comment out the stuff in fxmanifest.lua
	themes: {
		christmas: {
			particlesJS: {
				particles: {
					number: {
						value: 150,
						density: {
							enable: true,
							value_area: 1000,
						},
					},
					color: {
						value: "#ffffff",
					},
					opacity: {
						value: 0.7,
						random: true,
						anim: {
							enable: false,
						},
					},
					size: {
						value: 5,
						random: true,
						anim: {
							enable: false,
						},
					},
					line_linked: {
						enable: false,
					},
					move: {
						enable: true,
						speed: 10,
						direction: "bottom",
						random: true,
						straight: false,
						out_mode: "out",
						bounce: false,
						attract: {
							enable: true,
							rotateX: 300,
							rotateY: 1200,
						},
					},
				},
				interactivity: {
					events: {
						onhover: {
							enable: false,
						},
						onclick: {
							enable: false,
						},
						resize: false,
					},
				},
				retina_detect: true,
			}
		},
		halloween: {
			particlesJS: {
				particles: {
					number: {
						value: 150,
						density: {
							enable: true,
							value_area: 1000,
						},
					},
					color: {
						value: "#f88603",
					},
					opacity: {
						value: 0.7,
						random: true,
						anim: {
							enable: false,
						},
					},
					size: {
						value: 5,
						random: true,
						anim: {
							enable: false,
						},
					},
					line_linked: {
						enable: false,
					},
					move: {
						enable: true,
						speed: 10,
						direction: "bottom",
						random: true,
						straight: false,
						out_mode: "out",
						bounce: false,
						attract: {
							enable: true,
							rotateX: 300,
							rotateY: 1200,
						},
					},
				},
				interactivity: {
					events: {
						onhover: {
							enable: false,
						},
						onclick: {
							enable: false,
						},
						resize: false,
					},
				},
				retina_detect: true,
			}
		}
	}
}