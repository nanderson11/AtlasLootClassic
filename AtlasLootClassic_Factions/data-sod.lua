-- If we aren't on a SoD realm, ignore everything in this file
if C_Seasons.GetActiveSeason() ~= 2 then return end

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, 1)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local ALLIANCE_DIFF
local HORDE_DIFF
local LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local FACTIONS_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)
local FACTIONS2_CONTENT = data:AddContentType(AL["Secondary factions"], { 0.1, 0.3, 0.1, 1 })

--[[
0 - Unknown
1 - Hated
2 - Hostile
3 - Unfriendly
4 - Neutral
5 - Friendly
6 - Honored
7 - Revered
8 - Exalted
]] --

data["Emerald Wardens"] = {
	FactionID = 2641,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep8" },
				{ 2, 221442,     [PRICE_EXTRA_ITTYPE] = "emeraldchip:75" }, -- Roar of the Guardian
				{ 3, 220621,     [PRICE_EXTRA_ITTYPE] = "emeraldchip:75" }, -- Nightmare Resonance Crystal
				{ 4, 221440,     [PRICE_EXTRA_ITTYPE] = "emeraldchip:75" }, -- Roar of the Dream
				{ 5, 221443,     [PRICE_EXTRA_ITTYPE] = "emeraldchip:75" }, -- Roar of the Grove
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f2641rep7" },
				{ 2, 221441 },                                  -- Warden of the Dream
				{ 3, 220649,     [PRICE_EXTRA_ITTYPE] = "emeraldchip:50" }, -- Merithra's Inheritence
				{ 4, 221439,     [PRICE_EXTRA_ITTYPE] = "emeraldchip:50" }, -- Armor of the Emerald Slumber
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1,   "f2641rep6" },
				{ 2,   221391 }, --Emerald Scalemail Helmet
				{ 3,   221390 }, --Emerald Scalemail Breastplate
				{ 4,   221388 }, --Emerald Scalemail Leggings
				{ 6,   221397 }, --Emerald Laden Helmet
				{ 7,   221395 }, --Emerald Laden Breastplate
				{ 8,   221398 }, --Emerald Laden Leggings
				{ 10,  221402 }, --Emerald Chain Helmet
				{ 11,  221404 }, --Emerald Chain Breastplate
				{ 12,  221401 }, --Emerald Chain Leggings
				{ 17,  221384 }, --Emerald Encrusted Helmet
				{ 18,  221382 }, --Emerald Encrusted Battleplate
				{ 19,  221385 }, --Emerald Encrusted Legplates
				{ 21,  221376 }, --Emerald Dream Helm
				{ 22,  221380 }, --Emerald Dream Breastplate
				{ 23,  221377 }, --Emerald Dream Legplates
				{ 25,  221425 }, --Emerald Enchanted Circlet
				{ 26,  221430 }, --Emerald Enchanted Robes
				{ 27,  221429 }, --Emerald Enchanted Pants
				{ 101, 221437 }, --Emerald Woven Circlet
				{ 102, 221434 }, --Emerald Woven Robes
				{ 103, 221435 }, --Emerald Woven Pants
				{ 105, 221408 }, --Emerald Leather Helm
				{ 106, 221406 }, --Emerald Leather Vest
				{ 107, 221410 }, --Emerald Leather Pants
				{ 109, 221413 }, --Emerald Dreamkeeper Helm
				{ 110, 221417 }, --Emerald Dreamkeeper Chest
				{ 111, 221414 }, --Emerald Dreamkeeper Pants
				{ 113, 221422 }, --Emerald Watcher Helm
				{ 114, 221419 }, --Emerald Watcher Vest
				{ 115, 221423 }, --Emerald Watcher Leggings
				{ 116, 213407 }, -- Catnip
				{ 117, 221193 }, --Emerald Ring
				{ 118, 224006 }, --Emerald Ring
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1,   "f2641rep5" },
				{ 2,   221392 }, --Emerald Scalemail Shoudlers
				{ 3,   221389 }, --Emerald Scalemail Gauntlets
				{ 4,   221393 }, --Emerald Scalemail Boots
				{ 6,   221399 }, --Emerald Laden Shoulders
				{ 7,   221396 }, --Emerald Laden Gauntlets
				{ 8,   221394 }, --Emerald Laden Boots
				{ 10,  221400 }, --Emerald Chain Shoudlers
				{ 11,  221403 }, --Emerald Chain Gauntlets
				{ 12,  221405 }, --Emerald Chain Boots
				{ 17,  221386 }, --Emerald Encrusted Spaulders
				{ 18,  221383 }, --Emerald Encrusted Handguards
				{ 19,  221387 }, --Emerald Encrusted Plate Boots
				{ 21,  221381 }, --Emerald Dream Pauldrons
				{ 22,  221378 }, --Emerald Dream Gauntlets
				{ 23,  221379 }, --Emerald Dream Sabatons
				{ 25,  221431 }, --Emerald Enchanted Shoulders
				{ 26,  221427 }, --Emerald Enchanted Gloves
				{ 27,  221426 }, --Emerald Enchanted Boots
				{ 101, 221432 }, --Emerald Woven Mantle
				{ 102, 221436 }, --Emerald Woven Gloves
				{ 103, 221438 }, --Emerald Woven Boots
				{ 105, 221411 }, --Emerald Leather Shoulders
				{ 106, 221407 }, --Emerald Leather Gloves
				{ 107, 221409 }, --Emerald Leather Sabatons
				{ 109, 221416 }, --Emerald Dreamkeeper Shoulders
				{ 110, 221412 }, --Emerald Dreamkeeper Gloves
				{ 111, 221415 }, --Emerald Dreamkeeper Boots
				{ 113, 221424 }, --Emerald Watcher Shoulders
				{ 114, 221421 }, --Emerald Watcher Gloves
				{ 115, 221420 }, --Emerald Watcher Boots
				{ 116, 221369 }, -- Nightmare Siphon
				{ 117, 221374 }, -- Anguish of the Dream
				{ 118, 221362 }, -- Weapon Cleaning Cloth
				{ 119, 223648 }, -- Dream Imbued Arrow
				{ 120, 224005 }, -- Emerald Ring
				{ 121, 224004 }, -- Emerald Ring
			},
		},
		{ -- Neutral
			name = ALIL["Neutral"],
			[NORMAL_DIFF] = {
				{ 1,  "f2641rep4" },
				{ 2,  212568 }, -- Wolfshead Trophy
				{ 3,  223912 }, -- Purification Potion
				{ 4,  223913 }, -- Major Healing Potion
				{ 5,  223914 }, -- Greater Healing Potion
				{ 7,  221480 }, -- Spell Notes: Molten Armor
				{ 8,  221481 }, -- 	Nihilist Epiphany
				{ 9,  221482 }, -- 	Rune of Affliction
				{ 10, 221483 }, -- 	Rune of Burn
				{ 11, 221511 }, -- 	Rune of the Protector
				{ 12, 221512 }, -- 	Rune of Alacrity
				{ 13, 221515 }, -- 	Rune of Detonation
				{ 14, 221517 }, -- 	Rune of Bloodshed
				{ 15, 223288 }, -- 	Rune of the Hammer
			},
		},
	},
}

