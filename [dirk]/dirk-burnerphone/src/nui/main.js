
let maxContacts = 10;
let newPhone = false; 
let PageOpen = false; 
let textPrice = 1;
let TypeIcons = {
  Gun:"fa-solid fa-gun",
}

let thisPhoneData = {
  SIMNo:23123122,
  Battery:55, 
  Credit:100,
  Apps:{
    Messages:true,
    Contacts:true,
  },

  Settings:{
    PhoneName:"Not Set",
    Ringtone:"Default",
    Wallpaper:"Default",
    Notifs:true, 
  },

  Contacts:{
    'John Green':{
      Type:"zoneID", // zoneID, phoneNo, name
      MetAt:"South Broker St",
      MessageHistory:[
        {
          Time:"12:45am",
          Sender:"me",
          Message:"Hello World",
        }
      ],
    },
  },

  Notifications:[
    {
      Title:"Drug Run",
      Desc:"There is a drug run for you to go to",
      Type:"Gun",
      Message:"John Green", 
      Page:"Messages",
    },
  ]
}

CreatePhone = function(phoneData){
  PageOpen = false; 
  thisPhoneData = phoneData;

  // Brings up the phone to begin with
  // Loads up the home page 

  newPhone = $(`
  <div class="outerPhone">
    <div class="phoneScreen">
      <div class="topBar">
        <div class="Time">12:45am</div>
        <div class="Battery"><i class="fa-solid fa-battery-full"></i></div>
        <div class="Signal"><i class="fa-solid fa-signal"></i></div>
      </div>
      <div class="content"></div>
      <div class="bottomBar"></div> 
    </div>  
  </div>
  `).appendTo('body');


  $(newPhone).css({
    opacity:"1",
    bottom:"5%",
    right:"2%",
  })


  UpdateTopBar("Battery", thisPhoneData.Battery);
  // UpdateTopBar("Time", thisPhoneData.Battery);

  OpenPage("Notifications");
}


CreateHomeButton = function(type){
  $('.bottomBar').empty();
  if (type == "Home"){
    $(`<div class="centerButton">Home</div>`).appendTo('.bottomBar').click(function () {
      OpenPage("Notifications");
    })
  } else if(type == "Menu"){
    $(`<div class="centerButton">Menu</div>`).appendTo('.bottomBar').click(function () {
      OpenPage("Menu");
    })
  }
}

OpenPage = function(page, data){
  PageOpen = page;
  $('.content').empty();
  switch (page) {
    case "Menu":
      MenuGrid();      
      break
    case "Notifications": // Will require addition if open while recieving message
      NotifPage()
      break;
    case "Messages": // Will require addition if open while recieving message
      MessagesPage();
      break
    case "MessageThread": // Will sometimes require addition if open while recieving message
      curThread = data.contactID;
      OpenMessageThread(data.contactID, data.name, data.messageHistory);
      break
    case "Contacts": 
      OpenContacts()
      break
    default:
      break;
  }
} 

