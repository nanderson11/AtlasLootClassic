-- If we aren't on a SoD realm, ignore everything in this file
if C_Seasons.GetActiveSeason() ~= 2 then return end

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local string = _G.string
local format = string.format

-- WoW
local RAID_CLASS_COLORS = _G["RAID_CLASS_COLORS"]

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CLASSIC_VERSION_NUM)

local GetColorSkill = AtlasLoot.Data.Profession.GetColorSkillRankNoSpell

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local LEATHER_DIFF = data:AddDifficulty(ALIL["Leather"], "leather", 0)
local MAIL_DIFF = data:AddDifficulty(ALIL["Mail"], "mail", 0)
local PLATE_DIFF = data:AddDifficulty(ALIL["Plate"], "plate", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PROF_CONTENT = data:AddContentType(ALIL["Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_GATH_CONTENT = data:AddContentType(ALIL["Gathering Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_SEC_CONTENT = data:AddContentType(AL["Secondary Professions"], ATLASLOOT_SECPROFESSION_COLOR)
local PROF_CLASS_CONTENT = data:AddContentType(AL["Class Professions"], ATLASLOOT_CLASSPROFESSION_COLOR)

data["Alchemy"] = {
	name = ALIL["Alchemy"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ALCHEMY_LINK,
	items = {
		{
			name = AL["Flasks"],
			[NORMAL_DIFF] = {
				{ 1,  17635 }, -- Flask of the Titans
				{ 2,  17636 }, -- Flask of Distilled Wisdom
				{ 3,  17637 }, -- Flask of Supreme Power
				{ 4,  17638 }, -- Flask of Chromatic Resistance
				{ 6,  1213546 }, -- Flask of Ancient Knowledge
				{ 7,  1213552 }, -- Flask of Madness
				{ 8,  1213548 }, -- Flask of the Old Gods
				{ 9,  1213544 }, -- Flask of Unyielding Sorrow
				{ 16, 17634 }, -- Flask of Petrification
				{ 21, 448085 }, -- Flask of Restless Dreams
				{ 22, 446226 }, -- Flask of Everlasting Nightmares
				{ 23, 446851 }, -- Flask of Nightmarish Mojo
			},
		},
		{
			name = AL["Transmutes"],
			[NORMAL_DIFF] = {
				{ 1,  17560 }, -- Transmute: Fire to Earth
				{ 2,  17565 }, -- Transmute: Life to Earth
				{ 4,  17561 }, -- Transmute: Earth to Water
				{ 5,  17563 }, -- Transmute: Undeath to Water
				{ 7,  17562 }, -- Transmute: Water to Air
				{ 9,  17564 }, -- Transmute: Water to Undeath
				{ 11, 17566 }, -- Transmute: Earth to Life
				{ 13, 17559 }, -- Transmute: Air to Fire
				{ 16, 17187 }, -- Transmute: Arcanite
				{ 17, 11479 }, -- Transmute: Iron to Gold
				{ 18, 11480 }, -- Transmute: Mithril to Truesilver
				{ 20, 25146 }, -- Transmute: Elemental Fire
			},
		},
		{
			name = AL["Healing/Mana Potions"],
			[NORMAL_DIFF] = {
				{ 1,  17556 }, -- Major Healing Potion
				{ 2,  11457 }, -- Superior Healing Potion
				{ 3,  7181 }, -- Greater Healing Potion
				{ 4,  3447 }, -- Healing Potion
				{ 5,  2337 }, -- Lesser Healing Potion
				{ 6,  2330 }, -- Minor Healing Potion
				{ 8,  22732 }, -- Major Rejuvenation Potion
				{ 9,  24366 }, -- Greater Dreamless Sleep Potion
				{ 11, 11458 }, -- Wildvine Potion
				{ 13, 1231583 }, -- Major Discolored Healing Potion
				{ 14, 4508 }, -- Discolored Healing Potion
				{ 16, 17580 }, -- Major Mana Potion
				{ 17, 17553 }, -- Superior Mana Potion
				{ 18, 11448 }, -- Greater Mana Potion
				{ 19, 3452 }, -- Mana Potion
				{ 20, 3173 }, -- Lesser Mana Potion
				{ 21, 2331 }, -- Minor Mana Potion
				{ 23, 2332 }, -- Minor Rejuvenation Potion
				{ 24, 15833 }, -- Dreamless Sleep Potion
				{ 26, 24365 }, -- Mageblood Potion
				{ 28, 435971 }, -- Mildly Irradiated Rejuvenation Potion
			},
		},
		{
			name = AL["Protection Potions"],
			[NORMAL_DIFF] = {
				{ 1,  17574 }, -- Greater Fire Protection Potion
				{ 2,  17576 }, -- Greater Nature Protection Potion
				{ 3,  17575 }, -- Greater Frost Protection Potion
				{ 4,  17578 }, -- Greater Shadow Protection Potion
				{ 5,  17579 }, -- Greater Holy Protection Potion
				{ 6,  17577 }, -- Greater Arcane Protection Potion
				{ 8,  11453 }, -- Magic Resistance Potion
				{ 9,  3174 }, -- Elixir of Poison Resistance
				{ 16, 7257 }, -- Fire Protection Potion
				{ 17, 7259 }, -- Nature Protection Potion
				{ 18, 7258 }, -- Frost Protection Potion
				{ 19, 7256 }, -- Shadow Protection Potion
				{ 20, 7255 }, -- Holy Protection Potion
				{ 23, 3172 }, -- Minor Magic Resistance Potion
			},
		},
		{
			name = AL["Util Potions"],
			[NORMAL_DIFF] = {
				{ 1,  11464 }, -- Invisibility Potion
				{ 2,  2335 }, -- Swiftness Potion
				{ 3,  6624 }, -- Free Action Potion
				{ 4,  3175 }, -- Limited Invulnerability Potion
				{ 5,  24367 }, -- Living Action Potion
				{ 6,  7841 }, -- Swim Speed Potion
				{ 8,  17572 }, -- Purification Potion
				{ 10, 17552 }, -- Mighty Rage Potion
				{ 11, 6618 }, -- Great Rage Potion
				{ 12, 6617 }, -- Rage Potion
				{ 16, 3448 }, -- Lesser Invisibility Potion
				{ 23, 11452 }, -- Restorative Potion
				{ 25, 17570 }, -- Greater Stoneshield Potion
				{ 26, 4942 }, -- Lesser Stoneshield Potion
			},
		},
		{
			name = AL["Stat Elixirs"],
			[NORMAL_DIFF] = {
				{ 1,  24368 }, -- Mighty Troll
				{ 2,  3451 }, -- Major Troll
				{ 3,  3176 }, -- Strong Troll
				{ 4,  3170 }, -- Weak Troll
				{ 6,  17554 }, -- Elixir of Superior Defense
				{ 7,  11450 }, -- Elixir of Greater Defense
				{ 8,  3177 }, -- Elixir of Defense
				{ 9,  7183 }, -- Elixir of Minor Defense
				{ 11, 11472 }, -- Elixir of Giants
				{ 12, 3188 }, -- Elixir of Ogre
				{ 13, 2329 }, -- Elixir of Lion
				{ 16, 11467 }, -- Elixir of Greater Agility
				{ 17, 11449 }, -- Elixir of Agility
				{ 18, 2333 }, -- Elixir of Lesser Agility
				{ 19, 3230 }, -- Elixir of Minor Agility
				{ 21, 11465 }, -- Elixir of Greater Intellect
				{ 22, 3171 }, -- Elixir of Wisdom
				{ 24, 17573 }, -- Greater Arcane Elixir
				{ 25, 11461 }, -- Arcane Elixir
				{ 26, 439960 }, -- Lesser Arcane Elixir
			},
		},
		{
			name = AL["Special Elixirs"],
			[NORMAL_DIFF] = {
				{ 1,  26277 }, -- Elixir of Greater Firepower
				{ 2,  17555 }, -- Elixir of the Sages
				{ 5,  3450 }, -- Elixir of Fortitude
				{ 7,  17557 }, -- Elixir of Brute Force
				{ 8,  17571 }, -- Elixir of the Mongoose
				{ 10, 11477 }, -- Elixir of Demonslaying
				{ 12, 1213571 }, -- Elixir of Alacrity
				{ 13, 1213559 }, -- Elixir of the Honey Badger
				{ 14, 1213563 }, -- Elixir of the Mage-Lord
				{ 15, 1213565 }, -- Elixir of the Ironside
				{ 16, 7845 }, -- Elixir of Firepower
				{ 17, 21923 }, -- Elixir of Frost Power
				{ 18, 11476 }, -- Elixir of Shadow Power
				{ 20, 2334 }, -- Elixir of Minor Fortitude
				{ 22, 8240 }, -- Elixir of Giant Growth
			},
		},
		{
			name = AL["Misc Elixirs"],
			[NORMAL_DIFF] = {
				{ 1,  11478 }, -- Elixir of Detect Demon
				{ 2,  12609 }, -- Catseye Elixir
				{ 4,  22808 }, -- Elixir of Greater Water Breathing
				{ 6,  11468 }, -- Elixir of Dream Vision
				{ 16, 11460 }, -- Elixir of Detect Undead
				{ 17, 3453 }, -- Elixir of Detect Lesser Invisibility
				{ 19, 7179 }, -- Elixir of Water Breathing
				{ 21, 426607 }, -- Elixir of Coalesced Regret
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  17632 }, -- Alchemist's Stone
				{ 3,  11473 }, -- Ghost Dye
				{ 5,  24266 }, -- Gurubashi Mojo Madness
				{ 7,  11466 }, -- Gift of Arthas
				{ 8,  3449 }, -- Shadow Oil
				{ 9,  3454 }, -- Frost Oil
				{ 10, 11451 }, -- Oil of Immolation
				{ 12, 435969 }, -- Insulating Gniodine
				{ 13, 471400 }, -- Magnificent Trollshine
				{ 16, 11459 }, -- Philosophers' Stone
				{ 18, 11456 }, -- Goblin Rocket Fuel
				{ 23, 7836 }, -- Blackmouth Oil
				{ 24, 7837 }, -- Fire Oil
				{ 25, 17551 }, -- Stonescale Oil
			},
		},
	},
}

data["Blacksmithing"] = {
	name = ALIL["Blacksmithing"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.BLACKSMITHING_LINK,
	items = {
		{
			name = AL["Weapons"].." - "..ALIL["Daggers"],
			[NORMAL_DIFF] = {
				{ 1,  1214137 }, -- Obsidian Heartseeker
				{ 2,  23638 }, -- Black Amnesty / 66
				{ 3,  461716 }, -- Deadly Heartseeker
				{ 4,  10013 }, -- Ebon Shiv / 51
				{ 5,  15973 }, -- Searing Golden Blade / 39
				{ 6,  15972 }, -- Glinting Steel Dagger / 36
				{ 7,  3295 }, -- Deadly Bronze Poniard / 25
				{ 8,  6517 }, -- Pearl-handled Dagger / 23
				{ 9,  3491 }, -- Big Bronze Knife / 20
				{ 10, 8880 }, -- Copper Dagger / 11
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_sword_04", nil, ALIL["One-Handed Axes"] },
				{ 2,  1213506 }, -- Obsidian Defender
				{ 3,  20897 }, -- Dark Iron Destroyer / 65
				{ 4,  16991 }, -- Annihilator / 63
				{ 5,  16970 }, -- Dawn / 55
				{ 6,  16969 }, -- Ornate Thorium Handaxe / 55
				{ 7,  9995 }, -- Blue Glittering Axe / 44
				{ 8,  9993 }, -- Heavy Mithril Axe / 42
				{ 9,  21913 }, -- Edge of Winter / 38
				{ 10, 2741 }, -- Bronze Axe / 23
				{ 11, 3294 }, -- Thick War Axe / 17
				{ 12, 2738 }, -- Copper Axe / 9
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Axes"] },
				{ 17, 1213492 }, -- Obsidian Reaver
				{ 18, 23653 }, -- Nightfall / 70
				{ 19, 461675 }, -- Refined Arcanite Reaper
				{ 20, 16994 }, -- Arcanite Reaper / 63
				{ 21, 15294 }, -- Dark Iron Sunderer / 57
				{ 22, 16971 }, -- Huge Thorium Battleaxe / 56
				{ 23, 3500 }, -- Shadow Crescent Axe / 40
				{ 24, 3498 }, -- Massive Iron Axe / 37
				{ 25, 9987 }, -- Bronze Battle Axe / 27
				{ 26, 3293 }, -- Copper Battle Axe / 13
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_sword_04", nil, ALIL["One-Handed Maces"] },
				{ 2,  1213502 }, -- Obsidian Stormhammer
				{ 3,  23650 }, -- Ebon Hand / 70
				{ 4,  461647 }, -- Skyrider's Masterwork Stormhammer
				{ 5,  16993 }, -- Masterwork Stormhammer / 63
				{ 6,  27830 }, -- Persuader / 63
				{ 7,  16984 }, -- Volcanic Hammer / 58
				{ 8,  461718 }, -- Tranquility
				{ 9,  10009 }, -- Runed Mithril Hammer / 49
				{ 10, 10003 }, -- The Shatterer / 47
				{ 11, 10001 }, -- Big Black Mace / 46
				{ 12, 3297 }, -- Mighty Iron Hammer / 30
				{ 13, 6518 }, -- Iridescent Hammer / 28
				{ 14, 3296 }, -- Heavy Bronze Mace / 25
				{ 15, 2740 }, -- Bronze Mace / 22
				{ 30, 2737 }, -- Copper Mace / 9
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Maces"] },
				{ 17, 1213500 }, -- Obsidian Destroyer
				{ 18, 460460 }, -- Sulfuron Hammer / 67
				{ 19, 461712 }, -- Refined Hammer of the Titans
				{ 20, 16988 }, -- Hammer of the Titans / 63
				{ 21, 461733 }, -- Finely-Enchanted Battlehammer
				{ 22, 15292 }, -- Dark Iron Pulverizer / 55
				{ 23, 3495 }, -- Golden Iron Destroyer / 34
				{ 24, 3494 }, -- Solid Iron Maul / 31
				{ 25, 9985 }, -- Bronze Warhammer / 25
				{ 26, 7408 }, -- Heavy Copper Maul / 16
			}
		},
		{
			name = AL["Weapons"].." - "..AL["Swords"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_sword_04", nil, ALIL["One-Handed Swords"] },
				{ 2,  1213504 }, -- Obsidian Sageblade
				{ 3,  23652 }, -- Blackguard / 70
				{ 4,  20890 }, -- Dark Iron Reaver / 65
				{ 5,  461743 }, -- Sageblade of the Archmagus
				{ 6,  461730 }, -- Hardened Frostguard
				{ 7,  16992 }, -- Frostguard / 63
				{ 8,  16978 }, -- Blazing Rapier / 56
				{ 9,  10007 }, -- Phantom Blade / 49
				{ 10, 10005 }, -- Dazzling Mithril Rapier / 48
				{ 11, 9997 }, -- Wicked Mithril Blade / 45
				{ 12, 3493 }, -- Jade Serpentblade / 35
				{ 13, 3492 }, -- Hardened Iron Shortsword / 32
				{ 14, 2742 }, -- Bronze Shortsword / 24
				{ 15, 2739 }, -- Copper Shortsword / 9
				{ 16, "INV_sword_06", nil, ALIL["Two-Handed Swords"] },
				{ 17, 1213498 }, -- Obsidian Champion
				{ 18, 461669 }, -- Refined Arcanite Champion
				{ 19, 16990 }, -- Arcanite Champion / 63
				{ 20, 461714 }, -- Desecration
				{ 21, 10015 }, -- Truesilver Champion / 52
				{ 22, 3497 }, -- Frost Tiger Blade / 40
				{ 23, 439128 }, -- Moonsteel Broadsword / 36
				{ 24, 9986 }, -- Bronze Greatsword / 26
				{ 25, 3292 }, -- Heavy Copper Broadsword / 19
				{ 26, 9983 }, -- Copper Claymore / 11
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Polearms"],
			[NORMAL_DIFF] = {
				{ 1, 23639 }, -- Blackfury / 66
				{ 2, 10011 }, -- Blight / 50
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[MAIL_DIFF] = {
				{ 1, 461739 }, -- Warcrest of the Great Chief
				{ 2, 16659 }, -- Radiant Circlet / 59
				{ 3, 9961 }, -- Mithril Coif / 46
				{ 4, 439126 }, -- Golden Scale Coif / 38
				{ 5, 9814 }, -- Barbaric Iron Helm / 35
				{ 6, 3502 }, -- Green Iron Helm / 34
			},
			[PLATE_DIFF] = {
				{ 1,  1224631 }, -- Scarlet Soldier's Helmet
				{ 2,  1213481 }, -- Razorspike Headcage
				{ 3,  1214309 }, -- Dreamscale Visor
				{ 4,  23636 }, -- Dark Iron Helm / 66
				{ 5,  24913 }, -- Darkrune Helm / 63
				{ 6,  16742 }, -- Enchanted Thorium Helm / 62
				{ 7,  16729 }, -- Lionheart Helm / 61
				{ 8,  16726 }, -- Runic Plate Helm / 61
				{ 9,  16724 }, -- Whitesoul Helm / 60
				{ 10, 16658 }, -- Imperial Plate Helm / 59
				{ 11, 16653 }, -- Thorium Helm / 56
				{ 12, 9980 }, -- Ornate Mithril Helm / 49
				{ 13, 9970 }, -- Heavy Mithril Helm / 47
				{ 14, 435906 }, -- Reflective Truesilver Braincage
				{ 15, 435908 }, -- Tempered Interference-Negating Helmet
				{ 16, 9935 }, -- Steel Plate Helm / 43
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[MAIL_DIFF] = {
				{ 1, 24137 }, -- Bloodsoul Shoulders / 65
				{ 2, 20873 }, -- Fiery Chain Shoulders / 62
				{ 3, 9966 }, -- Mithril Scale Shoulders / 47
				{ 4, 439130 }, -- Golden Scale Shoulders / 35
				{ 5, 9811 }, -- Barbaric Iron Shoulders / 32
				{ 6, 3504 }, -- Green Iron Shoulders / 32
				{ 7, 427061 }, -- Mantle of the Second War
				{ 8, 3330 }, -- Silvered Bronze Shoulders / 25
				{ 9, 3328 }, -- Rough Bronze Shoulders / 22
			},
			[PLATE_DIFF] = {
				{ 1,  1224632 }, -- Scarlet Soldier's Spaulders
				{ 2,  1213484 }, -- Razorspike Shoulderplate
				{ 3,  24141 }, -- Darksoul Shoulders / 65
				{ 4,  16664 }, -- Runic Plate Shoulders / 60
				{ 5,  15295 }, -- Dark Iron Shoulders / 58
				{ 6,  16660 }, -- Dawnbringer Shoulders / 58
				{ 7,  446179 }, -- Shoulderplates of Dread
				{ 8,  446188 }, -- Fearmonger's Shoulderguards
				{ 9,  446191 }, -- Baleful Pauldrons
				{ 10, 16646 }, -- Imperial Plate Shoulders / 53
				{ 11, 9952 }, -- Ornate Mithril Shoulder / 45
				{ 12, 9926 }, -- Heavy Mithril Shoulder / 41
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[MAIL_DIFF] = {
				{ 1,  1214274 }, -- Obsidian Mail Tunic / 72
				{ 2,  24136 }, -- Bloodsoul Breastplate / 65
				{ 3,  461735 }, -- Invincible Mail
				{ 4,  15293 }, -- Dark Iron Mail / 56
				{ 5,  16650 }, -- Wildthorn Mail / 54
				{ 6,  16648 }, -- Radiant Breastplate / 54
				{ 7,  439124 }, -- Golden Scale Cuirass / 40
				{ 8,  9916 }, -- Steel Breastplate / 40
				{ 9,  3508 }, -- Green Iron Hauberk / 36
				{ 10, 9813 }, -- Barbaric Iron Breastplate / 32
				{ 11, 429348 }, -- Shifting Silver Breastplate
				{ 12, 2675 }, -- Shining Silver Breastplate / 29
				{ 13, 2673 }, -- Silvered Bronze Breastplate / 26
				{ 14, 2670 }, -- Rough Bronze Cuirass / 23
				{ 15, 8367 }, -- Ironforge Breastplate / 20
				{ 16, 2667 }, -- Runed Copper Breastplate / 18
				{ 17, 3321 }, -- Copper Chain Vest / 10
				{ 18, 12260 }, -- Rough Copper Vest / 7
			},
			[PLATE_DIFF] = {
				{ 1,  1224633 }, -- Scarlet Soldier's Chestplate
				{ 2,  28242 }, -- Icebane Breastplate / 80
				{ 3,  1213490 }, -- Razorspike Battleplate
				{ 4,  1215507 }, -- Thick Obsidian Breastplate / 72
				{ 5,  1213715 }, -- Ironvine Breastplate / 70
				{ 6,  24139 }, -- Darksoul Breastplate / 65
				{ 7,  24914 }, -- Darkrune Breastplate / 63
				{ 8,  16745 }, -- Enchanted Thorium Breastplate / 63
				{ 9,  16731 }, -- Runic Breastplate / 62
				{ 10, 16663 }, -- Imperial Plate Chest / 60
				{ 11, 461667 }, -- Tempered Dark Iron Plate / 59
				{ 12, 16667 }, -- Demon Forged Breastplate / 57
				{ 13, 16642 }, -- Thorium Armor / 50
				{ 14, 9974 }, -- Truesilver Breastplate / 49
				{ 15, 9972 }, -- Ornate Mithril Breastplate / 48
				{ 16, 9959 }, -- Heavy Mithril Breastplate / 46
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[MAIL_DIFF] = {
				{ 1, 23629 }, -- Heavy Timbermaw Boots / 64
				{ 2, 16656 }, -- Radiant Boots / 58
				{ 3, 439122 }, -- Golden Scale Boots / 40
				{ 4, 3513 }, -- Polished Steel Boots / 37
				{ 5, 9818 }, -- Barbaric Iron Boots / 36
				{ 6, 3334 }, -- Green Iron Boots / 29
				{ 7, 3331 }, -- Silvered Bronze Boots / 26
				{ 8, 7817 }, -- Rough Bronze Boots / 18
				{ 9, 3319 }, -- Copper Chain Boots / 9
			},
			[PLATE_DIFF] = {
				{ 1, 1224639 }, -- Scarlet Soldier's Stompers
				{ 2, 24399 }, -- Dark Iron Boots / 70
				{ 3, 16657 }, -- Imperial Plate Boots / 59
				{ 4, 16652 }, -- Thorium Boots / 56
				{ 5, 9979 }, -- Ornate Mithril Boots / 49
				{ 6, 9968 }, -- Heavy Mithril Boots / 47
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[MAIL_DIFF] = {
				{ 1,  1214257 }, -- Black Grasp of the Destroyer / 70
				{ 2,  24138 }, -- Bloodsoul Gauntlets / 65
				{ 3,  461737 }, -- Tempest Gauntlets
				{ 4,  16654 }, -- Radiant Gloves / 57
				{ 5,  439120 }, -- Golden Scale Gauntlets / 41
				{ 6,  9820 }, -- Barbaric Iron Gloves / 37
				{ 7,  3336 }, -- Green Iron Gauntlets / 30
				{ 8,  3333 }, -- Silvered Bronze Gauntlets / 27
				{ 9,  3325 }, -- Gemmed Copper Gauntlets / 15
				{ 10, 3323 }, -- Runed Copper Gauntlets / 12
			},
			[PLATE_DIFF] = {
				{ 1,  1224636 }, -- Scarlet Soldier's Grips
				{ 2,  28243 }, -- Icebane Gauntlets / 80
				{ 3,  23637 }, -- Dark Iron Gauntlets / 70
				{ 4,  1213711 }, -- Ironvine Gloves / 70
				{ 5,  23633 }, -- Gloves of the Dawn / 64
				{ 6,  24912 }, -- Darkrune Gauntlets / 63
				{ 7,  461671 }, -- Stronger-hold Gauntlets
				{ 8,  16655 }, -- Fiery Plate Gauntlets / 58
				{ 9,  9954 }, -- Truesilver Gauntlets / 45
				{ 10, 9950 }, -- Ornate Mithril Gloves / 44
				{ 11, 9928 }, -- Heavy Mithril Gauntlet / 41
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[MAIL_DIFF] = {
				{ 1, 16725 }, -- Radiant Leggings / 61
				{ 2, 9931 }, -- Mithril Scale Pants / 42
				{ 3, 9957 }, -- Orcish War Leggings / 42
				{ 4, 439132 }, -- Golden Scale Leggings / 34
				{ 5, 3506 }, -- Green Iron Leggings / 31
				{ 6, 12259 }, -- Silvered Bronze Leggings / 31
				{ 7, 2668 }, -- Rough Bronze Leggings / 21
				{ 8, 3324 }, -- Runed Copper Pants / 13
				{ 9, 2662 }, -- Copper Chain Pants / 9
			},
			[PLATE_DIFF] = {
				{ 1,  1224638 }, -- Scarlet Soldier's Legplates
				{ 2,  24140 }, -- Darksoul Leggings / 65
				{ 3,  16744 }, -- Enchanted Thorium Leggings / 63
				{ 4,  16732 }, -- Runic Plate Leggings / 62
				{ 5,  16730 }, -- Imperial Plate Leggings / 61
				{ 6,  16662 }, -- Thorium Leggings / 60
				{ 7,  20876 }, -- Dark Iron Leggings / 60
				{ 8,  27829 }, -- Titanic Leggings / 60
				{ 9,  9945 }, -- Ornate Mithril Pants / 44
				{ 10, 9933 }, -- Heavy Mithril Pants / 42
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[MAIL_DIFF] = {
				{ 1, 1213748 }, -- Light Obsidian Belt / 68
				{ 2, 20872 }, -- Fiery Chain Girdle / 59
				{ 3, 23628 }, -- Heavy Timbermaw Belt / 58
				{ 4, 16645 }, -- Radiant Belt / 52
				{ 5, 2666 }, -- Runed Copper Belt / 18
				{ 6, 2661 }, -- Copper Chain Belt / 11
			},
			[PLATE_DIFF] = {
				{ 1, 1224637 }, -- Scarlet Soldier's Waistguard
				{ 2, 1213709 }, -- Ironvine Belt / 70
				{ 3, 1213746 }, -- Heavy Obsidian Belt / 68
				{ 4, 23632 }, -- Girdle of the Dawn / 58
				{ 5, 16647 }, -- Imperial Plate Belt / 53
				{ 6, 16643 }, -- Thorium Belt / 50
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[MAIL_DIFF] = {
				{ 1, 9937 }, -- Mithril Scale Bracers / 43
				{ 2, 7223 }, -- Golden Scale Bracers / 37
				{ 3, 3501 }, -- Green Iron Bracers / 33
				{ 4, 2672 }, -- Patterned Bronze Bracers / 25
				{ 5, 2664 }, -- Runed Copper Bracers / 19
				{ 6, 2663 }, -- Copper Bracers / 7
			},
			[PLATE_DIFF] = {
				{ 1, 1224635 }, -- Scarlet Soldier's Protectors
				{ 2, 28244 }, -- Icebane Bracers / 80
				{ 3, 20874 }, -- Dark Iron Bracers / 59
				{ 4, 16649 }, -- Imperial Plate Bracers / 54
				{ 5, 16644 }, -- Thorium Bracers / 51
			},
		},
		{
			name = ALIL["Shields"],
			[NORMAL_DIFF] = {
				{ 1, 1214270 }, -- Jagged Obsidian Shield / 70
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  9964 }, -- Mithril Spurs / 43

				{ 3,  7224 }, -- Steel Weapon Chain / 38
				{ 18, 7222 }, -- Iron Counterweight / 33

				{ 5,  16651 }, -- Thorium Shield Spike / 55
				{ 6,  9939 }, -- Mithril Shield Spike / 43
				{ 20, 7221 }, -- Iron Shield Spike / 30


				{ 8,  22757 }, -- Elemental Sharpening Stone / 60
				{ 9,  16641 }, -- Dense Sharpening Stone / 45
				{ 10, 9918 }, -- Solid Sharpening Stone / 35
				{ 11, 2674 }, -- Heavy Sharpening Stone / 25
				{ 12, 430397 }, -- Blackfathom Sharpening Stone
				{ 13, 2665 }, -- Coarse Sharpening Stone / 15
				{ 14, 2660 }, -- Rough Sharpening Stone / 5

				{ 24, 16640 }, -- Dense Weightstone / 45
				{ 25, 9921 }, -- Solid Weightstone / 35
				{ 26, 3117 }, -- Heavy Weightstone / 25
				{ 27, 3116 }, -- Coarse Weightstone / 15
				{ 28, 3115 }, -- Rough Weightstone / 5
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  20201 }, -- Arcanite Rod / 55
				{ 2,  14380 }, -- Truesilver Rod / 40
				{ 16, 14379 }, -- Golden Rod / 30
				{ 17, 7818 }, -- Silver Rod / 20
				{ 4,  19669 }, -- Arcanite Skeleton Key / 55
				{ 5,  19668 }, -- Truesilver Skeleton Key / 40
				{ 19, 19667 }, -- Golden Skeleton Key / 30
				{ 20, 19666 }, -- Silver Skeleton Key / 20
				{ 7,  11454 }, -- Inlaid Mithril Cylinder / 42
				{ 8,  435910 }, -- Low-Background Truesilver Plates
				{ 22, 8768 }, -- Iron Buckle / 30
				{ 10, 1213643 }, -- Obsidian Grinding Stone
				{ 11, 16639 }, -- Dense Grinding Stone / 45
				{ 12, 9920 }, -- Solid Grinding Stone / 35
				{ 25, 3337 }, -- Heavy Grinding Stone / 25
				{ 26, 3326 }, -- Coarse Grinding Stone / 20
				{ 27, 3320 }, -- Rough Grinding Stone / 10
			},
		},
	}
}

data["Enchanting"] = {
	name = ALIL["Enchanting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENCHANTING_LINK,
	items = {
		{
			name = AL["Oil"],
			[NORMAL_DIFF] = {
				{ 1,  25130 }, -- Brilliant Mana Oil / 310
				{ 2,  25129 }, -- Brilliant Wizard Oil / 310
				{ 3,  25128 }, -- Wizard Oil / 285
				{ 4,  25127 }, -- Lesser Mana Oil / 260
				{ 5,  25126 }, -- Lesser Wizard Oil / 210
				{ 6,  430409 }, -- Blackfathom Mana Oil
				{ 7,  25125 }, -- Minor Mana Oil / 160
				{ 8,  25124 }, -- Minor Wizard Oil / 55
				{ 16, 1213610 }, -- Enchanted Repellent
				{ 17, 463869 }, -- Conductive Shield Coating
			}
		},
		{
			name = ALIL["Wands"],
			[NORMAL_DIFF] = {
				{ 1, 439134 }, -- Greater Mystic Wand / 195
				{ 2, 14809 }, -- Lesser Mystic Wand / 175
				{ 3, 14807 }, -- Greater Magic Wand / 110
				{ 4, 14293 }, -- Lesser Magic Wand / 75
			}
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 1213593 }, -- Speedstone
				{ 2, 1213595 }, -- Tear of the Dreamer
				{ 3, 1213598 }, -- Lodestone of Retaliation
				{ 4, 1213600 }, -- Enchanted Stopwatch
				{ 5, 1213603 }, -- Ruby-Encrusted Broach
			}
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1,  1213628 }, -- Enchanted Prayer Tome
				{ 2,  1216005 }, -- Libram of Righteousness
				{ 3,  1216010 }, -- Libram of Sanctity
				{ 4,  1216007 }, -- Libram of the Exorcist
				{ 6,  1213633 }, -- Enchanted Totem
				{ 7,  1216018 }, -- Totem of Flowing Magma
				{ 8,  1216014 }, -- Totem of Pyroclastic Thunder
				{ 9,  1216016 }, -- Totem of Thunderous Strikes
				{ 11, 1213635 }, -- Enchanted Mushroom
				{ 12, 1216022 }, -- Idol of Feline Ferocity
				{ 13, 1216020 }, -- Idol of Sidereal Wrath
				{ 14, 1216024 }, -- Idol of Ursin Power
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  20051 }, -- Runed Arcanite Rod / 310
				{ 2,  13702 }, -- Runed Truesilver Rod / 220
				{ 3,  13628 }, -- Runed Golden Rod / 175
				{ 4,  7795 }, -- Runed Silver Rod / 130
				{ 5,  7421 }, -- Runed Copper Rod / 5

				{ 7,  1213607 }, -- Scroll: Wrath of the Swarm
				{ 8,  463866 }, -- Sigil of Flowing Waters
				{ 9,  446243 }, -- Sigil of Living Dreams
				{ 10, 439156 }, -- Sigil of Innovation
				{ 11, 448624 }, -- Scroll of Spatial Mending

				{ 16, 15596 }, -- Smoking Heart of the Mountain / 285
				{ 18, 17181 }, -- Enchanted Leather / 250
				{ 20, 17180 }, -- Enchanted Thorium / 250
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  1231128 }, -- Enchant Weapon - Grand Crusader
				{ 2,  1231164 }, -- Enchant Weapon - Grand Sorcerer
				{ 3,  23804 }, -- Enchant Weapon - Mighty Intellect / 320
				{ 4,  20034 }, -- Enchant Weapon - Crusader / 320
				{ 5,  20032 }, -- Enchant Weapon - Lifestealing / 320
				{ 6,  22749 }, -- Enchant Weapon - Spell Power / 320
				{ 7,  22750 }, -- Enchant Weapon - Healing Power / 320
				{ 8,  23803 }, -- Enchant Weapon - Mighty Spirit / 320
				{ 9,  20031 }, -- Enchant Weapon - Superior Striking / 320
				{ 10, 20033 }, -- Enchant Weapon - Unholy Weapon / 315
				{ 11, 23799 }, -- Enchant Weapon - Strength / 310
				{ 12, 23800 }, -- Enchant Weapon - Agility / 310
				{ 13, 20029 }, -- Enchant Weapon - Icy Chill / 305
				{ 14, 13898 }, -- Enchant Weapon - Fiery Weapon / 285
				{ 15, 13943 }, -- Enchant Weapon - Greater Striking / 265
				{ 16, 13915 }, -- Enchant Weapon - Demonslaying / 250
				{ 17, 435481 }, -- Enchant Weapon - Dismantle
				{ 18, 13693 }, -- Enchant Weapon - Striking / 215
				{ 19, 21931 }, -- Enchant Weapon - Winter / 210
				{ 20, 13653 }, -- Enchant Weapon - Lesser Beastslayer / 195
				{ 21, 13655 }, -- Enchant Weapon - Lesser Elemental Slayer / 195
				{ 22, 13503 }, -- Enchant Weapon - Lesser Striking / 165
				{ 23, 7788 }, -- Enchant Weapon - Minor Striking / 120
				{ 24, 7786 }, -- Enchant Weapon - Minor Beastslayer / 120
			}
		},
		{
			name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  1232172 }, -- Enchant 2H Weapon - Grand Inquisitor
				{ 2,  1231139 }, -- Enchant 2H Weapon - Grand Arcanist
				{ 3,  1219580 }, -- Enchant 2H Weapon - Spellblasting
				{ 4,  20035 }, -- Enchant 2H Weapon - Major Spirit / 320
				{ 5,  20036 }, -- Enchant 2H Weapon - Major Intellect / 320
				{ 6,  20030 }, -- Enchant 2H Weapon - Superior Impact / 315
				{ 7,  27837 }, -- Enchant 2H Weapon - Agility / 310
				{ 8,  13937 }, -- Enchant 2H Weapon - Greater Impact / 260
				{ 9,  13695 }, -- Enchant 2H Weapon - Impact / 220
				{ 10, 13529 }, -- Enchant 2H Weapon - Lesser Impact / 170
				{ 11, 13380 }, -- Enchant 2H Weapon - Lesser Spirit / 135
				{ 12, 7745 }, -- Enchant 2H Weapon - Minor Impact / 130
				{ 13, 7793 }, -- Enchant 2H Weapon - Lesser Intellect / 130
			}
		},
		{
			name = ALIL["Off Hand"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 1219577 }, -- Enchant Off-Hand - Superior Intellect
				{ 2, 1219579 }, -- Enchant Off-Hand - Wisdom
				{ 3, 1219578 }, -- Enchant Off-Hand - Excellent Spirit
			}
		},
		{
			name = ALIL["Shield"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  1220623 }, -- Enchant Shield - Critical Strike
				{ 2,  1219581 }, -- Enchant Shield - Excellent Stamina
				{ 3,  463871 }, -- Enchant Shield - Law of Nature
				{ 4,  20016 }, -- Enchant Shield - Superior Spirit / 300
				{ 5,  20017 }, -- Enchant Shield - Greater Stamina / 285
				{ 6,  13933 }, -- Enchant Shield - Frost Resistance / 255
				{ 7,  13905 }, -- Enchant Shield - Greater Spirit / 250
				{ 8,  13817 }, -- Enchant Shield - Stamina / 230
				{ 9,  13689 }, -- Enchant Shield - Lesser Block / 215
				{ 10, 13659 }, -- Enchant Shield - Spirit / 200
				{ 11, 13631 }, -- Enchant Shield - Lesser Stamina / 175
				{ 12, 13485 }, -- Enchant Shield - Lesser Spirit / 155
				{ 13, 13464 }, -- Enchant Shield - Lesser Protection / 140
				{ 14, 13378 }, -- Enchant Shield - Minor Stamina / 130
			}
		},
		{
			name = ALIL["Cloak"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  1219587 }, -- Enchant Cloak - Agility
				{ 2,  25086 }, -- Enchant Cloak - Dodge / 320
				{ 3,  25081 }, -- Enchant Cloak - Greater Fire Resistance / 320
				{ 4,  25082 }, -- Enchant Cloak - Greater Nature Resistance / 320
				{ 5,  25084 }, -- Enchant Cloak - Subtlety / 320
				{ 6,  25083 }, -- Enchant Cloak - Stealth / 320
				{ 7,  20015 }, -- Enchant Cloak - Superior Defense / 305
				{ 8,  20014 }, -- Enchant Cloak - Greater Resistance / 285
				{ 9,  13882 }, -- Enchant Cloak - Lesser Agility / 245
				{ 10, 13794 }, -- Enchant Cloak - Resistance / 225
				{ 11, 13746 }, -- Enchant Cloak - Greater Defense / 225
				{ 12, 13657 }, -- Enchant Cloak - Fire Resistance / 195
				{ 13, 13635 }, -- Enchant Cloak - Defense / 175
				{ 14, 13522 }, -- Enchant Cloak - Lesser Shadow Resistance / 160
				{ 15, 7861 }, -- Enchant Cloak - Lesser Fire Resistance / 150
				{ 16, 13421 }, -- Enchant Cloak - Lesser Protection / 140
				{ 17, 13419 }, -- Enchant Cloak - Minor Agility / 135
				{ 18, 7771 }, -- Enchant Cloak - Minor Protection / 110
				{ 19, 7454 }, -- Enchant Cloak - Minor Resistance / 95
			}
		},
		{
			name = ALIL["Chest"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  1213616 }, -- Enchant Chest - Living Stats
				{ 2,  20025 }, -- Enchant Chest - Greater Stats / 320
				{ 3,  20028 }, -- Enchant Chest - Major Mana / 310
				{ 4,  20026 }, -- Enchant Chest - Major Health / 295
				{ 5,  13941 }, -- Enchant Chest - Stats / 265
				{ 6,  435903 }, -- Enchant Chest - Retricutioner
				{ 7,  13917 }, -- Enchant Chest - Superior Mana / 250
				{ 8,  13858 }, -- Enchant Chest - Superior Health / 240
				{ 9,  13700 }, -- Enchant Chest - Lesser Stats / 220
				{ 10, 13663 }, -- Enchant Chest - Greater Mana / 205
				{ 11, 13640 }, -- Enchant Chest - Greater Health / 180
				{ 12, 13626 }, -- Enchant Chest - Minor Stats / 175
				{ 13, 13607 }, -- Enchant Chest - Mana / 170
				{ 14, 13538 }, -- Enchant Chest - Lesser Absorption / 165
				{ 15, 7857 }, -- Enchant Chest - Health / 145
				{ 16, 7776 }, -- Enchant Chest - Lesser Mana / 115
				{ 17, 7748 }, -- Enchant Chest - Lesser Health / 105
				{ 18, 7426 }, -- Enchant Chest - Minor Absorption / 90
				{ 19, 7443 }, -- Enchant Chest - Minor Mana / 80
				{ 20, 7420 }, -- Enchant Chest - Minor Health / 70
			}
		},
		{
			name = ALIL["Feet"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  20023 }, -- Enchant Boots - Greater Agility / 315
				{ 2,  20024 }, -- Enchant Boots - Spirit / 295
				{ 3,  20020 }, -- Enchant Boots - Greater Stamina / 280
				{ 4,  13935 }, -- Enchant Boots - Agility / 255
				{ 5,  13890 }, -- Enchant Boots - Minor Speed / 245
				{ 6,  13836 }, -- Enchant Boots - Stamina / 235
				{ 7,  13687 }, -- Enchant Boots - Lesser Spirit / 210
				{ 8,  13644 }, -- Enchant Boots - Lesser Stamina / 190
				{ 9,  13637 }, -- Enchant Boots - Lesser Agility / 180
				{ 10, 7867 }, -- Enchant Boots - Minor Agility / 150
				{ 11, 7863 }, -- Enchant Boots - Minor Stamina / 150
			}
		},
		{
			name = ALIL["Hand"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  1219586 }, -- Enchant Gloves - Superior Strength
				{ 2,  1213622 }, -- Enchant Gloves - Holy Power
				{ 3,  1213626 }, -- Enchant Gloves - Arcane Power
				{ 4,  25080 }, -- Enchant Gloves - Superior Agility / 320
				{ 5,  25073 }, -- Enchant Gloves - Shadow Power / 320
				{ 6,  25074 }, -- Enchant Gloves - Frost Power / 320
				{ 7,  25072 }, -- Enchant Gloves - Threat / 320
				{ 8,  25079 }, -- Enchant Gloves - Healing Power / 320
				{ 9,  25078 }, -- Enchant Gloves - Fire Power / 320
				{ 10, 20013 }, -- Enchant Gloves - Greater Strength / 315
				{ 11, 20012 }, -- Enchant Gloves - Greater Agility / 290
				{ 12, 13948 }, -- Enchant Gloves - Minor Haste / 270
				{ 13, 13947 }, -- Enchant Gloves - Riding Skill / 270
				{ 14, 13868 }, -- Enchant Gloves - Advanced Herbalism / 245
				{ 15, 13887 }, -- Enchant Gloves - Strength / 245
				{ 16, 13841 }, -- Enchant Gloves - Advanced Mining / 235
				{ 17, 13815 }, -- Enchant Gloves - Agility / 230
				{ 18, 13698 }, -- Enchant Gloves - Skinning / 220
				{ 19, 13617 }, -- Enchant Gloves - Herbalism / 170
				{ 20, 13620 }, -- Enchant Gloves - Fishing / 170
				{ 21, 13612 }, -- Enchant Gloves - Mining / 170
			}
		},
		{
			name = ALIL["Wrist"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1,  1220624 }, -- Enchant Bracer - Greater Spellpower
				{ 2,  1217189 }, -- Enchant Bracer - Spell Power
				{ 3,  1217203 }, -- Enchant Bracer - Agility
				{ 4,  23802 }, -- Enchant Bracer - Healing Power / 320
				{ 5,  20011 }, -- Enchant Bracer - Superior Stamina / 320
				{ 6,  20010 }, -- Enchant Bracer - Superior Strength / 315
				{ 7,  23801 }, -- Enchant Bracer - Mana Regeneration / 310
				{ 8,  20009 }, -- Enchant Bracer - Superior Spirit / 290
				{ 9,  20008 }, -- Enchant Bracer - Greater Intellect / 275
				{ 10, 13945 }, -- Enchant Bracer - Greater Stamina / 265
				{ 11, 13939 }, -- Enchant Bracer - Greater Strength / 260
				{ 12, 13931 }, -- Enchant Bracer - Deflection / 255
				{ 13, 13846 }, -- Enchant Bracer - Greater Spirit / 240
				{ 14, 13822 }, -- Enchant Bracer - Intellect / 230
				{ 15, 13661 }, -- Enchant Bracer - Strength / 200
				{ 16, 13648 }, -- Enchant Bracer - Stamina / 190
				{ 17, 13646 }, -- Enchant Bracer - Lesser Deflection / 190
				{ 18, 13642 }, -- Enchant Bracer - Spirit / 185
				{ 19, 13622 }, -- Enchant Bracer - Lesser Intellect / 175
				{ 20, 13536 }, -- Enchant Bracer - Lesser Strength / 165
				{ 21, 13501 }, -- Enchant Bracer - Lesser Stamina / 155
				{ 22, 7859 }, -- Enchant Bracer - Lesser Spirit / 145
				{ 23, 7779 }, -- Enchant Bracer - Minor Agility / 115
				{ 24, 7782 }, -- Enchant Bracer - Minor Strength / 115
				{ 25, 7766 }, -- Enchant Bracer - Minor Spirit / 105
				{ 26, 7457 }, -- Enchant Bracer - Minor Stamina / 100
				{ 27, 7428 }, -- Enchant Bracer - Minor Deflect / 80
				{ 28, 7418 }, -- Enchant Bracer - Minor Health / 70
			}
		},
	}
}