local supplyFaction = UnitFactionGroup("player") == "Horde" and 2587 or 2586
data["Azeroth Commerce Authority or Durotar Supply And Logistics"] = {
	FactionID = supplyFaction,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f"..supplyFaction.."rep8" },
				{ 2, 223164 }, -- Curiosity Cowl
				{ 3, 223167 }, -- Initiative Cap
				{ 4, 223169 }, -- Tenacity Cap
				{ 5, 223172 }, -- Tenacity Chain
				{ 6, 223186 }, -- Supply Expediter
				{ 7, 223162 }, -- Handy Courier Haversack
				{ 8, 220639 }, -- Lledra's Inanimator
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f"..supplyFaction.."rep7" },
				{ 2, 217399 }, -- Recipe: Lesser Arcane Elixir
				{ 3, 219021 }, -- Hefty Courier Pack
				{ 4, 223161 }, -- Empty Supply Crate
				{ 5, 219135 }, -- Curiosity Pendant
				{ 6, 219136 }, -- Tenacity Pendant
				{ 7, 219137 }, -- Initiative Pendant
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f"..supplyFaction.."rep6" },
				{ 2, 211384 }, -- Sturdy Courier Bag
				{ 3, 210779 }, -- Plans: Mantle of the Second War
				{ 4, 211247 }, -- Pattern: Phoenix Bindings
				{ 5, 212230 }, -- Schematic: Soul Vessel
				{ 6, 223160 }, -- Bargain Bush
				{ 7, 219022 }, -- Hauler's Ring
				{ 8, 219023 }, -- Clerk's Ring
				{ 9, 219024 }, -- Messenger's Ring
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1,  "f"..supplyFaction.."rep5" },
				{ 2,  211382 }, -- Small Courier Satchel
				{ 3,  212588 }, -- Provisioner's Gloves
				{ 4,  212589 }, -- Courier Treads
				{ 5,  212590 }, -- Hoist Strap
				{ 7,  211386 }, -- Spell Notes: Arcane Surge
				{ 8,  211387 }, -- Rune of Beckoning Light
				{ 9,  211392 }, -- Rune of Everlasting Affliction
				{ 10, 211391 }, -- Rune of Healing Rain
				{ 11, 211385 }, -- Rune of Serpent Spread
				{ 12, 211393 }, -- Rune of Single-Minded Fury
				{ 13, 206992 }, -- Rune of Skull Bash
				{ 14, 211390 }, -- Rune of Teasing
				{ 15, 205950 }, -- Tenebrous Epiphany
			},
		},
	},
}