OpenContacts = function(){
  CreateHomeButton("Menu");
  let MessagePage = $(`<div class="notifications"></div>`).appendTo('.content');
  if (typeof(thisPhoneData.Contacts) == "array" || typeof(thisPhoneData.Contacts) == "object"){
    let contactAmount = Object.keys(thisPhoneData.Contacts).length

    $(`<div class="notif">
      <div class="notifIcon"><i class="fa-solid fa-user"></i></div>
      <div class="notifCont">
        <div class="notifTitle">Contact Count</div>
        <div class="notifDesc">${contactAmount}/${maxContacts}</div>
      </div>
    </div>`).appendTo(MessagePage);

    if (contactAmount == 0){
      $(`<div class="notif">
        <div class="notifIcon"><i class="fa-solid fa-user"></i></div>
        <div class="notifCont">
          <div class="notifTitle">No Contacts</div>
          <div class="notifDesc">Please make new contacts and they will appear here</div>
        </div>
      </div>`).appendTo(MessagePage);
    }

    Object.entries(thisPhoneData.Contacts).forEach(element => {
      const [k, v] = element;
      let newContact = $(`
      <div class="notif">
        <div class="notifIcon"><i class="fa-solid fa-user"></i></div>
        <div class="notifCont">
          <div class="notifTitle">${v.Name}</div>
          <div class="notifDesc">Meeting Spot: ${v.Origin}</div>
        </div>
      </div>`).appendTo(MessagePage);
  
      // let closeBtn = $(`<div class="closeBtn"><i class="fa-solid fa-circle-xmark"></i></div>`).prependTo(newContact).click(function () {
      //   $(newContact).css("opacity", "0");
      //   setTimeout(() => {
      //     $(newContact).remove();
      //     delete thisPhoneData.Contacts[k];
      //     $.post(`http://dirk-burnerphone/phoneRemoveContact`, JSON.stringify({ simNumber: thisPhoneData.SIMNo, newContacts: thisPhoneData.Contacts}))
      //     if (Object.keys(thisPhoneData.Contacts).length == 0){
      //       $(`<div class="notif">
      //         <div class="notifIcon"><i class="fa-solid fa-user"></i></div>
      //         <div class="notifCont">
      //           <div class="notifTitle">No Contacts</div>
      //           <div class="notifDesc">Please make new contacts and they will appear here</div>
      //         </div>
      //       </div>`).appendTo(MessagePage);
      //     }
  
      //   }, 250);
      // })
      
    })

  }



}

PhoneRecieveMessage = function(contactId,contactName,  messageData){
  // Push thisPhoneData new message and notification.
  if (!Array.isArray(thisPhoneData.Notifications)){
    thisPhoneData.Notifications = Object.values(thisPhoneData.Notifications);
  }
  let id = thisPhoneData.Notifications.push({
    Title: contactName,
    Desc: messageData.Message,
    Icon: "fa-solid fa-message",
    Message: contactId,
    Page: "Messages",
  })
  thisPhoneData.Contacts[contactId].MessageHistory.push({
    Sender: contactName,
    Message: messageData.Message,
  })
  if (PageOpen == "Notifications"){
    let thisNotif = $(`<div class="notif"></div>`).appendTo('.notifications');
    let closeBtn = $(`<div class="closeBtn"><i class="fa-solid fa-circle-xmark"></i></div>`).prependTo(thisNotif).click(function () {
      thisPhoneData.Notifications.splice(id -1);
      $(thisNotif).css("opacity", "0");
      setTimeout(() => {
        $(thisNotif).remove();
        $.post(`https://dirk-burnerphone/phoneRemoveNotif`, JSON.stringify({ simNumber: thisPhoneData.SIMNo, newNotifications: thisPhoneData.Notifications}))
      }, 250);
    })
    let Content = $(`        
      <div class="notifIcon"><i class="fa-solid fa-message"></i></div>
      <div class="notifCont">
        <div class="notifTitle">${contactName}</div>
        <div class="notifDesc">${messageData.Message}</div>
      </div>`).appendTo(thisNotif).click(function () {
        thisPhoneData.Notifications.splice(id - 1);
      // Fade Out Opacity
      $(thisNotif).css("opacity", "0");
      setTimeout(() => {
        $(thisNotif).remove();
        OpenPage("MessageThread", { name: contactName, contactID:contactId, messageHistory: thisPhoneData.Contacts[contactId].MessageHistory })
      }, 250);
    })
  }else if (PageOpen == "Messages"){
    OpenPage("Messages")
  }else if (PageOpen == "MessageThread" && curThread == contactId){
    let newMsg = $(`<div class="messageLeft">${messageData.Message}</div>`).appendTo('.messageContainer');
    $(newMsg)[0].scrollIntoView()
  }
}

let LightOn = false;