data["Engineering"] = {
	name = ALIL["Engineering"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENGINEERING_LINK,
	items = {
		{
			name = AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1,  1213588 }, -- Tuned Force Reactive Disk
				{ 2,  22797 }, -- Force Reactive Disk / 65
				{ 4,  12903 }, -- Gnomish Harm Prevention Belt / 43
				{ 6,  8895 }, -- Goblin Rocket Boots / 45
				{ 8,  446236 }, -- Void-Powered Invoker's Vambraces
				{ 9,  446238 }, -- Void-Powered Protector's Vambraces
				{ 10, 446237 }, -- Void-Powered Slayer's Vambraces
				{ 16, 19819 }, -- Voice Amplification Modulator / 58
				{ 19, 12616 }, -- Parachute Cloak / 45
				{ 21, 12905 }, -- Gnomish Rocket Boots / 45
				{ 23, 435960 }, -- Hyperconductive Goldwrap
				{ 25, 435958 }, -- Whirling Truesilver Gearwall
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1,  1221012 }, -- Creepy Censor Sensors
				{ 2,  24357 }, -- Bloodvine Lens / 65
				{ 3,  24356 }, -- Bloodvine Goggles / 65
				{ 4,  19825 }, -- Master Engineer / 58
				{ 5,  19794 }, -- Spellpower Goggles Xtreme Plus / 54
				{ 6,  12622 }, -- Green Lens / 49
				{ 7,  12758 }, -- Goblin Rocket Helmet / 47
				{ 8,  12907 }, -- Gnomish Mind Control Cap / 47
				{ 9,  12618 }, -- Rose Colored Goggles / 46
				{ 10, 12617 }, -- Deepdive Helmet / 46
				{ 11, 12607 }, -- Catseye Ultra Goggles / 44
				{ 12, 12615 }, -- Spellpower Goggles Xtreme / 43
				{ 13, 12897 }, -- Gnomish Goggles / 42
				{ 14, 12594 }, -- Fire Goggles / 41
				{ 15, 12717 }, -- Goblin Mining Helmet / 41
				{ 16, 12718 }, -- Goblin Construction Helmet / 41
				{ 17, 3966 }, -- Craftsman / 37
				{ 18, 12587 }, -- Bright-Eye Goggles / 35
				{ 19, 3956 }, -- Green Tinted Goggles / 30
				{ 20, 3940 }, -- Shadow Goggles / 24
				{ 21, 3934 }, -- Flying Tiger Goggles / 20
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1,  1226213 }, -- Semisafe Transporter: New Avalon
				{ 2,  19830 }, -- Arcanite Dragonling / 60
				{ 3,  23082 }, -- Ultra-Flash Shadow Reflector / 60
				{ 4,  23081 }, -- Hyper-Radiant Flame Reflector / 58
				{ 5,  23486 }, -- Dimensional Ripper - Everlook / 55
				{ 6,  23079 }, -- Major Recombobulator / 55
				{ 7,  23078 }, -- Goblin Jumper Cables XL / 53
				{ 8,  23077 }, -- Gyrofreeze Ice Reflector / 52
				{ 9,  23489 }, -- Ultrasafe Transporter: Gadgetzan / 52
				{ 10, 12624 }, -- Mithril Mechanical Dragonling / 50
				{ 11, 12908 }, -- Goblin Dragon Gun / 48
				{ 12, 12759 }, -- Gnomish Death Ray / 48
				{ 13, 12906 }, -- Gnomish Battle Chicken / 46
				{ 14, 12755 }, -- Goblin Bomb Dispenser / 46
				{ 15, 12902 }, -- Gnomish Net-o-Matic Projector / 42
				{ 16, 12899 }, -- Gnomish Shrink Ray / 41
				{ 17, 3969 }, -- Mechanical Dragonling / 40
				{ 18, 3971 }, -- Gnomish Cloaking Device / 40
				{ 19, 9273 }, -- Goblin Jumper Cables / 33
				{ 20, 3952 }, -- Minor Recombobulator / 28
				{ 21, 9269 }, -- Gnomish Universal Remote / 25
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 1217207 }, -- Obsidian Scope
				{ 2, 22793 }, -- Biznicks 247x128 Accurascope / 60
				{ 3, 12620 }, -- Sniper Scope / 48
				{ 4, 12597 }, -- Deadly Scope / 42
				{ 5, 3979 }, -- Accurate Scope / 36
				{ 6, 3978 }, -- Standard Scope / 22
				{ 7, 3977 }, -- Crude Scope / 12
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Guns"],
			[NORMAL_DIFF] = {
				{ 1,  1214145 }, -- Obsidian Shotgun
				{ 2,  461710 }, -- Fiery Core Sharpshooter Rifle
				{ 3,  19833 }, -- Flawless Arcanite Rifle / 61
				{ 4,  19796 }, -- Dark Iron Rifle / 55
				{ 5,  19792 }, -- Thorium Rifle / 52
				{ 6,  12614 }, -- Mithril Heavy-bore Rifle / 44
				{ 7,  12595 }, -- Mithril Blunderbuss / 41
				{ 8,  3954 }, -- Moonsight Rifle / 29
				{ 9,  3949 }, -- Silver-plated Shotgun / 26
				{ 10, 3939 }, -- Lovingly Crafted Boomstick / 24
				{ 11, 3936 }, -- Deadly Blunderbuss / 21
				{ 12, 3925 }, -- Rough Boomstick / 10
			}
		},
		{
			name = ALIL["Projectile"].." - "..ALIL["Bullet"],
			[NORMAL_DIFF] = {
				{ 1, 19800 }, -- Thorium Shells / 57
				{ 2, 12621 }, -- Mithril Gyro-Shot / 49
				{ 3, 12596 }, -- Hi-Impact Mithril Slugs / 42
				{ 4, 3947 }, -- Crafted Solid Shot / 35
				{ 5, 3930 }, -- Crafted Heavy Shot / 20
				{ 6, 3920 }, -- Crafted Light Shot / 10
			}
		},
		{
			name = ALIL["Parts"],
			[NORMAL_DIFF] = {
				{ 1,  1226206 }, -- Tinkerbox
				{ 2,  1213646 }, -- Obsidian Blasting Powder
				{ 3,  19815 }, -- Delicate Arcanite Converter / 58
				{ 4,  19791 }, -- Thorium Widget / 52
				{ 5,  19788 }, -- Dense Blasting Powder / 50
				{ 6,  23071 }, -- Truesilver Transformer / 50
				{ 7,  12599 }, -- Mithril Casing / 43
				{ 8,  12591 }, -- Unstable Trigger / 40
				{ 9,  19795 }, -- Thorium Tube / 39
				{ 10, 12589 }, -- Mithril Tube / 39
				{ 11, 12585 }, -- Solid Blasting Powder / 35
				{ 12, 3961 }, -- Gyrochronatom / 34
				{ 13, 3958 }, -- Iron Strut / 32
				{ 14, 12584 }, -- Gold Power Core / 30
				{ 15, 3953 }, -- Bronze Framework / 29
				{ 16, 3945 }, -- Heavy Blasting Powder / 25
				{ 17, 3942 }, -- Whirring Bronze Gizmo / 25
				{ 18, 3938 }, -- Bronze Tube / 21
				{ 19, 3973 }, -- Silver Contact / 18
				{ 20, 3926 }, -- Copper Modulator / 13
				{ 21, 3929 }, -- Coarse Blasting Powder / 15
				{ 22, 3924 }, -- Copper Tube / 10
				{ 23, 3922 }, -- Handful of Copper Bolts / 8
				{ 24, 3918 }, -- Rough Blasting Powder / 5
			}
		},
		{
			name = AL["Fireworks"],
			[NORMAL_DIFF] = {
				{ 16, 26443 }, -- Cluster Launcher / 1
				{ 1,  26442 }, -- Firework Launcher / 1
				{ 3,  26418 }, -- Small Red Rocket / 1
				{ 4,  26417 }, -- Small Green Rocket / 1
				{ 5,  26416 }, -- Small Blue Rocket / 1
				{ 7,  26425 }, -- Red Rocket Cluster / 1
				{ 8,  26424 }, -- Green Rocket Cluster / 1
				{ 9,  26423 }, -- Blue Rocket Cluster / 1
				{ 12, 23066 }, -- Red Firework / 20
				{ 13, 23068 }, -- Green Firework / 20
				{ 14, 23067 }, -- Blue Firework / 20
				{ 18, 26422 }, -- Large Red Rocket / 1
				{ 19, 26421 }, -- Large Green Rocket / 1
				{ 20, 26420 }, -- Large Blue Rocket / 1
				{ 22, 26428 }, -- Large Red Rocket Cluster / 1
				{ 23, 26427 }, -- Large Green Rocket Cluster / 1
				{ 24, 26426 }, -- Large Blue Rocket Cluster / 1
				{ 27, 23507 }, -- Snake Burst Firework / 50
			}
		},
		{
			name = ALIL["Explosives"],
			[NORMAL_DIFF] = {
				{ 1,  1213573 }, -- Arcane Megabomb
				{ 2,  1213576 }, -- The Fumigator
				{ 3,  1213578 }, -- Obsidian Bomb
				{ 4,  19831 }, -- Arcane Bomb / 60
				{ 5,  19799 }, -- Dark Iron Bomb / 57
				{ 6,  19790 }, -- Thorium Grenade / 55
				{ 7,  23070 }, -- Dense Dynamite / 45
				{ 8,  12619 }, -- Hi-Explosive Bomb / 47
				{ 9,  12754 }, -- The Big One / 45
				{ 10, 435966 }, -- Ez-Thro Radiation Bomb
				{ 11, 435964 }, -- High-Yield Radiation Bomb
				{ 12, 3968 }, -- Goblin Land Mine / 39
				{ 13, 12603 }, -- Mithril Frag Bomb / 43
				{ 14, 12760 }, -- Goblin Sapper Charge / 41
				{ 15, 23069 }, -- Ez-Thro Dynamite II / 40
				{ 16, 3967 }, -- Big Iron Bomb / 43
				{ 17, 8243 }, -- Flash Bomb / 37
				{ 18, 3962 }, -- Iron Grenade / 35
				{ 19, 12586 }, -- Solid Dynamite / 35
				{ 20, 3955 }, -- Explosive Sheep / 30
				{ 21, 3950 }, -- Big Bronze Bomb / 33
				{ 22, 3946 }, -- Heavy Dynamite / 30
				{ 23, 3941 }, -- Small Bronze Bomb / 29
				{ 24, 8339 }, -- Ez-Thro Dynamite / 25
				{ 25, 3937 }, -- Large Copper Bomb / 26
				{ 26, 3931 }, -- Coarse Dynamite / 20
				{ 27, 3923 }, -- Rough Copper Bomb / 14
				{ 28, 3919 }, -- Rough Dynamite / 10
			}
		},
		{
			name = AL["Pets"],
			[NORMAL_DIFF] = {
				{ 1, 19793 }, -- Lifelike Mechanical Toad / 53
				{ 2, 15633 }, -- Lil' Smoky / 41
				{ 3, 15628 }, -- Pet Bombling / 41
				{ 4, 3928 }, -- Mechanical Squirrel Box / 15
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,   23080 }, -- Powerful Seaforium Charge / 52
				{ 2,   3972 }, -- Large Seaforium Charge / 40
				{ 3,   3933 }, -- Small Seaforium Charge / 20
				{ 5,   22704 }, -- Field Repair Bot 74A / 60
				{ 6,   15255 }, -- Mechanical Repair Kit / 40
				{ 8,   19814 }, -- Masterwork Target Dummy / 55
				{ 9,   3965 }, -- Advanced Target Dummy / 37
				{ 10,  3932 }, -- Target Dummy / 17
				{ 12,  28327 }, -- Steam Tonk Controller / 55
				{ 13,  9271 }, -- Aquadynamic Fish Attractor / 30
				{ 15,  12715 }, -- Recipe: Goblin Rocket Fuel / 42
				{ 16,  3957 }, -- Ice Deflector / 31
				{ 17,  3944 }, -- Flame Deflector / 25
				{ 19,  23129 }, -- World Enlarger / 50
				{ 20,  12590 }, -- Gyromatic Micro-Adjustor / 35
				{ 21,  3959 }, -- Discombobulator Ray / 32
				{ 22,  26011 }, -- Tranquil Mechanical Yeti / 60
				{ 23,  23096 }, -- Gnomish Alarm-O-Bot / 53
				{ 24,  19567 }, -- Salt Shaker / 50
				{ 25,  21940 }, -- SnowMaster 9000 / 38
				{ 26,  3963 }, -- Compact Harvest Reaper Kit / 35
				{ 27,  3960 }, -- Portable Bronze Mortar / 33
				{ 28,  6458 }, -- Ornate Spyglass / 27
				{ 29,  8334 }, -- Practice Lock / 20
				{ 30,  12895 }, -- Plans: Inlaid Mithril Cylinder / 40
				{ 101, 1226207 }, -- Tinkerbox: Teleport
				{ 102, 1226208 }, -- Tinkerbox: Nitro Boosts
				{ 103, 1226209 }, -- Tinkerbox: Magnetic Displacement
				{ 104, 1228088 }, -- Pup-Up Shrub
				{ 106, 1213586 }, -- G00 DV-1B3 Generator
				{ 108, 435956 }, -- Polished Truesilver Gears
				{ 109, 431362 }, -- Soul Vessel
				{ 111, 424641 }, -- Shredder Autosalvage Unit
			}
		},
	}
}

