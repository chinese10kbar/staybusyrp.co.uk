# t3_deliveroo

A deliveroo job for FiveM. Deliver food orders to NPC's for money. Supports ESX and QBCore.

## Installation

> Download and install *t3_lib* from our GitHub: `https://github.com/T3development/t3_lib`.

> Drag *t3_deliveroo* into your server's resources folder and add `ensure t3_deliveroo` to your *server.cfg*.

> Configure the options to your liking in *config.lua*.

> Add the Job `deliveroo` and Item `fooddelivery` to your framework. Some snippets below.

> Restart your server.

## Snippets

### Ox

>>items.lua

	["fooddelivery"] = {
		label = "Food Delivery",
		weight = 1,
		metadata = {},
		stack = true,
		close = true,
	},

### QBCore

>>app.js

        else if (itemData.name == "fooddelivery") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| itemData.label}` + "</p>");
			var orderString = "";
			$.each(itemData.info.items, function(i, item) {
				if (i == itemData.info.items.length - 1) {
					orderString += item;
				} else {
					orderString += item + ", ";
				}
			});
            $(".item-info-description").html(
                    "<p><strong>Address: </strong><span>" +
                    itemData.info.addressName +
                    "</span></p><p><strong>Shop: </strong><span>" +
                    itemData.info.shop +
                    "</span></p><p><strong>Order: </strong><span>" +
                    orderString +
					"</span></p><br /><p>" +
                    itemData.description +
                    "</p>"
                );;
        } 

>>items.lua

['fooddelivery'] 				 = {['name'] = 'fooddelivery',					['label'] = 'Food Delivery', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fooddelivery.png', 		['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'UberEats Delivery Bag'},

>>jobs.lua

	['deliveroo'] = {
		label = 'Deliveroo',
		defaultDuty = true,
		offDutyPay = true,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},