MenuGrid = function(){
  CreateHomeButton('Home');
  let menuGrid = $(`
    <div class="menuGrid"></div>
  `).appendTo('.content');

  // Message App

  $(`<div class="menuIcon hoverIcon"><i class="fa-solid fa-message"></i></div>`).appendTo(menuGrid).click(function(){
    OpenPage("Messages");
  })

    // Contacts App
  $(`<div class="menuIcon hoverIcon"><i class="fa-solid fa-address-book"></i></div>`).appendTo(menuGrid).click(function () {
    OpenPage("Contacts");
  })


  // Torch App
  let lightIcon = $(`<div class="menuIcon ${LightOn ? "glow":""}"><i class="fa-solid fa-lightbulb"></i></div>`).appendTo(menuGrid).click(function () {
    if (LightOn){
      LightOn = false;
      $(this).removeClass("glow");
      $(this).addClass("hoverIcon");
      $.post(`https://dirk-burnerphone/FlashLight`, JSON.stringify({ state: false }))
    } else {
      LightOn = true;
      $(this).addClass("glow");
      $(this).removeClass("hoverIcon");
      $.post(`https://dirk-burnerphone/FlashLight`, JSON.stringify({ state: true }))
    }
  })


  let dndIcon = $(`<div class="menuIcon" style="background-color:${thisPhoneData.Settings.Notifs ? "rgba(24, 24, 24, 0.5)" : "rgba(255, 0, 0, 0.5)"}"};"><i id="DND" class="fa-solid ${thisPhoneData.Settings.Notifs ? "fa-bell":"fa-bell-slash"}"></i></div>`).appendTo(menuGrid).click(function () {
    if (thisPhoneData.Settings.Notifs) {
      thisPhoneData.Settings.Notifs = false;
      $('#DND').removeClass("fa-bell");
      $('#DND').addClass("fa-bell-slash");
      $(this).css("background-color", "rgba(255, 0, 0, 0.5)");
    } else {
      thisPhoneData.Settings.Notifs = true;
      $(this).css("background-color", "rgba(24, 24, 24, 0.5)");
      $('#DND').removeClass("fa-bell-slash");
      $('#DND').addClass("fa-bell");
    }
    $.post(`https://dirk-burnerphone/NotifState`, JSON.stringify({ simNumber: thisPhoneData.SIMNo, state: thisPhoneData.Settings.Notifs }))

  })



  setTimeout(() => {
    $(menuGrid).css("opacity", "1");
  }, 50);

}


MessagesPage = function(){
  CreateHomeButton('Menu');
  let MessagePage = $(`<div class="notifications"></div>`).appendTo('.content');

  if (typeof(thisPhoneData.Contacts) == "array" || typeof(thisPhoneData.Contacts) == "object"){
    if (Object.keys(thisPhoneData.Contacts).length == 0){
      $(`<div class="notif">
        <div class="notifIcon"><i class="fa-solid fa-message"></i></div>
        <div class="notifCont">
          <div class="notifTitle">No Messages</div>
          <div class="notifDesc">You have no messages</div>
        </div>
      </div>`).appendTo(MessagePage);
    }
  }

  Object.entries(thisPhoneData.Contacts).forEach(element => {
    const [k, v] = element;
    if (v.MessageHistory.length >= 1) {
      let newMsg = $(`
      <div class="notif">
        <div class="notifIcon"><i class="${TypeIcons[v.Type]}"></i></div>
        <div class="notifCont">
          <div class="notifTitle">${v.Name}</div>
          <div class="notifDesc">${v.MessageHistory.at(-1).Message}</div>
        </div>
      </div>`).appendTo(MessagePage).click(function(){
        OpenPage("MessageThread", {name:v.Name, contactID:k,  messageHistory:v.MessageHistory})
      })
    } 
  })
}

let CurrentMessageThread = false;
let positiveKeywords = ['yes', 'yep', 'sure', 'ok', 'okay', 'absolutely', 'definitely', 'affirmative', 'aye', 'yeah', 'yup', 'correct', 'indeed', 'you bet', 'exactly', 'agreed', 'roger that', 'great', 'sounds good', 'alright', 'fine', 'cool', 'no problem', 'no worries', 'of course', 'gladly', 'certainly', 'by all means', 'naturally', 'sure thing', 'positively', 'uh-huh', 'yessir', 'yea', 'yay', 'ye', 'y'];
let negativeKeywords = ['no', 'nope', 'nah', 'not', 'never', 'negative', 'nothing', 'nada', 'fuck off', 'huh'];