data["Tailoring"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.TAILORING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1,  28208 }, --Glacial Cloak / 80
				{ 2,  28210 }, --Gaea's Embrace / 70
				{ 3,  22870 }, --Cloak of Warding / 62
				{ 4,  18418 }, --Cindercloth Cloak / 55
				{ 5,  18420 }, --Brightcloth Cloak / 55
				{ 6,  18422 }, --Cloak of Fire / 55
				{ 7,  18409 }, --Runecloth Cloak / 53
				{ 8,  3862 }, --Icy Cloak / 40
				{ 9,  3861 }, --Long Silken Cloak / 37
				{ 10, 8789 }, --Crimson Silk Cloak / 36
				{ 11, 8786 }, --Azure Silk Cloak / 35
				{ 12, 3844 }, --Heavy Woolen Cloak / 21
				{ 13, 6521 }, --Pearl-clasped Cloak / 19
				{ 14, 2402 }, --Woolen Cape / 16
				{ 15, 2397 }, --Reinforced Linen Cape / 12
				{ 16, 2387 }, --Linen Cloak / 6
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1,  28481 }, --Sylvan Crown / 70
				{ 2,  18452 }, --Mooncloth Circlet / 62
				{ 3,  18450 }, --Wizardweave Turban / 61
				{ 4,  18444 }, --Runecloth Headband / 59
				{ 5,  18442 }, --Felcloth Hood / 58
				{ 6,  12092 }, --Dreamweave Circlet / 50
				{ 7,  12086 }, --Shadoweave Mask / 49
				{ 8,  12084 }, --Red Mageweave Headband / 48
				{ 9,  12081 }, --Admiral's Hat / 48
				{ 10, 12072 }, --Black Mageweave Headband / 46
				{ 11, 12059 }, --White Bandit Mask / 43
				{ 12, 3858 }, --Shadow Hood / 34
				{ 13, 3857 }, --Enchanter's Cowl / 33
				{ 14, 8762 }, --Silk Headband / 32
				{ 15, 8760 }, --Azure Silk Hood / 29
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[NORMAL_DIFF] = {
				{ 1,  28482 }, --Sylvan Shoulders / 70 / 315
				{ 2,  23663 }, --Mantle of the Timbermaw / 64 / 315
				{ 3,  23665 }, --Argent Shoulders / 64 / 315
				{ 4,  18453 }, --Felcloth Shoulders / 62 / 315
				{ 5,  20848 }, --Flarecore Mantle / 61 / 315
				{ 6,  18449 }, --Runecloth Shoulders / 61 / 315
				{ 7,  18448 }, --Mooncloth Shoulders / 61 / 315
				{ 8,  12078 }, --Red Mageweave Shoulders / 47 / 250
				{ 9,  12076 }, --Shadoweave Shoulders / 47 / 250
				{ 10, 12074 }, --Black Mageweave Shoulders / 46 / 245
				{ 11, 8793 }, --Crimson Silk Shoulders / 38 / 210
				{ 12, 8795 }, --Azure Shoulders / 38 / 210
				{ 13, 8774 }, --Green Silken Shoulders / 36 / 200
				{ 14, 3849 }, --Reinforced Woolen Shoulders / 24 / 145
				{ 15, 3848 }, --Double-stitched Woolen Shoulders / 22 / 135
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[NORMAL_DIFF] = {
				{ 1,   28207 }, --Glacial Vest / 80
				{ 2,   28480 }, --Sylvan Vest / 70
				{ 3,   23666 }, --Flarecore Robe / 66
				{ 4,   24091 }, --Bloodvine Vest / 65
				{ 5,   18457 }, --Robe of the Archmage / 62
				{ 6,   18456 }, --Truefaith Vestments / 62
				{ 7,   18458 }, --Robe of the Void / 62
				{ 8,   22902 }, --Mooncloth Robe / 61
				{ 9,   18451 }, --Felcloth Robe / 61
				{ 10,  18446 }, --Wizardweave Robe / 60
				{ 11,  18447 }, --Mooncloth Vest / 60
				{ 12,  18436 }, --Robe of Winter Night / 57
				{ 13,  18416 }, --Ghostweave Vest / 55
				{ 14,  18414 }, --Brightcloth Robe / 54
				{ 15,  18408 }, --Cindercloth Vest / 52
				{ 16,  18407 }, --Runecloth Tunic / 52
				{ 17,  18406 }, --Runecloth Robe / 52
				{ 18,  18404 }, --Frostweave Robe / 51
				{ 19,  18403 }, --Frostweave Tunic / 51
				{ 20,  12077 }, --Simple Black Dress / 47
				{ 21,  12070 }, --Dreamweave Vest / 45
				{ 22,  12069 }, --Cindercloth Robe / 45
				{ 23,  12056 }, --Red Mageweave Vest / 43
				{ 24,  12055 }, --Shadoweave Robe / 43
				{ 25,  12050 }, --Black Mageweave Robe / 42
				{ 26,  12048 }, --Black Mageweave Vest / 41
				{ 27,  8802 }, --Crimson Silk Robe / 41
				{ 28,  8770 }, --Robe of Power / 38
				{ 29,  8791 }, --Crimson Silk Vest / 37
				{ 30,  12091 }, --White Wedding Dress / 35
				{ 101, 12093 }, --Tuxedo Jacket / 35
				{ 102, 8764 }, --Earthen Vest / 34
				{ 103, 8784 }, --Green Silk Armor / 33
				{ 104, 6692 }, --Robes of Arcana / 30
				{ 105, 3859 }, --Azure Silk Vest / 30
				{ 106, 6690 }, --Lesser Wizard's Robe / 27
				{ 107, 7643 }, --Greater Adept's Robe / 23
				{ 108, 8467 }, --White Woolen Dress / 22
				{ 109, 2403 }, --Gray Woolen Robe / 21
				{ 110, 7639 }, --Blue Overalls / 20
				{ 111, 2399 }, --Green Woolen Vest / 17
				{ 112, 2395 }, --Barbaric Linen Vest / 14
				{ 113, 7633 }, --Blue Linen Robe / 14
				{ 114, 7629 }, --Red Linen Vest / 12
				{ 115, 7630 }, --Blue Linen Vest / 12
				{ 116, 8465 }, --Simple Dress / 10
				{ 117, 7624 }, --White Linen Robe / 10
				{ 118, 2389 }, --Red Linen Robe / 10
				{ 119, 7623 }, --Brown Linen Robe / 10
				{ 120, 2385 }, --Brown Linen Vest / 8
				{ 121, 26407 }, --Festival Suit / 1
				{ 122, 26403 }, --Festival Dress / 1
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[NORMAL_DIFF] = {
				{ 1,  24093 }, --Bloodvine Boots / 65
				{ 2,  24903 }, --Runed Stygian Boots / 63
				{ 3,  23664 }, --Argent Boots / 58
				{ 4,  18437 }, --Felcloth Boots / 57
				{ 5,  19435 }, --Mooncloth Boots / 56
				{ 6,  18423 }, --Runecloth Boots / 56
				{ 7,  12088 }, --Cindercloth Boots / 49
				{ 8,  12082 }, --Shadoweave Boots / 48
				{ 9,  12073 }, --Black Mageweave Boots / 46
				{ 10, 3860 }, --Boots of the Enchanter / 35
				{ 11, 3856 }, --Spider Silk Slippers / 28
				{ 12, 3855 }, --Spidersilk Boots / 25
				{ 13, 3847 }, --Red Woolen Boots / 20
				{ 14, 2401 }, --Woolen Boots / 19
				{ 15, 3845 }, --Soft-soled Linen Boots / 16
				{ 16, 2386 }, --Linen Boots / 13
				{ 17, 12045 }, --Simple Linen Boots / 9
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[NORMAL_DIFF] = {
				{ 1,  28205 }, --Glacial Gloves / 80
				{ 2,  22869 }, --Mooncloth Gloves / 62
				{ 3,  22867 }, --Felcloth Gloves / 62
				{ 4,  20849 }, --Flarecore Gloves / 62
				{ 5,  22868 }, --Inferno Gloves / 62
				{ 6,  18454 }, --Gloves of Spell Mastery / 62
				{ 7,  18417 }, --Runecloth Gloves / 55
				{ 8,  18415 }, --Brightcloth Gloves / 54
				{ 9,  18413 }, --Ghostweave Gloves / 54
				{ 10, 18412 }, --Cindercloth Gloves / 54
				{ 11, 18411 }, --Frostweave Gloves / 53
				{ 12, 12071 }, --Shadoweave Gloves / 45
				{ 13, 12066 }, --Red Mageweave Gloves / 45
				{ 14, 12067 }, --Dreamweave Gloves / 45
				{ 15, 12053 }, --Black Mageweave Gloves / 43
				{ 16, 8804 }, --Crimson Silk Gloves / 42
				{ 17, 8782 }, --Truefaith Gloves / 30
				{ 18, 8780 }, --Hands of Darkness / 29
				{ 19, 3854 }, --Azure Silk Gloves / 29
				{ 20, 3852 }, --Gloves of Meditation / 26
				{ 21, 3868 }, --Phoenix Gloves / 25
				{ 22, 3843 }, --Heavy Woolen Gloves / 17
				{ 23, 3840 }, --Heavy Linen Gloves / 10
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[NORMAL_DIFF] = {
				{ 1,  23667 }, --Flarecore Leggings / 70
				{ 2,  24092 }, --Bloodvine Leggings / 65
				{ 3,  24901 }, --Runed Stygian Leggings / 63
				{ 4,  18440 }, --Mooncloth Leggings / 58
				{ 5,  18439 }, --Brightcloth Pants / 58
				{ 6,  18441 }, --Ghostweave Pants / 58
				{ 7,  18438 }, --Runecloth Pants / 57
				{ 8,  18424 }, --Frostweave Pants / 56
				{ 9,  18434 }, --Cindercloth Pants / 56
				{ 10, 18419 }, --Felcloth Pants / 55
				{ 11, 18421 }, --Wizardweave Leggings / 55
				{ 12, 12060 }, --Red Mageweave Pants / 43
				{ 13, 12052 }, --Shadoweave Pants / 42
				{ 14, 12049 }, --Black Mageweave Leggings / 41
				{ 15, 8799 }, --Crimson Silk Pantaloons / 39
				{ 16, 12089 }, --Tuxedo Pants / 35
				{ 17, 8758 }, --Azure Silk Pants / 28
				{ 18, 3851 }, --Phoenix Pants / 25
				{ 19, 12047 }, --Colorful Kilt / 24
				{ 20, 3850 }, --Heavy Woolen Pants / 22
				{ 21, 12046 }, --Simple Kilt / 15
				{ 22, 3842 }, --Handstitched Linen Britches / 14
				{ 23, 3914 }, --Brown Linen Pants / 10
				{ 24, 12044 }, --Simple Linen Pants / 7
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Body"],
			[NORMAL_DIFF] = {
				{ 1,  12085 }, --Tuxedo Shirt / 1 / 245
				{ 2,  12080 }, --Pink Mageweave Shirt / 47 / 240
				{ 3,  12075 }, --Lavender Mageweave Shirt / 46 / 235
				{ 4,  12064 }, --Orange Martial Shirt / 40 / 225
				{ 5,  12061 }, --Orange Mageweave Shirt / 43 / 220
				{ 6,  3873 }, --Black Swashbuckler's Shirt / 40 / 210
				{ 7,  21945 }, --Green Holiday Shirt / 40 / 200
				{ 8,  3872 }, --Rich Purple Silk Shirt / 37 / 195
				{ 9,  8489 }, --Red Swashbuckler's Shirt / 35 / 185
				{ 10, 3871 }, --Formal White Shirt / 34 / 180
				{ 11, 8483 }, --White Swashbuckler's Shirt / 32 / 170
				{ 12, 3870 }, --Dark Silk Shirt / 31 / 165
				{ 13, 7893 }, --Stylish Green Shirt / 25 / 145
				{ 14, 3869 }, --Bright Yellow Shirt / 27 / 145
				{ 15, 7892 }, --Stylish Blue Shirt / 25 / 145
				{ 16, 3866 }, --Stylish Red Shirt / 22 / 135
				{ 17, 2406 }, --Gray Woolen Shirt / 20 / 110
				{ 18, 2396 }, --Green Linen Shirt / 14 / 95
				{ 19, 2394 }, --Blue Linen Shirt / 10 / 65
				{ 20, 2392 }, --Red Linen Shirt / 10 / 65
				{ 21, 2393 }, --White Linen Shirt / 7 / 35
				{ 22, 3915 }, --Brown Linen Shirt / 7 / 35
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[NORMAL_DIFF] = {
				{ 1,  24902 }, --Runed Stygian Belt / 63 / 315
				{ 2,  22866 }, --Belt of the Archmage / 62 / 315
				{ 3,  23662 }, --Wisdom of the Timbermaw / 58 / 305
				{ 4,  18410 }, --Ghostweave Belt / 53 / 280
				{ 5,  18402 }, --Runecloth Belt / 51 / 270
				{ 6,  3864 }, --Star Belt / 40 / 220
				{ 7,  8797 }, --Earthen Silk Belt / 39 / 215
				{ 8,  3863 }, --Spider Belt / 36 / 200
				{ 9,  8772 }, --Crimson Silk Belt / 35 / 195
				{ 10, 8766 }, --Azure Silk Belt / 35 / 195
				{ 11, 8776 }, --Linen Belt / 9 / 50
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[NORMAL_DIFF] = {
				{ 1, 28209 }, --Glacial Wrists / 80 / 315
				{ 2, 22759 }, --Flarecore Wraps / 64 / 320
				{ 3, 3841 }, --Green Linen Bracers / 12 / 85
			}
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1,  18455 }, --Bottomless Bag / 62 / 315
				{ 2,  18445 }, --Mooncloth Bag / 60 / 315
				{ 3,  18405 }, --Runecloth Bag / 52 / 275
				{ 4,  12079 }, --Red Mageweave Bag / 35 / 250
				{ 5,  12065 }, --Mageweave Bag / 35 / 240
				{ 6,  6695 }, --Black Silk Pack / 25 / 205
				{ 7,  6693 }, --Green Silk Pack / 25 / 195
				{ 8,  3813 }, --Small Silk Pack / 25 / 170
				{ 9,  6688 }, --Red Woolen Bag / 15 / 140
				{ 10, 3758 }, --Green Woolen Bag / 15 / 120
				{ 11, 3757 }, --Woolen Bag / 15 / 105
				{ 12, 6686 }, --Red Linen Bag / 5 / 95
				{ 13, 3755 }, --Linen Bag / 5 / 70
				{ 16, 27725 }, --Satchel of Cenarius / 65 / 315
				{ 17, 27724 }, --Cenarion Herb Bag / 55 / 290
				{ 19, 27660 }, --Big Bag of Enchantment / 65 / 315
				{ 20, 27659 }, --Enchanted Runecloth Bag / 55 / 290
				{ 21, 27658 }, --Enchanted Mageweave Pouch / 45 / 240
				{ 23, 26087 }, --Core Felcloth Bag / 60 / 315
				{ 24, 26086 }, --Felcloth Bag / 57 / 300
				{ 25, 26085 }, --Soul Pouch / 52 / 275
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 18560 }, --Mooncloth / 55 / 290
				{ 3, 18401 }, --Bolt of Runecloth / 55 / 255
				{ 4, 3865 }, --Bolt of Mageweave / 45 / 180
				{ 5, 3839 }, --Bolt of Silk Cloth / 35 / 135
				{ 6, 2964 }, --Bolt of Woolen Cloth / 25 / 90
				{ 7, 2963 }, --Bolt of Linen Cloth / 10 / 25
			}
		},
	}
}

data["Leatherworking"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.LEATHERWORKING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1,  22927 }, --Hide of the Wild / 62 / 320
				{ 2,  22928 }, --Shifting Cloak / 62 / 320
				{ 3,  22926 }, --Chromatic Cloak / 62 / 320
				{ 4,  19093 }, --Onyxia Scale Cloak / 60 / 320
				{ 5,  10574 }, --Wild Leather Cloak / 50 / 270
				{ 6,  10562 }, --Big Voodoo Cloak / 48 / 260
				{ 7,  7153 }, --Guardian Cloak / 37 / 205
				{ 8,  9198 }, --Frost Leather Cloak / 36 / 200
				{ 9,  3760 }, --Hillman's Cloak / 30 / 170
				{ 10, 2168 }, --Dark Leather Cloak / 22 / 135
				{ 11, 9070 }, --Black Whelp Cloak / 20 / 125
				{ 12, 7953 }, --Deviate Scale Cloak / 18 / 120
				{ 13, 2159 }, --Fine Leather Cloak / 15 / 105
				{ 14, 2162 }, --Embossed Leather Cloak / 13 / 90
				{ 15, 9058 }, --Handstitched Leather Cloak / 9 / 40
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[LEATHER_DIFF] = {
				{ 1,   28219 }, --Polar Tunic / 80 / 320
				{ 2,   24121 }, --Primal Batskin Jerkin / 65 / 320
				{ 3,   24124 }, --Blood Tiger Breastplate / 65 / 320
				{ 4,   19102 }, --Runic Leather Armor / 62 / 320
				{ 5,   19104 }, --Frostsaber Tunic / 62 / 320
				{ 6,   19098 }, --Wicked Leather Armor / 61 / 320
				{ 7,   19095 }, --Living Breastplate / 60 / 320
				{ 8,   19086 }, --Ironfeather Breastplate / 58 / 310
				{ 9,   19081 }, --Chimeric Vest / 58 / 310
				{ 10,  19076 }, --Volcanic Breastplate / 57 / 305
				{ 11,  19079 }, --Stormshroud Armor / 57 / 305
				{ 12,  19068 }, --Warbear Harness / 55 / 295
				{ 13,  10647 }, --Feathered Breastplate / 50 / 270
				{ 14,  10544 }, --Wild Leather Vest / 45 / 245
				{ 15,  10520 }, --Big Voodoo Robe / 43 / 235
				{ 16,  10499 }, --Nightscape Tunic / 41 / 225
				{ 17,  6661 }, --Barbaric Harness / 38 / 210
				{ 18,  3773 }, --Guardian Armor / 35 / 195
				{ 19,  9197 }, --Green Whelp Armor / 35 / 195
				{ 20,  9196 }, --Dusky Leather Armor / 35 / 195
				{ 21,  6704 }, --Thick Murloc Armor / 34 / 190
				{ 22,  4096 }, --Raptor Hide Harness / 33 / 185
				{ 23,  3772 }, --Green Leather Armor / 31 / 175
				{ 24,  2166 }, --Toughened Leather Armor / 24 / 145
				{ 25,  24940 }, --Black Whelp Tunic / 20 / 125
				{ 26,  3762 }, --Hillman's Leather Vest / 20 / 125
				{ 27,  2169 }, --Dark Leather Tunic / 20 / 125
				{ 28,  6703 }, --Murloc Scale Breastplate / 19 / 125
				{ 29,  8322 }, --Moonglow Vest / 18 / 115
				{ 30,  3761 }, --Fine Leather Tunic / 17 / 115
				{ 101, 2163 }, --White Leather Jerkin / 13 / 90
				{ 102, 2160 }, --Embossed Leather Vest / 12 / 70
				{ 103, 7126 }, --Handstitched Leather Vest / 8 / 40
			},
			[MAIL_DIFF] = {
				{ 1,  28222 }, --Icy Scale Breastplate / 80 / 320
				{ 2,  24703 }, --Dreamscale Breastplate / 68 / 320
				{ 3,  24851 }, --Sandstalker Breastplate / 62 / 320
				{ 4,  24848 }, --Spitfire Breastplate / 62 / 320
				{ 5,  19054 }, --Red Dragonscale Breastplate / 61 / 320
				{ 6,  19085 }, --Black Dragonscale Breastplate / 58 / 310
				{ 7,  19077 }, --Blue Dragonscale Breastplate / 57 / 305
				{ 8,  19051 }, --Heavy Scorpid Vest / 53 / 285
				{ 9,  19050 }, --Green Dragonscale Breastplate / 52 / 280
				{ 10, 10650 }, --Dragonscale Breastplate / 51 / 275
				{ 11, 10525 }, --Tough Scorpid Breastplate / 44 / 240
				{ 12, 10511 }, --Turtle Scale Breastplate / 42 / 230
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[LEATHER_DIFF] = {
				{ 1,  28473 }, --Bramblewood Boots / 70 / 320
				{ 2,  22922 }, --Mongoose Boots / 62 / 320
				{ 3,  20853 }, --Corehound Boots / 59 / 315
				{ 4,  23705 }, --Dawn Treaders / 58 / 310
				{ 5,  19063 }, --Chimeric Boots / 55 / 295
				{ 6,  19066 }, --Frostsaber Boots / 55 / 295
				{ 7,  10566 }, --Wild Leather Boots / 49 / 265
				{ 8,  10558 }, --Nightscape Boots / 47 / 255
				{ 9,  9207 }, --Dusky Boots / 40 / 220
				{ 10, 9208 }, --Swift Boots / 40 / 220
				{ 11, 2167 }, --Dark Leather Boots / 20 / 125
				{ 12, 2158 }, --Fine Leather Boots / 18 / 120
				{ 13, 2161 }, --Embossed Leather Boots / 15 / 85
				{ 14, 2149 }, --Handstitched Leather Boots / 8 / 40
			},
			[MAIL_DIFF] = {
				{ 1, 20855 }, --Black Dragonscale Boots / 61 / 320
				{ 2, 10554 }, --Tough Scorpid Boots / 47 / 255
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[LEATHER_DIFF] = {
				{ 1,  28220 }, --Polar Gloves / 80 / 320
				{ 2,  24122 }, --Primal Batskin Gloves / 65 / 320
				{ 3,  23704 }, --Timbermaw Brawlers / 64 / 320
				{ 4,  26279 }, --Stormshroud Gloves / 62 / 320
				{ 5,  19087 }, --Frostsaber Gloves / 59 / 315
				{ 6,  19084 }, --Devilsaur Gauntlets / 58 / 310
				{ 7,  19055 }, --Runic Leather Gauntlets / 54 / 290
				{ 8,  19053 }, --Chimeric Gloves / 53 / 285
				{ 9,  19049 }, --Wicked Leather Gauntlets / 52 / 280
				{ 10, 10630 }, --Gauntlets of the Sea / 46 / 250
				{ 11, 22711 }, --Shadowskin Gloves / 40 / 210
				{ 12, 7156 }, --Guardian Gloves / 38 / 210
				{ 13, 21943 }, --Gloves of the Greatfather / 38 / 210
				{ 14, 3771 }, --Barbaric Gloves / 30 / 170
				{ 15, 9149 }, --Heavy Earthen Gloves / 29 / 170
				{ 16, 3764 }, --Hillman's Leather Gloves / 29 / 170
				{ 17, 9148 }, --Pilferer's Gloves / 28 / 165
				{ 18, 3770 }, --Toughened Leather Gloves / 27 / 160
				{ 19, 9146 }, --Herbalist's Gloves / 27 / 160
				{ 20, 3765 }, --Dark Leather Gloves / 26 / 155
				{ 21, 9145 }, --Fletcher's Gloves / 25 / 150
				{ 22, 9074 }, --Nimble Leather Gloves / 24 / 145
				{ 23, 9072 }, --Red Whelp Gloves / 24 / 145
				{ 24, 7954 }, --Deviate Scale Gloves / 21 / 130
				{ 25, 2164 }, --Fine Leather Gloves / 15 / 105
				{ 26, 3756 }, --Embossed Leather Gloves / 13 / 85
			},
			[MAIL_DIFF] = {
				{ 1, 28223 }, --Icy Scale Gauntlets / 80 / 320
				{ 2, 23708 }, --Chromatic Gauntlets / 70 / 320
				{ 3, 24847 }, --Spitfire Gauntlets / 62 / 320
				{ 4, 24850 }, --Sandstalker Gauntlets / 62 / 320
				{ 5, 24655 }, --Green Dragonscale Gauntlets / 56 / 300
				{ 6, 19064 }, --Heavy Scorpid Gauntlet / 55 / 295
				{ 7, 10542 }, --Tough Scorpid Gloves / 45 / 245
				{ 8, 10619 }, --Dragonscale Gauntlets / 45 / 245
				{ 9, 10509 }, --Turtle Scale Gloves / 41 / 225
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[LEATHER_DIFF] = {
				{ 1,  28472 }, --Bramblewood Helm / 70 / 320
				{ 2,  20854 }, --Molten Helm / 60 / 320
				{ 3,  19082 }, --Runic Leather Headband / 58 / 310
				{ 4,  19071 }, --Wicked Leather Headband / 56 / 300
				{ 5,  10632 }, --Helm of Fire / 50 / 270
				{ 6,  10621 }, --Wolfshead Helm / 45 / 245
				{ 7,  10546 }, --Wild Leather Helmet / 45 / 245
				{ 8,  10531 }, --Big Voodoo Mask / 44 / 240
				{ 9,  10507 }, --Nightscape Headband / 41 / 225
				{ 10, 10490 }, --Comfortable Leather Hat / 40 / 220
			},
			[MAIL_DIFF] = {
				{ 1, 19088 }, --Heavy Scorpid Helm / 59 / 315
				{ 2, 10570 }, --Tough Scorpid Helm / 50 / 270
				{ 3, 10552 }, --Turtle Scale Helm / 46 / 250
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[LEATHER_DIFF] = {
				{ 1,  19097 }, --Devilsaur Leggings / 60 / 320
				{ 2,  19091 }, --Runic Leather Pants / 60 / 320
				{ 3,  19083 }, --Wicked Leather Pants / 58 / 310
				{ 4,  19074 }, --Frostsaber Leggings / 57 / 305
				{ 5,  19080 }, --Warbear Woolies / 57 / 305
				{ 6,  19078 }, --Living Leggings / 57 / 305
				{ 7,  19073 }, --Chimeric Leggings / 56 / 300
				{ 8,  19067 }, --Stormshroud Pants / 55 / 295
				{ 9,  19059 }, --Volcanic Leggings / 54 / 290
				{ 10, 10572 }, --Wild Leather Leggings / 50 / 270
				{ 11, 10560 }, --Big Voodoo Pants / 47 / 260
				{ 12, 10548 }, --Nightscape Pants / 46 / 250
				{ 13, 7149 }, --Barbaric Leggings / 34 / 190
				{ 14, 9195 }, --Dusky Leather Leggings / 33 / 185
				{ 15, 7147 }, --Guardian Pants / 32 / 180
				{ 16, 7135 }, --Dark Leather Pants / 23 / 140
				{ 17, 7133 }, --Fine Leather Pants / 21 / 130
				{ 18, 9068 }, --Light Leather Pants / 19 / 125
				{ 19, 3759 }, --Embossed Leather Pants / 15 / 105
				{ 20, 9064 }, --Rugged Leather Pants / 11 / 65
				{ 21, 2153 }, --Handstitched Leather Pants / 10 / 45
			},
			[MAIL_DIFF] = {
				{ 1, 19107 }, --Black Dragonscale Leggings / 62 / 320
				{ 2, 24654 }, --Blue Dragonscale Leggings / 60 / 320
				{ 3, 19075 }, --Heavy Scorpid Leggings / 57 / 305
				{ 4, 19060 }, --Green Dragonscale Leggings / 54 / 290
				{ 5, 10568 }, --Tough Scorpid Leggings / 49 / 265
				{ 6, 10556 }, --Turtle Scale Leggings / 47 / 255
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[LEATHER_DIFF] = {
				{ 1,  24125 }, --Blood Tiger Shoulders / 65 / 320
				{ 2,  23706 }, --Golden Mantle of the Dawn / 64 / 320
				{ 3,  19103 }, --Runic Leather Shoulders / 62 / 320
				{ 4,  19101 }, --Volcanic Shoulders / 61 / 320
				{ 5,  19090 }, --Stormshroud Shoulders / 59 / 315
				{ 6,  19061 }, --Living Shoulders / 54 / 290
				{ 7,  19062 }, --Ironfeather Shoulders / 54 / 290
				{ 8,  10529 }, --Wild Leather Shoulders / 44 / 240
				{ 9,  10516 }, --Nightscape Shoulders / 42 / 230
				{ 10, 7151 }, --Barbaric Shoulders / 35 / 195
				{ 11, 3769 }, --Dark Leather Shoulders / 28 / 165
				{ 12, 9147 }, --Earthen Leather Shoulders / 27 / 160
				{ 13, 3768 }, --Hillman's Shoulders / 26 / 155
			},
			[MAIL_DIFF] = {
				{ 1, 19100 }, --Heavy Scorpid Shoulders / 61 / 320
				{ 2, 19094 }, --Black Dragonscale Shoulders / 60 / 320
				{ 3, 19089 }, --Blue Dragonscale Shoulders / 59 / 315
				{ 4, 10564 }, --Tough Scorpid Shoulders / 48 / 260
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[LEATHER_DIFF] = {
				{ 1,  23709 }, --Corehound Belt / 70 / 320
				{ 2,  23710 }, --Molten Belt / 70 / 320
				{ 3,  28474 }, --Bramblewood Belt / 70 / 320
				{ 4,  23707 }, --Lava Belt / 66 / 320
				{ 5,  22921 }, --Girdle of Insight / 62 / 320
				{ 6,  19092 }, --Wicked Leather Belt / 60 / 320
				{ 7,  23703 }, --Might of the Timbermaw / 58 / 310
				{ 8,  19072 }, --Runic Leather Belt / 56 / 300
				{ 9,  3779 }, --Barbaric Belt / 40 / 220
				{ 10, 9206 }, --Dusky Belt / 39 / 215
				{ 11, 3778 }, --Gem-studded Leather Belt / 37 / 205
				{ 12, 3775 }, --Guardian Belt / 34 / 190
				{ 13, 4097 }, --Raptor Hide Belt / 33 / 185
				{ 14, 3774 }, --Green Leather Belt / 32 / 180
				{ 15, 3767 }, --Hillman's Belt / 25 / 145
				{ 16, 3766 }, --Dark Leather Belt / 25 / 150
				{ 17, 7955 }, --Deviate Scale Belt / 23 / 140
				{ 18, 6702 }, --Murloc Scale Belt / 18 / 120
				{ 19, 3763 }, --Fine Leather Belt / 16 / 110
				{ 20, 3753 }, --Handstitched Leather Belt / 10 / 55
			},
			[MAIL_DIFF] = {
				{ 1, 19070 }, --Heavy Scorpid Belt / 56 / 300
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[LEATHER_DIFF] = {
				{ 1,  28221 }, --Polar Bracers / 80 / 320
				{ 2,  24123 }, --Primal Batskin Bracers / 65 / 320
				{ 3,  19065 }, --Runic Leather Bracers / 55 / 295
				{ 4,  19052 }, --Wicked Leather Bracers / 53 / 285
				{ 5,  3777 }, --Guardian Leather Bracers / 39 / 215
				{ 6,  9202 }, --Green Whelp Bracers / 38 / 210
				{ 7,  6705 }, --Murloc Scale Bracers / 38 / 210
				{ 8,  9201 }, --Dusky Bracers / 37 / 205
				{ 9,  3776 }, --Green Leather Bracers / 36 / 200
				{ 10, 23399 }, --Barbaric Bracers / 32 / 175
				{ 11, 9065 }, --Light Leather Bracers / 14 / 100
				{ 12, 9059 }, --Handstitched Leather Bracers / 9 / 40
			},
			[MAIL_DIFF] = {
				{ 1, 28224 }, --Icy Scale Bracers / 80 / 320
				{ 2, 24849 }, --Sandstalker Bracers / 62 / 320
				{ 3, 22923 }, --Swift Flight Bracers / 62 / 320
				{ 4, 24846 }, --Spitfire Bracers / 62 / 320
				{ 5, 19048 }, --Heavy Scorpid Bracers / 51 / 275
				{ 6, 10533 }, --Tough Scorpid Bracers / 44 / 240
				{ 7, 10518 }, --Turtle Scale Bracers / 42 / 230
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1,  14932 }, --Thick Leather Ammo Pouch / 45 / 245
				{ 2,  9194 }, --Heavy Leather Ammo Pouch / 35 / 170
				{ 3,  9062 }, --Small Leather Ammo Pouch / 5 / 60
				{ 5,  14930 }, --Quickdraw Quiver / 45 / 245
				{ 6,  9193 }, --Heavy Quiver / 35 / 170
				{ 7,  9060 }, --Light Leather Quiver / 5 / 60
				{ 16, 5244 }, --Kodo Hide Bag / 5 / 70
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  22331 }, --Rugged Leather / 50 / 250
				{ 2,  20650 }, --Thick Leather / 40 / 200
				{ 3,  20649 }, --Heavy Leather / 30 / 150
				{ 4,  20648 }, --Medium Leather / 20 / 100
				{ 5,  2881 }, --Light Leather / 10 / 20
				{ 7,  22727 }, --Core Armor Kit / 60 / 320
				{ 8,  19058 }, --Rugged Armor Kit / 50 / 250
				{ 9,  10487 }, --Thick Armor Kit / 40 / 220
				{ 10, 3780 }, --Heavy Armor Kit / 30 / 170
				{ 11, 2165 }, --Medium Armor Kit / 15 / 115
				{ 12, 2152 }, --Light Armor Kit / 5 / 30
				{ 16, 19047 }, --Cured Rugged Hide / 50 / 250
				{ 17, 10482 }, --Cured Thick Hide / 40 / 200
				{ 18, 3818 }, --Cured Heavy Hide / 30 / 160
				{ 19, 3817 }, --Cured Medium Hide / 20 / 115
				{ 20, 3816 }, --Cured Light Hide / 10 / 55
				{ 22, 23190 }, --Heavy Leather Ball / 1 / 150
			},
		},
	}
}

data["Mining"] = {
	name = ALIL["Mining"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.MINING_LINK,
	items = {
		{
			name = AL["Smelting"],
			[NORMAL_DIFF] = {
				{ 1,  22967 }, -- Smelt Elementium / 310
				{ 2,  1213638 }, -- Smelt Obsidian-Infused Thorium Bar
				{ 3,  16153 }, -- Smelt Thorium / 250
				{ 4,  10098 }, -- Smelt Truesilver / 230
				{ 5,  14891 }, -- Smelt Dark Iron / 230
				{ 6,  10097 }, -- Smelt Mithril / 175
				{ 7,  3308 }, -- Smelt Gold / 170
				{ 8,  3569 }, -- Smelt Steel / 165
				{ 9,  3307 }, -- Smelt Iron / 130
				{ 10, 2658 }, -- Smelt Silver / 100
				{ 11, 2659 }, -- Smelt Bronze / 65
				{ 12, 3304 }, -- Smelt Tin / 50
				{ 13, 2657 }, -- Smelt Copper / 25
			}
		},
	}
}

data["Herbalism"] = {
	name = ALIL["Herbalism"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.HERBALISM_LINK,
	items = {
		{
			name = AL["Artisan"],
			[NORMAL_DIFF] = {
				{ 1,  13467 }, -- Icecap
				{ 2,  13466 }, -- Plaguebloom
				{ 3,  13465, 234012 }, -- Mountain Silversage (Hive Thistle)
				{ 4,  13463, 234012 }, -- Dreamfoil (Hive Thistle)
				{ 5,  13464, 234012 }, -- Golden Sansam (Hive Thistle)
				{ 6,  8846 }, -- Gromsblood
				{ 7,  8845 }, -- Ghost Mushroom
				{ 8,  8839 }, -- Blindweed
				{ 9,  8838,  234012 }, -- Sungrass (Hive Thistle)
				{ 16, 13468, 234012 }, -- Black Lotus (Hive Thistle)
				{ 18, 19727 }, -- Blood Scythe
				{ 19, 19726 }, -- Bloodvine
			}
		},
		{
			name = AL["Expert"],
			[NORMAL_DIFF] = {
				{ 1, 8836 }, -- Arthas' Tears
				{ 2, 8831, 8153 }, -- Purple Lotus (Wildvine)
				{ 3, 4625 }, -- Firebloom
				{ 4, 3819 }, -- Wintersbite
				{ 5, 3358 }, -- Khadgar's Whisker
				{ 6, 3821 }, -- Goldthorn
				{ 7, 3818 }, -- Fadeleaf
			}
		},
		{
			name = AL["Journeyman"],
			[NORMAL_DIFF] = {
				{ 1, 3357 }, -- Liferoot
				{ 2, 3356 }, -- Kingsblood
				{ 3, 3369 }, -- Grave Moss
				{ 4, 3355 }, -- Wild Steelbloom
				{ 5, 2453 }, -- Bruiseweed
				{ 6, 3820 }, -- Stranglekelp
			}
		},
		{
			name = AL["Apprentice"],
			[NORMAL_DIFF] = {
				{ 1, 2450, 2452 }, -- Briarthorn (Swiftthistle)
				{ 2, 785,  2452 }, -- Mageroyal (Swiftthistle)
				{ 3, 2449 }, -- Earthroot
				{ 4, 765 }, -- Silverleaf
				{ 5, 2447 }, -- Peacebloom
			}
		},
	}
}

data["Cooking"] = {
	name = ALIL["Cooking"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.COOKING_LINK,
	items = {
		{
			name = ALIL["Stamina"],
			[NORMAL_DIFF] = {
				{ 1, 25659 }, -- Dirge / 325
				{ 2, 18246 }, -- Mightfish Steak / 315
				{ 3, 18239 }, -- Cooked Glossy Mightfish / 265
			},
		},
		{
			name = ALIL["Intellect"],
			[NORMAL_DIFF] = {
				{ 1, 22761 }, -- Runn Tum Tuber Surprise / 315
			},
		},
		{
			name = ALIL["Agility"],
			[NORMAL_DIFF] = {
				{ 1, 18240 }, -- Grilled Squid / 280
			},
		},
		{
			name = ALIL["Strength"],
			[NORMAL_DIFF] = {
				{ 1, 24801 }, -- Smoked Desert Dumplings / 325
			},
		},
		{
			name = ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 18242 }, -- Hot Smoked Bass / 280
			},
		},
		{
			name = ALIL["Stamina"].." + "..ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1,   15933 }, -- Monster Omelet / 265
				{ 2,   22480 }, -- Tender Wolf Steak / 265
				{ 3,   15915 }, -- Spiced Chili Crab / 265
				{ 4,   15910 }, -- Heavy Kodo Stew / 240
				{ 5,   21175 }, -- Spider Sausage / 240
				{ 6,   15855 }, -- Roast Raptor / 215
				{ 7,   15863 }, -- Carrion Surprise / 215
				{ 8,   4094 }, -- Barbecued Buzzard Wing / 215
				{ 9,   7213 }, -- Giant Clam Scorcho / 215
				{ 10,  15861 }, -- Jungle Stew / 215
				{ 11,  15856 }, -- Hot Wolf Ribs / 215
				{ 12,  3400 }, -- Soothing Turtle Bisque / 215
				{ 13,  15865 }, -- Mystery Stew / 215
				{ 14,  3399 }, -- Tasty Lion Steak / 190
				{ 15,  3398 }, -- Hot Lion Chops / 175
				{ 16,  3376 }, -- Curiously Tasty Omelet / 170
				{ 17,  15853 }, -- Lean Wolf Steak / 165
				{ 18,  6500 }, -- Goblin Deviled Clams / 165
				{ 19,  24418 }, -- Heavy Crocolisk Stew / 160
				{ 20,  3373 }, -- Crocolisk Gumbo / 160
				{ 21,  3397 }, -- Big Bear Steak / 150
				{ 22,  3377 }, -- Gooey Spider Cake / 150
				{ 23,  6419 }, -- Lean Venison / 150
				{ 24,  6418 }, -- Crispy Lizard Tail / 140
				{ 25,  2549 }, -- Seasoned Wolf Kabob / 140
				{ 26,  2547 }, -- Redridge Goulash / 135
				{ 27,  3372 }, -- Murloc Fin Soup / 130
				{ 28,  3370 }, -- Crocolisk Steak / 120
				{ 29,  2546 }, -- Dry Pork Ribs / 120
				{ 30,  2544 }, -- Crab Cake / 115
				{ 101, 3371 }, -- Blood Sausage / 100
				{ 102, 6416 }, -- Strider Stew / 90
				{ 103, 2542 }, -- Goretusk Liver Pie / 90
				{ 104, 2541 }, -- Coyote Steak / 90
				{ 105, 6499 }, -- Boiled Clams / 90
				{ 106, 6415 }, -- Fillet of Frenzy / 90
				{ 107, 21144 }, -- Egg Nog / 75
				{ 108, 6414 }, -- Roasted Kodo Meat / 75
				{ 109, 2795 }, -- Beer Basted Boar Ribs / 60
				{ 110, 2539 }, -- Spiced Wolf Meat / 50
				{ 111, 6412 }, -- Kaldorei Spider Kabob / 50
				{ 112, 15935 }, -- Crispy Bat Wing / 45
				{ 113, 8604 }, -- Herb Baked Egg / 45
				{ 114, 21143 }, -- Gingerbread Cookie / 45
			},
		},
		{
			name = ALIL["Mana Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 18243 }, -- Nightfin Soup / 290
				{ 2, 25954 }, -- Sagefish Delight / 215
				{ 3, 25704 }, -- Smoked Sagefish / 120
			},
		},
		{
			name = ALIL["Health Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 18244 }, -- Poached Sunscale Salmon / 290
			},
		},
		{
			name = ALIL["Food"],
			[NORMAL_DIFF] = {
				{ 1,  18245 }, -- Lobster Stew / 315
				{ 2,  18238 }, -- Spotted Yellowtail / 315
				{ 3,  18247 }, -- Baked Salmon / 265
				{ 4,  6501 }, -- Clam Chowder / 265
				{ 5,  18241 }, -- Filet of Redgill / 265
				{ 6,  20916 }, -- Mithril Headed Trout / 215
				{ 7,  7828 }, -- Rockscale Cod / 190
				{ 8,  7755 }, -- Bristle Whisker Catfish / 140
				{ 9,  20626 }, -- Undermine Clam Chowder / 130
				{ 10, 2548 }, -- Succulent Pork Ribs / 130
				{ 11, 6417 }, -- Dig Rat Stew / 130
				{ 12, 2545 }, -- Cooked Crab Claw / 125
				{ 13, 2543 }, -- Westfall Stew / 115
				{ 14, 7827 }, -- Rainbow Fin Albacore / 90
				{ 15, 7754 }, -- Loch Frenzy Delight / 90
				{ 16, 7753 }, -- Longjaw Mud Snapper / 90
				{ 17, 8607 }, -- Smoked Bear Meat / 80
				{ 18, 6413 }, -- Scorpid Surprise / 60
				{ 19, 7752 }, -- Slitherskin Mackerel / 45
				{ 20, 2538 }, -- Charred Wolf Meat / 45
				{ 21, 7751 }, -- Brilliant Smallfish / 45
				{ 22, 2540 }, -- Roasted Boar Meat / 45
			},
		},
		{
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1,  1225762 }, -- Smoked Redgill
				{ 2,  1225763 }, -- Grand Lobster Banquet
				{ 4,  470359 }, -- Darkclaw Bisque
				{ 5,  470370 }, -- Smoked Redgill
				{ 7,  15906 }, -- Dragonbreath Chili / 240
				{ 8,  8238 }, -- Savory Deviate Delight / 125
				{ 9,  9513 }, -- Thistle Tea / 100
				{ 16, 13028 }, -- Goldthorn Tea / 215
			},
		},
	}
}