local AD_INSIGNIA_FORMAT_BLUE, AD_INSIGNIA_FORMAT_EPIC = "|cff0070dd%d|r", "|cffa335ee%d|r" -- format(AD_INSIGNIA_FORMAT, 30)
data["ArgentDawn"] = {
	FactionID = 529,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1,  "f529rep8" },
				{ 2,  18182 },                                                                                                                            -- Chromatic Mantle of the Dawn
				{ 17, 22523,     22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 27), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 27) }, -- Insignia of the Dawn / Crusade
				{ 18, 22523,     22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 6),  [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 6) }, -- Insignia of the Dawn / Crusade
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1,  "f529rep7" },
				{ 2,  13810 },                                                                                                                                                                      -- Blessed Sunfruit
				{ 3,  13813 },                                                                                                                                                                      -- Blessed Sunfruit Juice
				{ 5,  19217 },                                                                                                                                                                      -- Pattern: Argent Shoulders
				{ 6,  19329 },                                                                                                                                                                      -- Pattern: Golden Mantle of the Dawn
				{ 7,  19205 },                                                                                                                                                                      -- Plans: Gloves of the Dawn
				{ 8,  12698 },                                                                                                                                                                      -- Plans: Dawnbringer Shoulders
				{ 9,  19447 },                                                                                                                                                                      -- Formula: Enchant Bracer - Healing
				{ 11, 18171 },                                                                                                                                                                      -- Arcane Mantle of the Dawn
				{ 12, 18169 },                                                                                                                                                                      -- Flame Mantle of the Dawn
				{ 13, 18170 },                                                                                                                                                                      -- Frost Mantle of the Dawn
				{ 14, 18172 },                                                                                                                                                                      -- Nature Mantle of the Dawn
				{ 15, 18173 },                                                                                                                                                                      -- Shadow Mantle of the Dawn
				{ 17, 22523,     22524,                                           [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 45), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 45) }, -- Insignia of the Dawn / Crusade
				{ 18, 22523,     22524,                                           [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 7),  [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 7) }, -- Insignia of the Dawn / Crusade
				{ 20, 227888,    [PRICE_EXTRA_ITTYPE] = "19059:1:12843:4:12753:3" },                                                                                                                -- Argent Elite Shoulders
				{ 21, 227818,    [PRICE_EXTRA_ITTYPE] = "19058:1:12843:4:12753:3" },                                                                                                                -- Glowing Mantle of the Dawn
				{ 22, 227817,    [PRICE_EXTRA_ITTYPE] = "19057:1:12843:3:12735:2" },                                                                                                                -- Radiant Gloves of the Dawn
				{ 23, 227859,    [PRICE_EXTRA_ITTYPE] = "12625:1:12843:4:12735:3" },                                                                                                                -- Shimmering Dawnbringer Shoulders
				{ 27, 227819 },                                                                                                                                                                     -- Blessed Flame Mantle of the Dawn
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1,  "f529rep6" },
				{ 2,  227813 },                                                                                                                                                                     -- Drinkable Stratholme Holy Water
				{ 4,  19442 },                                                                                                                                                                      -- Formula: Powerful Anti-Venom
				{ 5,  19446 },                                                                                                                                                                      -- Formula: Enchant Bracer - Mana Regeneration
				{ 6,  13482 },                                                                                                                                                                      -- Recipe: Transmute Air to Fire
				{ 7,  19216 },                                                                                                                                                                      -- Pattern: Argent Boots
				{ 8,  19328 },                                                                                                                                                                      -- Pattern: Dawn Treaders
				{ 9,  19203 },                                                                                                                                                                      -- Plans: Girdle of the Dawn
				{ 17, 22523,     22524,                                           [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 75), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 75) }, -- Insignia of the Dawn / Crusade
				{ 18, 22523,     22524,                                           [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 20), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 20) }, -- Insignia of the Dawn / Crusade
				{ 22, 227816,    [PRICE_EXTRA_ITTYPE] = "19056:1:12843:3:12753:2" },                                                                                                                -- Argent Elite Boots
				{ 23, 227815,    [PRICE_EXTRA_ITTYPE] = "19052:1:12843:3:12753:2" },                                                                                                                -- Fine Dawn Treaders
				{ 24, 227814,    [PRICE_EXTRA_ITTYPE] = "19051:1:12843:2:12735:2" },                                                                                                                -- Radiant Girdle of the Dawn
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1,  "f529rep5" },
				{ 2,  13724 },                                                                                                                              -- Enriched Manna Biscuit
				{ 17, 22523,     22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_EPIC, 110), [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_EPIC, 110) }, -- Insignia of the Dawn / Crusade
				{ 18, 22523,     22524, [ATLASLOOT_IT_AMOUNT1] = format(AD_INSIGNIA_FORMAT_BLUE, 30),  [ATLASLOOT_IT_AMOUNT2] = format(AD_INSIGNIA_FORMAT_BLUE, 30) }, -- Insignia of the Dawn / Crusade
			},
		},
	},
}

