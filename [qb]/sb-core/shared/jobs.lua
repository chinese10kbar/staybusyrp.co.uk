QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.QBJobsStatus = false -- true: integrate sb-jobs into the whole of sb-core | false: treat sb-jobs as an add-on resource.
QBShared.Jobs = {} -- All of below has been migrated into sb-jobs
if QBShared.QBJobsStatus then return end
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 10
            },
        },
	},
    ['electrician'] = {
		label = 'Electrician',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'electrician',
                payment = 10
            },
        },
	},
	['builder'] = {
		label = 'Bricky',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Construction',
                payment = 10
            },
        },
	},
    ['busysecurity'] = {
		label = 'Security',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Security Guard',
                payment = 10
            },
        },
	},
	['deliveroo'] = {
		label = 'Delivery Driver',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Deliveroo',
                payment = 10
            },
        },
	},
    ['busymechanic'] = {
		label = 'Busy Mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
    ['lumber'] = {
		label = 'lumber',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'lumber',
                payment = 10
            },
        },
	},
	['police'] = {
		label = 'Metropolitan Police',
        type = "leo",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'PCSO',
                payment = 20
            },
            ['1'] = {
                name = 'Response',
                payment = 30        
            },
            ['2'] = {
                name = 'CID',
                payment = 50    
            },
            ['3'] = {
                name = 'MO-4',
                payment = 100
            },
            ['4'] = {
                name = 'MO-8',
                payment = 150
            },
            ['5'] = {
                name = 'MO-19',
                payment = 200
            },
            ['6'] = {
                name = 'NPAS',
                payment = 250
            },

            ['7'] = {
                name = 'MO-1',
       		 	isboss = true,
                payment = 300
            },
            ['8'] = {
                name = 'army',
       		 	isboss = true,
                payment = 3000
            },
            ['9'] = {
                name = 'commisioner',
       		 	isboss = true,
                payment = 3000
            },
        },
	},
	['ambulance'] = {
		label = 'London Ambulance Service',
        type = 'ems',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Student Paramedic',
                payment = 1000
            },
            ['1'] = {
                name = 'Paramedic',
                payment = 2000
            },
            ['2'] = {
                name = 'Advanced Paramedic',
                payment = 2000
            },
            ['3'] = {
                name = 'Senior Paramedic',
                payment = 2000
            },
            ['4'] = {
                name = 'Junior Doctor',
                isboss = true,
                payment = 2000    
            },
            ['5'] = {
                name = 'Doctor',
                isboss = true,
                payment = 2000
            },
            ['6'] = {
                name = 'Surgeon',
                isboss = true,
                payment = 2000
            },
            ['7'] = {
                name = 'Executives',
                isboss = true,
                payment = 2000
            },
        },
	},
	['firefighter'] = {
		label = 'LFB',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Firefighter',
                payment = 1500
            },
            ['1'] = {
                name = 'Station Commander',
                payment = 2000
            },
            ['2'] = {
                name = 'Commissioner',
                isboss = true,
                payment = 2000
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['uber'] = {
		label = 'Uber Driver',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Driver',
                payment = 75
            },
			['2'] = {
                name = 'Event Driver',
                payment = 100
            },
			['3'] = {
                name = 'Sales',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
    ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['ottosdealer'] = {
		label = 'Ottos Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['offroaddealer'] = {
		label = 'Off-Road Car Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },	
	},
	['aedealer'] = {
		label = 'Auto Exotics Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['bikedealer'] = {
		label = 'Bike Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},

	['mechanic'] = {
		label = 'Mechanic',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['europarts'] = {
		label = 'Euro car Parts',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['harmonyauto'] = {
		label = 'Harmony Autos',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['aemechanics'] = {
		label = 'Auto Exotics Mechanics',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['ugtuner'] = {
		label = 'UG TUNER',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['fsmc'] = {
		label = 'Fallen sons bangers',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},

	['ottos'] = {
		label = 'Ottos Garage',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['risingsun'] = {
		label = 'Rising Sun',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Novice',
                payment = 75
            },
			['2'] = {
                name = 'Experienced',
                payment = 100
            },
			['3'] = {
                name = 'Advanced',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['lvmc'] = {
		label = 'lost venom',
		defaultDuty = true,
		offDutyPay = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 100
            },
			['1'] = {
                name = 'Novice',
                payment = 175
            },
			['2'] = {
                name = 'Experienced',
                payment = 180
            },
			['3'] = {
                name = 'Advanced',
                payment = 190
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 500
            },
        },
	},
    ['taco'] = {
		label = 'Taco Shop',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Cook',
                payment = 75
            },
            ['1'] = {
                name = 'Manager',
                isboss = true,
                payment = 150,
            },
        },
	},
    ['goonz'] = {
        label = 'goonz',
        defaultDuty = true,
        offDutyPay = true,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 10
            },
            ['1'] = {
                name = 'Novice',
                payment = 20
            },
            ['2'] = {
                name = 'Experienced',
                payment = 30
            },
            ['3'] = {
                name = 'Advanced',
                payment = 40
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
                payment = 50
            },
        },
    },
    ['sonsautos'] = {
		label = 'sons autos',
		defaultDuty = true,
		offDutyPay = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 100
            },
			['1'] = {
                name = 'Novice',
                payment = 175
            },
			['2'] = {
                name = 'Experienced',
                payment = 180
            },
			['3'] = {
                name = 'Advanced',
                payment = 190
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 500
            },
        },
	},
	['weed'] = {
		label = 'Marley Mashups',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
	    ['0'] = {
                name = 'Owner',
				isboss = true,
                payment = 150
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee Associate',
                payment = 50
            },
            ['1'] = {
                name = 'Associate',
                payment = 150
            },
            ['2'] = {
                name = 'Senior Associate',
                payment = 250
            },
            ['3'] = {
                name = 'Legal Director',
                isboss = true,
                payment = 500
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 50
            },
        },
	},
	['burgershot'] = {
    label = 'Burgershot',
    defaultDuty = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},

['catcafe'] = {
    label = 'UwU Cafe',
    defaultDuty = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},

['pizzathis'] = {
    label = 'Pizza this',
    defaultDuty = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},

['beanmachine'] = {
    label = 'Bean Machine',
    defaultDuty = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},

['vu'] = {
    label = 'Strip Club',
    defaultDuty = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 75
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 100
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 150
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 200
        },
    },
},