getResponseType = function(str) {
  // Convert the string to lowercase for case-insensitive matching
  const lowercaseStr = str.toLowerCase();
  // Define arrays of positive and negative response keywords

  // Check if the lowercase string contains any positive or negative keywords
  for (let i = 0; i < positiveKeywords.length; i++) {
    if (lowercaseStr.includes(positiveKeywords[i])) {
      return 'positive'; // Positive response found
    }
  }

  for (let i = 0; i < negativeKeywords.length; i++) {
    if (lowercaseStr.includes(negativeKeywords[i])) {
      return 'negative'; // Negative response found
    }
  }

  return 'unknown'; // No positive or negative response keywords found
}


OpenMessageThread = function(contactID, name,  messageHistory){
  $('.content').empty();
  $(`  <div class="messageTitle">${name}</div>`).appendTo('.content')
  let msgBox = $(`<div class="messageContainer"></div>`).appendTo('.content');
  Object.entries(messageHistory).forEach(e => {
    const [m, d] = e;
    if (d != null || d != undefined){
      newMsg = $(`<div class="${d.Sender == "me"?"messageRight":"messageLeft"}">${d.Message}</div>`).appendTo(msgBox);
      if (m == messageHistory.length - 1){
        newMsg[0].scrollIntoView()
      }
    }
  })

  let input = $(`<div class="messageInput"> <input id="inputBox" type="text"></input></div>`).appendTo('.content')
  
  input.find('#inputBox').on('keyup', function (e) {
    if (e.key === 'Enter' || e.keyCode === 13) {
      // Do something
      // Add to the Array 
      if ($(this).val()){
        if (thisPhoneData.Credit - textPrice >= 0) {
          thisPhoneData.Credit -= textPrice;
          thisPhoneData.Contacts[contactID].MessageHistory.push({
            Sender: "me",
            Message: $(this).val(),
          });
  
          let newMsg = $(`<div class="messageRight">${$(this).val()}</div>`).appendTo(msgBox);
          let responseType = getResponseType($(this).val());
          // console.log(responseType)
          // if (responseType == "positive"){
          //   console.log("Positive Response")
          // } else if (responseType == "negative"){
          //   console.log("Negative Response")
          // } else {
          //   console.log("Unknown Response")
          // }
          newMsg[0].scrollIntoView()
          $.post(`https://dirk-burnerphone/newMessage`, JSON.stringify({ simNumber: thisPhoneData.SIMNo, contactID: contactID, message: $(this).val(), responseType: responseType}))
          $(this).val("")
        }else{
          let newMsg = $(`<div class="messageRight redMesg">Not Enough Credit to Send</div>`).appendTo(msgBox);
          newMsg[0].scrollIntoView()
        }

      }
    }
  });
}

NotifPage = function(){
  CreateHomeButton('Menu');
  $(`<div class="creditBox">$${thisPhoneData.Credit} Credit</div>`).appendTo('.content');
  $(`<div class="notifications"></div>`).appendTo('.content');

  Object.entries(thisPhoneData.Notifications).forEach(element => {

    const [key, value] = element;
    if (value != null || value != undefined){
      let thisNotif = $(`<div class="notif"></div>`).appendTo('.notifications');
      let closeBtn = $(`<div class="closeBtn"><i class="fa-solid fa-circle-xmark"></i></div>`).prependTo(thisNotif).click(function(){
        delete thisPhoneData.Notifications[key];
        $(thisNotif).css("opacity", "0");
        setTimeout(() => {
          $(thisNotif).remove();
        }, 250);
      })
      let Content = $(`        
        <div class="notifIcon"><i class="${value.Icon}"></i></div>
        <div class="notifCont">
          <div class="notifTitle">${value.Title}</div>
          <div class="notifDesc">${value.Desc}</div>
        </div>`).appendTo(thisNotif).click(function(){
        delete thisPhoneData.Notifications[key];
        // Fade Out Opacity
        $(thisNotif).css("opacity", "0");
        setTimeout(() => {
          $(thisNotif).remove();
          if (value.Message){
            OpenPage("MessageThread", { contactID: value.Message, name:value.Title,  messageHistory:thisPhoneData.Contacts[value.Message].MessageHistory})
          }
        }, 250);
      })
    }
  });
}