data["Timbermaw"] = {
	FactionID = 576,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f576rep8" },
				{ 2, 21326 }, -- Defender of the Timbermaw
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1,  "f576rep7" },
				{ 2,  19218 },                                            -- Pattern: Mantle of the Timbermaw
				{ 3,  19327 },                                            -- Pattern: Timbermaw Brawlers
				{ 4,  19204 },                                            -- Plans: Heavy Timbermaw Boots
				{ 5,  228982 },                                           -- Formula: Enchant Shield - Law of Nature
				{ 17, 227808,    [PRICE_EXTRA_ITTYPE] = "19050:1:14342:1:21383:25" }, -- Rugged Mantle of the Timbermaw
				{ 18, 227809,    [PRICE_EXTRA_ITTYPE] = "19049:1:15407:1:21383:20" }, -- Studded Timbermaw Brawlers
				{ 19, 227810,    [PRICE_EXTRA_ITTYPE] = "19048:1:12360:1:21383:25" }, -- Dense Timbermaw Boots
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1,  "f576rep6" },
				{ 2,  16768 },                                            -- Furbolg Medicine Pouch
				{ 3,  16769 },                                            -- Furbolg Medicine Totem
				{ 4,  19202 },                                            -- Plans: Heavy Timbermaw Belt
				{ 5,  19326 },                                            -- Pattern: Might of the Timbermaw
				{ 6,  19215 },                                            -- Pattern: Wisdom of the Timbermaw
				{ 7,  19445 },                                            -- Formula: Enchant Weapon - Agility
				{ 19, 227807,    [PRICE_EXTRA_ITTYPE] = "19043:1:12360:1:21383:20" }, -- Dense Timbermaw Belt
				{ 20, 227805,    [PRICE_EXTRA_ITTYPE] = "19044:1:15407:1:21383:20" }, -- Ferocity of the Timbermaw
				{ 21, 228190,    [PRICE_EXTRA_ITTYPE] = "19047:1:14342:1:21383:20" }, -- Knowledge of the Timbermaw
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1,  "f576rep5" },
				{ 2,  13484 },                                            -- Recipe: Transmute Earth to Water
				{ 3,  15754 },                                            -- Pattern: Warbear Woolies
				{ 4,  15742 },                                            -- Pattern: Warbear Harness
				{ 5,  22392 },                                            -- Formula: Enchant 2H Weapon - Agility
				{ 18, 227804,    [PRICE_EXTRA_ITTYPE] = "15065:1:15407:2:21383:30" }, -- Dire Warbear Woolies
				{ 19, 227803,    [PRICE_EXTRA_ITTYPE] = "15064:1:15407:2:21383:30" }, -- Dire Warbear Harness
				{ 21, 227862,    [PRICE_EXTRA_ITTYPE] = "15802:1:14342:1:21383:25" }, -- Incandescent Mooncloth Boots
			},
		},
	},
}

