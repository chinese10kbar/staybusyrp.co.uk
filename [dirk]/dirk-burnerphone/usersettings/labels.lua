Labels = {
  ['ENG'] = {
    NoSignal          = "Your phone appears to have no signal", --## When the user has no signal
    GiveNumber        = "Give Phone Number", 
    BuyPhone          = "Buy New Phone: $%s",
    BuyCredit         = "Buy Credit: $%s",
    RepairPhone       = "Repair Phone: $%s per phone",
    BuyCharger        = "Buy Charger: $%s",
    BoughtPhone       = "You bought a new phone",
    BoughtCharger     = "You have bought a charger",
    RepairedPhones    = "You repaired your phones",
    NotEnoughMoney    = "You do not have enough money",
    NotEnoughItems    = "You dont have the items for this deal",
    BrokenPhone       = "It appears this phone is broken...",
    NoPhonesToRepair  = "You do not have any phones to repair",
    NoPhones          = "You don't have any phones to exchange numbers with or they are all full",
    NoMatchPhone      = "Are you sure it's you I am meant to be meeting you dont have the same phone?",
    NewMessage        = "New Message from %s",
    WrongArea         = "You are not in the right area to do this",
    WaterDamage       = "You have damaged %s of your phone(s) due to being in the water",
    NoBattery         = "You have no battery left on your phone",
    NoChargeItem      = "You need a charging cable to charge your phone",
    PhoneDied         = "Your battery has died",
    PhonePluggedIn    = "You have plugged your phone(s) into charge",
    PhoneUnplugged    = "You have unplugged your phone(s) from charge",
    NoStolenGoods     = "There is nothing on this corpse",
    StolenMoneyFound  = "You found $%s on the corpse",
    StolenGoodsFound  = "You found %s x %s on the corpse",
    SearchPed         = "Search %s",
    CustomerSpeak     = "Speak to %s",
    PhoneCorrupt      = "Your phone has corrupted due to inactivity throw it away and buy another",
    TooFarAway        = "You have run away from the ped you were trying to speak to",
    Exchanging        = "Exchanging numbers with %s",
    CorruptPhone      = "Corrupted Phone",
    BoughtCredit      = "You have topped this phone up with $%s worth of credits",
    PositiveResponses = {'yeah', 'yes', 'sure', 'alright', 'safe', 'bet', 'on god no cap', 'yeppers', 'you know it', 'okay', 'on god'},
    NegativeResponses = {'no', 'nope', 'nah', 'negative', 'get fucked idiot', 'get lost', 'fuck off'},
    MiniGameWords     = {"cipher", "brute force", "exploit", "vulnerability", "firewall", "encryption", "decryption", "malware", "phishing", "ransomware", "penetration", "botnet", "keylogger", "zero-day", "backdoor", "spoofing", "man-in-the-middle", "rootkit", "social engineering", "payload", "trojan", "worm", "bug", "hacker", "cracker", "cybersecurity", "anonymity", "hash", "packet sniffing"},
    --[[
      You can use the following within these responses
        itemLabel  = Item Label
        itemAlias  = A random alias for the item from Config.Items[item].Alias
        itemAmount = Amount of Item
        itemPrice  = Price Per Item
        itemTotal  = Total Price of this deal
    ]]
    BuyOffers = {
      "Give me some fucking {itemAlias} right now or im gonna lose my shit, ${itemPrice} per unit and I need {itemAmount}, let me know!",
      "I'm hard up for {itemAmount} {itemAlias}. Please swing that shit by? ${itemTotal} is what I need.",
      "I'd do anything for {itemAmount} {itemAlias}. Come with it? ${itemTotal} is my offer.",
      "Let me get {itemAmount} {itemAlias}. Can you bring it by? ${itemTotal} is what i need.",
      "I need me that damn {itemAmount} {itemAlias}. I'll do you right if you bring it? ${itemTotal} is what I got.",
      "I'd stab a midget for {itemAmount} {itemAlias}. You come with it? ${itemTotal} is the least of what I can do.",
      "I'm going to die if I dont get {itemAmount} {itemAlias}. Can you bring it? ${itemTotal} is all I stole from the offering plate.",
      "I'd blow a priest for {itemAmount} {itemAlias}. Same to you if you bring it? ${itemTotal} on top of that.",
      "I won't rob you if you got {itemAmount} {itemAlias}. Can you deliver? ${itemTotal} is nothing.",
      "I'm fiending for {itemAmount} {itemAlias}. Please bring it? ${itemTotal} is all I can do.",
      "I can't stop thinking about {itemAmount} {itemAlias}. Can you come with it? ${itemTotal} is what I can pay.",
      "In the market for {itemAmount} {itemLabel}. Can you deliver? ${itemTotal} is my offer.",
      "Yo, I'm looking to buy {itemLabel} x {itemAmount}. I can pay {itemPrice} per {itemLabel}.",
    },

    SpokeAlready = {
      'I already spoke to you..',
      'Man fuck off we just spoke',
      'Leave me the fuck alone',
      'You worse than my baby mama fuck off',
      'fuck outta my face for awhile man',
      'Go Wash your balls and leave me alone', 
      'How many times you gonna hit me up in an hour',
      'I think you need some more friends holmes',
      'Im away to your moms house, hit me up later',
      'My phone dying, hit me up later man',
      'Dont hit me up while im eating',
      'Hit me up later when I need something',
      'I told you buzz off for a bit',
    },

    SellOffers = {
      "I Got some {itemAmount} {itemAlias} come grab it, ${itemTotal} is a steal!",
      "I'm holding {itemAmount} {itemAlias} come get this shit, ${itemTotal} is the right price!",
      "I've got {itemAmount} {itemAlias} come hold it, ${itemTotal} for a shit ton come quick!",
      "I have {itemAmount} {itemAlias} come snatch this shit up, ${itemTotal} for all of it come quick!",
      "I found {itemAmount} {itemAlias} come get this shit, ${itemTotal} is the best I can do!",
      "I stole {itemAmount} {itemAlias} come take it off my hands, ${itemTotal} for every last bit!",
      "I jacked {itemAmount} {itemAlias} come buy it quick, ${itemTotal} for all of it!",
      "Come get {itemAmount} {itemAlias} I stole it and need it gone, ${itemTotal} for it if you come now!",
      "The crew scored {itemAmount} {itemAlias} come get this shit, ${itemTotal} if you get here soon!",
      "I have {itemAmount} {itemAlias} come get this shit, ${itemTotal} for the whole lot come quick!",
    },

    FailToReply = {
      "You can just say no you dont have to ghost me you fucking mug", 
      "I'll just go fuck myself then",
      "Instead of blowing me off you can just blow me",
      "I could have stayed in bed for this shit",
      "Next time I'll just call Big Smoke",
      "You off chasin that damn train again?",
      "I'll just go make the shit myself",
      "Guess my shit not good enough for you",
      "You out with that bitch again aint you",
      "Why you never hit me back",
      "Imma have to go into business with someone else if you dont hit me up",
      "I got some other shit to do anyway",
      "If you hate me, just say that",
      "Right well I guess you dont have then...",
    }, 

    --[[
      You can use the following within these responses
        contactName = This will be the contact name of the contact who is messaging
    ]]

    NewContactResponses = {
      "Yo, it's {contactName}! Got your number. We'll connect soon to discuss some business.",
      "Hey, it's {contactName}. Save my digits and expect a call from me real soon.",
      "{contactName} here. Let's stay in touch and explore potential opportunities.",
      "What's up, it's {contactName}? Just got your number. I'll hit you up when things heat up.",
      "Hey there, it's {contactName}. Keep my contact info handy. We might have some dope collaborations.",
      "Yo, it's {contactName}. Let's make some moves and turn it into cash.",
      "Hey, it's {contactName}! I'll reach out to you in the near future. Stay hustlin'.",
      "Thanks for the number, it's {contactName}. I'll let you know if I need anything.",
      "Thanks for the number, it's {contactName}. Fuck around and find out, I'll let you know if I need anything.",
      "Got your number just in case, it's {contactName}. I'll let you know if I need anything. Meow.",
      "Yo, it's {contactName}. I'll give you a shout soon. Let's make some paper together.",
      "Hey, it's {contactName}. Keep an eye out for my message. We got things to discuss."
    },

    --[[
      You can use the following within these responses
        streetName = The street name where you will meet the contact
    ]]

    AcceptDealResponse = {
      "Perfect, meet me over at {streetName}, you know the same place I met ya.",
      "Ok bruh, get to {streetName}. Let's do this quick.",
      "Lets go, meet me over at {streetName}, we can get this over with.",
      "Ok man, swing to {streetName}, and we can do this.",
      "Come on baby, meet me over at {streetName}, and we can get this done.",
      "Alright, meet me over at {streetName}, and we can do this.",
      "That's great, man. I'll be over at {streetName}. Head over ASAP.",
      "Thanks, dude. I'll see you at the usual spot: {streetName}.",
      "Cool, cool. Let's link up at {streetName}. Looking forward to it.",
      "All good, fam. I'll catch you over at {streetName}. Don't keep me waiting.",
      "No problemo, my dude. Meet me over at {streetName}, and we'll get things sorted.",
      "Alright, homie. I'll be holding it down at {streetName}. Swing by when you're ready.",
      "Gotcha, my G. I'll be posted up at {streetName}. Roll through whenever you're good.",
    },

    DealFailed = { --## If you show up without the goods or the money this is how they wil respond or if you dont show up at all
      "Quit playing games, fool. I ain't got time for your bullshit.",
      "You think you can screw me over? Think again, punk.",
      "You're trying to pull a fast one on me, huh? Not gonna fly, scumbag.",
      "You crossed the line, and now you're gonna pay the price, chump.",
      "You thought you could hustle me, but I'm onto your game, rat.",
      "Don't try to pull that shit on me again, or you'll regret it, punk-ass.",
      "You're pushing your luck, man. This ain't gonna end well for you.",
      "You messed with the wrong person, and now you're gonna suffer, bitch.",
      "I don't tolerate betrayal, and you just sealed your fate, asshole.",
      "You think you're slick? Well, I see through your lies, motherfucker."
    },

    DealSuccess = { --## When you have a successful deal this is how they will respond
      "Thanks I will hit you up another time for more",
      "Perfect I will see you later",
      "Thanks bro, till next time",
      "Thank god you came through",
      "Thanks man, I can't suck another one right now",
      "Next time imma give you a kiss",
      "Thanks, tell your mom I love her",
      "Next time we meet at the usual spot",
      "I'll see you at the barbeque",
      "Ta Ta for now",
      "Cheers bye for now",
    },

    DealTheft = {   --## When you are robbed
      "Better luck next time I'm taking your shit",
      "I got your shit for nothing this time and you cant do shit",
      "Get fucked idiot",
      "Get shit on loser, take this L",
      "Get fucked, Tell your mom I said hello",
      "Better luck next time, Tell your sister to stop calling me",
      "Thanks for the loot, Get fucked idiot",
      "Thanks for the donation dumbass",
      "How many times do we have to teach you this lesson old man",
      "Thanks for the goods, go eat a whole bag of dicks",
      "You fucked around and found out idiot",
      "Have fun grinding that shit out again loser",
    },
    
    SnitchResponse = {
      "I'm sorry man the cops got to me and I had to tell",
      "They pressed me hard af bro, had to rat you out",
      "I'm a bigger rat than Sean West, Well not that bad but sorry bro",
      "Maybe next time you wont trust the person you fucked",
      "Hey man, money wasnt enough, I ratted good luck",
      "The pigs got to me and you should run",
      "I cant go back to jail, had to rat on you bro",
      "Their offer was too good, had to change sides",
      "Nothing personal bro, had to snitch",
      "They got the info from my phone man, I'm sorry",
      "They said they'd lock up my lady, had to give you up",
      "Maybe next time you'll give me what I deserve",
      "Gotta pay your people bro, Had to let em know bout you",

    },

    DealChaseUp = {
      "Hey, are you remembering you're meant to meet me over at {streetName}?",
      "Yo, don't forget to meet me at {streetName}. We gotta handle this.",
      "Hey, I think you've forgotten about me. I'm over on {streetName}, waiting for you.",
      "Just a reminder, we're supposed to meet up at {streetName}. Don't leave me hangin'.",
      "Hey, just making sure you're still on for meeting me at {streetName}. Holla back.",
      "Yo, time's ticking. I'm here at {streetName}. Don't keep me waiting, my dude.",
      "Hey, don't let it slip your mind. We had plans to link up at {streetName}, remember?",
      "I'm giving you a heads up. I'm over at {streetName}, waiting for you to show up.",
      "Just checking in. You still good to meet me at {streetName}? Let me know, bro.",
      "Hey, I'm at {streetName}, holding it down. Hit me up when you're on the way.",
    },

    DeclineDealResponse = {
      "No worries, fam. Maybe next time you got me.",
      "Alright, I feel you. Hit me up if you change your mind, aight?",
      "Well, take it or leave it, playa.",
      "No problemo, man. If you ever feel like rollin' with it, just holla.",
      "I hear you, my G. Let's keep it cool for future moves.",
      "Nah, it's all good. Holla at me if you wanna make it happen later.",
      "No sweat, my dude. If you flip the script, hit me up.",
      "Aight, I respect your decision. Holla if you wanna revisit it.",
      "I get it, homie. If you need more info or change your mind, I'm here.",
      "Alright, cool beans. If you ever wanna switch gears, let me know.",
      "No doubt, my man. I'm here if you got any other tricks up your sleeve.",
      "Understood, fam. If you got any other plays or proposals, I'm all ears.",
      "No biggie, my G. If you need anything else or have questions, holla at me.",
      "Alright, I appreciate you. If you think of something else or need assistance, give me a shout.",
      "I feel you, my dude. If you got any feedback or need tweaks, holla and we can work it out.",
      "No problemo, bro. If there's anything else I can do for you, just slide into my DMs.",
    },

    RandomResponses = { --## Message you'll recieve if they've no idea what you're talking about
      "Yo, what's the deal? I'm clueless about what you're after.",
      "Sorry, my dude, I got no clue what you need. Can you break it down?",
      "Ain't got a clue, man. Give me some context, so I can catch up.",
      "Nah, I can't help you, fam. I ain't got nothin' and I don't need nothin'.",
      "I'm as lost as a ball in high weeds. I don't know what you're talking about.",
      "I'm clueless in these streets, bro. Fill me in on the details.",
      "Sorry, homie, I got nothin' for ya. What's this all about?",
      "I'm all ears, but I ain't got no answers. What's the story?",
      "I'm straight up oblivious, my dude. Can you enlighten me?",
      "I'm out of the loop, man. Can you give me more info?",
      "I'm scratching my head on this one. Can you break it down, bro?",
      "Sorry, my street knowledge is lacking. Can you explain it better?",
      "I'm in the dark, my dude. Can you shed some light on it?",
      "I ain't got a clue, G. Help me understand what you're talkin' about."
    },

    BadContactExchange = {
      "I don't want your fuckin' number, man. Get lost.",
      "Why the fuck would I need your number? Don't waste my time.",
      "Keep your fuckin' number to yourself. I ain't interested.",
      "You think I give a shit about your number? Think again.",
      "You must be outta your damn mind if you think I want your fuckin' number.",
      "I don't have time for your bullshit. Keep your number and bounce.",
      "Get the fuck outta here with your number. I don't need it.",
      "I'm not interested in your fuckin' number. Find someone else to bother.",
      "You're wastin' your breath offerin' me your number. I don't give a fuck.",
      "Save your fuckin' number for someone who actually gives a shit."
    },

    GoodContactExchange = {
      "Thanks, man. I'll hit you up sometime. Keep it real.",
      "Appreciate it, bro. I'll drop you a text when the time is right.",
      "Alright, man. I'll reach out when I need to. Stay on the grind.",
      "Good lookin' out, homie. I'll keep your number close. We'll connect soon.",
      "Thanks for the digits, my friend. I'll hit you up when there's somethin' cookin'.",
      "You're solid, man. I'll give you a shout when the stars align.",
      "Alright, alright. I'll remember your number. We might make things happen.",
      "I see you, bro. I'll keep your contact info handy. 'Til next time.",
      "I appreciate the gesture, man. I'll keep you in mind. Stay hustlin'.",
      "Thanks, man. I'll reach out when the time is right. Keep doin' your thing."
    },

  }
}