UpdateTopBar = function(type, val){
  if (type == "Battery"){
    if (val <= 100 && val > 75){
      $('.Battery').empty();
      $(`<i class="fa-solid fa-battery-full"></i>`).appendTo('.Battery');
    } else if(val <= 75 && val > 50){
      $('.Battery').empty();
      $(`<i class="fa-solid fa-battery-three-quarters"></i>`).appendTo('.Battery');
    } else if(val <= 50 && val > 25){
      $('.Battery').empty();
      $(`<i class="fa-solid fa-battery-half"></i>`).appendTo('.Battery'); 
    } else if(val <= 25 && val > 0){
      $('.Battery').empty();
      $(`<i class="fa-solid fa-battery-quarter"></i>`).appendTo('.Battery');
    }
  } else if(type == "Time"){
    $('.Time').text(val);
  } else if(type == "Signal"){
    if (val == false){
      $('.Signal').empty();
      $(`<i class="fa-solid fa-triangle-exclamation"></i>`).appendTo('.Signal');
    } else if (val == true) {
      $('.Signal').empty();
      $(`<i class="fa-solid fa-signal"></i>`).appendTo('.Signal');
    }
  }
}



// CreatePhone(thisPhoneData);

// UpdateTopBar('Signal', false)
// setTimeout(() => {
//   UpdateTopBar('Signal', true)
// }, 2500);


// setTimeout(() => {
//   UpdateTopBar('Time', "12:46am")
// }, 1200);


// setTimeout(() => {
//   UpdateTopBar("Battery", 15)  
// }, 6000);

$(document).on('keyup', function (event) {
  if (event.key == "Escape") {
    ClosePhone();
  }
});

let tabletOpen = false;

ClosePhone = function(){
  if (newPhone) {
    $(newPhone).remove();
    newPhone = false;
    $.post(`https://dirk-burnerphone/closed`, JSON.stringify({ simNumber: thisPhoneData.SIMNo, NewNotifs: thisPhoneData.Notifications}))
  }else if(tabletOpen){
    $.post(`https://dirk-burnerphone/closedtablet`)
    tablet.css("opacity", "0");
    setTimeout(() => {
      tablet.remove();
      tabletOpen = false;
    }, 500);
  }   
}

CloseSelector = function(){
  $('.selectorContainer').css("opacity", "0");
  setTimeout(() => {
    $('.selectorContainer').remove();
  }, 250);  
}

window.addEventListener("message", function (event) {
  if (event.data.type === "openPhone") {
    textPrice = event.data.textPrice;
    maxContacts = event.data.maxContacts;
    positiveKeywords = event.data.positiveKeywords;
    negativeKeywords = event.data.negativeKeywords;
    CreatePhone(event.data.phoneData);
    UpdateTopBar('Time', event.data.time)
  }else if (event.data.type === "closePhone") {
    ClosePhone();
  } else if (event.data.type === "newMessage") {
    PhoneRecieveMessage(event.data.contactId, event.data.contactName, event.data.message)
  } else if (event.data.type === "closeSelector") {
    CloseSelector();
  } else if (event.data.type === "updateBattery") {
    UpdateTopBar("Battery", event.data.battery)
    if (event.data.battery <= 0) {
      ClosePhone();
    }
  } else if (event.data.type === "updateSignal") {
    UpdateTopBar('Signal', event.data.signal)
  } else if (event.data.type === "playMessageSound") {
    let newSound = new Audio("ringtones/nokiamessage.mp3");
    newSound.play();
    newSound.volume = 0.05;
  } else if (event.data.type === "selectSim") {
    OpenSelector(event.data.phones);
  } else if (event.data.type === "openPoliceTablet") {
    OpenTablet(event.data.messages);
  }
});