data["ThoriumBrotherhood"] = {
	FactionID = 59,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1,  "f59rep8" },
				{ 2,  19210 },                                                    -- Plans: Ebon Hand
				{ 3,  19211 },                                                    -- Plans: Blackguard
				{ 4,  19212 },                                                    -- Plans: Nightfall
				{ 5,  20040 },                                                    -- Plans: Dark Iron Boots
				{ 17, 227842,   [PRICE_EXTRA_ITTYPE] = "19170:1:firelandsember:25:17010:2" }, -- Ebon Fist
				{ 18, 227840,   [PRICE_EXTRA_ITTYPE] = "19168:1:firelandsember:25:17011:2" }, -- Implacable Blackguard
				{ 20, 228929,   [PRICE_EXTRA_ITTYPE] = "20039:1:firelandsember:15:17010:1" }, -- Tempered Dark Iron Boots
				{ 21, 228924,   [PRICE_EXTRA_ITTYPE] = "20039:1:firelandsember:15:17010:1" }, -- Tempered Dark Iron Boots
				{ 22, 228927,   [PRICE_EXTRA_ITTYPE] = "20039:1:firelandsember:15:17010:1" }, -- Tempered Dark Iron Boots
				{ 23, 228926,   [PRICE_EXTRA_ITTYPE] = "20039:1:firelandsember:15:17010:1" }, -- Tempered Dark Iron Boots
				{ 24, 228925,   [PRICE_EXTRA_ITTYPE] = "20039:1:firelandsember:15:17010:1" }, -- Tempered Dark Iron Boots
				{ 25, 228928,   [PRICE_EXTRA_ITTYPE] = "20039:1:firelandsember:15:17010:1" }, -- Tempered Dark Iron Boots
				{ 26, 227841,   [PRICE_EXTRA_ITTYPE] = "20039:1:firelandsember:15:17010:1" }, -- Tempered Dark Iron Boots
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1,  "f59rep7" },
				{ 2,  19220 },                                                    -- Pattern: Flarecore Leggings
				{ 3,  19333 },                                                    -- Pattern: Molten Belt
				{ 4,  19332 },                                                    -- Pattern: Corehound Belt
				{ 5,  17053 },                                                    -- Plans: Fiery Chain Shoulders
				{ 6,  19331 },                                                    -- Pattern: Chromatic Gauntlets
				{ 7,  19207 },                                                    -- Plans: Dark Iron Gauntlets
				{ 8,  17052 },                                                    -- Plans: Dark Iron Leggings
				{ 9,  19208 },                                                    -- Plans: Black Amnesty
				{ 10, 19209 },                                                    -- Plans: Blackfury
				{ 11, 19449 },                                                    -- Formula: Enchant Weapon - Mighty Intellect
				{ 17, 227839,   [PRICE_EXTRA_ITTYPE] = "19165:1:firelandsember:15:17010:1" }, -- Fine Flarecore Leggings
				{ 19, 227837,   [PRICE_EXTRA_ITTYPE] = "19162:1:firelandsember:15:17010:1" }, -- Thick Corehound Belt
				{ 20, 227834,   [PRICE_EXTRA_ITTYPE] = "16988:1:firelandsember:15:17010:1" }, -- Molten Chain Shoulders
				{ 21, 227838,   [PRICE_EXTRA_ITTYPE] = "19157:1:firelandsember:15:17010:1" }, -- Shining Chromatic Gauntlets
				{ 22, 227835,   [PRICE_EXTRA_ITTYPE] = "19164:1:firelandsember:15:17011:1" }, -- Tempered Dark Iron Gauntlets
				{ 23, 227836,   [PRICE_EXTRA_ITTYPE] = "17013:1:firelandsember:15:17010:1" }, -- Tempered Dark Iron Leggings
				{ 24, 227832,   [PRICE_EXTRA_ITTYPE] = "19166:1:firelandsember:25:17010:2" }, -- Tempered Black Amnesty
				{ 25, 227833,   [PRICE_EXTRA_ITTYPE] = "19167:1:firelandsember:25:17011:2" }, -- Glaive of Obsidian Fury
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1,  "f59rep6" },
				{ 2,  17017 },                                                    -- Pattern: Flarecore Mantle
				{ 3,  19219 },                                                    -- Pattern: Flarecore Robe
				{ 4,  19330 },                                                    -- Pattern: Lava Belt
				{ 5,  17049 },                                                    -- Plans: Fiery Chain Girdle
				{ 6,  17025 },                                                    -- Pattern: Black Dragonscale Boots
				{ 7,  19206 },                                                    -- Plans: Dark Iron Helm
				{ 8,  17059 },                                                    -- Plans: Dark Iron Reaver
				{ 9,  17060 },                                                    -- Plans: Dark Iron Destroyer
				{ 10, 19448 },                                                    -- Formula: Enchant Weapon - Mighty Spirit
				{ 11, 228981 },                                                   -- Formula: Conductive Shield Coating
				{ 12, 229008 },                                                   -- Formula: Enchant Cloak - Greater Fire Resistance
				{ 13, 229009 },                                                   -- Formula: Enchant Cloak - Greater Nature Resistance
				{ 17, 227830,   [PRICE_EXTRA_ITTYPE] = "16980:1:firelandsember:15:17010:1" }, -- Fine Flarecore Mantle
				{ 18, 227831,   [PRICE_EXTRA_ITTYPE] = "19156:1:firelandsember:20:17011:1" }, -- Fine Flarecore Robe
				{ 19, 227828,   [PRICE_EXTRA_ITTYPE] = "19149:1:firelandsember:15:17011:1" }, -- Lavawalker Belt
				{ 20, 227827,   [PRICE_EXTRA_ITTYPE] = "16989:1:firelandsember:15:17010:1" }, -- Molten Chain Girdle
				{ 21, 227829,   [PRICE_EXTRA_ITTYPE] = "16984:1:firelandsember:15:17011:1" }, -- Hardened Black Dragonscale Boots
				{ 22, 227824,   [PRICE_EXTRA_ITTYPE] = "19148:1:firelandsember:15:17011:1" }, -- Tempered Dark Iron Helm
				{ 23, 227826,   [PRICE_EXTRA_ITTYPE] = "17015:1:firelandsember:25:17010:2" }, -- Dark Iron Flame Reaver
				{ 24, 227825,   [PRICE_EXTRA_ITTYPE] = "17016:1:firelandsember:25:17010:2" }, -- Molten Dark Iron Destroyer
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1,  "f59rep5" },
				{ 2,  17018 },                                                    -- Pattern: Flarecore Gloves
				{ 3,  17023 },                                                    -- Pattern: Molten Helm
				{ 4,  17022 },                                                    -- Pattern: Corehound Boots
				{ 5,  17051 },                                                    -- Plans: Dark Iron Bracers
				{ 6,  20761 },                                                    -- Recipe: Transmute Elemental Fire
				{ 7,  19444 },                                                    -- Formula: Enchant Weapon - Strength
				{ 17, 227823,   [PRICE_EXTRA_ITTYPE] = "16979:1:firelandsember:15:17010:1" }, -- Fine Flarecore Gloves
				{ 18, 227821,   [PRICE_EXTRA_ITTYPE] = "16983:1:firelandsember:15:17011:1" }, -- Flamekissed Molten Helm
				{ 19, 227822,   [PRICE_EXTRA_ITTYPE] = "16982:1:firelandsember:15:17011:1" }, -- Thick Corehound Boots
				{ 20, 227820,   [PRICE_EXTRA_ITTYPE] = "17014:1:firelandsember:10:17010:1" }, -- Tempered Dark Iron Bracers
			},
		},
	},
}

