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
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CLASSIC_VERSION_NUM)

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
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local ICON_ITTYPE = data:AddItemTableType("Dummy")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local PVP_CONTENT = data:AddContentType(AL["Battlegrounds"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)

local HORDE, ALLIANCE, RANK_FORMAT = "Horde", "Alliance", AL["|cff33ff99Rank:|r %s"]
local GetRankName, GetRankIcon = AtlasLoot.Data.Requirements.GetPvPRankName, AtlasLoot.Data.Requirements.GetPvPRankIcon
local PVP_RANKS = {
	name = AL["PvP Ranks"],
	TableType = ICON_ITTYPE,
	ExtraList = true,
	[NORMAL_DIFF] = {
		{ 1,  136782,          FACTION_HORDE },
		{ 2,  GetRankIcon(1),  GetRankName(1, HORDE),     format(RANK_FORMAT, 1) },
		{ 3,  GetRankIcon(2),  GetRankName(2, HORDE),     format(RANK_FORMAT, 2) },
		{ 4,  GetRankIcon(3),  GetRankName(3, HORDE),     format(RANK_FORMAT, 3) },
		{ 5,  GetRankIcon(4),  GetRankName(4, HORDE),     format(RANK_FORMAT, 4) },
		{ 6,  GetRankIcon(5),  GetRankName(5, HORDE),     format(RANK_FORMAT, 5) },
		{ 7,  GetRankIcon(6),  GetRankName(6, HORDE),     format(RANK_FORMAT, 6) },
		{ 8,  GetRankIcon(7),  GetRankName(7, HORDE),     format(RANK_FORMAT, 7) },
		{ 9,  GetRankIcon(8),  GetRankName(8, HORDE),     format(RANK_FORMAT, 8) },
		{ 10, GetRankIcon(9),  GetRankName(9, HORDE),     format(RANK_FORMAT, 9) },
		{ 11, GetRankIcon(10), GetRankName(10, HORDE),    format(RANK_FORMAT, 10) },
		{ 12, GetRankIcon(11), GetRankName(11, HORDE),    format(RANK_FORMAT, 11) },
		{ 13, GetRankIcon(12), GetRankName(12, HORDE),    format(RANK_FORMAT, 12) },
		{ 14, GetRankIcon(13), GetRankName(13, HORDE),    format(RANK_FORMAT, 13) },
		{ 15, GetRankIcon(14), GetRankName(14, HORDE),    format(RANK_FORMAT, 14) },
		{ 16, 136781,          FACTION_ALLIANCE },
		{ 17, GetRankIcon(1),  GetRankName(1, ALLIANCE),  format(RANK_FORMAT, 1) },
		{ 18, GetRankIcon(2),  GetRankName(2, ALLIANCE),  format(RANK_FORMAT, 2) },
		{ 19, GetRankIcon(3),  GetRankName(3, ALLIANCE),  format(RANK_FORMAT, 3) },
		{ 20, GetRankIcon(4),  GetRankName(4, ALLIANCE),  format(RANK_FORMAT, 4) },
		{ 21, GetRankIcon(5),  GetRankName(5, ALLIANCE),  format(RANK_FORMAT, 5) },
		{ 22, GetRankIcon(6),  GetRankName(6, ALLIANCE),  format(RANK_FORMAT, 6) },
		{ 23, GetRankIcon(7),  GetRankName(7, ALLIANCE),  format(RANK_FORMAT, 7) },
		{ 24, GetRankIcon(8),  GetRankName(8, ALLIANCE),  format(RANK_FORMAT, 8) },
		{ 25, GetRankIcon(9),  GetRankName(9, ALLIANCE),  format(RANK_FORMAT, 9) },
		{ 26, GetRankIcon(10), GetRankName(10, ALLIANCE), format(RANK_FORMAT, 10) },
		{ 27, GetRankIcon(11), GetRankName(11, ALLIANCE), format(RANK_FORMAT, 11) },
		{ 28, GetRankIcon(12), GetRankName(12, ALLIANCE), format(RANK_FORMAT, 12) },
		{ 29, GetRankIcon(13), GetRankName(13, ALLIANCE), format(RANK_FORMAT, 13) },
		{ 30, GetRankIcon(14), GetRankName(14, ALLIANCE), format(RANK_FORMAT, 14) },
	},
}

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

data["AlteracValley"] = {
	MapID = 2597,
	AtlasMapID = "AlteracValley",
	ContentType = PVP_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- AVRepExalted
			name = _G["FACTION_STANDING_LABEL8"],
			[ALLIANCE_DIFF] = {
				{ 1,  "f730rep8" },

				{ 2,  19312 }, -- Lei of the Lifegiver
				{ 3,  19315 }, -- Therazane's Touch
				{ 4,  19308 }, -- Tome of Arcane Domination
				{ 5,  19311 }, -- Tome of Fiery Arcana
				{ 6,  19309 }, -- Tome of Shadow Force
				{ 7,  19310 }, -- Tome of the Ice Lord
				{ 8,  19325 }, -- Don Julio's Band
				{ 9,  21563 }, -- Don Rodrigo's Band
				{ 10, 19321 }, -- The Immovable Object
				{ 11, 19324 }, -- The Lobotomizer
				{ 12, 19323 }, -- The Unstoppable Force

				{ 17, 19030 }, -- Stormpike Battle Charger
			},
			[HORDE_DIFF] = {
				{ 1,  "f729rep8" },

				{ 2,  19312 }, -- Lei of the Lifegiver
				{ 3,  19315 }, -- Therazane's Touch
				{ 4,  19308 }, -- Tome of Arcane Domination
				{ 5,  19311 }, -- Tome of Fiery Arcana
				{ 6,  19309 }, -- Tome of Shadow Force
				{ 7,  19310 }, -- Tome of the Ice Lord
				{ 8,  19325 }, -- Don Julio's Band
				{ 9,  21563 }, -- Don Rodrigo's Band
				{ 10, 19321 }, -- The Immovable Object
				{ 11, 19324 }, -- The Lobotomizer
				{ 12, 19323 }, -- The Unstoppable Force

				{ 17, 19029 }, -- Horn of the Frostwolf Howler
			},
		},
		{ -- AVRepRevered
			name = _G["FACTION_STANDING_LABEL7"],
			[ALLIANCE_DIFF] = {
				{ 1, "f730rep7" },
				{ 2, 19045 }, -- Stormpike Battle Standard
				{ 3, 19320 }, -- Gnoll Skin Bandolier
				{ 4, 19319 }, -- Harpy Hide Quiver
				{ 5, 19100 }, -- Electrified Dagger
				{ 6, 19104 }, -- Stormstrike Hammer
				{ 7, 19102 }, -- Crackling Staff
			},
			[HORDE_DIFF] = {
				{ 1, "f729rep7" },
				{ 2, 19046 }, -- Frostwolf Battle Standard
				{ 3, 19320 }, -- Gnoll Skin Bandolier
				{ 4, 19319 }, -- Harpy Hide Quiver
				{ 5, 19099 }, -- Glacial Blade
				{ 6, 19103 }, -- Frostbite
				{ 7, 19101 }, -- Whiteout Staff
			},
		},
		{ -- AVRepHonored
			name = _G["FACTION_STANDING_LABEL6"],
			[ALLIANCE_DIFF] = {
				{ 1,  "f730rep6" },
				{ 2,  19098 }, -- Stormpike Sage's Pendant
				{ 3,  19097 }, -- Stormpike Soldier's Pendant
				{ 4,  19086 }, -- Stormpike Sage's Cloak
				{ 5,  19084 }, -- Stormpike Soldier's Cloak
				{ 6,  19094 }, -- Stormpike Cloth Girdle
				{ 7,  19093 }, -- Stormpike Leather Girdle
				{ 8,  19092 }, -- Stormpike Mail Girdle
				{ 9,  19091 }, -- Stormpike Plate Girdle
				{ 17, 19316 }, -- Ice Threaded Arrow
				{ 18, 19317 }, -- Ice Threaded Bullet
				{ 19, 19301 }, -- Alterac Manna Biscuit
				{ 20, 17348 }, -- Major Healing Draught
				{ 21, 17351 }, -- Major Mana Draught
			},
			[HORDE_DIFF] = {
				{ 1,  "f729rep6" },
				{ 2,  19096 }, -- Frostwolf Advisor's Pendant
				{ 3,  19095 }, -- Frostwolf Legionnaire's Pendant
				{ 4,  19085 }, -- Frostwolf Advisor's Cloak
				{ 5,  19083 }, -- Frostwolf Legionnaire's Cloak
				{ 6,  19090 }, -- Frostwolf Cloth Belt
				{ 7,  19089 }, -- Frostwolf Leather Belt
				{ 8,  19088 }, -- Frostwolf Mail Belt
				{ 9,  19087 }, -- Frostwolf Plate Belt
				{ 17, 19316 }, -- Ice Threaded Arrow
				{ 18, 19317 }, -- Ice Threaded Bullet
				{ 19, 19301 }, -- Alterac Manna Biscuit
				{ 20, 17348 }, -- Major Healing Draught
				{ 21, 17351 }, -- Major Mana Draught
			},
		},
		{ -- AVRepFriendly
			name = _G["FACTION_STANDING_LABEL5"],
			[ALLIANCE_DIFF] = {
				{ 1,  "f730rep5" },
				{ 2,  19318 }, -- Bottled Alterac Spring Water
				{ 3,  19307 }, -- Alterac Heavy Runecloth Bandage
				{ 4,  17349 }, -- Superior Healing Draught
				{ 5,  17352 }, -- Superior Mana Draught
				{ 17, 19032 }, -- Stormpike Battle Tabard
			},
			[HORDE_DIFF] = {
				{ 1,  "f729rep5" },
				{ 2,  19318 }, --  Spring Water
				{ 3,  19307 }, -- Alterac Heavy Runecloth Bandage
				{ 4,  17349 }, -- Superior Healing Draught
				{ 5,  17352 }, -- Superior Mana Draught
				{ 17, 19031 }, -- Frostwolf Battle Tabard
			},
		},
		PVP_RANKS,
	},
}