let testPhones = {
  'IMEI:1231231212':true, 
  'IMEI:!21123qasds':true, 
  'IMEI:!asdasd':true, 
  'IMEI:!2112sadasd3qasds':true, 
  'IMEI:!sdasd':true, 
  'IMEI:!21123asdsdqasds':true, 
};
OpenSelector = function(myPhones){
  let mainContainer = $(`<div class="selectorContainer"></div>`).appendTo('body');

  Object.entries(myPhones).forEach(element => {
    const [key, value] = element;
    let phoneBox = $(`<div class="phoneBox">
      <i class="fa-solid fa-mobile-screen-button"></i>
      <div class="phoneName">${key}</div>
    </div>`).appendTo(mainContainer).on("mouseup", function () {
      setTimeout(() => {
        $.post(`https://dirk-burnerphone/selected`, JSON.stringify({ simNumber: key }))
        $(mainContainer).css("opacity", "0");
        setTimeout(() => {
          $(mainContainer).remove();
        }, 250);        
      }, 100);
    });
  });

  setTimeout(() => {
    $(mainContainer).css("opacity", "1");
  }, 250);
}


let listenedMessages = [
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you IW ANT TO MAKE THIS LONG SO THAT I CAN SEE HOW IT RESPONDS TO HABING A LOT IN EHRE NOT SURE HOW I DID IT TBH?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
  {
    decrypted:true,
    contactID: "123123123",
    recipient: "John Smith",
    message: "Hey, how are you?", 
    sender: "SIM:123123",
    position: {x:1, y:1, z:1},
    time: "12:00am"
  },
]

function getRandomCapitalLetter() {
  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const randomIndex = Math.floor(Math.random() * alphabet.length);
  return alphabet[randomIndex];
}

function isEnd(number) {
  if (number >= 43 && (number - 43) % 44 === 0) {
    return true;
  }
  return false;
}

function isStart(number) {
  if (number >= 0 && number % 44 === 0) {
    return true;
  }
  return false;
}

// let gameWords = ['RECIPIENT', 'SENDER', 'MESSAGE', 'TIME', 'POSITION', 'CONTACTID', 'DECRYPTED'];
// let amountWords = 5;
// let maxWrongLetters = 5;
// let moveSpeed   = 2000; // ms how often the letters change
// let timeToCrack = 60;
// let randomColors = false;

// OpenMiniGame = function(cb) {
//   let gameActive = true;
//   let miniGameContainer = $(`<div class="miniGameContainer">
//     <div class="hackGrid"></div>
//   </div>`).appendTo(tabletScreen);

//   let gridLetters = [];

//   // Generate the grid of random letters
//   for (let i = 0; i <= 923; i++) {
//     let letter = getRandomCapitalLetter();
//     if (isEnd(i) || isStart(i)) letter = " ";
//     let gridLetter = $(`<div class="hackLetter badHover"> </div>`);
//     $('.hackGrid').append(gridLetter);
//     gridLetters.push(gridLetter);
//   }

//   // Generate random words from the list
//   let randomWords = [];
//   let totalToFind = 0;
//   for (let i = 0; i < amountWords; i++) {
    
//     let randomWord = gameWords[Math.floor(Math.random() * gameWords.length)];
//     // Ensure this random word isn't already in randomWords
//     while (randomWords.includes(randomWord)) {
//       randomWord = gameWords[Math.floor(Math.random() * gameWords.length)];
//     }
//     totalToFind += randomWord.length;
//     randomWords.push(randomWord);
//   }
//   let countFound = 0; 
//   let wrongLetters = 0;