data["FirstAid"] = {
	name = ALIL["First Aid"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.FIRSTAID_LINK,
	items = {
		{
			name = ALIL["First Aid"],
			[NORMAL_DIFF] = {
				{ 1,  470349 }, -- Dense Runecloth Bandage / 300
				{ 2,  18630 }, -- Heavy Runecloth Bandage / 290
				{ 3,  18629 }, -- Runecloth Bandage / 260
				{ 4,  10841 }, -- Heavy Mageweave Bandage / 240
				{ 5,  10840 }, -- Mageweave Bandage / 210
				{ 6,  7929 }, -- Heavy Silk Bandage / 180
				{ 7,  7928 }, -- Silk Bandage / 150
				{ 8,  3278 }, -- Heavy Wool Bandage / 115
				{ 9,  3277 }, -- Wool Bandage / 80
				{ 10, 3276 }, -- Heavy Linen Bandage / 50
				{ 11, 3275 }, -- Linen Bandage / 30
				{ 16, 23787 }, -- Powerful Anti-Venom / 300
				{ 17, 7935 }, -- Strong Anti-Venom / 130
				{ 18, 7934 }, -- Anti-Venom / 80
			}
		},
	}
}

data["Fishing"] = {
	name = ALIL["Fishing"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.FISHING_LINK,
	items = {
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
				{ 1,  6533 }, -- Aquadynamic Fish Attractor
				{ 2,  6532 }, -- Bright Baubles
				{ 3,  7307 }, -- Flesh Eating Worm
				{ 4,  6811 }, -- Aquadynamic Fish Lens
				{ 5,  6530 }, -- Nightcrawlers
				{ 16, 19971 }, -- High Test Eternium Fishing Line
				{ 29, 16082 }, -- Artisan Fishing - The Way of the Lure
				{ 30, 16083 }, -- Expert Fishing - The Bass and You
			}
		},
		{
			name = ALIL["Fishing Pole"],
			[NORMAL_DIFF] = {
				{ 1, 19970 }, -- Arcanite Fishing Pole
				{ 2, 19022 }, -- Nat Pagle's Extreme Angler FC-5000
				{ 3, 6367 }, -- Big Iron Fishing Pole
				{ 4, 6366 }, -- Darkwood Fishing Pole
				{ 5, 6365 }, -- Strong Fishing Pole
				{ 6, 12225 }, -- Blump Family Fishing Pole
				{ 7, 6256 }, -- Fishing Pole
			}
		},
		{
			name = AL["Fishes"],
			[NORMAL_DIFF] = {
				{ 1,  13888 }, -- Darkclaw Lobster
				{ 2,  13890 }, -- Plated Armorfish
				{ 3,  13889 }, -- Raw Whitescale Salmon
				{ 4,  13754 }, -- Raw Glossy Mightfish
				{ 5,  13759 }, -- Raw Nightfin Snapper
				{ 6,  13758 }, -- Raw Redgill
				{ 7,  4603 }, -- Raw Spotted Yellowtail
				{ 8,  13756 }, -- Raw Summer Bass
				{ 9,  13760 }, -- Raw Sunscale Salmon
				{ 10, 7974 }, -- Zesty Clam Meat
				{ 11, 21153 }, -- Raw Greater Sagefish
				{ 12, 8365 }, -- Raw Mithril Head Trout
				{ 13, 6362 }, -- Raw Rockscale Cod
				{ 14, 6308 }, -- Raw Bristle Whisker Catfish
				{ 15, 21071 }, -- Raw Sagefish
				{ 16, 6317 }, -- Raw Loch Frenzy
				{ 17, 6289 }, -- Raw Longjaw Mud Snapper
				{ 18, 6361 }, -- Raw Rainbow Fin Albacore
				{ 19, 6291 }, -- Raw Brilliant Smallfish
				{ 20, 6303 }, -- Raw Slitherskin Mackerel
			}
		},
	}
}