data["WarsongGulch"] = {
	MapID = 3277,
	AtlasMapID = "WarsongGulch",
	ContentType = PVP_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- WSGRepExalted
			name = _G["FACTION_STANDING_LABEL8"],
			[ALLIANCE_DIFF] = {
				{ 1,  "f890rep8" },
				{ 2,  "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepExalted4049
				{ 3,  19597 },                 -- Dryad's Wrist Bindings
				{ 4,  19590 },                 -- Forest Stalker's Bracers
				{ 5,  19584 },                 -- Windtalker's Wristguards
				{ 6,  19581 },                 -- Berserker Bracers
				{ 8,  "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepExalted5059
				{ 9,  19596 },                 -- Dryad's Wrist Bindings
				{ 10, 19589 },                 -- Forest Stalker's Bracers
				{ 11, 19583 },                 -- Windtalker's Wristguards
				{ 12, 19580 },                 -- Berserker Bracers
				{ 17, "INV_Box_01", nil, "60",      nil }, -- WSGRepExalted60
				{ 18, 19595 },                 -- Dryad's Wrist Bindings
				{ 19, 19587 },                 -- Forest Stalker's Bracers
				{ 20, 19582 },                 -- Windtalker's Wristguards
				{ 21, 19578 },                 -- Berserker Bracers
				{ 22, 22752 },                 -- Sentinel's Silk Leggings
				{ 23, 22749 },                 -- Sentinel's Leather Pants
				{ 24, 22750 },                 -- Sentinel's Lizardhide Pants
				{ 25, 22748 },                 -- Sentinel's Chain Leggings
				{ 26, 22753 },                 -- Sentinel's Lamellar Legguards
				{ 27, 22672 },                 -- Sentinel's Plate Legguards
				{ 28, 19506 },                 -- Silverwing Battle Tabard
			},
			[HORDE_DIFF] = {
				{ 1,  "f889rep8" },
				{ 2,  "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepExalted4049
				{ 3,  19597 },                 -- Dryad's Wrist Bindings
				{ 4,  19590 },                 -- Forest Stalker's Bracers
				{ 5,  19584 },                 -- Windtalker's Wristguards
				{ 6,  19581 },                 -- Berserker Bracers
				{ 8,  "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepExalted5059
				{ 9,  19596 },                 -- Dryad's Wrist Bindings
				{ 10, 19589 },                 -- Forest Stalker's Bracers
				{ 11, 19583 },                 -- Windtalker's Wristguards
				{ 12, 19580 },                 -- Berserker Bracers
				{ 17, "INV_Box_01", nil, "60",      nil }, -- WSGRepExalted60
				{ 18, 19595 },                 -- Dryad's Wrist Bindings
				{ 19, 19587 },                 -- Forest Stalker's Bracers
				{ 20, 19582 },                 -- Windtalker's Wristguards
				{ 21, 19578 },                 -- Berserker Bracers
				{ 22, 22747 },                 -- Outrider's Silk Leggings
				{ 23, 22740 },                 -- Outrider's Leather Pants
				{ 24, 22741 },                 -- Outrider's Lizardhide Pants
				{ 25, 22673 },                 -- Outrider's Chain Leggings
				{ 26, 22676 },                 -- Outrider's Mail Leggings
				{ 27, 22651 },                 -- Outrider's Plate Legguards
				{ 28, 19505 },                 -- Warsong Battle Tabard
			},
		},
		{ -- WSGRepRevered
			name = _G["FACTION_STANDING_LABEL7"],
			[ALLIANCE_DIFF] = {
				{ 1,   "f890rep7" },
				{ 2,   "INV_Box_01", nil, "10 - 19", nil }, -- WSGRepRevered1019
				{ 3,   20438 },                 -- Outrunner's Bow
				{ 4,   20443 },                 -- Sentinel's Blade
				{ 5,   20440 },                 -- Protector's Sword
				{ 6,   20434 },                 -- Lorekeeper's Staff
				{ 8,   "INV_Box_01", nil, "25",      nil },
				{ 9,   212581 },                --Outrunner's Bow
				{ 10,  212583 },                --Sentinel's Blade
				{ 11,  212582 },                --Protector's Sword
				{ 12,  212580 },                --Lorekeeper's Staff
				{ 13,  213087 },                --Sergeant's Cloak
				{ 17,  "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepRevered2029
				{ 18,  19565 },                 -- Outrunner's Bow
				{ 19,  19549 },                 -- Sentinel's Blade
				{ 20,  19557 },                 -- Protector's Sword
				{ 21,  19573 },                 -- Lorekeeper's Staff
				{ 23,  "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepRevered3039
				{ 24,  19564 },                 -- Outrunner's Bow
				{ 25,  19548 },                 -- Sentinel's Blade
				{ 26,  19556 },                 -- Protector's Sword
				{ 27,  19572 },                 -- Lorekeeper's Staff
				{ 101, "f890rep7" },
				{ 102, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepRevered4049
				{ 103, 19563 },                 -- Outrunner's Bow
				{ 104, 19547 },                 -- Sentinel's Blade
				{ 105, 19555 },                 -- Protector's Sword
				{ 106, 19571 },                 -- Lorekeeper's Staff
				{ 108, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepRevered5059
				{ 109, 19562 },                 -- Outrunner's Bow
				{ 110, 19546 },                 -- Sentinel's Blade
				{ 111, 19554 },                 -- Protector's Sword
				{ 112, 19570 },                 -- Lorekeeper's Staff
			},
			[HORDE_DIFF] = {
				{ 1,   "f889rep7" },
				{ 2,   "INV_Box_01", nil, "10 - 19", nil }, -- WSGRepRevered1019
				{ 3,   20437 },                 -- Outrider's Bow
				{ 4,   20441 },                 -- Scout's Blade
				{ 5,   20430 },                 -- Legionnaire's Sword
				{ 6,   20425 },                 -- Advisor's Gnarled Staff
				{ 8,   "INV_Box_01", nil, "25",      nil },
				{ 9,   212585 },                --Outrider's Bow
				{ 10,  212587 },                --Scout's Blade
				{ 11,  212586 },                --Legionnaire's Sword
				{ 12,  212584 },                --Advisor's Gnarled Staff
				{ 13,  213088 },                --Sergeant's Cloak
				{ 17,  "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepRevered2029
				{ 18,  19561 },                 -- Outrider's Bow
				{ 19,  19545 },                 -- Scout's Blade
				{ 20,  19553 },                 -- Legionnaire's Sword
				{ 21,  19569 },                 -- Advisor's Gnarled Staff
				{ 23,  "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepRevered3039
				{ 24,  19560 },                 -- Outrider's Bow
				{ 25,  19544 },                 -- Scout's Blade
				{ 26,  19552 },                 -- Legionnaire's Sword
				{ 27,  19568 },                 -- Advisor's Gnarled Staff
				{ 101, "f889rep7" },
				{ 102, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepRevered4049
				{ 103, 19559 },                 -- Outrider's Bow
				{ 104, 19543 },                 -- Scout's Blade
				{ 105, 19551 },                 -- Legionnaire's Sword
				{ 106, 19567 },                 -- Advisor's Gnarled Staff
				{ 108, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepRevered5059
				{ 109, 19558 },                 -- Outrider's Bow
				{ 110, 19542 },                 -- Scout's Blade
				{ 111, 19550 },                 -- Legionnaire's Sword
				{ 112, 19566 },                 -- Advisor's Gnarled Staff
			},
		},
		{ -- WSGRepHonored
			name = _G["FACTION_STANDING_LABEL6"],
			[ALLIANCE_DIFF] = {
				{ 1,   "f890rep6" },
				{ 2,   "INV_Box_01", nil, "10 - 19", nil }, -- WSGRepHonored1019
				{ 3,   20444 },                 -- Sentinel's Medallion
				{ 4,   20428 },                 -- Caretaker's Cape
				{ 5,   20431 },                 -- Lorekeeper's Ring
				{ 6,   20439 },                 -- Protector's Band
				{ 8,   "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepHonored2029
				{ 9,   19541 },                 -- Sentinel's Medallion
				{ 10,  19533 },                 -- Caretaker's Cape
				{ 11,  19525 },                 -- Lorekeeper's Ring
				{ 12,  19517 },                 -- Protector's Band
				{ 17,  "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepHonored3039
				{ 18,  19540 },                 -- Sentinel's Medallion
				{ 19,  19532 },                 -- Caretaker's Cape
				{ 20,  19524 },                 -- Lorekeeper's Ring
				{ 21,  19515 },                 -- Protector's Band
				{ 23,  "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepHonored4049
				{ 24,  19539 },                 -- Sentinel's Medallion
				{ 25,  19531 },                 -- Caretaker's Cape
				{ 26,  19523 },                 -- Lorekeeper's Ring
				{ 27,  19516 },                 -- Protector's Band
				{ 28,  17348 },                 -- Major Healing Draught
				{ 29,  17351 },                 -- Major Mana Draught
				{ 101, "f890rep6" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepHonored5059
				{ 103, 19538 },                 -- Sentinel's Medallion
				{ 104, 19530 },                 -- Caretaker's Cape
				{ 105, 19522 },                 -- Lorekeeper's Ring
				{ 106, 19514 },                 -- Protector's Band
			},
			[HORDE_DIFF] = {
				{ 1,   "f889rep6" },
				{ 2,   "INV_Box_01", nil, "10 - 19", nil }, -- WSGRepHonored1019
				{ 3,   20442 },                 -- Scout's Medallion
				{ 4,   20427 },                 -- Battle Healer's Cloak
				{ 5,   20426 },                 -- Advisor's Ring
				{ 6,   20429 },                 -- Legionnaire's Band
				{ 8,   "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepHonored2029
				{ 9,   19537 },                 -- Scout's Medallion
				{ 10,  19529 },                 -- Battle Healer's Cloak
				{ 11,  19521 },                 -- Advisor's Ring
				{ 12,  19513 },                 -- Legionnaire's Band
				{ 17,  "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepHonored3039
				{ 18,  19536 },                 -- Scout's Medallion
				{ 19,  19528 },                 -- Battle Healer's Cloak
				{ 20,  19520 },                 -- Advisor's Ring
				{ 21,  19512 },                 -- Legionnaire's Band
				{ 23,  "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepHonored4049
				{ 24,  19535 },                 -- Scout's Medallion
				{ 25,  19527 },                 -- Battle Healer's Cloak
				{ 26,  19519 },                 -- Advisor's Ring
				{ 27,  19511 },                 -- Legionnaire's Band
				{ 28,  17348 },                 -- Major Healing Draught
				{ 29,  17351 },                 -- Major Mana Draught
				{ 101, "f889rep6" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- WSGRepHonored5059
				{ 103, 19534 },                 -- Scout's Medallion
				{ 104, 19526 },                 -- Battle Healer's Cloak
				{ 105, 19518 },                 -- Advisor's Ring
				{ 106, 19510 },                 -- Legionnaire's Band
			},
		},
		{ -- WSGRepFriendly
			name = _G["FACTION_STANDING_LABEL5"],
			[ALLIANCE_DIFF] = {
				{ 1,  "f890rep5" },
				{ 2,  "INV_Box_01", nil, "25",      nil },
				{ 3,  211500 },                --Resilient Cloth Headband
				{ 4,  211857 },                --Resilient Leather Mask
				{ 5,  211856 },                --Resilient Mail Coif
				{ 6,  211498 },                --Trainee's Sentinel Nightsaber
				{ 8,  "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepFriendly2029
				{ 9,  21568 },                 -- Rune of Duty
				{ 10, 21566 },                 -- Rune of Perfection
				{ 11, 19062 },                 -- Warsong Gulch Field Ration
				{ 12, 19068 },                 -- Warsong Gulch Silk Bandage
				{ 17, "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepFriendly3039
				{ 18, 19061 },                 -- Warsong Gulch Iron Ration
				{ 19, 19067 },                 -- Warsong Gulch Mageweave Bandage
				{ 20, 17349 },                 -- Superior Healing Draught
				{ 21, 17352 },                 -- Superior Mana Draught
				{ 23, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepFriendly4049
				{ 24, 21567 },                 -- Rune of Duty
				{ 25, 21565 },                 -- Rune of Perfection
				{ 26, 19060 },                 -- Warsong Gulch Enriched Ration
				{ 27, 19066 },                 -- Warsong Gulch Runecloth Bandage
			},
			[HORDE_DIFF] = {
				{ 1,  "f889rep5" },
				{ 2,  "INV_Box_01", nil, "25",      nil },
				{ 3,  211500 },                --Resilient Cloth Headband
				{ 4,  211857 },                --Resilient Leather Mask
				{ 5,  211856 },                --Resilient Mail Coif
				{ 6,  211499 },                --Trainee's Outrider Wolf
				{ 8,  "INV_Box_01", nil, "20 - 29", nil }, -- WSGRepFriendly2029
				{ 9,  21568 },                 -- Rune of Duty
				{ 10, 21566 },                 -- Rune of Perfection
				{ 11, 19062 },                 -- Warsong Gulch Field Ration
				{ 12, 19068 },                 -- Warsong Gulch Silk Bandage
				{ 17, "INV_Box_01", nil, "30 - 39", nil }, -- WSGRepFriendly3039
				{ 18, 19061 },                 -- Warsong Gulch Iron Ration
				{ 19, 19067 },                 -- Warsong Gulch Mageweave Bandage
				{ 20, 17349 },                 -- Superior Healing Draught
				{ 21, 17352 },                 -- Superior Mana Draught
				{ 23, "INV_Box_01", nil, "40 - 49", nil }, -- WSGRepFriendly4049
				{ 24, 21567 },                 -- Rune of Duty
				{ 25, 21565 },                 -- Rune of Perfection
				{ 26, 19060 },                 -- Warsong Gulch Enriched Ration
				{ 27, 19066 },                 -- Warsong Gulch Runecloth Bandage
			},
		},
		PVP_RANKS,
	},
}

data["ArathiBasin"] = {
	MapID = 3358,
	AtlasMapID = "ArathiBasin",
	ContentType = PVP_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- ABRepExalted
			name = _G["FACTION_STANDING_LABEL8"],
			[ALLIANCE_DIFF] = {
				{ 1,  "f509rep8" },
				{ 2,  20061 }, -- Highlander's Epaulets
				{ 3,  20060 }, -- Highlander's Lizardhide Shoulders
				{ 4,  20059 }, -- Highlander's Leather Shoulders
				{ 5,  20055 }, -- Highlander's Chain Pauldrons
				{ 6,  20058 }, -- Highlander's Lamellar Spaulders
				{ 7,  20057 }, -- Highlander's Plate Spaulders
				{ 8,  20073 }, -- Cloak of the Honor Guard
				{ 9,  20070 }, -- Sageclaw
				{ 10, 20069 }, -- Ironbark Staff
				{ 17, 20132 }, -- Arathor Battle Tabard
			},
			[HORDE_DIFF] = {
				{ 1,  "f510rep8" },
				{ 2,  20176 }, -- Defiler's Epaulets
				{ 3,  20175 }, -- Defiler's Lizardhide Shoulders
				{ 4,  20194 }, -- Defiler's Leather Shoulders
				{ 5,  20158 }, -- Defiler's Chain Pauldrons
				{ 6,  20203 }, -- Defiler's Mail Pauldrons
				{ 7,  20212 }, -- Defiler's Plate Spaulders
				{ 8,  20068 }, -- Deathguard's Cloak
				{ 9,  20214 }, -- Mindfang
				{ 10, 20220 }, -- Ironbark Staff
				{ 17, 20131 }, -- Battle Tabard of the Defilers
			},
		},
		{ -- ABRepRevered
			name = _G["FACTION_STANDING_LABEL7"],
			[ALLIANCE_DIFF] = {
				{ 1,   "f509rep7" },
				{ 2,   "INV_Box_01", nil, "20 - 29", nil }, -- ABRepRevered2029
				{ 3,   20096 },                 -- Highlander's Cloth Boots
				{ 4,   20114 },                 -- Highlander's Leather Boots
				{ 5,   20102 },                 -- Highlander's Lizardhide Boots
				{ 6,   20093 },                 -- Highlander's Chain Greaves
				{ 7,   20111 },                 -- Highlander's Lamellar Greaves
				{ 8,   20129 },                 -- Highlander's Plate Greaves
				{ 10,  "INV_Box_01", nil, "30 - 39", nil }, -- ABRepRevered3039
				{ 11,  20095 },                 -- Highlander's Cloth Boots
				{ 12,  20113 },                 -- Highlander's Leather Boots
				{ 13,  20101 },                 -- Highlander's Lizardhide Boots
				{ 17,  "INV_Box_01", nil, "40 - 49", nil }, -- ABRepRevered4049
				{ 18,  20094 },                 -- Highlander's Cloth Boots
				{ 19,  20112 },                 -- Highlander's Leather Boots
				{ 20,  20100 },                 -- Highlander's Lizardhide Boots
				{ 21,  20091 },                 -- Highlander's Chain Greaves
				{ 22,  20109 },                 -- Highlander's Lamellar Greaves
				{ 23,  20127 },                 -- Highlander's Plate Greaves
				{ 24,  20092 },                 -- Highlander's Chain Greaves
				{ 25,  20110 },                 -- Highlander's Lamellar Greaves
				{ 26,  20128 },                 -- Highlander's Plate Greaves
				{ 101, "f509rep7" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepRevered5059
				{ 103, 20054 },                 -- Highlander's Cloth Boots
				{ 104, 20052 },                 -- Highlander's Leather Boots
				{ 105, 20053 },                 -- Highlander's Lizardhide Boots
				{ 106, 20050 },                 -- Highlander's Chain Greaves
				{ 107, 20049 },                 -- Highlander's Lamellar Greaves
				{ 108, 20048 },                 -- Highlander's Plate Greaves
			},
			[HORDE_DIFF] = {
				{ 1,   "f510rep7" },
				{ 2,   "INV_Box_01", nil, "20 - 29", nil }, -- ABRepRevered2029
				{ 3,   20162 },                 -- Defiler's Cloth Boots
				{ 4,   20188 },                 -- Defiler's Leather Boots
				{ 5,   20169 },                 -- Defiler's Lizardhide Boots
				{ 6,   20157 },                 -- Defiler's Chain Greaves
				{ 7,   20201 },                 -- Defiler's Mail Greaves
				{ 8,   20210 },                 -- Defiler's Plate Greaves
				{ 10,  "INV_Box_01", nil, "30 - 39", nil }, -- ABRepRevered3039
				{ 11,  20161 },                 -- Defiler's Cloth Boots
				{ 12,  20187 },                 -- Defiler's Leather Boots
				{ 13,  20168 },                 -- Defiler's Lizardhide Boots
				{ 17,  "INV_Box_01", nil, "40 - 49", nil }, -- ABRepRevered4049
				{ 18,  20160 },                 -- Defiler's Cloth Boots
				{ 19,  20189 },                 -- Defiler's Leather Boots
				{ 20,  20170 },                 -- Defiler's Lizardhide Boots
				{ 21,  20155 },                 -- Defiler's Chain Greaves
				{ 22,  20202 },                 -- Defiler's Mail Greaves
				{ 23,  20211 },                 -- Defiler's Plate Greaves
				{ 24,  20156 },                 -- Defiler's Chain Greaves
				{ 25,  20200 },                 -- Defiler's Mail Greaves
				{ 26,  20209 },                 -- Defiler's Plate Greaves
				{ 101, "f510rep7" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepRevered5059
				{ 103, 20159 },                 -- Defiler's Cloth Boots
				{ 104, 20186 },                 -- Defiler's Leather Boots
				{ 105, 20167 },                 -- Defiler's Lizardhide Boots
				{ 106, 20154 },                 -- Defiler's Chain Greaves
				{ 107, 20199 },                 -- Defiler's Mail Greaves
				{ 108, 20208 },                 -- Defiler's Plate Greaves
			},
		},
		{ -- ABRepHonored
			name = _G["FACTION_STANDING_LABEL6"],
			[ALLIANCE_DIFF] = {
				{ 1,   "f509rep6" },
				{ 2,   "INV_Box_01", nil, "20 - 29", nil }, -- ABRepHonored2029
				{ 3,   20099 },                 -- Highlander's Cloth Girdle
				{ 4,   20117 },                 -- Highlander's Leather Girdle
				{ 5,   20105 },                 -- Highlander's Lizardhide Girdle
				{ 6,   20090 },                 -- Highlander's Chain Girdle
				{ 7,   20108 },                 -- Highlander's Lamellar Girdle
				{ 8,   20126 },                 -- Highlander's Plate Girdle
				{ 10,  "INV_Box_01", nil, "30 - 39", nil }, -- ABRepHonored3039
				{ 11,  20098 },                 -- Highlander's Cloth Girdle
				{ 12,  20116 },                 -- Highlander's Leather Girdle
				{ 13,  20104 },                 -- Highlander's Lizardhide Girdle
				{ 17,  "INV_Box_01", nil, "40 - 49", nil }, -- ABRepHonored4049
				{ 18,  20097 },                 -- Highlander's Cloth Girdle
				{ 19,  20115 },                 -- Highlander's Leather Girdle
				{ 20,  20103 },                 -- Highlander's Lizardhide Girdle
				{ 21,  20088 },                 -- Highlander's Chain Girdle
				{ 22,  20106 },                 -- Highlander's Lamellar Girdle
				{ 23,  20124 },                 -- Highlander's Plate Girdle
				{ 24,  20089 },                 -- Highlander's Chain Girdle
				{ 25,  20107 },                 -- Highlander's Lamellar Girdle
				{ 26,  20125 },                 -- Highlander's Plate Girdle
				{ 101, "f509rep6" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepHonored5059
				{ 103, 20047 },                 -- Highlander's Cloth Girdle
				{ 104, 20045 },                 -- Highlander's Leather Girdle
				{ 105, 20046 },                 -- Highlander's Lizardhide Girdle
				{ 106, 20043 },                 -- Highlander's Chain Girdle
				{ 107, 20042 },                 -- Highlander's Lamellar Girdle
				{ 108, 20041 },                 -- Highlander's Plate Girdle
			},
			[HORDE_DIFF] = {
				{ 1,   "f510rep6" },
				{ 2,   "INV_Box_01", nil, "20 - 29", nil }, -- ABRepHonored2029
				{ 3,   20164 },                 -- Defiler's Cloth Girdle
				{ 4,   20191 },                 -- Defiler's Leather Girdle
				{ 5,   20172 },                 -- Defiler's Lizardhide Girdle
				{ 6,   20152 },                 -- Defiler's Chain Girdle
				{ 7,   20197 },                 -- Defiler's Mail Girdle
				{ 8,   20207 },                 -- Defiler's Plate Girdle
				{ 10,  "INV_Box_01", nil, "30 - 39", nil }, -- ABRepHonored3039
				{ 11,  20166 },                 -- Defiler's Cloth Girdle
				{ 12,  20192 },                 -- Defiler's Leather Girdle
				{ 13,  20173 },                 -- Defiler's Lizardhide Girdle
				{ 17,  "INV_Box_01", nil, "40 - 49", nil }, -- ABRepHonored4049
				{ 18,  20165 },                 -- Defiler's Cloth Girdle
				{ 19,  20193 },                 -- Defiler's Leather Girdle
				{ 20,  20174 },                 -- Defiler's Lizardhide Girdle
				{ 21,  20151 },                 -- Defiler's Chain Girdle
				{ 22,  20196 },                 -- Defiler's Mail Girdle
				{ 23,  20205 },                 -- Defiler's Plate Girdle
				{ 24,  20153 },                 -- Defiler's Chain Girdle
				{ 25,  20198 },                 -- Defiler's Mail Girdle
				{ 26,  20206 },                 -- Defiler's Plate Girdle
				{ 101, "f510rep6" },
				{ 102, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepHonored5059
				{ 103, 20163 },                 -- Defiler's Cloth Girdle
				{ 104, 20190 },                 -- Defiler's Leather Girdle
				{ 105, 20171 },                 -- Defiler's Lizardhide Girdle
				{ 106, 20150 },                 -- Defiler's Chain Girdle
				{ 107, 20195 },                 -- Defiler's Mail Girdle
				{ 108, 20204 },                 -- Defiler's Plate Girdle
			},
		},
		{ -- ABRepFriendly
			name = _G["FACTION_STANDING_LABEL5"],
			[ALLIANCE_DIFF] = {
				{ 1,  "f509rep5" },
				{ 2,  "INV_Box_01", nil, "20 - 29", nil }, -- ABRepFriendly2029
				{ 3,  21119 },                 -- Talisman of Arathor
				{ 4,  20226 },                 -- Highlander's Field Ration
				{ 5,  20244 },                 -- Highlander's Silk Bandage
				{ 7,  "INV_Box_01", nil, "30 - 39", nil }, -- ABRepFriendly3039
				{ 8,  21118 },                 -- Talisman of Arathor
				{ 9,  20227 },                 -- Highlander's Iron Ration
				{ 10, 20237 },                 -- Highlander's Mageweave Bandage
				{ 11, 17349 },                 -- Superior Healing Draught
				{ 12, 17352 },                 -- Superior Mana Draught
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- ABRepFriendly4049
				{ 18, 21117 },                 -- Talisman of Arathor
				{ 19, 20225 },                 -- Highlander's Enriched Ration
				{ 20, 20243 },                 -- Highlander's Runecloth Bandage
				{ 22, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepFriendly5059
				{ 23, 20071 },                 -- Talisman of Arathor
			},
			[HORDE_DIFF] = {
				{ 1,  "f510rep5" },
				{ 2,  "INV_Box_01", nil, "20 - 29", nil }, -- ABRepFriendly2029
				{ 3,  21120 },                 -- Defiler's Talisman
				{ 4,  20223 },                 -- Defiler's Field Ration
				{ 5,  20235 },                 -- Defiler's Silk Bandage
				{ 7,  "INV_Box_01", nil, "30 - 39", nil }, -- ABRepFriendly3039
				{ 8,  21116 },                 -- Defiler's Talisman
				{ 9,  20224 },                 -- Defiler's Iron Ration
				{ 10, 20232 },                 -- Defiler's Mageweave Bandage
				{ 11, 17349 },                 -- Superior Healing Draught
				{ 12, 17352 },                 -- Superior Mana Draught
				{ 17, "INV_Box_01", nil, "40 - 49", nil }, -- ABRepFriendly4049
				{ 18, 21115 },                 -- Defiler's Talisman
				{ 19, 20222 },                 -- Defiler's Enriched Ration
				{ 20, 20234 },                 -- Defiler's Runecloth Bandage
				{ 22, "INV_Box_01", nil, "50 - 59", nil }, -- ABRepFriendly5059
				{ 23, 20072 },                 -- Defiler's Talisman
			},
		},
		PVP_RANKS,
	},
}

data["Blood Moon"] = {
	name = AL["Blood Moon"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = SET_ITTYPE,
	items = {
		{
			name = AL["Level 60"],
			TableType = NORMAL_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,   235144 }, -- Satchel of Blood-Caked Copper Coins
				{ 2,   235145 }, -- Satchel of Blood-Caked Silver Coins
				{ 3,   234145 }, -- Blood-Caked Hakkari Bijou
				{ 4,   234960 }, -- Reins of the Blood-Caked Tiger
				{ 5,   234961 }, -- Whistle of the Blood-Caked Raptor
				{ 7,   233728 }, -- Blood-Caked Insignia
				{ 8,   233740 }, -- Blood-Caked Shroud
				{ 9,   233739 }, -- Blood-Caked Drape
				{ 10,  233738 }, -- Blood-Caked Cape
				{ 11,  233737 }, -- Blood-Caked Cloak
				{ 12,  233736 }, -- Blood-Caked Band
				{ 13,  233735 }, -- Blood-Caked Loop
				{ 14,  233734 }, -- Blood-Caked Circle
				{ 15,  233733 }, -- Blood-Caked Ring
				{ 16,  233732 }, -- Blood-Caked Necklace
				{ 17,  233731 }, -- Blood-Caked Amulet
				{ 18,  233730 }, -- Blood-Caked Talisman
				{ 19,  233729 }, -- Blood-Caked Choker
				{ 21,  233765 }, -- Battle Hardened Dragonhide Cord
				{ 22,  233761 }, -- Battle Hardened Dragonhide Belt
				{ 23,  233763 }, -- Battle Hardened Dragonhide Waistguard
				{ 24,  233759 }, -- Battle Hardened Dragonhide Bracers
				{ 25,  233767 }, -- Battle Hardened Dragonhide Wrists
				{ 26,  233769 }, -- Battle Hardened Dragonhide Armbands
				{ 101, 233751 }, -- Battle Hardened Chain Girdle
				{ 102, 233753 }, -- Battle Hardened Chain Belt
				{ 103, 233755 }, -- Battle Hardened Chain Wristguards
				{ 104, 233757 }, -- Battle Hardened Chain Bracers
				{ 106, 233777 }, -- Battle Hardened Silk Sash
				{ 107, 233775 }, -- Battle Hardened Silk Cuffs
				{ 109, 233741 }, -- Battle Hardened Lamellar Belt
				{ 110, 233744 }, -- Battle Hardened Lamellar Cord
				{ 111, 233743 }, -- Battle Hardened Lamellar Wrists
				{ 112, 233742 }, -- Battle Hardened Lamellar Armguards
				{ 116, 233783 }, -- Battle Hardened Satin Sash
				{ 117, 233786 }, -- Battle Hardened Satin Cinch
				{ 118, 233781 }, -- Battle Hardened Satin Wrists
				{ 119, 233780 }, -- Battle Hardened Satin Bracers
				{ 121, 233771 }, -- Battle Hardened Leather Girdle
				{ 122, 233773 }, -- Battle Hardened Leather Armsplints
				{ 124, 233745 }, -- Battle Hardened Mail Waistband
				{ 125, 233746 }, -- Battle Hardened Mail Cord
				{ 126, 233747 }, -- Battle Hardened Mail Belt
				{ 127, 233748 }, -- Battle Hardened Mail Bracers
				{ 128, 233749 }, -- Battle Hardened Mail Wristguards
				{ 129, 233750 }, -- Battle Hardened Mail Vambraces
				{ 201, 233789 }, -- Battle Hardened Dreadweave Belt
				{ 202, 233787 }, -- Battle Hardened Dreadweave Cuffs
				{ 204, 233724 }, -- Battle Hardened Plate Girdle
				{ 205, 233726 }, -- Battle Hardened Plate Armguards
			},
		},
		{
			name = AL["Level 50"],
			TableType = NORMAL_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,  221447 }, -- Ritualist's Bloodmoon Grimoire
				{ 2,  221446 }, -- Ritualist's Hammer
				{ 3,  221448 }, -- Talisman of the Corrupted Grove
				{ 5,  221451 }, -- Bloodthirst Crossbow
				{ 6,  221450 }, -- Gurubashi Pit Fighter's Bow
				{ 8,  221452 }, -- Bloodfocused Arcane Band
				{ 9,  221453 }, -- Band of Boiling Blood
				{ 10, 221454 }, -- Glacial Blood Band
				{ 12, 221457 }, -- Libram of Draconic Destruction
				{ 13, 221455 }, -- Bloodlight Reverence
				{ 14, 221456 }, -- Eclipsed Sanguine Saber
				{ 15, 220173 }, -- Parasomnia
				{ 16, 221459 }, -- Seal of the Sacrificed
				{ 17, 221458 }, -- Shadowy Band of Victory
				{ 19, 221460 }, -- Gurubashi Backstabber
				{ 20, 221462 }, -- Bloodied Sword of Speed
				{ 22, 221464 }, -- Totem of Fiery Precision
				{ 23, 221463 }, -- Ancestral Voodoo Doll
				{ 24, 221465 }, -- Corrupted Smashbringer
				{ 26, 221466 }, -- Loop of Burning Blood
				{ 27, 221467 }, -- Eye of the Bloodmoon
				{ 29, 221469 }, -- Headhunter's Barbed Spear
				{ 30, 221468 }, -- Wall of Whispers
			},
		},
		{
			name = AL["Level 40"],
			TableType = NORMAL_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,   216621 }, -- Blooddrenched Drape
				{ 2,   216620 }, -- Bloodrot Cloak
				{ 3,   216623 }, -- Cape of Hemostasis
				{ 4,   216622 }, -- Coagulated Cloak
				{ 5,   216570 }, -- Reins of the Golden Sabercat
				{ 6,   216492 }, -- Whistle of the Mottled Blood Raptor
				{ 8,   216498 }, -- Enchanted Sanguine Grimoire
				{ 9,   216499 }, -- Bloodbark Crusher
				{ 10,  216500 }, -- Bloodbonded Grove Talisman
				{ 12,  216513 }, -- Tigerblood Talisman
				{ 13,  216514 }, -- Sanguine Quiver
				{ 14,  216515 }, -- Sanguine Ammo Pouch
				{ 15,  216516 }, -- Bloodlash Bow
				{ 16,  216510 }, -- Blood Resonance Circle
				{ 17,  216511 }, -- Emberblood Seal
				{ 18,  216512 }, -- Loop of Chilled Veins
				{ 20,  216504 }, -- Eclipsed Bloodlight Saber
				{ 21,  216505 }, -- Bloodlight Crusader's Radiance
				{ 22,  216506 }, -- Bloodlight Avenger's Edge
				{ 23,  216607 }, -- Bloodlight Offering
				{ 25,  216517 }, -- Sanguine Sanctuary
				{ 26,  216518 }, -- Blood Covenant Seal
				{ 27,  216519 }, -- Sanguine Shadow Band
				{ 101, 216520 }, -- Bloodharvest Blade
				{ 102, 216521 }, -- Swift Sanguine Strikers
				{ 103, 216522 }, -- Blood Spattered Stiletto
				{ 105, 216501 }, -- Bloodstorm Barrier
				{ 106, 216502 }, -- Bloodstorm War Totem
				{ 107, 216503 }, -- Bloodstorm Jewel
				{ 108, 216615 }, -- Ancestral Bloodstorm Beacon
				{ 110, 216507 }, -- Umbral Bloodseal
				{ 111, 216508 }, -- Infernal Bloodcoil Band
				{ 112, 216509 }, -- Infernal Pact Essence
				{ 116, 216495 }, -- Sanguine Crusher
				{ 117, 216496 }, -- Sanguine Skullcrusher
				{ 118, 216497 }, -- Exsanguinar
			},
		},
	},
}

data["ClassSets"] = {
	name = AL["Class Sets"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	items = {
		{ -- Epic
			name = AL["Level 60"].." "..ALIL["Epic"],
			[ALLIANCE_DIFF] = {
				{ 1,  1740 }, -- Mage
				{ 3,  1741 }, -- Priest caster
				{ 4,  1742 }, -- Priest healer
				{ 6,  1746 }, -- Warlock
				{ 8,  1735 }, -- Druid caster
				{ 9,  1736 }, -- Druid healer
				{ 10, 1737 }, -- Druid melee
				{ 12, 1743 }, -- Rogue
				{ 16, 1738 }, -- Hunter melee
				{ 17, 1739 }, -- Hunter ranged
				{ 19, 1745 }, -- Paladin healer
				{ 20, 1744 }, -- Paladin melee
				{ 22, 1747 }, -- Warrior
			},

			[HORDE_DIFF] = {
				{ 1,  1727 }, -- Mage
				{ 3,  1728 }, -- Priest caster
				{ 4,  1729 }, -- Priest healer
				{ 6,  1734 }, -- Warlock
				{ 8,  1723 }, -- Druid caster
				{ 9,  1724 }, -- Druid healer
				{ 10, 1722 }, -- Druid melee
				{ 12, 1730 }, -- Rogue
				{ 16, 1726 }, -- Hunter melee
				{ 17, 1725 }, -- Hunter ranged
				{ 19, 1732 }, -- Shaman caster
				{ 20, 1733 }, -- Shaman healer
				{ 21, 1731 }, -- Shaman melee
				{ 23, 1721 }, -- Warrior
			},
		},
		{ -- Rare
			name = AL["Level 60"].." "..ALIL["Rare"],
			[ALLIANCE_DIFF] = {
				{ 1,  1767 }, -- Mage
				{ 3,  1768 }, -- Priest
				{ 4,  1769 }, -- Priest
				{ 6,  1774 }, -- Warlock
				{ 8,  1762 }, -- Druid
				{ 9,  1763 }, -- Druid
				{ 10, 1764 }, -- Druid
				{ 12, 1770 }, -- Rogue
				{ 16, 1765 }, -- Hunter
				{ 17, 1766 }, -- Hunter
				{ 19, 1776 }, -- Paladin
				{ 20, 1777 }, -- Paladin
				{ 22, 1775 }, -- Warrior
			},

			[HORDE_DIFF] = {
				{ 1,  1753 }, -- Mage
				{ 3,  1754 }, -- Priest
				{ 4,  1755 }, -- Priest
				{ 6,  1760 }, -- Warlock
				{ 8,  1748 }, -- Druid
				{ 9,  1749 }, -- Druid
				{ 10, 1750 }, -- Druid
				{ 12, 1756 }, -- Rogue
				{ 16, 1751 }, -- Hunter
				{ 17, 1752 }, -- Hunter
				{ 19, 1757 }, -- shaman
				{ 20, 1758 }, -- Shaman
				{ 21, 1759 }, -- Shaman
				{ 23, 1761 }, -- Warrior
			},
		},
		{
			name = AL["Level 50"],
			[ALLIANCE_DIFF] = {
				{ 1,  1634 },
				{ 2,  1636 },
				{ 4,  1628 },
				{ 5,  1630 },
				{ 6,  1632 },
				{ 8,  1665 },
				{ 9,  1626 },
				{ 11, 1619 },
				{ 12, 1620 },
				{ 13, 1621 },
			},
			[HORDE_DIFF] = {
				{ 1,  1633 },
				{ 2,  1635 },
				{ 4,  1627 },
				{ 5,  1631 },
				{ 6,  1629 },
				{ 8,  1624 },
				{ 9,  1623 },
				{ 10, 1622 },
				{ 11, 1625 },
				{ 13, 1618 },
			},
		},
		PVP_RANKS,
	},
}

data["Armor"] = {
	name = AL["Armor"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- PVPArmor
			name = AL["Armor"],
			[ALLIANCE_DIFF] = {
				{ 1,  18664 }, -- A Treatise on Military Ranks

				{ 3,  18443 }, -- Master Sergeant's Insignia
				{ 4,  18444 }, -- Master Sergeant's Insignia
				{ 5,  18442 }, -- Master Sergeant's Insignia

				{ 7,  18456 }, -- Sergeant Major's Silk Cuffs
				{ 8,  18457 }, -- Sergeant Major's Silk Cuffs

				{ 10, 18452 }, -- Sergeant Major's Leather Armsplints
				{ 11, 18453 }, -- Sergeant Major's Leather Armsplints

				{ 13, 18448 }, -- Sergeant Major's Chain Armguards
				{ 14, 18449 }, -- Sergeant Major's Chain Armguards

				{ 16, 15196 }, -- Private's Tabard

				{ 18, 16342 }, -- Sergeant's Cape
				{ 19, 18441 }, -- Sergeant's Cape
				{ 20, 18440 }, -- Sergeant's Cape

				{ 22, 18445 }, -- Sergeant Major's Plate Wristguards
				{ 23, 18447 }, -- Sergeant Major's Plate Wristguards

				{ 25, 18454 }, -- Sergeant Major's Dragonhide Armsplints
				{ 26, 18455 }, -- Sergeant Major's Dragonhide Armsplints

			},
			[HORDE_DIFF] = {
				{ 1,  18675 }, -- Military Ranks of the Horde & Alliance

				{ 3,  16335 }, -- Senior Sergeant's Insignia
				{ 4,  18428 }, -- Senior Sergeant's Insignia
				{ 5,  15200 }, -- Senior Sergeant's Insignia

				{ 7,  16486 }, -- First Sergeant's Silk Cuffs
				{ 8,  18437 }, -- First Sergeant's Silk Cuffs

				{ 10, 16497 }, -- First Sergeant's Leather Armguards
				{ 11, 18435 }, -- First Sergeant's Leather Armguards

				{ 13, 18429 }, -- First Sergeant's Plate Bracers
				{ 14, 18430 }, -- First Sergeant's Plate Bracers

				{ 16, 15197 }, -- Scout's Tabard

				{ 18, 18461 }, -- Sergeant's Cloak
				{ 19, 16341 }, -- Sergeant's Cloak
				{ 20, 18427 }, -- Sergeant's Cloak

				{ 22, 16532 }, -- First Sergeant's Mail Wristguards
				{ 23, 18432 }, -- First Sergeant's Mail Wristguards

				{ 25, 18434 }, -- First Sergeant's Dragonhide Armguards
				{ 26, 18436 }, -- First Sergeant's Dragonhide Armguards

			},
		},
		PVP_RANKS,
	},
}

data["Weapons"] = {
	name = AL["Weapons"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{ -- PVPWeapons
			name = AL["Weapons"],
			[ALLIANCE_DIFF] = {
				{ 1,  234580 }, -- Grand Marshal's Handaxe
				{ 2,  234566 }, -- Grand Marshal's Sunderer
				{ 3,  234582 }, -- Grand Marshal's Dirk
				{ 4,  235479 }, -- Grand Marshal's Shiv
				{ 5,  234574 }, -- Grand Marshal's Mageblade
				{ 6,  234583 }, -- Grand Marshal's Right Hand Blade
				{ 7,  234584 }, -- Grand Marshal's Left Hand Blade
				{ 8,  234581 }, -- Grand Marshal's Punisher
				{ 9,  235481 }, -- Grand Marshal's Hacker
				{ 10, 235480 }, -- Grand Marshal's Bonecracker
				{ 11, 234576 }, -- Grand Marshal's Warhammer
				{ 12, 234568 }, -- Grand Marshal's Demolisher
				{ 13, 234567 }, -- Grand Marshal's Battle Hammer
				{ 14, 234578 }, -- Grand Marshal's Longsword
				{ 15, 234579 }, -- Grand Marshal's Swiftblade
				{ 16, 234565 }, -- Grand Marshal's Claymore
				{ 17, 234569 }, -- Grand Marshal's Glaive
				{ 18, 234570 }, -- Grand Marshal's Polearm
				{ 19, 234571 }, -- Grand Marshal's Stave
				{ 20, 234585 }, -- Grand Marshal's Bullseye
				{ 21, 234586 }, -- Grand Marshal's Repeater
				{ 22, 234587 }, -- Grand Marshal's Hand Cannon
				{ 23, 234588 }, -- Grand Marshal's Aegis
				{ 24, 235473 }, -- Grand Marshal's Barricade
				{ 25, 234589 }, -- Grand Marshal's Tome of Power
				{ 26, 234590 }, -- Grand Marshal's Tome of Restoration
			},
			[HORDE_DIFF] = {
				{ 1,  234554 }, -- High Warlord's Cleaver
				{ 2,  234543 }, -- High Warlord's Battle Axe
				{ 3,  235476 }, -- High Warlord's Hacker
				{ 4,  234556 }, -- High Warlord's Razor
				{ 5,  235478 }, -- High Warlord's Razor
				{ 6,  234550 }, -- High Warlord's Spellblade
				{ 7,  234557 }, -- High Warlord's Right Claw
				{ 8,  234558 }, -- High Warlord's Left Claw
				{ 9,  234555 }, -- High Warlord's Bludgeon
				{ 10, 234551 }, -- High Warlord's Battle Mace
				{ 11, 235477 }, -- High Warlord's Bonecracker
				{ 12, 234546 }, -- High Warlord's Destroyer
				{ 13, 234545 }, -- High Warlord's Pulverizer
				{ 14, 234552 }, -- High Warlord's Blade
				{ 15, 234553 }, -- High Warlord's Quickblade
				{ 16, 234542 }, -- High Warlord's Greatsword
				{ 17, 234547 }, -- High Warlord's Pig Sticker
				{ 18, 234548 }, -- High Warlord's Pig Poker
				{ 19, 234549 }, -- High Warlord's War Staff
				{ 20, 234559 }, -- High Warlord's Recurve
				{ 21, 234560 }, -- High Warlord's Crossbow
				{ 22, 234561 }, -- High Warlord's Street Sweeper
				{ 23, 234562 }, -- High Warlord's Shield Wall
				{ 24, 235474 }, -- High Warlord's Barricade
				{ 25, 234563 }, -- High Warlord's Tome of Destruction
				{ 26, 234564 }, -- High Warlord's Tome of Mending
			},
		},
		PVP_RANKS,
	},
}

data["PvPMounts"] = {
	name = ALIL["Mounts"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	CorrespondingFields = private.MOUNTS_LINK,
	items = {
		{ -- PvPMountsPvP
			name = ALIL["Mounts"],
			[ALLIANCE_DIFF] = {
				{ 1, 19030 }, -- Stormpike Battle Charger
				{ 3, 18244 }, -- Black War Ram
				{ 4, 18243 }, -- Black Battlestrider
				{ 5, 18241 }, -- Black War Steed Bridle
				{ 6, 18242 }, -- Reins of the Black War Tiger
			},
			[HORDE_DIFF] = {
				{ 1, 19029 }, -- Horn of the Frostwolf Howler
				{ 3, 18245 }, -- Horn of the Black War Wolf
				{ 4, 18247 }, -- Black War Kodo
				{ 5, 18246 }, -- Whistle of the Black War Raptor
				{ 6, 18248 }, -- Red Skeletal Warhorse
			},
		},
		PVP_RANKS,
	},
}

data["Insignia"] = {
	name = AL["Insignia"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	items = {
		{
			name = AL["Insignia"],
			[ALLIANCE_DIFF] = {
				{ 1, 18854 }, -- Warrior
				{ 2, 18856 }, -- Hunter
				{ 3, 18857 }, -- Rogue
				{ 4, 18858 }, -- Warlock
				{ 5, 18862 }, -- Priest
				{ 6, 18863 }, -- Druid
				{ 7, 18864 }, -- Paladin
				{ 8, 18859 }, -- Mage

			},
			[HORDE_DIFF] = {
				{ 1, 18834 }, -- Warrior
				{ 2, 18846 }, -- Hunter
				{ 3, 18849 }, -- Rogue
				{ 4, 18852 }, -- Warlock
				{ 5, 18851 }, -- Priest
				{ 6, 18853 }, -- Druid
				{ 7, 18845 }, -- Shaman
				{ 8, 18850 }, -- Mage
			},
		},
		PVP_RANKS,
	},
}
