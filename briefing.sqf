/*
This is purely an example. You can alter it as you see fit.

It is in reverese order as it will be in the correct order once ingame.

Formatting tags for tasks and briefings
There are many formatting tags that can be incorporated in the strings for tasks and notes:

To add a link to a marker: <marker name='obj1'>Link to Marker</marker>
To show an image: <img image='somePic.jpg'/>
Manipulate the image width and height like so: <img image='somePic.jpg' width='200' height='200'/>
Coloured text: <font color='#A52A2A'>Some text</font color>
Line break can be added with: <br/>

https://community.bistudio.com/wiki/Arma_3:_Briefing

// Story so far 
// 1. Over ran by Bandits, need assets to build up enough to take over their base at Petlove Junkyard and rescue the traders there.
// 2. After securing Junkyard, able to get PPE that allows people to cross over Level 1 borders safely, need to knock out Military Towers, Ambush Supplies and secure them before assaulting airfield
// 3. Securing Airfield brings in a higher more dangerous thread, Black Order which are scattered all over the place. PPE to access every area is now accessiable, need to find caches and radios around from intel 
// on Black Order soldiers before finding out they're held up in Novi Grad and eventually taking it over completely.

*/
player createDiaryRecord 
["Diary",
	["Contract Types",


		"
			<br/>
			<br/><font size=14 color='#0000FF' face='TahomaB'>Current Integrated Contracts</font>
			<br/>
			<br/><font size=10 color='#ffffffff' face='TahomaB'>Kill Contract</font>
			<br/>
			<br/> Kill a Target, Target may or may not have additional support. Target may or may not be on the move.
			<br/> If the Target is not found at the map marker, look for clues outside the camp to track where they are. ( ACE Interact )
			<br/> 
			<br/><font size=10 color='#ffffffff' face='TahomaB'>Supply Contract</font> 
			<br/>
			<br/> Gather the listed items you were tasked to and bring them back to whomever gave you the Contract. Whichever items you gather will also restock
			<br/> a merchant if the employer is one.
			<br/> 
			<br/><font size=10 color='#ffffffff' face='TahomaB'>Advanced Supply Contract</font> 
			<br/>
			<br/> Same as the Supply Contract but the items are rarer, pays out more and usually require vastly less amounts to fulfill the contract.
			<br/> 
			<br/><font size=10 color='#ffffffff' face='TahomaB'>Gun Run Contract</font> 
			<br/>
			<br/> Much like the Advanced Supply Contract, but Firearms instead.   
			<br/> 
			<br/><font size=10 color='#FF0000' face='TahomaB'>Additional Information</font> 
			<br/>
			<br/> Ensure any items, weapons etc you have are in your inventory and not worn, prevents any items that you want to use fulfilling the contract.
			<br/> 
			<br/><font size=10 color='#00FF00' face='TahomaB'>Planned Contracts/Missions</font> 
			<br/>
			<br/> * Special Order Contacts ( Combined Supply/Gun Run Contracts, so gather 1 Firearm, x amount of Supplies, maybe x amount of Advanced Items )
			<br/>
			<br/> * Vehicle Acquisition Contract ( Find a certain vehicle, repair it and return it to your employer )
			<br/>
			<br/> * Crate Acquisition Contract ( Find a certain crate and return it to your employer, which if is a merchant will restock items )
			<br/>
			<br/> * Medical Rescue Contract ( Find the target and perform medical on them. )
			<br/>
			<br/> * Rescue Contract ( Find the target and bring them back to your employer )
			<br/>
			<br/> * Persistent Level Missions/Contracts ( Progresses the story and evolves the scenario. e.g unlocking the next Trader via liberating etc )
			<br/>
		"
	]
];

player createDiaryRecord 
["Diary",
	["Info/Mods/Scripts",


		"
			<br/>This Alpha Persistent Mission was brought to you by J. Andrews ( Samantha/Sammy )
			<br/>
			<br/><font size=10 color='#00FF00' face='TahomaB'>The Following Systems were used.</font>
			<br/>
			<br/>* HALs Store ( Modified to Automatically Price Firearms, Vests etc )
			<br/>* Loot Spawning Script by Sarogahtyp on BI Forums ( Heavily modified, almost completely reworked with spawning of crates, vast amount of params etc )
			<br/>* Job Board/NPC Job System ( Completely Designed and Created by J. Andrews ) 
			<br/>* EOS System 
			<br/>* GRAD Persistence 
			<br/>* HG Stores
			<br/>* BTC Hearts and Minds Scripts
			<br/>* Zombie Framework Scripts
			<br/><font size=14 color='#0000FF' face='TahomaB'>Possible Future Plans</font>
			<br/><font size=5 color='#ffffffff' face='TahomaB'>Subjected to Change</font>
			<br/>
			<br/> * Automatic Pricing of HG Vehicle Stores ( Including Selling )
			<br/> * Time Skipping 
			<br/> * Friendly NPCs 
			<br/> * Additional Factions 
			<br/> * Wildlife 
			<br/> * Simple Crafting ( Possibly )
			<br/> * More Tasks/Jobs ( Including Server wide Tasks )
			<br/> * Expanding of Task/Job System ( Group Reward Sharing, More Complicated Taskings )
			<br/> * Overarching Persistent Story 
			<br/> * Add Story Barriers ( Map Areas Indicated by Green/Yellow/Red are varied PPE Required to Cross )
			<br/> * New Essker Related ( Build more locations )
			<br/> * Possible Implementation of additional mods ( Fleff's Advanced ACE Repair, KJW's Radiate/Medical Expansion, GreenMag are some few examples )
			<br/> * Random Stashes 
			<br/> * Expand Task/Job System ( UI and conversations )
			<br/> * Dynamic Occupation System ( Units from Factions occupying, reinforcing, patrolling with a Command Structure )
			<br/> * Safe Zone Building ( Liberation type base building )
			<br/> * Implement Higher Level Traders ( Level 2, 3 and 4 )
			<br/> * Less Invasive HG Hud
			<br/> * Scrap Types ( Metal, Wood, Electronic, Gun Powder )
			<br/> * Weird Shit 
			<br/> * Filling Buildings ( Furniture Mods )
			<br/> * Wreck Loot
			<br/> * Discounts with stores depending on rank 
			<br/> This Scenario Uses HAL Store's Currency Variable 

			
		"
	]
];


player createDiaryRecord 
["Diary",
	["HG Store KEYBINDS",  //Example provided below with a refernce to a marker.

				/* This is a clear and concise statement of what the unit is to accomplish. Use When (time), Who (unit), What (task), Where (grid), and Why (purpose) to construct your Mission Statement). */

		"
		<br/><font size=14 face='TahomaB'>Locks/unlocks owned vehicles</font>
		<br/>Y
		<br/>
		<br/><font size=14 face='TahomaB'>Give Money</font>
		<br/>U
		<br/>
		<br/><font size=14 face='TahomaB'>Vehicles Keys Menu</font>
		<br/>F
		<br/>
		<br/><font size=14 face='TahomaB'>Toggle HUD</font>
		<br/>*
		<br/>
		<br/><font size=14 face='TahomaB'>Admin Menu</font>
		<br/>Right Windows Key
		<br/>
		"
	]
];