//   // Loop through gridLetters and decide where we can place these words
//   for (let i = 0; i < randomWords.length; i++) {
//     let word = randomWords[i];
//     console.log("Trying to place: ", word);
//     // Pick random starting position from gridLetters 
//     let randomStart = Math.floor(Math.random() * gridLetters.length);
//     // ensure this randomStart doesnt contain an existing word or is the start of the grid
//     while (!gridLetters[randomStart] || gridLetters[randomStart] == undefined || gridLetters[randomStart] == null || gridLetters[randomStart].text() !== " " || isStart(randomStart)) {
//       randomStart = Math.floor(Math.random() * gridLetters.length);
//     }
//       console.log("Random start: ", randomStart);
//     // Loop through this words letters
//     let wordLetters = word.split("");
//     for (let j = 0; j < wordLetters.length; j++) {
//       let letter = wordLetters[j];
//       gridLetters[randomStart].text(letter);
//       gridLetters[randomStart].removeClass("badHover");
//       gridLetters[randomStart].addClass("goodHover");
//       let highlighted = false;
//       gridLetters[randomStart].click(function(){
//         if (!highlighted){
//           countFound = countFound + 1;
//           highlighted = true;
//           gridLetters[randomStart].removeClass("goodHover");
//           $(this).css("background-color","green");
//           let newSound = new Audio("ringtones/correct.wav");
//           newSound.play();
//           newSound.volume = 0.05;
//           if (countFound >= totalToFind){
//             gameActive = false;
//             $(miniGameContainer).css("opacity", "0");
//             setTimeout(() => {
//               $(miniGameContainer).remove();
//             }, 250);
//             let newSound = new Audio("ringtones/cpmplete.wav");
//             newSound.play();
//             newSound.volume = 0.05;
//             cb('done')
//           }
//         }
//       })
//       // gridLetters[randomStart].css("color", "red");
//       delete gridLetters[randomStart];
//       randomStart = randomStart + 1;
//     }
//   }
//   for (let i = 0; i < gridLetters.length; i++) {
//     if (gridLetters[i] !== undefined && gridLetters[i] !== null) {
//       gridLetters[i].click(function(){
//         wrongLetters = wrongLetters + 1;
//         $(this).css("background-color","red");
//         $(this).removeClass("badHover");

//         if (wrongLetters >= maxWrongLetters){

//           gameActive = false;
//           $(miniGameContainer).css("opacity", "0");
//           setTimeout(() => {
//             $(miniGameContainer).remove();
//           }, 250);
//           let newSound = new Audio("ringtones/failed.wav");
//           newSound.play();
//           newSound.volume = 0.05;
//           cb('fail')
//         } else{
//           let newSound = new Audio("ringtones/wrong.mp3");
//           newSound.play();
//           newSound.volume = 0.05;
//         }
//       })
//     }
//   }

//   let myInterval 
//   updateNonVitals = function(){
//     if (!gameActive) {
//       clearInterval(myInterval);
//       return;
//     } 
//     for (let i = 0; i < gridLetters.length; i++) {
//       if (gridLetters[i] !== undefined && gridLetters[i] !== null) {
//         let letter = gridLetters[i];
//         letter.text(getRandomCapitalLetter());
//       }
//     }
//   }
//   updateNonVitals();
//   setTimeout(() => {
//     $(miniGameContainer).css("opacity", "1");
//   }, 20);
//   myInterval = setInterval(updateNonVitals, moveSpeed)

// };


let gameWords = ['Message', 'Sender', 'Recipient', 'Time', 'Decrypt', 'Obfuscate', 'Lua', 'Technology', 'DirkScripts'];
let amountWords = 5;
let amountToPass = 3;
let timePerWord = 10; // seconds

