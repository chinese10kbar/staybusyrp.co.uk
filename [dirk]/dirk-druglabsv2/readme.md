Dependencies - 
meta_libs
dirk-core

Installation - 
If you are using dirk-cores auto-add for items you don't need to do anything however if you want to disable this and manually insert items into your 
database or shared.lua then you will find the corresponding files within usersettings. 

Configuration - 
Make sure you have fully configured dirk-core as it will handle all framework/target/inventory settings for this script. 
If you change item names etc in the configuration make sure the item name changes in items.lua same goes if you add items to the script make sure they 
are added to usersettings/items.lua following the same format

Support - 
Support will be gained via our discord ticket system please allow 24-48 hours for a reply however it should always be much less than this 

Inventories and Compatibility - 
Some inventories dont have full compabitibility with TeamWorkMode so please set this to false on all labs and make sure ToInventory is true for Ingredients orders if you notice issues 

OX BASE ITEMS -

  ['lab-key'] = {          
    ['label'] = 'Lab Keys',           
    ['weight'] = 1000,   
  },
  ['raidtool'] = {             
    ['label'] = 'Raid Tool',          
    ['weight'] = 1000,   
  },
  --## Cocaine Lab
  ['bakingsoda'] = {              
    ['label'] = 'Baking Soda',          
    ['weight'] = 1000,   
  },
  ['rawcocaine'] = {          
    ['label'] = 'Raw Cocaine',          
    ['weight'] = 1000,   
  },
  ['cutcocaine'] = {              
    ['label'] = 'Cut Cocaine',          
    ['weight'] = 1000,   
  },
  ['cocainepackage'] = {              
    ['label'] = 'Cocaine Package',          
    ['weight'] = 1000,   
  },
  ['actionfigure'] = {              
    ['label'] = 'Action Figure',          
    ['weight'] = 1000,   
  },
  --## Meth-Lab
  ['bagmeth'] = {            
    ['label'] = 'Bag of Meth',          
    ['weight'] = 1000,   
  },
  ['boxmeth'] = {            
    ['label'] = 'Box of Meth',          
    ['weight'] = 1000,   
  },
  ['sodiumbenzoate'] = {             
    ['label'] = 'Sodium Benzoate',          
    ['weight'] = 1000,   
  },
  ['propelyeneglycol'] = {            
    ['label'] = 'Propelyene Glycol',          
    ['weight'] = 1000,   
  },

  --## Weed-Lab
  ['trimmed_weed'] = {          
    ['label'] = 'Trimmed Weed',          
    ['weight'] = 1000,   
  },
  ['untrimmed_weed'] = {            
    ['label'] = 'Untrimmed Weed',          
    ['weight'] = 1000,   
  },

-------------------------------------------------------------------