data["CenarionCircle"] = {
	FactionID = 609,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1,  "f609rep8" },
				{ 2,  234325 }, -- Pattern: Dreamscale Breastplate
				{ 3,  234461 }, -- Plans: Obisidian Mail Tunic
				{ 17, 234747 }, -- Fist of Cenarius
				{ 18, 234462 }, -- Earthstrike
				{ 19, 234463 }, -- Wrath of Cenarius
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1,  "f609rep7" },
				{ 2,  22312 }, -- Pattern: Satchel of Cenarius
				{ 3,  234318 }, -- Pattern: Sylvan Vest
				{ 4,  234311 }, -- Pattern: Bramblewood Helm
				{ 5,  234305 }, -- Pattern: Spitfire Breastplate
				{ 6,  234299 }, -- Pattern: Sandstalker Breastplate
				{ 7,  234293 }, -- Plans: Ironvine Breastplate
				{ 8,  234458 }, -- Plans: Jagged Obsidian Shield
				{ 9,  234261 }, -- Schematic: Arcane Megabomb
				{ 17, 234748 }, -- Deeprock Bracers
				{ 18, 234760 }, -- Rockfury Bracers
				{ 19, 234749 }, -- Earthcalm Orb
				{ 20, 234761 }, -- Might of Cenarius
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1,  "f609rep6" },
				{ 2,  234316 }, -- Pattern: Sylvan Crown
				{ 3,  234309 }, -- Pattern: Bramblewood Boots
				{ 4,  234303 }, -- Pattern: Spitfire Gauntlets
				{ 5,  234297 }, -- Pattern: Sandstalker Gauntlets
				{ 6,  234291 }, -- Plans: Ironvine Gloves
				{ 7,  234322 }, -- Plans: Light Obsidian Belt
				{ 8,  20733 }, -- Formula: Enchant Cloak - Greater Nature Resistance
				{ 9,  234278 }, -- Manual: Smelt Obsidian-Infused Thorium Bar
				{ 10, 234257 }, -- Recipe: Elixir of the Honey Badger
				{ 11, 234258 }, -- Recipe: Elixir of the Mage-Lord
				{ 12, 234259 }, -- Recipe: Elixir of the Ironside
				{ 13, 234262 }, -- Schematic: The Fumigator
				{ 17, 234779 }, -- Grace of Earth
				{ 18, 234782 }, -- Earthpower Vest
				{ 19, 234780 }, -- Band of Earthen Might
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1,  "f609rep5" },
				{ 2,  234314 }, -- Pattern: Sylvan Shoulders
				{ 3,  22310 }, -- Pattern: Cenarion Herb Bag
				{ 4,  234307 }, -- Pattern: Bramblewood Belt
				{ 5,  234301 }, -- Pattern: Spitfire Bracers
				{ 6,  234295 }, -- Pattern: Sandstalker Bracers
				{ 7,  234289 }, -- Plans: Ironvine Belt
				{ 8,  234320 }, -- Plans: Heavy Obsidian Belt
				{ 9,  20732 }, -- Formula: Enchant Cloak - Greater Fire Resistance
				{ 10, 234279 }, -- Plans: Obsidian Grinding Stone
				{ 11, 234280 }, -- Schematic: Obsidian Blasting Powder
				{ 12, 234445 }, -- Pattern: Bolt of Qiraji Silk
				{ 13, 234260 }, -- Recipe: Elixir of Alacrity
				{ 14, 234263 }, -- Schematic: Obsidian Bomb
				{ 15, 234272 }, -- Formula: Enchanted Repellent
				{ 17, 234271 }, -- Formula: Scroll: Wrath of the Swarm
				{ 19, 234785 }, -- Gloves of Earthen Power
				{ 20, 234788 }, -- Earthweave Cloak
				{ 21, 234786 }, -- Band of Earthen Wrath
			},
		},
	},
}