data["RoguePoisons"] = {
	name = format("|c%s%s|r", RAID_CLASS_COLORS["ROGUE"].colorStr, ALIL["ROGUE"]),
	ContentType = PROF_CLASS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ROGUE_POISONS_LINK,
	items = {
		{
			name = ALIL["Poisons"],
			[NORMAL_DIFF] = {
				{ 1,  11343 }, -- Instant Poison VI
				{ 2,  11342 }, -- Instant Poison V
				{ 3,  11341 }, -- Instant Poison IV
				{ 4,  8691 }, -- Instant Poison III
				{ 5,  8687 }, -- Instant Poison II
				{ 6,  8681 }, -- Instant Poison
				{ 8,  13230 }, -- Wound Poison IV
				{ 9,  13229 }, -- Wound Poison III
				{ 10, 13228 }, -- Wound Poison II
				{ 11, 13220 }, -- Wound Poison
				{ 13, 3420 }, -- Crippling Poison
				{ 14, 439503 }, -- Atrophic Poison
				{ 15, 6510 }, -- Blinding Powder
				{ 16, 1214168 }, -- Occult Poison II
				{ 17, 458822 }, -- Occult Poison I
				{ 18, 25347 }, -- Deadly Poison V
				{ 19, 11358 }, -- Deadly Poison IV
				{ 20, 11357 }, -- Deadly Poison III
				{ 21, 2837 }, -- Deadly Poison II
				{ 22, 2835 }, -- Deadly Poison
				{ 24, 11400 }, -- Mind-numbing Poison III
				{ 25, 8694 }, -- Mind-numbing Poison II
				{ 26, 5763 }, -- Mind-numbing Poison
				{ 28, 439505 }, -- Numbing Poison
				{ 29, 439500 }, -- Sebacious Poison
			}
		},
	}
}