Names = {
  First = {
    Female = {
      "Olivia", "Anna", "Sophie", "Emma", "Grace", "Ella", "Ava", "Mia", "Isabella", "Charlotte",
      "Lily", "Sophia", "Amelia", "Harper", "Abigail", "Emily", "Scarlett", "Hazel", "Nora", "Zoe",
      "Chloe", "Madison", "Avery", "Evelyn", "Eleanor", "Victoria", "Hannah", "Lucy", "Aria", "Stella",
      "Penelope", "Lillian", "Leah", "Natalie", "Samantha", "Audrey", "Violet", "Elizabeth", "Claire", "Sarah"
    },
    Male = {
      "Liam", "Robert", "Oliver", "William", "James", "Henry", "Benjamin", "Jack", "Samuel", "Noah",
      "Elijah", "Mason", "Logan", "Alexander", "Daniel", "Matthew", "Michael", "Joseph", "David", "Gabriel",
      "Andrew", "Christopher", "Joshua", "Jackson", "Carter", "Caleb", "Luke", "John", "Isaac", "Ethan",
      "Jonathan", "Nathan", "Ryan", "Connor", "Adam", "Thomas", "Nathaniel", "Aaron", "Owen", "Tyler", "Justin"
    }
  },
  Last = {
    "Clark", "Johnson", "Smith", "Anderson", "Brown", "Davis", "Evans", "Garcia", "Hall",
    "Jackson", "Khan", "Lee", "Miller", "Nelson", "Owens", "Parker", "Reed", "Scott", "Turner",
    "Walker", "White", "Young", "Baker", "Carter", "Edwards", "Foster", "Gray", "Harris", "Ingram",
    "Jenkins", "King", "Lewis", "Morris", "Neal", "O'Connor", "Patterson", "Roberts", "Stewart", "Taylor", "Case"
  }
}