['henhouse'] = {
    label = 'Hen House',
    defaultDuty = true,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},

['GoonzBlock'] = {
    label = 'GoonzBlock',
    defaultDuty = true,
    grades = {
        ['0'] = {
            name = 'StreetG',
            payment = 100
        },
        ['1'] = {
            name = 'StreetG1',
            payment = 100
        },
        ['2'] = {
            name = 'StreetG2',
            payment = 100
        },
        ['3'] = {
            name = 'StreetG3',
            isboss = true,
            payment = 100
        },
        ['4'] = {
            name = 'StreetG4',
            isboss = true,
            payment = 100
        },
    },
},
['southbeachmechanic'] = {
    label = 'southbeachmechanic',
    defaultDuty = true,
		offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},
['goldenpub'] = {
    label = 'golden pub',
    defaultDuty = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},
['luxclub'] = {
    label = 'lux club',
    defaultDuty = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},

['mirrorrestaunt'] = {
label = 'mirrorrestaunt',
defaultDuty = false,
grades = {
    ['0'] = {
        name = 'Recruit',
        payment = 50
    },
    ['1'] = {
        name = 'Worker',
        payment = 100
    },
    ['2'] = {
        name = 'Shift Manager',
        payment = 150
    },
    ['3'] = {
        name = 'Manager',
        isboss = true,
        payment = 200
    },
    ['4'] = {
        name = 'Owner',
        isboss = true,
        payment = 300
    },
  },
},
['vargosgrage'] = {
    label = 'vargosgrage',
    defaultDuty = true,
		offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Recruit',
            payment = 50
        },
        ['1'] = {
            name = 'Worker',
            payment = 100
        },
        ['2'] = {
            name = 'Shift Manager',
            payment = 150
        },
        ['3'] = {
            name = 'Manager',
            isboss = true,
            payment = 200
        },
        ['4'] = {
            name = 'Owner',
            isboss = true,
            payment = 300
        },
    },
},




	['insertcoin'] = {
		label = 'Insert Coin',
		defaultDuty = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
	['yellowjack'] = {
		label = 'Yellow Jack',
		defaultDuty = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
	['cyberbar'] = {
		label = 'Cyber Bar',
		defaultDuty = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
	['irishpub'] = {
		label = 'Irish Pub',
		defaultDuty = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
	['splitsides'] = {
		label = 'Split Sides',
		defaultDuty = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
	['bahama'] = {
		label = 'Bahama Mamas',
		defaultDuty = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
	['limeys'] = {
		label = 'Limeys',
		defaultDuty = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
}