data["ZandalarTribe"] = {
	FactionID = 270,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep8" },
				{ 2, 20013 }, -- Recipe: Living Action Potion
				{ 3, 20077 }, -- Zandalar Signet of Might
				{ 4, 20076 }, -- Zandalar Signet of Mojo
				{ 5, 20078 }, -- Zandalar Signet of Serenity
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1,  "f270rep7" },
				{ 2,  19764 }, -- Pattern: Bloodvine Vest
				{ 3,  19769 }, -- Pattern: Primal Batskin Jerkin
				{ 4,  19772 }, -- Pattern: Blood Tiger Breastplate
				{ 5,  19776 }, -- Plans: Bloodsoul Breastplate
				{ 6,  19779 }, -- Plans: Darksoul Breastplate
				{ 7,  20011 }, -- Recipe: Mageblood Potion
				{ 17, 20080 }, -- Sheen of Zanza
				{ 18, 20079 }, -- Spirit of Zanza
				{ 19, 20081 }, -- Swiftness of Zanza
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1,  "f270rep6" },
				{ 2,  19765 }, -- Pattern: Bloodvine Leggings
				{ 3,  20000 }, -- Schematic: Bloodvine Goggles
				{ 4,  19770 }, -- Pattern: Primal Batskin Gloves
				{ 5,  19773 }, -- Pattern: Blood Tiger Shoulders
				{ 6,  19777 }, -- Plans: Bloodsoul Shoulders
				{ 7,  19780 }, -- Plans: Darksoul Leggings
				{ 8,  20014 }, -- Recipe: Major Troll's Blood Potion
				{ 9,  20756 }, -- Formula: Brilliant Wizard Oil
				{ 10, 232610 }, -- Formula: Magnificent Trollshine
				{ 11, 20031 }, -- Essence Mango
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f270rep5" },
				{ 2, 19766 }, -- Pattern: Bloodvine Boots
				{ 3, 19771 }, -- Pattern: Primal Batskin Bracers
				{ 4, 20001 }, -- Schematic: Bloodvine Lens
				{ 5, 19778 }, -- Plans: Bloodsoul Gauntlets
				{ 6, 19781 }, -- Plans: Darksoul Shoulders
				{ 7, 20012 }, -- Recipe: Greater Dreamless Sleep
				{ 8, 20757 }, -- Formula: Brilliant Mana Oil
			},
		},
	},
}

data["BroodOfNozdormu"] = {
	FactionID = 910,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep8" },
				{ 2, 234034,    [PRICE_EXTRA_ITTYPE] = "20879:1" }, --Signet Ring of the Bronze Dragonflight / 80
				{ 3, 234202,    [PRICE_EXTRA_ITTYPE] = "20876:1" }, --Signet Ring of the Bronze Dragonflight / 80
				{ 4, 234032,    [PRICE_EXTRA_ITTYPE] = "20875:1" }, --Signet Ring of the Bronze Dragonflight / 80
				{ 5, 234436,    [PRICE_EXTRA_ITTYPE] = "20877:1" }, --Signet Ring of the Bronze Dragonflight / 80
				{ 6, 234035,    [PRICE_EXTRA_ITTYPE] = "20881:1" }, --Signet Ring of the Bronze Dragonflight / 80
				{ 7, 234964,    [PRICE_EXTRA_ITTYPE] = "20874:1" }, --Signet Ring of the Bronze Dragonflight / 80
				{ 8, 234033,    [PRICE_EXTRA_ITTYPE] = "20878:1" }, --Signet Ring of the Bronze Dragonflight / 80
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep7" },
				{ 2, 234030,    [PRICE_EXTRA_ITTYPE] = "20868:2" }, --Signet Ring of the Bronze Dragonflight / 75
				{ 3, 234201,    [PRICE_EXTRA_ITTYPE] = "20873:2" }, --Signet Ring of the Bronze Dragonflight / 75
				{ 4, 234028,    [PRICE_EXTRA_ITTYPE] = "20872:2" }, --Signet Ring of the Bronze Dragonflight / 75
				{ 5, 234437,    [PRICE_EXTRA_ITTYPE] = "20870:2" }, --Signet Ring of the Bronze Dragonflight / 75
				{ 6, 234031,    [PRICE_EXTRA_ITTYPE] = "20867:2" }, --Signet Ring of the Bronze Dragonflight / 75
				{ 7, 234965,    [PRICE_EXTRA_ITTYPE] = "20871:2" }, --Signet Ring of the Bronze Dragonflight / 75
				{ 8, 234029,    [PRICE_EXTRA_ITTYPE] = "20869:2" }, --Signet Ring of the Bronze Dragonflight / 75
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep6" },
				{ 2, 234026,    [PRICE_EXTRA_ITTYPE] = "20871:1" }, --Signet Ring of the Bronze Dragonflight / 70
				{ 3, 234200,    [PRICE_EXTRA_ITTYPE] = "20866:1" }, --Signet Ring of the Bronze Dragonflight / 70
				{ 4, 234024,    [PRICE_EXTRA_ITTYPE] = "20867:1" }, --Signet Ring of the Bronze Dragonflight / 70
				{ 5, 234438,    [PRICE_EXTRA_ITTYPE] = "20869:1" }, --Signet Ring of the Bronze Dragonflight / 70
				{ 6, 234027,    [PRICE_EXTRA_ITTYPE] = "20872:1" }, --Signet Ring of the Bronze Dragonflight / 70
				{ 7, 234966,    [PRICE_EXTRA_ITTYPE] = "20868:1" }, --Signet Ring of the Bronze Dragonflight / 70
				{ 8, 234025,    [PRICE_EXTRA_ITTYPE] = "20870:1" }, --Signet Ring of the Bronze Dragonflight / 70
			},
		},
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep5" },
				{ 2, 234021,    [PRICE_EXTRA_ITTYPE] = "20863:10" }, --Signet Ring of the Bronze Dragonflight / 65
				{ 3, 234199,    [PRICE_EXTRA_ITTYPE] = "20858:10" }, --Signet Ring of the Bronze Dragonflight / 65
				{ 4, 234020,    [PRICE_EXTRA_ITTYPE] = "20859:10" }, --Signet Ring of the Bronze Dragonflight / 65
				{ 5, 234439,    [PRICE_EXTRA_ITTYPE] = "20861:10" }, --Signet Ring of the Bronze Dragonflight / 65
				{ 6, 234022,    [PRICE_EXTRA_ITTYPE] = "20864:10" }, --Signet Ring of the Bronze Dragonflight / 65
				{ 7, 234967,    [PRICE_EXTRA_ITTYPE] = "20860:10" }, --Signet Ring of the Bronze Dragonflight / 65
				{ 8, 234023,    [PRICE_EXTRA_ITTYPE] = "20862:10" }, --Signet Ring of the Bronze Dragonflight / 65
			},
		},
		{ -- Neutral
			name = ALIL["Neutral"],
			[NORMAL_DIFF] = {
				{ 1, "f910rep4" },
				{ 2, 234017,    [PRICE_EXTRA_ITTYPE] = "20864:5" }, --Signet Ring of the Bronze Dragonflight / 60
				{ 3, 234198,    [PRICE_EXTRA_ITTYPE] = "20861:5" }, --Signet Ring of the Bronze Dragonflight / 60
				{ 4, 234016,    [PRICE_EXTRA_ITTYPE] = "20858:5" }, --Signet Ring of the Bronze Dragonflight / 60
				{ 5, 234440,    [PRICE_EXTRA_ITTYPE] = "20862:5" }, --Signet Ring of the Bronze Dragonflight / 60
				{ 6, 234018,    [PRICE_EXTRA_ITTYPE] = "20865:5" }, --Signet Ring of the Bronze Dragonflight / 60
				{ 7, 234968,    [PRICE_EXTRA_ITTYPE] = "20859:5" }, --Signet Ring of the Bronze Dragonflight / 60
				{ 8, 234019,    [PRICE_EXTRA_ITTYPE] = "20863:5" }, --Signet Ring of the Bronze Dragonflight / 60
			},
		},
	},
}