OpenMiniGame = function(cb){
  let curIndex = -1;
  let gameActive = true;
  let guessedWords = [];
  let jumbledWords = {};
  let jumbledWordsArray = [];

  let miniGameContainer = $(`<div class="miniGameContainer" style="display:flex; flex-direction:column; gap:15px; align-content:center; align-items:center;"></div>`).appendTo(tabletScreen);
  let miniGameHeader = $(`<div class="miniGameHeader">Message Descrambler</div>`).appendTo(miniGameContainer);

  let gameBox = $(`<div class="gameBox">
    <div class="gameText"></div>
    <div class="timerWrapper">
      <div class="timerBar"></div>
    </div>  
  </div>`).appendTo(miniGameContainer);


  // Jumble the order of gameWords
  gameWords.sort(() => Math.random() - 0.5);


  for (let i = 0; i < amountWords; i++) {
    let word = gameWords[i];
    let jumbledWord = word.split('').sort(function(){return 0.5-Math.random()}).join('');
    jumbledWords[jumbledWord] = word;
    jumbledWordsArray.push(jumbledWord);
  }

  let guessedWordsDiv = $(`<div class="guessedWords"></div>`).appendTo(miniGameContainer);
  let playerInput = $(`<div class="playerInputWrap"><input class="playerInput" placeholder="Guess the word here!"></input></div>`).appendTo(miniGameContainer);

  setTimeout(() => {
    $(miniGameContainer).css("opacity", "1");
  }, 20);

  nextWord = function(){
    $('.timerBar').stop();
    playerInput.find('.playerInput').val("");
    curIndex = curIndex + 1;
    $('.timerBar').css("width", "100%")
    if (curIndex < jumbledWordsArray.length){
      $('.gameText').text(jumbledWordsArray[curIndex]);
      $('.timerBar').animate({
        width: '0px'
      },timePerWord * 1000, function(){
        $(`<div class="incorrect">${jumbledWordsArray[curIndex]}</div>`).appendTo(guessedWordsDiv);
        nextWord();  
      });
    } else{
      gameActive = false;
      if (guessedWords.length >= amountToPass){
        $('.gameText').text("Success").css("color", "rgba(0,255,0,0.8)");
        setTimeout(() => {
          $(miniGameContainer).css("opacity", "0");
          cb('Success')
          setTimeout(() => {
            $(miniGameContainer).remove();
          }, 1000);
        }, 2000);
        
      } else{
        $('.gameText').text("Unsuccesful").css("color", "rgba(255,0,0,0.8)");;
        setTimeout(() => {
          $(miniGameContainer).css("opacity", "0");
          cb('Fail')
          setTimeout(() => {
            $(miniGameContainer).remove();
          }, 1000);
        }, 2000);
      } 
    }
  }

  playerInput.find('.playerInput').on("input", function(){
    if (!gameActive) return;
    let curWord = jumbledWords[jumbledWordsArray[curIndex]];
    let thisValue = $(this).val();
    if (thisValue.toLowerCase() == curWord.toLowerCase()){
      guessedWords.push(curWord);
      $(`<div class="correct">${curWord}</div>`).appendTo(guessedWordsDiv);
      $(this).val("");
      nextWord();
    }
  })
  nextWord();
}

OpenTablet = function(msgs){
  tabletOpen = true;
  listenedMessages = msgs;
  tablet = $(`<div class="tabletContainer"></div>`).appendTo('body');
  tabletScreen = $(`<div class="tabletScreen"></div>`).appendTo(tablet);
  setTimeout(() => {
    $(tablet).css("opacity", "1");

    let decryptContainer = $(`<div class="decryptContainer">
      <div class="decryptBar">
        <div class="decryptIcon"></div>
      </div>
      <div class="incomingMessages">
        <div class="row header full spaceEven">
          <div>Sender</div>
          <div>Recipient</div>
          <div>Message</div>
          <div>Time</div>
          <i></i>
        </div>
        
        <div id="listMessages" class="column"></div>
      
      </div>
    </div>`).appendTo(tabletScreen);

    for (let i = 0; i < listenedMessages.length; i++) {
      let data = listenedMessages[i];
      let newMessage = $(`            
      <div class="row full spaceEven ${data.decrypted?"":"hidden"}">
        <div>${data.sender}</div>
        <div>${data.recipient}</div>
        <div>${data.message}</div>
        <div>${data.time}</div>
        
      </div>`).appendTo('#listMessages');
      let newButton = $(` <i class="fa-solid ${data.decrypted?"fa-floppy-disk saveRowBut":"fa-laptop-code crackButton"}"></i>`).appendTo(newMessage).on("mouseup", function () {
        if (data.decrypted){

        }else{
          OpenMiniGame(function(ret){
            if ( ret == "Success" ){
              $(newMessage).removeClass("hidden");
              $(newButton).removeClass("fa-laptop-code crackButton").addClass("fa-floppy-disk saveRowBut");
              data.decrypted = true;
            }else{
              
            }
          })
        }
      });
    }
    


  }, 250);
}

// OpenTablet(listenedMessages);