data["HydraxianWaterlords"] = {
	FactionID = 749,
	ContentType = FACTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[NORMAL_DIFF] = {
				{ 1, "f749rep8" },
				{ 2, 227915 }, -- Duke's Domain
				{ 3, 227927 }, -- Oath of the Sea
			},
		},
		{ -- Revered
			name = ALIL["Revered"],
			[NORMAL_DIFF] = {
				{ 1,  "f749rep7" },
				{ 2,  22687 }, -- Pattern: Glacial Wrists
				{ 3,  22698 }, -- Pattern: Icy Scale Bracers
				{ 4,  22705 }, -- Plans: Icebane Bracers
				{ 5,  22695 }, -- Pattern: Polar Bracers
				{ 6,  228979 }, -- Enchanted Sigil: Flowing Waters
				{ 17, 22754 }, -- Eternal Quintessence
			},
		},
		{ -- Honored
			name = ALIL["Honored"],
			[NORMAL_DIFF] = {
				{ 1,  "f749rep6" },
				{ 2,  227926 }, -- Hydraxian Coronation
				{ 17, 17333 }, -- Aqual Quintessence
			},
		},
	},
}

data["BloodsailBuccaneers"] = {
	FactionID = 87,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Friendly
			name = ALIL["Friendly"],
			[NORMAL_DIFF] = {
				{ 1, "f87rep5" },
				{ 2, 12185 }, -- Bloodsail Admiral's Hat
				{ 3, 22742 }, -- Bloodsail Shirt
				{ 4, 22743 }, -- Bloodsail Sash
				{ 5, 22745 }, -- Bloodsail Pants
			},
		},
	},
}

data["WintersaberTrainers"] = {
	FactionID = 589,
	ContentType = FACTIONS2_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- Exalted
			name = ALIL["Exalted"],
			[ALLIANCE_DIFF] = {
				{ 1, "f589rep8", [ATLASLOOT_IT_ALLIANCE] = true },
				{ 2, 13086,      [ATLASLOOT_IT_ALLIANCE] = true }, -- Reins of the Winterspring Frostsaber
			},
		},
	},
}
