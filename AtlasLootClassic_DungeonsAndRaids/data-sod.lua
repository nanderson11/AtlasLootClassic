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
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.CLASSIC_VERSION_NUM)

local AL = AtlasLoot.Locales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local RAID20_DIFF = data:AddDifficulty("20RAID")
local RAID40_DIFF = data:AddDifficulty("40RAID")

local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
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

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID10_CONTENT = data:AddContentType(AL["10 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID20_CONTENT = data:AddContentType(AL["20 Raids"], ATLASLOOT_RAID20_COLOR)
local RAID40_CONTENT = data:AddContentType(AL["40 Raids"], ATLASLOOT_RAID40_COLOR)

local ATLAS_MODULE_NAME = "Atlas_ClassicWoW"

local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURP = "|cff9900ff%s|r"
local WHIT = "|cffffffff%s|r"

local NAME_COLOR, NAME_COLOR_BOSS = "|cffC0C0C0", "|cffC0C0C0"
local NAME_BRD_RING_OF_LAW = NAME_COLOR_BOSS..AL["Ring of Law"]..":|r %s" -- Tempest Keep

local KEYS = {                                                            -- Keys
	name = AL["Keys"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,  "INV_Box_01", nil, AL["Key"],  nil },
		{ 2,  16309, },
		{ 3,  12344, },
		{ 4,  17191, },
		{ 5,  7146, },
		{ 6,  12382, },
		{ 7,  6893, },
		{ 8,  11000, },
		{ 9,  11140, },
		{ 10, 18249, },
		{ 11, 13704, },
		{ 12, 11197, },
		{ 13, 18266, },
		{ 14, 18268, },
		{ 15, 13873, },
		{ 16, "INV_Box_01", nil, AL["Misc"], nil },
		{ 17, 19931 },
		{ 18, 18250 },
		{ 19, 9240 },
		{ 20, 17333 },
		{ 21, 22754 },
		{ 22, 13523 },
		{ 23, 18746 },
		{ 24, 18663 },
		{ 25, 19974 },
		{ 26, 7733 },
		{ 27, 10818 },
		{ 29, 22057 },
		{ 30, 21986 },
	},
}

local BFD_SET = {
	name = AL["Level 25 Raid Sets"],
	ExtraList = true,
	TableType = SET_ITTYPE,
	[NORMAL_DIFF] = {
		{ 1, 1570 }, -- Twilight Invoker's Vestments
		{ 3, 1578 }, -- Twilight Slayer's Leather
		{ 4, 1579 }, -- Twilight Elementalist's Hide
		{ 6, 1577 }, -- Twilight Avenger's Mail
	},
}

local GNOMEREGAN_SET = {
	name = AL["Level 40 Raid Sets"],
	ExtraList = true,
	TableType = SET_ITTYPE,
	[NORMAL_DIFF] = {
		{ 1,  1584 },
		{ 2,  1587 },
		{ 3,  1588 },
		{ 5,  1585 },
		{ 6,  1586 },
		{ 8,  1590 },
		{ 9,  1591 },
		{ 11, 1589 },
		{ 12, 1592 },
	},
}

local ST_SET = {
	name = AL["Level 50 Raid Sets"],
	ExtraList = true,
	TableType = SET_ITTYPE,
	[NORMAL_DIFF] = {
		{ 1,  1637 },
		{ 2,  1638 },
		{ 3,  1639 },
		{ 5,  1640 },
		{ 6,  1641 },
		{ 7,  1642 },
		{ 8,  1643 },
		{ 10, 1644 },
		{ 11, 1645 },
		{ 12, 1646 },
		{ 13, 1647 },
		{ 16, 1648 },
		{ 17, 1649 },
		{ 18, 1650 },
	},
}

local T1_SET = {
	name = format(AL["Tier %s Sets"], "1"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1,  1698 }, --Balance Druid
		{ 2,  1699 }, --Feral Druid
		{ 3,  1701 }, --Tank Druid
		{ 4,  1700 }, --Resto Druid
		{ 6,  1702 }, --Ranged Hunter
		{ 7,  1703 }, --Melee Hunter
		{ 9,  1704 }, --Damage Mage
		{ 10, 1705 }, --Healer Mage
		{ 12, 1706 }, -- Holy Pally
		{ 13, 1707 }, -- Ret Pally
		{ 14, 1708 }, -- Tank Pally
		{ 16, 1709 }, -- Healer Priest
		{ 17, 1710 }, -- DPS Priest
		{ 19, 1711 }, -- DPS Rogue
		{ 20, 1712 }, -- Tank Rogue
		{ 22, 1717 }, -- DPS Lock
		{ 23, 1718 }, -- Tank Lock
		{ 25, 1719 }, -- Tank Warr
		{ 26, 1720 }, -- Dps Warr
	},
	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 12, 1713 }, -- Healer Sham
		{ 13, 1715 }, -- Melee Sham
		{ 14, 1714 }, -- Ranged Sham
		{ 15, 1716 }, -- Tank Sham
	},
}

local T2_SET = {
	name = format(AL["Tier %s Sets"], "2"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 3,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1,  1801 }, --Balance Druid
		{ 2,  1803 }, --Feral Druid
		{ 3,  1804 }, --Tank Druid
		{ 4,  1802 }, --Resto Druid
		{ 6,  1805 }, --Ranged Hunter
		{ 7,  1806 }, --Melee Hunter
		{ 9,  1807 }, --Damage Mage
		{ 10, 1808 }, --Healer Mage
		{ 12, 1809 }, -- Holy Pally
		{ 13, 1810 }, -- Ret Pally
		{ 14, 1811 }, -- Tank Pally -
		{ 16, 1812 }, -- Healer Priest
		{ 17, 1813 }, -- DPS Priest -
		{ 19, 1814 }, -- DPS Rogue
		{ 20, 1815 }, -- Tank Rogue -
		{ 22, 1820 }, -- DPS Lock
		{ 23, 1821 }, -- Tank Lock
		{ 25, 1822 }, -- Tank Warr
		{ 26, 1823 }, -- Dps Warr
	},
	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 12, 1816 }, -- Healer Sham
		{ 13, 1818 }, -- Melee Sham
		{ 14, 1817 }, -- Ranged Sham
		{ 15, 1819 }, -- Tank Sham
	},
}

local T3_SET = {
	name = format(AL["Tier %s Sets"], "3"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 6,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1,  1904 }, -- Druid Balance
		{ 2,  1903 }, -- Druid Feral
		{ 3,  1902 }, -- Druid Resto
		{ 4,  1901 }, -- Druid Tank
		{ 6,  1899 }, -- Hunter (Ranged)
		{ 7,  1900 }, -- Hunter (Melee)
		{ 9,  1898 }, -- Mage (DPS)
		{ 10, 1897 }, -- Mage (Healer)
		{ 12, 1896 }, -- Paladin (DPS)
		{ 13, 1895 }, -- Paladin (Healer)
		{ 14, 1894 }, -- Paladin (Tank)
		{ 16, 1893 }, -- Priest (DPS)
		{ 17, 1892 }, -- Priest (Healer)
		{ 19, 1891 }, -- Rogue (DPS)
		{ 20, 1890 }, -- Rogue (Tank)
		{ 22, 1885 }, -- Warlock (DPS)
		{ 23, 1884 }, -- Warlock (Tank)
		{ 25, 1883 }, -- Warrior (DPS)
		{ 26, 1882 }, -- Warrior (Tank)
	},
	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 12, 1889 }, -- Shaman (Ele)
		{ 13, 1888 }, -- Shaman (Enhance)
		{ 14, 1887 }, -- Shaman (Resto)
		{ 15, 1886 }, -- Shaman (Tank)
	},
}

local T3_5_SET = {
	name = format(AL["Tier %s Sets"], "3.5"),
	ExtraList = true,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	ContentPhase = 6,
	IgnoreAsSource = true,
	[ALLIANCE_DIFF] = {
		{ 1,  1945 }, -- Druid
		{ 2,  1946 }, -- Druid
		{ 3,  1947 }, -- Druid
		{ 4,  1948 }, -- Druid
		{ 6,  1936 }, -- Hunter
		{ 7,  1937 }, -- Hunter
		{ 9,  1943 }, -- Mage
		{ 10, 1944 }, -- Mage
		{ 12, 1940 }, -- Paladin
		{ 13, 1941 }, -- Paladin
		{ 14, 1942 }, -- Paladin
		{ 15, 1963 }, -- Paladin
		{ 16, 1938 }, -- Priest
		{ 17, 1939 }, -- Priest
		{ 19, 1934 }, -- Rogue
		{ 20, 1935 }, -- Rogue
		{ 22, 1953 }, -- Warlock
		{ 23, 1954 }, -- Warlock
		{ 25, 1932 }, -- Warrior
		{ 26, 1933 }, -- Warrior
	},
	[HORDE_DIFF] = {
		GetItemsFromDiff = ALLIANCE_DIFF,
		{ 12, 1949 }, -- Shaman
		{ 13, 1950 }, -- Shaman
		{ 14, 1951 }, -- Shaman
		{ 15, 1952 }, -- Shaman
	},
}

local AQ_SCARABS = { -- AQ40Trash2
	name = AL["Ahn'Qiraj scarabs"],
	ExtraList = true,
	[NORMAL_DIFF] = {
		{ 1,  20876 }, -- Idol of Death
		{ 2,  20879 }, -- Idol of Life
		{ 3,  20875 }, -- Idol of Night
		{ 4,  20878 }, -- Idol of Rebirth
		{ 5,  20881 }, -- Idol of Strife
		{ 6,  20877 }, -- Idol of the Sage
		{ 7,  20874 }, -- Idol of the Sun
		{ 8,  20882 }, -- Idol of War
		{ 10, 21762 }, -- Greater Scarab Coffer Key
		{ 12, 21156 }, -- Scarab Bag
		{ 14, 21230 }, -- Ancient Qiraji Artifact
		{ 16, 20864 }, -- Bone Scarab
		{ 17, 20861 }, -- Bronze Scarab
		{ 18, 20863 }, -- Clay Scarab
		{ 19, 20862 }, -- Crystal Scarab
		{ 20, 20859 }, -- Gold Scarab
		{ 21, 20865 }, -- Ivory Scarab
		{ 22, 20860 }, -- Silver Scarab
		{ 23, 20858 }, -- Stone Scarab
		{ 26, 22203 }, -- Large Obsidian Shard
		{ 27, 22202 }, -- Small Obsidian Shard
		{ 29, 21229 }, -- Qiraji Lord's Insignia
	},
}

local AQ_ENCHANTS = { -- AQEnchants
	name = AL["Ahn'Qiraj enchants"],
	ExtraList = true,
	[NORMAL_DIFF] = {
		{ 1,  20728 }, -- Formula: Enchant Gloves - Frost Power
		{ 2,  20731 }, -- Formula: Enchant Gloves - Superior Agility
		{ 3,  20734 }, -- Formula: Enchant Cloak - Stealth
		{ 4,  20729 }, -- Formula: Enchant Gloves - Fire Power
		{ 5,  20736 }, -- Formula: Enchant Cloak - Dodge
		{ 6,  20730 }, -- Formula: Enchant Gloves - Healing Power
		{ 7,  20727 }, -- Formula: Enchant Gloves - Shadow Power
		{ 9,  233998 }, -- Formula: Enchant Gloves - Holy Power
		{ 10, 233999 }, -- Formula: Enchant Gloves - Arcane Power
		{ 11, 235526 }, -- Formula: Enchant Bracer - Spell Power
		{ 12, 235528 }, -- Formula: Enchant Bracer - Agility
		{ 13, 233997 }, -- Formula: Living Stats
	},
}

local AQ_OPENING = { -- Keys
	name = AL["AQ opening"],
	TableType = NORMAL_ITTYPE,
	ExtraList = true,
	ContentPhase = 5,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,  21138 }, -- Red Scepter Shard
		{ 2,  234130 }, -- Amulet of Shadow Shielding
		{ 3,  234129 }, -- Onyx Embedded Leggings
		{ 5,  21139 }, -- Green Scepter Shard
		{ 6,  234132 }, -- Drake Tooth Necklace
		{ 7,  234133 }, -- Drudge Boots
		{ 9,  21137 }, -- Blue Scepter Shard
		{ 10, 234134 }, -- Gnomish Turban of Psychic Might
		{ 11, 234136 }, -- Darkwater Robes
		{ 12, 234135 }, -- Band of Icy Depths
		{ 13, 21025 }, -- Recipe: Dirge's Kickin' Chimaerok Chops
		{ 16, 21175 }, -- The Scepter of the Shifting Sands
		{ 17, 21176 }, -- Black Qiraji Resonating Crystal
		{ 18, 234137 }, -- Fang of Korialstrasz
		{ 19, 234141 }, -- Runesword of the Red
		{ 20, 234138 }, -- Shadowsong's Sorrow
		{ 21, 234139 }, -- Ravencrest's Legacy
	},
}

local DM_BOOKS = { -- DMBooks
	name = AL["Books"],
	ExtraList = true,
	IgnoreAsSource = true,
	[NORMAL_DIFF] = {
		{ 1,  18401 }, -- Foror's Compendium of Dragon Slaying
		{ 3,  18362 }, -- Holy Bologna: What the Light Won't Tell You
		{ 4,  228466 }, -- The Arcanist's Cookbook
		{ 5,  18360 }, -- Harnessing Shadows
		{ 6,  228464 }, -- Garona: A Study on Stealth and Treachery
		{ 7,  18364 }, -- The Emerald Dream
		{ 8,  18361 }, -- The Greatest Race of Hunters
		{ 9,  18363 }, -- Frost Shock and You
		{ 10, 228467 }, -- The Light and How to Swing It
		{ 11, 228465 }, -- Codex of Defense
		--{ 16, 18348 }, -- Quel'Serrar
		{ 18, 18333 }, -- Libram of Focus
		{ 19, 18334 }, -- Libram of Protection
		{ 20, 18332 }, -- Libram of Rapidity
		{ 22, 11733 }, -- Libram of Constitution
		{ 23, 11736 }, -- Libram of Resilience
		{ 24, 11732 }, -- Libram of Rumination
		{ 25, 11734 }, -- Libram of Tenacity
		{ 26, 11737 }, -- Libram of Voracity
	},
}

data["Ragefire"] = {
	MapID = 2437,
	InstanceID = 389,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Ragefire",
	AtlasMapFile = "RagefireChasm",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 10, 13, 18 }, { 8, 13, 16 }),
	items = {
		{ -- RFCTaragaman
			name = AL["Taragaman the Hungerer"],
			npcID = 11520,
			Level = 16,
			DisplayIDs = { { 7970 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 14149 }, -- Subterranean Cape
				{ 2, 14148 }, -- Crystalline Cuffs
				{ 3, 14145 }, -- Cursed Felblade
			},
		},
		{ -- RFCJergosh
			name = AL["Jergosh the Invoker"],
			npcID = 11518,
			Level = 16,
			DisplayIDs = { { 11429 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 14150 }, -- Robe of Evocation
				{ 2, 14147 }, -- Cavedweller Bracers
				{ 3, 14151 }, -- Chanting Blade
			},
		},
	},
}

data["WailingCaverns"] = {
	MapID = 718,
	InstanceID = 43,
	SubAreaIDs = { 15285, 15301, 15294, 15300, 15292, 17731 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "WailingCaverns",
	AtlasMapFile = { "CL_WailingCaverns", "CL_WailingCavernsEnt" },
	AtlasMapFile_AL = { "WailingCaverns", "WailingCavernsEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 10, 17, 24 }, { 10, 17, 21 }),
	items = {
		{ -- WCLordCobrahn
			name = AL["Lord Cobrahn"],
			npcID = 3669,
			Level = 20,
			SubAreaID = 15300,
			DisplayIDs = { { 4213 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 6460 }, -- Cobrahn's Grasp
				{ 2, 10410 }, -- Leggings of the Fang
				{ 4, 6465 }, -- Robe of the Moccasin
			},
		},
		{ -- WCLadyAnacondra
			name = AL["Lady Anacondra"],
			npcID = 3671,
			Level = 20,
			DisplayIDs = { { 4313 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 10412 }, -- Belt of the Fang
				{ 3, 5404 }, -- Serpent's Shoulders
				{ 4, 6446 }, -- Snakeskin Bag
			},
		},
		{ -- WCKresh
			name = AL["Kresh"],
			npcID = 3653,
			Level = 20,
			DisplayIDs = { { 5126 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 13245 }, -- Kresh's Back
				{ 3, 6447 }, -- Worn Turtle Shell Shield
			},
		},
		{ -- WCLordPythas
			name = AL["Lord Pythas"],
			npcID = 3670,
			Level = GetForVersion(21, 20),
			SubAreaID = 17731,
			DisplayIDs = { { 4214 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 6472 }, -- Stinging Viper
				{ 3, 6473 }, -- Armor of the Fang
			},
		},
		{ -- WCSkum
			name = AL["Skum"],
			npcID = 3674,
			Level = GetForVersion(21, 20),
			DisplayIDs = { { 4203 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 6449 }, -- Glowing Lizardscale Cloak
				{ 3, 6448 }, -- Tail Spike
			},
		},
		{ -- WCLordSerpentis
			name = AL["Lord Serpentis"],
			npcID = 3673,
			Level = GetForVersion(21, 20),
			DisplayIDs = { { 4215 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 6469 }, -- Venomstrike
				{ 3, 5970 }, -- Serpent Gloves
				{ 4, 10411 }, -- Footpads of the Fang
				{ 5, 6459 }, -- Savage Trodders
			},
		},
		{ -- WCVerdan
			name = AL["Verdan the Everliving"],
			npcID = 5775,
			Level = GetForVersion(21, 20),
			DisplayIDs = { { 4256 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 6630 }, -- Seedcloud Buckler
				{ 2, 6631 }, -- Living Root
				{ 4, 6629 }, -- Sporid Cape
			},
		},
		{ -- WCMutanus
			name = AL["Mutanus the Devourer"],
			npcID = 3654,
			Level = GetForVersion(22, 20),
			SubAreaID = 15294,
			DisplayIDs = { { 4088 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  6461 }, -- Slime-encrusted Pads
				{ 2,  6627 }, -- Mutant Scale Breastplate
				{ 3,  6463 }, -- Deep Fathom Ring
				{ 16, 10441 }, -- Glowing Shard
			},
		},
		{ -- WCDeviateFaerieDragon
			name = AL["Deviate Faerie Dragon"],
			npcID = 5912,
			Level = GetForVersion(19, 20),
			DisplayIDs = { { 1267 } },
			AtlasMapBossID = 10,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 5243 }, -- Firebelcher
				{ 3, 6632 }, -- Feyscale Cloak
			},
		},
		{ -- WCTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 10413 }, -- Gloves of the Fang
			},
		},
	},
}

data["TheDeadmines"] = {
	MapID = 1581,
	InstanceID = 36,
	SubAreaIDs = { 19444, 19529, 19502, 26104 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheDeadmines",
	AtlasMapFile_AL = { "TheDeadmines", "TheDeadminesEnt" },
	AtlasMapFile = { "CL_TheDeadmines", "CL_TheDeadminesEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 10, 17, 26 }, { 10, 18, 22 }),
	items = {
		{ --DMRhahkZor
			name = AL["Rhahk'Zor"],
			npcID = 644,
			Level = 19,
			DisplayIDs = { { 14403 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 872 }, -- Rockslicer
				{ 3, 5187 }, -- Rhahk'Zor's Hammer
			},
		},
		{ --DMMinerJohnson
			name = AL["Miner Johnson"],
			npcID = 3586,
			Level = 19,
			DisplayIDs = { { 556 } },
			specialType = "rare",
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 5443 }, -- Gold-plated Buckler
				{ 3, 5444 }, -- Miner's Cape
			},
		},
		{ --DMSneed
			name = AL["Sneed"],
			npcID = 643,
			Level = 20,
			SubAreaID = 19529,
			DisplayIDs = { { 7125 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 5194 }, -- Taskmaster Axe
				{ 3, 5195 }, -- Gold-flecked Gloves
			},
		},
		{ --DMSneedsShredder
			name = AL["Sneed's Shredder"],
			npcID = 642,
			Level = 20,
			DisplayIDs = { { 1269 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 1937 }, -- Buzz Saw
				{ 3, 2169 }, -- Buzzer Blade
			},
		},
		{ --DMGilnid
			name = AL["Gilnid"],
			npcID = 1763,
			Level = 20,
			SubAreaID = 19502,
			DisplayIDs = { { 7124 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 1156 }, -- Lavishly Jeweled Ring
				{ 3, 5199 }, -- Smelting Pants
			},
		},
		{ --DMMrSmite
			name = AL["Mr. Smite"],
			npcID = 646,
			Level = 20,
			SubAreaID = 26104,
			DisplayIDs = { { 2026 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 7230 }, -- Smite's Mighty Hammer
				{ 3, 5192 }, -- Thief's Blade
				{ 4, 5196 }, -- Smite's Reaver
			},
		},
		{ --DMCaptainGreenskin
			name = AL["Captain Greenskin"],
			npcID = 647,
			Level = 20,
			DisplayIDs = { { 7113 }, { 2349 }, { 2347 }, { 5207 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5201 }, -- Emberstone Staff
				{ 3, 10403 }, -- Blackened Defias Belt
				{ 4, 5200 }, -- Impaling Harpoon
			},
		},
		{ --DMVanCleef
			name = AL["Edwin VanCleef"],
			npcID = 639,
			Level = GetForVersion(21, 20),
			DisplayIDs = { { 2029 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5193 }, -- Cape of the Brotherhood
				{ 2, 5202 }, -- Corsair's Overshirt
				{ 3, 10399 }, -- Blackened Defias Armor
				{ 4, 5191 }, -- Cruel Barb
				{ 6, 2874 }, -- An Unsent Letter
			},
		},
		{ --DMCookie
			name = AL["Cookie"],
			npcID = 645,
			Level = 20,
			DisplayIDs = { { 1305 } },
			specialType = "elite",
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 5198 }, -- Cookie's Stirring Rod
				{ 3, 5197 }, -- Cookie's Tenderizer
				{ 5, 8490 }, -- Cat Carrier (Siamese)
			},
		},
		{ --DMDefiasGunpowder
			name = AL["Defias Gunpowder"],
			ExtraList = true,
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 5397 }, -- Defias Gunpowder
			},
		},
		{ --DMTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 8492 }, -- Parrot Cage (Green Wing Macaw)
			},
		},
		KEYS,
	}
}

data["ShadowfangKeep"] = {
	MapID = 209,
	InstanceID = 33,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ShadowfangKeep",
	AtlasMapFile = "CL_ShadowfangKeep",
	AtlasMapFile_AL = "ShadowfangKeep",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 11, 22, 30 }, { 14, 18, 21 }),
	items = {
		{ -- SFKRethilgore
			name = AL["Rethilgore"],
			npcID = 3914,
			Level = 20,
			DisplayIDs = { { 524 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 5254 }, -- Rugged Spaulders
			},
		},
		{ -- SFKFelSteed
			name = AL["Fel Steed / Shadow Charger"],
			npcID = { 3865, 3864 },
			Level = GetForVersion({ 19, 20 }, { 18, 19 }),
			DisplayIDs = { { 1952 }, { 1951 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 6341 }, -- Eerie Stable Lantern
				{ 3, 932 }, -- Fel Steed Saddlebags
			},
		},
		{ -- SFKRazorclawtheButcher
			name = AL["Razorclaw the Butcher"],
			npcID = 3886,
			Level = GetForVersion(22, 20),
			DisplayIDs = { { 524 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 1292 }, -- Butcher's Cleaver
				{ 3, 6226 }, -- Bloody Apron
				{ 4, 6633 }, -- Butcher's Slicer
			},
		},
		{ -- SFKSilverlaine
			name = AL["Baron Silverlaine"],
			npcID = 3887,
			Level = GetForVersion(24, 20),
			DisplayIDs = { { 3222 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 6321 }, -- Silverlaine's Family Seal
				{ 3, 6323 }, -- Baron's Scepter
			},
		},
		{ -- SFKSpringvale
			name = AL["Commander Springvale"],
			npcID = 4278,
			Level = GetForVersion(24, 20),
			DisplayIDs = { { 3223 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 6320 }, -- Commander's Crest
				{ 3, 3191 }, -- Arced War Axe
			},
		},
		{ -- SFKOdotheBlindwatcher
			name = AL["Odo the Blindwatcher"],
			npcID = 4279,
			Level = GetForVersion(24, 21),
			DisplayIDs = { { 522 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 6318 }, -- Odo's Ley Staff
				{ 3, 6319 }, -- Girdle of the Blindwatcher
			},
		},
		{ -- SFKDeathswornCaptain
			name = AL["Deathsworn Captain"],
			npcID = 3872,
			Level = GetForVersion(25, 21),
			DisplayIDs = { { 3224 } },
			specialType = "rare",
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1, 6642 }, -- Phantom Armor
				{ 3, 6641 }, -- Haunting Blade
			},
		},
		{ -- SFKArugalsVoidwalker
			name = AL["Arugal's Voidwalker"],
			npcID = 4627,
			Level = GetForVersion({ 24, 25 }, 20),
			DisplayIDs = { { 1131 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1, 5943 }, -- Rift Bracers
			},
		},
		{ -- SFKFenrustheDevourer
			name = AL["Fenrus the Devourer"],
			npcID = 4274,
			Level = GetForVersion(25, 21),
			DisplayIDs = { { 2352 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1, 6340 }, -- Fenrus' Hide
				{ 2, 3230 }, -- Black Wolf Bracers
			},
		},
		{ -- SFKWolfMasterNandos
			name = AL["Wolf Master Nandos"],
			npcID = 3927,
			Level = GetForVersion(25, 21),
			DisplayIDs = { { 11179 } },
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1, 3748 }, -- Feline Mantle
				{ 3, 6314 }, -- Wolfmaster Cape
			},
		},
		{ -- SFKArchmageArugal
			name = AL["Archmage Arugal"],
			npcID = 4275,
			Level = GetForVersion(25, 21),
			DisplayIDs = { { 2353 } },
			AtlasMapBossID = 12,
			[NORMAL_DIFF] = {
				{ 1, 6324 }, -- Robes of Arugal
				{ 2, 6392 }, -- Belt of Arugal
				{ 3, 6220 }, -- Meteor Shard
			},
		},
		{ -- SFKTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  2292 }, -- Necrology Robes
				{ 2,  1489 }, -- Gloomshroud Armor
				{ 3,  1974 }, -- Mindthrust Bracers
				{ 4,  2807 }, -- Guillotine Axe
				{ 5,  1482 }, -- Shadowfang
				{ 6,  1935 }, -- Assassin's Blade
				{ 7,  1483 }, -- Face Smasher
				{ 8,  1318 }, -- Night Reaver
				{ 9,  3194 }, -- Black Malice
				{ 10, 2205 }, -- Duskbringer
				{ 11, 1484 }, -- Witching Stave
			},
		},
		{ -- SFKSever
			name = AL["Sever"],
			npcID = 14682,
			DisplayIDs = { { 1061 } },
			AtlasMapBossID = 7,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 238349 }, -- Abomination Skin Leggings
				{ 2, 238348 }, -- The Axe of Severing
			},
		},
		{ -- SFKJordansHammer
			name = AL["Jordan's Smithing Hammer"],
			ExtraList = true,
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 6895 }, -- Jordan's Smithing Hammer
			},
		},
		{ -- SFKBookofUr
			name = AL["The Book of Ur"],
			ExtraList = true,
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1, 6283 }, -- The Book of Ur
			},
		},
	},
}

data["BlackfathomDeeps"] = {
	MapID = 719,
	InstanceID = 48,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackfathomDeeps",
	AtlasMapFile = { "CL_BlackfathomDeepsA", "CL_BlackfathomDeepsEnt" },
	AtlasMapFile_AL = { "BlackfathomDeeps", "BlackfathomDeepsEnt" },
	ContentType = RAID10_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = { 25, 25, 40 },
	items = {
		{ -- BFDBaronAquanis
			name = AL["Baron Aquanis"],
			npcID = 202699,
			Level = GetForVersion(28, 24),
			DisplayIDs = { { 110 } },
			[NORMAL_DIFF] = {
				{ 1,  [ATLASLOOT_IT_HORDE] = 211454, [ATLASLOOT_IT_ALLIANCE] = 211818 }, -- Strange Water Globe
				{ 2,  211852 },                                              -- Handwraps of Befouled Water
				{ 3,  209423 },                                              -- Flowing Scarf
				{ 4,  209421 },                                              -- Cord of Aquanis
				{ 5,  209828 },                                              -- Sub-Zero Pauldrons
				{ 6,  209422 },                                              -- High Tide Choker
				{ 7,  209825 },                                              -- Droplet Choker
				{ 8,  204807 },                                              -- Fathomblade
				{ 9,  204804 },                                              -- Hydraxian Bangles
				{ 10, 209676 },                                              -- Shoulderguards of Crushing Depths
				{ 11, 209590 },                                              -- Cracked Water Globe
				{ 12, 209677 },                                              -- Loop of Swift Currents
			},
		},
		{ -- BFDGhamoora
			name = AL["Ghamoo-ra"],
			npcID = 201722,
			Level = GetForVersion(25, 23),
			DisplayIDs = { { 5027 } },
			[NORMAL_DIFF] = {
				{ 1,  209436 }, -- Chipped Bite of Serra'kis
				{ 2,  209830 }, -- Ironhide Arbalest
				{ 3,  209418 }, -- Adamantine Tortoise Armor
				{ 4,  209824 }, -- Shimmering Shoulderpads
				{ 5,  209523 }, -- Shimmering Thresher Cape
				{ 6,  209432 }, -- Ghamoo-ra's Cinch
				{ 7,  209678 }, -- Mantle of the Thresher Slayer
				{ 8,  209424 }, -- Shell Plate Barrier
				{ 9,  209675 }, -- Clamweave Tunic
				{ 10, 209524 }, -- Bindings of Serra'kis
			},
		},
		{ -- BFDLadySarevess
			name = AL["Lady Sarevess"],
			npcID = 204068,
			Level = GetForVersion(25, 23),
			DisplayIDs = { { 4979 } },
			[NORMAL_DIFF] = {
				{ 1,  209566 }, -- Leggings of the Faithful
				{ 2,  211789 }, -- Artemis Cowl
				{ 3,  211842 }, -- Rakkamar's Tattered Thinking Cap
				{ 4,  209680 }, -- Waterproof Scarf
				{ 5,  209525 }, -- Honed Darkwater Talwar
				{ 6,  209565 }, -- Band of Deep Places
				{ 7,  211843 }, -- Mask of Scorn
				{ 8,  209563 }, -- Naga Heartrender
				{ 9,  209564 }, -- Guardian's Trident
				{ 10, 209527 }, -- Naga Battle Gauntlets
				{ 11, 209822 }, -- Strength of Purpose
				{ 12, 209679 }, -- Azshari Novice's Shoulderpads
				{ 13, 209823 }, -- Signet of Beasts
			},
		},
		{ -- BFDGelihast
			name = AL["Gelihast"],
			npcID = 204921,
			Level = GetForVersion(26, 24),
			DisplayIDs = { { 1773 } },
			[NORMAL_DIFF] = {
				{ 1,  209569 }, -- Murloc Hide Kneeboots
				{ 2,  209559 }, -- Twilight Sage's Walking Stick
				{ 3,  209568 }, -- Algae Gauntlets
				{ 4,  209820 }, -- Black Shroud Choker
				{ 5,  209573 }, -- Wrathful Spire
				{ 6,  209567 }, -- Coral Reef Axe
				{ 7,  209571 }, -- Deadlight
				{ 8,  209670 }, -- Skinwalkers
				{ 9,  209570 }, -- Tome of Cavern Lore
				{ 10, 209821 }, -- Ring of Shadowsight
				{ 11, 209572 }, -- Black Boiled Leathers
				{ 12, 209681 }, -- Black Murloc Egg
				{ 13, 211491 }, -- Bottomless Murloc Skin Bag
				{ 16, 211505 }, -- Twilight Avenger's Helm
				{ 17, 211504 }, -- Twilight Avenger's Chain
				{ 18, 211506 }, -- Twilight Avenger's Boots
				{ 20, 211507 }, -- Twilight Elementalist's Cowl
				{ 21, 211509 }, -- Twilight Elementalist's Robe
				{ 22, 211508 }, -- Twilight Elementalist's Footpads
				{ 24, 211510 }, -- Twilight Slayer's Cowl
				{ 25, 211512 }, -- Twilight Slayer's Tunic
				{ 26, 211511 }, -- Twilight Slayer's Footpads
				{ 28, 209683 }, -- Twilight Invoker's Shawl
				{ 29, 209671 }, -- Twilight Invoker's Robes
				{ 30, 209669 }, -- Twilight Invoker's Shoes
			},
		},
		{ -- BFDOldSerrakis
			name = AL["Lorgus Jett"],
			npcID = 207356,
			Level = GetForVersion(26, 24),
			DisplayIDs = { { 1816 } },
			[NORMAL_DIFF] = {
				{ 1,  209560 }, -- Hammer of Righteous Judgement
				{ 2,  209576 }, -- Mind-Expanding Mushroom
				{ 3,  209818 }, -- Sun-Touched Crescent
				{ 4,  209581 }, -- Silver Hand Sabatons
				{ 5,  209578 }, -- Glowing Leather Bands
				{ 6,  209682 }, -- Sturdy Hood
				{ 7,  209574 }, -- Discarded Tenets of the Silver Hand
				{ 8,  209577 }, -- Fist of the Wild
				{ 9,  209575 }, -- Carved Driftwood Icon
				{ 10, 209579 }, -- Crashing Thunder
				{ 16, 211505 }, -- Twilight Avenger's Helm
				{ 17, 211504 }, -- Twilight Avenger's Chain
				{ 18, 211506 }, -- Twilight Avenger's Boots
				{ 20, 211507 }, -- Twilight Elementalist's Cowl
				{ 21, 211509 }, -- Twilight Elementalist's Robe
				{ 22, 211508 }, -- Twilight Elementalist's Footpads
				{ 24, 211510 }, -- Twilight Slayer's Cowl
				{ 25, 211512 }, -- Twilight Slayer's Tunic
				{ 26, 211511 }, -- Twilight Slayer's Footpads
				{ 28, 209683 }, -- Twilight Invoker's Shawl
				{ 29, 209671 }, -- Twilight Invoker's Robes
				{ 30, 209669 }, -- Twilight Invoker's Shoes
			},
		},
		{ -- BFDTwilightLordKelris
			name = AL["Twilight Lord Kelris"],
			npcID = 4832,
			Level = GetForVersion(27, 24),
			DisplayIDs = { { 4939 } },
			AtlasMapFile = { "CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt" },
			[NORMAL_DIFF] = {
				{ 1,  209694 }, -- Blackfathom Ritual Dagger
				{ 2,  209672 }, -- Black Fingerless Gloves
				{ 3,  209686 }, -- Jagged Bone Necklace
				{ 4,  209667 }, -- Gaze Dreamer Leggings
				{ 5,  209668 }, -- Signet of the Twilight Lord
				{ 6,  211455 }, -- Slick Fingerless Gloves
				{ 7,  209817 }, -- Voidwalker Brooch
				{ 8,  209674 }, -- Phoenix Ignition
				{ 9,  211458 }, -- Tome of Shadow Warding
				{ 10, 211457 }, -- Twilight Defender's Girdle
				{ 11, 209673 }, -- Glowing Fetish Amulet
				{ 12, 209816 }, -- Fetish of Mischief
				{ 13, 209561 }, -- Rod of the Ancient Sleepwalker
				{ 14, 211492 }, -- Kelris's Satchel
				{ 16, 211505 }, -- Twilight Avenger's Helm
				{ 17, 211504 }, -- Twilight Avenger's Chain
				{ 18, 211506 }, -- Twilight Avenger's Boots
				{ 20, 211507 }, -- Twilight Elementalist's Cowl
				{ 21, 211509 }, -- Twilight Elementalist's Robe
				{ 22, 211508 }, -- Twilight Elementalist's Footpads
				{ 24, 211510 }, -- Twilight Slayer's Cowl
				{ 25, 211512 }, -- Twilight Slayer's Tunic
				{ 26, 211511 }, -- Twilight Slayer's Footpads
				{ 28, 209683 }, -- Twilight Invoker's Shawl
				{ 29, 209671 }, -- Twilight Invoker's Robes
				{ 30, 209669 }, -- Twilight Invoker's Shoes
			},
		},
		{ -- BFDAkumai
			name = AL["Aku'mai"],
			npcID = 213334,
			Level = GetForVersion(28, 24),
			DisplayIDs = { { 2837 } },
			AtlasMapFile = { "CL_BlackfathomDeepsB", "CL_BlackfathomDeepsEnt" },
			[NORMAL_DIFF] = {
				{ 1,  [ATLASLOOT_IT_HORDE] = 211452, [ATLASLOOT_IT_ALLIANCE] = 209693 }, -- Perfect Blackfathom Pearl
				{ 3,  209692 },                                              -- Sentinel Pauldrons
				{ 4,  211456 },                                              -- Dagger of Willing Sacrifice
				{ 5,  209685 },                                              -- Ancient Moss Cinch
				{ 6,  209688 },                                              -- Bael Modan Blunderbuss
				{ 7,  209687 },                                              -- Hydra Hide Cuirass
				{ 8,  209690 },                                              -- Shadowscale Coif
				{ 9,  209691 },                                              -- Vampiric Boot Knife
				{ 10, 209580 },                                              -- Gusting Wind
				{ 11, 209684 },                                              -- Soul Leech Pants
				{ 12, 209689 },                                              -- Crabshell Waders
				{ 13, 209534 },                                              -- Azshari Arbalest
				{ 14, 209562 },                                              -- Deadly Strike of the Hydra
				{ 16, 211505 },                                              -- Twilight Avenger's Helm
				{ 17, 211504 },                                              -- Twilight Avenger's Chain
				{ 18, 211506 },                                              -- Twilight Avenger's Boots
				{ 20, 211507 },                                              -- Twilight Elementalist's Cowl
				{ 21, 211509 },                                              -- Twilight Elementalist's Robe
				{ 22, 211508 },                                              -- Twilight Elementalist's Footpads
				{ 24, 211510 },                                              -- Twilight Slayer's Cowl
				{ 25, 211512 },                                              -- Twilight Slayer's Tunic
				{ 26, 211511 },                                              -- Twilight Slayer's Footpads
				{ 28, 209683 },                                              -- Twilight Invoker's Shawl
				{ 29, 209671 },                                              -- Twilight Invoker's Robes
				{ 30, 209669 },                                              -- Twilight Invoker's Shoes
			},
		},
		{ -- BFDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  1486 }, -- Tree Bark Jacket
				{ 2,  3416 }, -- Martyr's Chain
				{ 3,  1491 }, -- Ring of Precision
				{ 4,  3414 }, -- Crested Scepter
				{ 5,  1454 }, -- Axe of the Enforcer
				{ 6,  1481 }, -- Grimclaw
				{ 7,  2567 }, -- Evocator's Blade
				{ 8,  3413 }, -- Doomspike
				{ 9,  3417 }, -- Onyx Claymore
				{ 10, 3415 }, -- Staff of the Friar
				{ 11, 2271 }, -- Staff of the Blessed Seer
			},
		},
		BFD_SET,
	},
}

data["TheStockade"] = {
	MapID = 717,
	InstanceID = 34,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheStockade",
	AtlasMapFile = "CL_TheStockade",
	AtlasMapFile_AL = "TheStockade",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 15, 24, 32 }, { 15, 23, 29 }),
	items = {
		{ -- SWStKamDeepfury
			name = AL["Kam Deepfury"],
			npcID = 1666,
			Level = GetForVersion(27, 25),
			DisplayIDs = { { 825 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 2280 }, -- Kam's Walking Stick
			},
		},
		{ -- SWStBruegalIronknuckle
			name = AL["Bruegal Ironknuckle"],
			npcID = 1720,
			Level = GetForVersion(26, 25),
			DisplayIDs = { { 2142 } },
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 3228 }, -- Jimmied Handcuffs
				{ 2, 2941 }, -- Prison Shank
				{ 3, 2942 }, -- Iron Knuckles
			},
		},
		{ -- SWStTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 1076 }, -- Defias Renegade Ring
			},
		},
	},
}

data["Gnomeregan"] = {
	MapID = 721,
	InstanceID = 90,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Gnomeregan",
	AtlasMapFile = { "CL_Gnomeregan", "CL_GnomereganEnt" },
	AtlasMapFile_AL = { "Gnomeregan", "GnomereganEnt" },
	ContentType = RAID10_CONTENT,
	LevelRange = { 40, 40, 50 },
	items = {
		{ -- Grubbis
			name = AL["Grubbis"],
			npcID = 217280,
			Level = 40,
			DisplayIDs = { { 117047 } },
			[NORMAL_DIFF] = {
				{ 1,  213288 }, -- Grubbis Grubby Gauntlets
				{ 2,  213304 }, -- Troggslayer Pauldrons
				{ 3,  213321 }, -- Volatile Concoction Belt
				{ 4,  213294 }, -- Caverndeep Sabatons
				{ 5,  213327 }, -- Belt of the Trogg Berserker
				{ 6,  213322 }, -- Skullduggery Waistband
				{ 7,  213351 }, -- Irradiated Tower Shield
				{ 8,  213542 }, -- The Necro-Gnomicon
				{ 9,  213323 }, -- Cord of Deep Earth
				{ 10, 215435 }, -- Libram of Benediction
				{ 11, 213324 }, -- Electromagnetic Waistcord
				{ 12, 213326 }, -- Girdle of Reclamation
				{ 13, 215436 }, -- Totem of Invigorating Flame
				{ 14, 215437 }, -- Trogg Transfigurator 3000
				{ 15, 216490 }, -- Idol of Wrath
			},
		},
		{ -- GnViscousFallout
			name = AL["Viscous Fallout"],
			npcID = 220007,
			Level = GetForVersion(32, 28),
			DisplayIDs = { { 5497 } },
			[NORMAL_DIFF] = {
				{ 1,  213307 }, -- Drape of Dismantling
				{ 2,  213355 }, -- Falco's Sting
				{ 3,  213352 }, -- Gear-Mender's Grace
				{ 4,  213289 }, -- Hydrostaff
				{ 5,  213285 }, -- Lev's Oil-Stained Bindings
				{ 6,  213301 }, -- Synthetic Mantle
				{ 7,  213302 }, -- Mantle of the Cunning Negotiator
				{ 8,  213299 }, -- Petrolspill Pants
				{ 9,  213413 }, -- Generously Padded Shoulderpads
				{ 10, 213290 }, -- Acidic Waders
				{ 11, 213291 }, -- Toxic Revenger II
				{ 12, 213353 }, -- Defibrillating Staff
			},
		},
		{ -- GnElectrocutioner6000
			name = AL["Electrocutioner 6000"],
			npcID = 220072,
			Level = GetForVersion(30, 28),
			DisplayIDs = { { 118007 } },
			[NORMAL_DIFF] = {
				{ 1,  213319 }, -- Machinist's Gloves
				{ 2,  213300 }, -- Fighter Ace Gloves
				{ 3,  213309 }, -- Cloak of Invention
				{ 4,  213287 }, -- Electrocutioner Hexnut
				{ 5,  213560 }, -- Mechanostrider Muffler
				{ 6,  213298 }, -- Mechbuilder's Overalls
				{ 7,  213293 }, -- Hi-tech Supergun Mk.VII
				{ 8,  213559 }, -- Mechanostrider Gear Shifter
				{ 9,  216494 }, -- Aragriar's Whimsical World Warper
				{ 10, 213354 }, -- Staff of the Evil Genius
				{ 11, 213414 }, -- Mech-Mender's Sash
				{ 12, 213418 }, -- Welded Truesilver Ringlets
				{ 13, 213279 }, -- Reflective Skullcap
				{ 16, 215377 }, -- Irradiated Robe
				{ 17, 215379 }, -- Irradiated Trousers
				{ 18, 215378 }, -- Irradiated Boots
				{ 20, 213286 }, -- Electrocutioner's Needle
				{ 22, 217008 }, -- Power Depleted Chest
				{ 23, 217009 }, -- Power Depleted Legs
				{ 24, 217007 }, -- Power Depleted Boots
			},
		},
		{ -- GnCrowdPummeler960
			name = AL["Crowd Pummeler 9-60"],
			npcID = 215728,
			Level = GetForVersion(32, 28),
			DisplayIDs = { { 6774 } },
			[NORMAL_DIFF] = {
				{ 1,  213295 }, -- Ultrasonic Vibroblade
				{ 2,  213419 }, -- 9-60 Repair Manual
				{ 3,  213408 }, -- Gyromatic Macro-Adjustor
				{ 4,  213278 }, -- Bonk-Maestro's Handguards
				{ 5,  213442 }, -- Cogmaster's Claw
				{ 6,  213317 }, -- Experimental Aim Stabilizers
				{ 7,  213292 }, -- Gizmotron Gigachopper
				{ 8,  213340 }, -- Gnomebot Operators Boots
				{ 9,  213415 }, -- Tinker's Wrist Wraps
				{ 10, 213305 }, -- Machined Alloy Shoulderplates
				{ 11, 210741 }, -- Automatic Crowd Pummeler
				{ 13, 215449 }, -- World Shrinker
				{ 14, 213412 }, -- Dielectric Safety Shield
			},
		},
		{ -- GnMechanicalMenagerie
			name = AL["The Mechanical Menagerie"],
			npcID = 218242,
			Level = GetForVersion(33, 28),
			DisplayIDs = { { 117365 } },
			[NORMAL_DIFF] = {
				{ 1,  213296 }, -- Supercharged Headchopper
				{ 2,  213297 }, -- Oscillating Blasthammer
				{ 3,  213306 }, -- Ingenuity's Cover
				{ 4,  213325 }, -- Darkvision Girdle
				{ 5,  213411 }, -- Izzleflick's Inextinguishable Igniter
				{ 6,  213280 }, -- Marksman's Scopevisor
				{ 7,  213318 }, -- Ornate Dark Iron Bangles
				{ 8,  213320 }, -- Fingers of Arcane Accuracy
				{ 9,  213308 }, -- Prototype Parachute Cloak
				{ 10, 213417 }, -- Truesilver Filament Coif
				{ 11, 213303 }, -- Lightning Rod Spaulders
				{ 13, 215378 }, -- Irradiated Boots
				{ 14, 215379 }, -- Irradiated Trousers
				{ 15, 215377 }, -- Irradiated Robe
				{ 16, 215380 }, -- Power-Assisted Lifting Belt
				{ 17, 213410 }, -- Glimmering Gizmoblade
				{ 19, 217008 }, -- Power Depleted Chest
				{ 20, 217009 }, -- Power Depleted Legs
				{ 21, 217007 }, -- Power Depleted Boots
			},
		},
		{ -- GnMekgineerThermaplugg
			name = AL["Mekgineer Thermaplugg"],
			npcID = 218537,
			Level = GetForVersion(34, 28),
			DisplayIDs = { { 117499 } },
			[NORMAL_DIFF] = {
				{ 1,  [ATLASLOOT_IT_HORDE] = 217351, [ATLASLOOT_IT_ALLIANCE] = 217350 }, -- Thermaplugg's Engineering Notes
				{ 3,  213281 },                                              -- Electromagnetic Hyperflux Reactivator
				{ 4,  213348 },                                              -- Gyromatic Experiment 420b
				{ 5,  213349 },                                              -- Gniodine Pill Bottle
				{ 6,  213350 },                                              -- Wirdal's Hardened Core
				{ 7,  213347 },                                              -- Miniaturized Combustion Chamber
				{ 8,  215461 },                                              -- Domesticated Attack Chicken
				{ 10, 215379 },                                              -- Irradiated Trousers
				{ 11, 215377 },                                              -- Irradiated Robe
				{ 12, 215378 },                                              -- Irradiated Boots
				{ 16, 213283 },                                              -- Hypercharged Gear of Conflagration
				{ 17, 213284 },                                              -- Hypercharged Gear of Devastation
				{ 18, 213282 },                                              -- Hypercharged Gear of Innovation
				{ 20, 213356 },                                              -- Thermaplugg's Custom Blaster
				{ 21, 213409 },                                              -- Mekgatorque's Arcano-Shredder
				{ 22, 213416 },                                              -- Thermaplugg's Rocket Cleaver
				{ 24, 216608 },                                              -- Radiant Ray Reflectors
				{ 25, 13325 },                                               -- Fluorescent Green Mechanostrider
				{ 27, 217008 },                                              -- Power Depleted Chest
				{ 28, 217009 },                                              -- Power Depleted Legs
				{ 29, 217007 },                                              -- Power Depleted Boots
			},
		},
		{ -- GnTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  9508 }, -- Mechbuilder's Overalls
				{ 2,  9491 }, -- Hotshot Pilot's Gloves
				{ 3,  9509 }, -- Petrolspill Leggings
				{ 4,  9510 }, -- Caverndeep Trudgers
				{ 5,  9487 }, -- Hi-tech Supergun
				{ 6,  9485 }, -- Vibroblade
				{ 7,  9488 }, -- Oscillating Power Hammer
				{ 8,  9486 }, -- Supercharger Battle Axe
				{ 9,  9490 }, -- Gizmotron Megachopper
				{ 11, 9489 }, -- Gyromatic Icemaker
				{ 12, 11827, 11826 }, -- Schematic: Lil' Smoky
				{ 16, 9327 }, -- Security DELTA Data Access Card
				{ 18, 7191 }, -- Fused Wiring
				{ 19, 9308 }, -- Grime-Encrusted Object
				{ 20, 9326 }, -- Grime-Encrusted Ring
				{ 22, 9279 }, -- White Punch Card
				{ 23, 9280 }, -- Yellow Punch Card
				{ 24, 9282 }, -- Blue Punch Card
				{ 25, 9281 }, -- Red Punch Card
				{ 26, 9316 }, -- Prismatic Punch Card
				{ 29, 213427 }, -- Grime-Encrusted Salvage
			},
		},
		GNOMEREGAN_SET,
	},
}

data["RazorfenKraul"] = {
	MapID = 491,
	InstanceID = 47,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "RazorfenKraul",
	AtlasMapFile = "CL_RazorfenKraul",
	AtlasMapFile_AL = "RazorfenKraul",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 25, 29, 38 }, { 17, 24, 27 }),
	items = {
		{ -- RFKAggem
			name = AL["Aggem Thorncurse"],
			npcID = 4424,
			Level = GetForVersion(30, 26),
			DisplayIDs = { { 6097 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 6681 }, -- Thornspike
			},
		},
		{ -- RFKDeathSpeakerJargba
			name = AL["Death Speaker Jargba"],
			npcID = 4428,
			Level = GetForVersion(30, 27),
			DisplayIDs = { { 4644 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 2816 }, -- Death Speaker Scepter
				{ 3, 6685 }, -- Death Speaker Mantle
				{ 4, 6682 }, -- Death Speaker Robes
			},
		},
		{ -- RFKOverlordRamtusk
			name = AL["Overlord Ramtusk"],
			npcID = 4420,
			Level = GetForVersion(32, 27),
			DisplayIDs = { { 4652 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 6687 }, -- Corpsemaker
				{ 3, 6686 }, -- Tusken Helm
			},
		},
		{ -- RFKRazorfenSpearhide
			name = AL["Razorfen Spearhide"],
			npcID = 4438,
			Level = GetForVersion({ 29, 30 }, 27),
			DisplayIDs = { { 6078 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 6679 }, -- Armor Piercer
			},
		},
		{ -- RFKAgathelos
			name = AL["Agathelos the Raging"],
			npcID = 4422,
			Level = GetForVersion(33, 27),
			DisplayIDs = { { 2450 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 6691 }, -- Swinetusk Shank
				{ 3, 6690 }, -- Ferine Leggings
			},
		},
		{ -- RFKBlindHunter
			name = AL["Blind Hunter"],
			npcID = 4425,
			Level = GetForVersion(32, 27),
			DisplayIDs = { { 4735 } },
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 6695 }, -- Stygian Bone Amulet
				{ 2, 6697 }, -- Batwing Mantle
				{ 3, 6696 }, -- Nightstalker Bow
			},
		},
		{ -- RFKCharlgaRazorflank
			name = AL["Charlga Razorflank"],
			npcID = 4421,
			Level = GetForVersion(33, 27),
			DisplayIDs = { { 4642 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  6693 }, -- Agamaggan's Clutch
				{ 2,  6694 }, -- Heart of Agamaggan
				{ 3,  6692 }, -- Pronged Reaver
				{ 16, 17008 }, -- Small Scroll
			},
		},
		{ -- RFKEarthcallerHalmgar
			name = AL["Earthcaller Halmgar"],
			npcID = 4842,
			Level = GetForVersion(32, 27),
			DisplayIDs = { { 6102 } },
			AtlasMapBossID = 9,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 6689 }, -- Wind Spirit Staff
				{ 3, 6688 }, -- Whisperwind Headdress
			},
		},
		{ -- RFKTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  2264 }, -- Mantle of Thieves
				{ 2,  1488 }, -- Avenger's Armor
				{ 3,  4438 }, -- Pugilist Bracers
				{ 4,  1978 }, -- Wolfclaw Gloves
				{ 5,  2039 }, -- Plains Ring
				{ 6,  1727 }, -- Sword of Decay
				{ 7,  776 }, -- Vendetta
				{ 8,  1976 }, -- Slaghammer
				{ 9,  1975 }, -- Pysan's Old Greatsword
				{ 10, 2549 }, -- Staff of the Shade
			},
		},
	},
}

data["ScarletMonasteryGraveyard"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21379, 24000, 23805 },
	name = C_Map.GetAreaInfo(796).." - "..AL["Graveyard"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = { "CL_SMGraveyard", "CL_ScarletMonasteryEnt" },
	AtlasMapFile_AL = { "SMGraveyard", "SMEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 20, 26, 36 }, { 20, 30, 32 }),
	items = {
		-- Graveyard
		{ -- SMVishas
			name = AL["Interrogator Vishas"],
			npcID = 3983,
			Level = 32,
			DisplayIDs = { { 2044 } },
			SubAreaID = 21379,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 7682 }, -- Torturing Poker
				{ 3, 7683 }, -- Bloody Brass Knuckles
			},
		},
		{ -- SMAzshir
			name = AL["Azshir the Sleepless"],
			npcID = 6490,
			Level = GetForVersion(33, 32),
			DisplayIDs = { { 5534 } },
			SubAreaID = 24000,
			AtlasMapBossID = "1'",
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 7709 }, -- Blighted Leggings
				{ 2, 217295 }, -- Necrotic Wand
				{ 3, 217296 }, -- Ghostshard Talisman
			},
		},
		{ -- SMFallenChampion
			name = AL["Fallen Champion"],
			npcID = 6488,
			Level = GetForVersion(33, 32),
			DisplayIDs = { { 5230 } },
			specialType = "rare",
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1, 217294 }, -- Embalmed Shroud
				{ 2, 7690 }, -- Ebon Vise
				{ 3, 7689 }, -- Morbid Dawn
			},
		},
		{ -- SMIronspine
			name = AL["Ironspine"],
			npcID = 6489,
			Level = GetForVersion(33, 32),
			DisplayIDs = { { 5231 } },
			AtlasMapBossID = "1'",
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 7688 }, -- Ironspine's Ribcage
				{ 2, 7687 }, -- Ironspine's Fist
				{ 3, 7686 }, -- Ironspine's Eye
			},
		},
		{ -- SMBloodmageThalnos
			name = AL["Bloodmage Thalnos"],
			npcID = 4543,
			Level = GetForVersion(33, 32),
			SubAreaID = 23805,
			DisplayIDs = { { 11396 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 7685 }, -- Orb of the Forgotten Seer
				{ 3, 7684 }, -- Bloodmage Mantle
			},
		},
		{ -- SMGTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7727 }, -- Watchman Pauldrons
				{ 3,  7728 }, -- Beguiler Robes
				{ 4,  7754 }, -- Harbinger Boots
				{ 5,  10332 }, -- Scarlet Boots
				{ 6,  2262 }, -- Mark of Kern
				{ 7,  7787 }, -- Resplendent Guardian
				{ 8,  7729 }, -- Chesterfall Musket
				{ 9,  7761 }, -- Steelclaw Reaver
				{ 10, 7752 }, -- Dreamslayer
				{ 11, 8226 }, -- The Butcher
				{ 12, 7786 }, -- Headsplitter
				{ 13, 7753 }, -- Bloodspiller
				{ 14, 7730 }, -- Cobalt Crusher
			},
		},
		{ -- SMScorn
			name = AL["Scorn"],
			npcID = 14693,
			DisplayIDs = { { 16197 } },
			AtlasMapBossID = 1,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 238352 }, -- Scorn's Icy Choker
				{ 2, 238351 }, -- The Frozen Clutch
				{ 3, 238350 }, -- Scorn's Focal Dagger
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryLibrary"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21426, 21444, 21420 },
	name = C_Map.GetAreaInfo(796).." - "..AL["Library"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = { "CL_SMLibrary", "CL_ScarletMonasteryEnt" },
	AtlasMapFile_AL = { "SMLibrary", "SMEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 20, 29, 39 }, { 20, 33, 35 }),
	items = {
		-- Library
		{ -- SMHoundmasterLoksey
			name = AL["Houndmaster Loksey"],
			npcID = 3974,
			Level = 34,
			SubAreaID = 21444,
			DisplayIDs = { { 2040 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 7710 }, -- Loksey's Training Stick
				{ 3, 7756 }, -- Dog Training Gloves
				{ 4, 3456 }, -- Dog Whistle
			},
		},
		{ -- SMDoan
			name = AL["Arcanist Doan"],
			npcID = 6487,
			Level = GetForVersion(37, 34),
			SubAreaID = 21420,
			DisplayIDs = { { 5266 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 7714 }, -- Hypnotic Blade
				{ 2, 217299 }, -- Illusionary Rod
				{ 4, 217298 }, -- Mantle of Doan
				{ 5, 217297 }, -- Robe of Doan
			},
		},
		{ -- SMLTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
			},
		},
		{
			name = AL["Doan's Strongbox"],
			ExtraList = true,
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1, 7146 }, -- The Scarlet Key
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryArmory"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21460, 21455, 21448, 21457 },
	name = C_Map.GetAreaInfo(796).." - "..AL["Armory"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = { "CL_SMArmory", "CL_ScarletMonasteryEnt" },
	AtlasMapFile_AL = { "SMArmory", "SMEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 20, 32, 42 }, { 20, 35, 37 }),
	items = {
		-- Armory
		{ -- SMHerod
			name = AL["Herod"],
			npcID = 3975,
			Level = GetForVersion(40, 37),
			SubAreaID = 21448,
			DisplayIDs = { { 2041 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 7719 }, -- Raging Berserker's Helm
				{ 2, 7718 }, -- Herod's Shoulder
				{ 3, 10330 }, -- Scarlet Leggings
				{ 4, 7717 }, -- Ravager
			},
		},
		{ -- SMATrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7754 }, -- Harbinger Boots
				{ 7,  10332 }, -- Scarlet Boots
				{ 8,  1992 }, -- Swampchill Fetish
				{ 9,  2262 }, -- Mark of Kern
				{ 10, 7787 }, -- Resplendent Guardian
				{ 11, 7729 }, -- Chesterfall Musket
				{ 12, 7761 }, -- Steelclaw Reaver
				{ 13, 7752 }, -- Dreamslayer
				{ 14, 8226 }, -- The Butcher
				{ 15, 7786 }, -- Headsplitter
				{ 16, 5756 }, -- Sliverblade
				{ 17, 7736 }, -- Fight Club
				{ 18, 8225 }, -- Tainted Pierce
				{ 19, 7753 }, -- Bloodspiller
				{ 20, 7730 }, -- Cobalt Crusher
				{ 21, 7757 }, -- Windweaver Staff
				{ 23, 10333 }, -- Scarlet Wristguards
				{ 24, 10329 }, -- Scarlet Belt
				{ 26, 23192 }, -- Tabard of the Scarlet Crusade
			},
		},
		KEYS,
	},
}

data["ScarletMonasteryCathedral"] = {
	MapID = 796,
	InstanceID = 189,
	SubAreaIDs = { 21401, 21410 },
	name = C_Map.GetAreaInfo(796).." - "..AL["Cathedral"],
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "ScarletMonastery",
	AtlasMapFile = { "CL_SMCathedral", "CL_ScarletMonasteryEnt" },
	AtlasMapFile_AL = { "SMCathedral", "SMEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 20, 35, 45 }, { 20, 36, 40 }),
	items = {
		-- Cathedral
		{ -- SMFairbanks
			name = AL["High Inquisitor Fairbanks"],
			npcID = 4542,
			Level = 40,
			DisplayIDs = { { 2605 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 19507 }, -- Inquisitor's Shawl
				{ 2, 19508 }, -- Branded Leather Bracers
				{ 3, 19509 }, -- Dusty Mail Boots
			},
		},
		{ -- SMMograine
			name = AL["Scarlet Commander Mograine"],
			npcID = 3976,
			Level = GetForVersion(42, 40),
			DisplayIDs = { { 2042 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 7724 }, -- Gauntlets of Divinity
				{ 2, 10330 }, -- Scarlet Leggings
				{ 3, 7726 }, -- Aegis of the Scarlet Commander
				{ 4, 217302 }, -- Mograine's Might
			},
		},
		{ -- SMWhitemane
			name = AL["High Inquisitor Whitemane"],
			npcID = 3977,
			Level = GetForVersion(42, 40),
			DisplayIDs = { { 2043 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 217300 }, -- Whitemane's Chapeau
				{ 2, 217301 }, -- Triune Amulet
				{ 3, 7721 }, -- Hand of Righteousness
			},
		},
		{ -- SMCTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  5819 }, -- Sunblaze Coif
				{ 2,  7755 }, -- Flintrock Shoulders
				{ 3,  7727 }, -- Watchman Pauldrons
				{ 4,  7728 }, -- Beguiler Robes
				{ 5,  7759 }, -- Archon Chestpiece
				{ 6,  7760 }, -- Warchief Kilt
				{ 7,  7754 }, -- Harbinger Boots
				{ 8,  10332 }, -- Scarlet Boots
				{ 9,  1992 }, -- Swampchill Fetish
				{ 10, 2262 }, -- Mark of Kern
				{ 11, 7787 }, -- Resplendent Guardian
				{ 12, 7729 }, -- Chesterfall Musket
				{ 13, 7761 }, -- Steelclaw Reaver
				{ 14, 7752 }, -- Dreamslayer
				{ 15, 8226 }, -- The Butcher
				{ 16, 7786 }, -- Headsplitter
				{ 17, 5756 }, -- Sliverblade
				{ 18, 7736 }, -- Fight Club
				{ 19, 8225 }, -- Tainted Pierce
				{ 20, 7753 }, -- Bloodspiller
				{ 21, 7730 }, -- Cobalt Crusher
				{ 22, 7758 }, -- Ruthless Shiv
				{ 23, 7757 }, -- Windweaver Staff
				{ 25, 10328 }, -- Scarlet Chestpiece
				{ 26, 10331 }, -- Scarlet Gauntlets
				{ 27, 10329 }, -- Scarlet Belt
			},
		},
		KEYS,
	},
}

data["RazorfenDowns"] = {
	MapID = 722,
	InstanceID = 129,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "RazorfenDowns",
	AtlasMapFile = "CL_RazorfenDowns",
	AtlasMapFile_AL = "RazorfenDowns",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 35, 37, 46 }, { 25, 34, 37 }),
	items = {
		{ -- RFDTutenkash
			name = AL["Tuten'kash"],
			npcID = 7355,
			Level = GetForVersion(40, 37),
			DisplayIDs = { { 7845 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 217293 }, -- Silky Spider Cape
				{ 2, 10775 }, -- Carapace of Tuten'kash
				{ 3, 10777 }, -- Arachnid Gloves
			},
		},
		{ -- RFDMordreshFireEye
			name = AL["Mordresh Fire Eye"],
			npcID = 7357,
			Level = GetForVersion(39, 37),
			DisplayIDs = { { 8055 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 217290 }, -- Glowing Eye of Mordresh
				{ 2, 217292 }, -- Deathmage Sash
				{ 3, 217291 }, -- Mordresh's Lifeless Skull
			},
		},
		{ -- RFDGlutton
			name = AL["Glutton"],
			npcID = 8567,
			Level = GetForVersion(40, 37),
			DisplayIDs = { { 7864 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 10774 }, -- Fleshhide Shoulders
				{ 3, 10772 }, -- Glutton's Cleaver
			},
		},
		{ -- RFDRagglesnout
			name = AL["Ragglesnout"],
			npcID = 7354,
			Level = GetForVersion(40, 37),
			DisplayIDs = { { 11382 } },
			AtlasMapBossID = 5,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 10768 }, -- Boar Champion's Belt
				{ 2, 10767 }, -- Savage Boar's Guard
				{ 3, 10758 }, -- X'caliboar
			},
		},
		{ -- RFDAmnennar
			name = AL["Amnennar the Coldbringer"],
			npcID = 7358,
			Level = GetForVersion(41, 37),
			DisplayIDs = { { 7971 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 10763 }, -- Icemetal Barbute
				{ 2, 217288 }, -- Robes of the Lich
				{ 3, 217289 }, -- Deathchill Armor
				{ 4, 10761 }, -- Coldrage Dagger
				{ 6, 10765 }, -- Bonefingers
			},
		},
		{ -- RFDPlaguemaw
			name = AL["Plaguemaw the Rotting"],
			npcID = 7356,
			Level = GetForVersion(40, 37),
			DisplayIDs = { { 6124 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 10766 }, -- Plaguerot Sprig
				{ 3, 10760 }, -- Swine Fists
			},
		},

		{ -- RFDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10574 }, -- Corpseshroud
				{ 2,  10581 }, -- Death's Head Vestment
				{ 3,  10583 }, -- Quillward Harness
				{ 4,  10584 }, -- Stormgale Fists
				{ 5,  10578 }, -- Thoughtcast Boots
				{ 6,  10582 }, -- Briar Tredders
				{ 7,  10572 }, -- Freezing Shard
				{ 8,  10567 }, -- Quillshooter
				{ 9,  10571 }, -- Ebony Boneclub
				{ 10, 10570 }, -- Manslayer
				{ 11, 10573 }, -- Boneslasher
			},
		},
		{ -- RFDLadyF
			name = AL["Lady Falther'ess"],
			npcID = 14686,
			DisplayIDs = { { 10698 } },
			AtlasMapBossID = 2,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 238353 }, -- Mantle of Lady Falther'ess
				{ 2, 238354 }, -- Lady Falther'ess' Finger
			},
		},
		{ -- RFDHenryStern
			name = AL["Henry Stern"],
			npcID = 8696,
			DisplayIDs = { { 8029 } },
			AtlasMapBossID = 2,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 3826 }, -- Mighty Troll's Blood Potion
				{ 2, 10841 }, -- Goldthorn Tea
			},
		},
	},
}

data["Uldaman"] = {
	MapID = 1337,
	InstanceID = 70,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Uldaman",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	AtlasMapFile = { "CL_Uldaman", "CL_UldamanEnt" },
	AtlasMapFile_AL = { "Uldaman", "UldamanEnt" },
	LevelRange = GetForVersion({ 30, 41, 51 }, { 30, 36, 40 }),
	items = {
		{ -- UldEric
			name = AL["Eric \"The Swift\""],
			npcID = 6907,
			Level = GetForVersion(40, 39),
			DisplayIDs = { { 5708 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 9394 }, -- Horned Viking Helmet
				{ 3, 9398 }, -- Worn Running Boots
				{ 5, 2459 }, -- Swiftness Potion
			},
		},
		{ -- UldBaelog
			name = AL["Baelog"],
			npcID = 6906,
			Level = GetForVersion(41, 39),
			DisplayIDs = { { 5710 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 9401 }, -- Nordic Longshank
				{ 3, 9399 }, -- Precision Arrow
				{ 5, 9400 }, -- Baelog's Shortbow
			},
		},
		{ -- UldOlaf
			name = AL["Olaf"],
			npcID = 6908,
			Level = GetForVersion(40, 39),
			DisplayIDs = { { 5709 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 9404 }, -- Olaf's All Purpose Shield
				{ 3, 9403 }, -- Battered Viking Shield
				{ 4, 1177 }, -- Oil of Olaf
			},
		},
		{ -- UldRevelosh
			name = AL["Revelosh"],
			npcID = 6910,
			Level = GetForVersion(40, 39),
			DisplayIDs = { { 5945 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 217307 }, -- Revelosh's Spaulders
				{ 2, 217305 }, -- Revelosh's Armguards
				{ 3, 217304 }, -- Revelosh's Gloves
				{ 4, 217306 }, -- Revelosh's Boots
				{ 6, 7741 }, -- The Shaft of Tsol
			},
		},
		{ -- UldIronaya
			name = AL["Ironaya"],
			npcID = 7228,
			Level = GetForVersion(40, 39),
			DisplayIDs = { { 6089 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 9409 }, -- Ironaya's Bracers
				{ 2, 217303 }, -- Stoneweaver Leggings
				{ 3, 9408 }, -- Ironshod Bludgeon
			},
		},
		{ -- UldObsidianSentinel
			name = AL["Obsidian Sentinel"],
			npcID = 7023,
			Level = GetForVersion(42, 40),
			DisplayIDs = { { 5285 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 8053 }, -- Obsidian Power Source
			},
		},
		{ -- UldAncientStoneKeeper
			name = AL["Ancient Stone Keeper"],
			npcID = 7206,
			Level = GetForVersion(44, 40),
			DisplayIDs = { { 10798 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 9410 }, -- Cragfists
				{ 3, 9411 }, -- Rockshard Pauldrons
			},
		},
		{ -- UldGalgannFirehammer
			name = AL["Galgann Firehammer"],
			npcID = 7291,
			Level = GetForVersion(45, 40),
			DisplayIDs = { { 6059 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 11310 }, -- Flameseer Mantle
				{ 2, 9412 }, -- Galgann's Fireblaster
				{ 4, 11311 }, -- Emberscale Cape
				{ 5, 9419 }, -- Galgann's Firehammer
			},
		},
		{ -- UldGrimlok
			name = AL["Grimlok"],
			npcID = 4854,
			Level = GetForVersion(45, 40),
			DisplayIDs = { { 11165 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  223535 }, -- Grimlok's Tribal Vestments
				{ 2,  223536 }, -- Grimlok's Charge
				{ 4,  9414 }, -- Oilskin Leggings
				{ 16, 7670 }, -- Shattered Necklace Sapphire
			},
		},
		{ -- UldArchaedas
			name = AL["Archaedas"],
			npcID = 2748,
			Level = GetForVersion(47, 40),
			DisplayIDs = { { 5988 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1, 11118 }, -- Archaedic Stone
				{ 2, 9413 }, -- The Rockpounder
				{ 3, 9418 }, -- Stoneslayer
			},
		},
		{ -- UldTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  9431 }, -- Papal Fez
				{ 2,  9429 }, -- Miner's Hat of the Deep
				{ 3,  9420 }, -- Adventurer's Pith Helmet
				{ 4,  9430 }, -- Spaulders of a Lost Age
				{ 5,  9397 }, -- Energy Cloak
				{ 6,  9406 }, -- Spirewind Fetter
				{ 7,  9428 }, -- Unearthed Bands
				{ 8,  223537 }, -- Skullplate Bracers
				{ 9,  9396 }, -- Legguards of the Vault
				{ 10, 9393 }, -- Beacon of Hope
				{ 12, 7666 }, -- Shattered Necklace
				--{ 13, 7673 }, -- Talvash's Enhancing Necklace
				{ 16, 9381 }, -- Earthen Rod
				{ 17, 9426 }, -- Monolithic Bow
				{ 18, 9422 }, -- Shadowforge Bushmaster
				{ 19, 9465 }, -- Digmaster 5000
				{ 20, 9384 }, -- Stonevault Shiv
				{ 21, 9386 }, -- Excavator's Brand
				{ 22, 9427 }, -- Stonevault Bonebreaker
				{ 23, 9392 }, -- Annealed Blade
				{ 24, 9424 }, -- Ginn-su Sword
				{ 25, 9383 }, -- Obsidian Cleaver
				{ 26, 9425 }, -- Pendulum of Doom
				{ 27, 9423 }, -- The Jackhammer
				{ 28, 9391 }, -- The Shoveler
			},
		},
		{ -- UldBaelogsChest
			name = AL["Baelog's Chest"],
			ExtraList = true,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 7740 }, -- Gni'kiv Medallion
			},
		},
		{ -- UldConspicuousUrn
			name = AL["Conspicuous Urn"],
			ExtraList = true,
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 7671 }, -- Shattered Necklace Topaz
			},
		},
		{ -- UldShadowforgeCache
			name = AL["Shadowforge Cache"],
			ExtraList = true,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 7669 }, -- Shattered Necklace Ruby
			},
		},
		{ -- UldTabletofWill
			name = AL["Tablet of Will"],
			ExtraList = true,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 5824 }, -- Tablet of Will
			},
		},
	},
}

data["Zul'Farrak"] = {
	MapID = 1176,
	InstanceID = 209,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Zul'Farrak",
	AtlasMapFile = "CL_ZulFarrak",
	AtlasMapFile_AL = "ZulFarrak",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 39, 44, 54 }, { 35, 42, 46 }),
	items = {
		{ -- ZFAntusul
			name = AL["Antu'sul"],
			npcID = 8127,
			Level = GetForVersion(48, 46),
			DisplayIDs = { { 7353 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 9640 }, -- Vice Grips
				{ 2, 223532 }, -- Lifeblood Amulet
				{ 3, 9639 }, -- The Hand of Antu'sul
				{ 5, 9379 }, -- Sang'thraze the Deflector
			},
		},
		{ -- ZFThekatheMartyr
			name = AL["Theka the Martyr"],
			npcID = 7272,
			Level = GetForVersion({ 45, 46 }, 46),
			DisplayIDs = { { 6696 } },
			AtlasMapBossID = 2,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 10660 }, -- First Mosh'aru Tablet
			},
		},
		{ -- ZFSandarrDunereaver
			name = AL["Sandarr Dunereaver"],
			npcID = 10080,
			Level = 45,
			DisplayIDs = { { 9291 } },
			IgnoreAsSource = true,
			--AtlasMapBossID = 2,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 9523, [ATLASLOOT_IT_AMOUNT1] = "2-4" }, -- First Mosh'aru Tablet
			},
		},
		{ -- ZFWitchDoctorZumrah
			name = AL["Witch Doctor Zum'rah"],
			npcID = 7271,
			Level = 46,
			DisplayIDs = { { 6434 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 223534 }, -- Jumanza Grips
				{ 2, 18082 }, -- Zum'rah's Vexing Cane
			},
		},
		{ -- ZFNekrumGutchewer
			name = AL["Nekrum Gutchewer"],
			npcID = 7796,
			Level = GetForVersion({ 45, 46 }, 45),
			DisplayIDs = { { 6690 } },
			AtlasMapBossID = 4,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 9471 }, -- Nekrum's Medallion
			},
		},
		{ -- ZFSezzziz
			name = AL["Shadowpriest Sezz'ziz"],
			npcID = 7275,
			Level = GetForVersion(47, 46),
			DisplayIDs = { { 6441 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 9470 }, -- Bad Mojo Mask
				{ 2, 223529 }, -- Jinxed Hoodoo Skin
				{ 3, 223530 }, -- Jinxed Hoodoo Kilt
				{ 4, 9475 }, -- Diabolic Skiver
			},
		},
		{ -- ZFDustwraith
			name = AL["Dustwraith"],
			npcID = 10081,
			Level = GetForVersion(47, 46),
			DisplayIDs = { { 9292 } },
			AtlasMapBossID = 4,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 223533 }, -- Desertwalker Cane
			},
		},
		{ -- ZFSandfury
			name = AL["Sandfury Executioner"],
			npcID = 7274,
			Level = 46,
			DisplayIDs = { { 6440 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 8444 }, -- Executioner's Key
			},
		},
		{ -- ZFSergeantBly
			name = AL["Sergeant Bly"],
			npcID = 7604,
			Level = 45,
			DisplayIDs = { { 6433 } },
			AtlasMapBossID = 5,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 8548 }, -- Divino-matic Rod
			},
		},
		{ -- ZFHydromancerVelratha
			name = AL["Hydromancer Velratha"],
			npcID = 7795,
			Level = 46,
			DisplayIDs = { { 6685 } },
			AtlasMapBossID = 6,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 9234 }, -- Tiara of the Deep
				{ 2, 10661 }, -- Second Mosh'aru Tablet
			},
		},
		{ -- ZFGahzrilla
			name = AL["Gahz'rilla"],
			npcID = 7273,
			Level = 46,
			DisplayIDs = { { 7271 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 223528 }, -- Gahz'rilla Scale Armor
				{ 3, 223527 }, -- Gahz'rilla Fang
			},
		},
		{ -- ZFChiefUkorzSandscalp
			name = AL["Chief Ukorz Sandscalp"],
			npcID = 7267,
			Level = GetForVersion(48, 46),
			DisplayIDs = { { 6439 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 223963 }, -- Embrace of the Lycan
				{ 2, 223531 }, -- Big Bad Pauldrons
				{ 3, 9478 }, -- Ripsaw
				{ 4, 9477 }, -- The Chief's Enforcer
				{ 6, 11086 }, -- Jang'thraze the Protector
			},
		},
		{ -- ZFZerillis
			name = AL["Zerillis"],
			npcID = 10082,
			Level = 45,
			DisplayIDs = { { 9293 } },
			AtlasMapBossID = 8,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 12470 }, -- Sandstalker Ankleguards
			},
		},
		{ -- ZFTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  9512 }, -- Blackmetal Cape
				{ 2,  9484 }, -- Spellshock Leggings
				{ 3,  862 }, -- Runed Ring
				{ 4,  6440 }, -- Brainlash
				{ 5,  9483 }, -- Flaming Incinerator
				{ 6,  2040 }, -- Troll Protector
				{ 7,  5616 }, -- Gutwrencher
				{ 8,  9511 }, -- Bloodletter Scalpel
				{ 9,  9481 }, -- The Minotaur
				{ 10, 9480 }, -- Eyegouger
				{ 11, 9482 }, -- Witch Doctor's Cane
				{ 13, 9243 }, -- Shriveled Heart
			},
		},
	},
}

data["Maraudon"] = {
	MapID = 2100,
	InstanceID = 349,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Maraudon",
	AtlasMapFile = { "CL_Maraudon", "CL_MaraudonEnt" },
	AtlasMapFile_AL = { "Maraudon", "MaraudonEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 25, 46, 55 }, { 30, 43, 48 }),
	items = {
		{ -- MaraKhanVeng
			name = AL["Veng"],
			npcID = 13738,
			DisplayIDs = { { 9418 } },
			AtlasMapBossID = 1,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 17765 }, -- Gem of the Fifth Khan
			},
		},
		{ -- MaraNoxxion
			name = AL["Noxxion"],
			npcID = 13282,
			Level = GetForVersion(48, 46),
			DisplayIDs = { { 11172 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 17746 }, -- Noxxion's Shackles
				{ 2, 17744 }, -- Heart of Noxxion
				{ 3, 17745 }, -- Noxious Shooter
			},
		},
		{ -- MaraRazorlash
			name = AL["Razorlash"],
			npcID = 12258,
			Level = GetForVersion(48, 46),
			DisplayIDs = { { 12389 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 17749 }, -- Phytoskin Spaulders
				{ 2, 223543 }, -- Vinerot Sandals
				{ 4, 17750 }, -- Chloromesh Girdle
				{ 5, 17751 }, -- Brusslehide Leggings
			},
		},
		{ -- MaraKhanMaraudos
			name = AL["Maraudos"],
			npcID = 13739,
			DisplayIDs = { { 9441 } },
			AtlasMapBossID = 4,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 17764 }, -- Gem of the Fourth Khan
			},
		},
		{ -- MaraLordVyletongue
			name = AL["Lord Vyletongue"],
			npcID = 12236,
			Level = GetForVersion(47, 44),
			DisplayIDs = { { 12334 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 17755 }, -- Satyrmane Sash
				{ 2, 17754 }, -- Infernal Trickster Leggings
				{ 3, 17752 }, -- Satyr's Lash
			},
		},
		{ -- MaraMeshlok
			name = AL["Meshlok the Harvester"],
			npcID = 12237,
			Level = 48,
			DisplayIDs = { { 9014 } },
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 17767 }, -- Bloomsprout Headpiece
				{ 2, 17741 }, -- Nature's Embrace
				{ 3, 17742 }, -- Fungus Shroud Armor
			},
		},
		{ -- MaraCelebras
			name = AL["Celebras the Cursed"],
			npcID = 12225,
			Level = GetForVersion(49, 46),
			DisplayIDs = { { 12350 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 223525 }, -- Soothsayer's Headdress
				{ 2, 17739 }, -- Grovekeeper's Drape
				{ 3, 17738 }, -- Claw of Celebras
			},
		},
		{ -- MaraLandslide
			name = AL["Landslide"],
			npcID = 12203,
			Level = GetForVersion(50, 48),
			DisplayIDs = { { 12293 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 223522 }, -- Helm of the Mountain
				{ 2, 17736 }, -- Rockgrip Gauntlets
				{ 3, 223523 }, -- Cloud Stone
				{ 4, 223524 }, -- Fist of Stone
			},
		},
		{ -- MaraTinkererGizlock
			name = AL["Tinkerer Gizlock"],
			npcID = 13601,
			Level = GetForVersion(50, 48),
			DisplayIDs = { { 7125 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1, 223545 }, -- Gizlock's Hypertech Buckler
				{ 2, 223542 }, -- Megashot Rifle
				{ 3, 223520 }, -- Inventor's Focal Sword
			},
		},
		{ -- MaraRotgrip
			name = AL["Rotgrip"],
			npcID = 13596,
			Level = GetForVersion(50, 48),
			DisplayIDs = { { 13589 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1, 223521 }, -- Rotgrip Mantle
				{ 2, 17728 }, -- Albino Crocscale Boots
				{ 3, 17730 }, -- Gatorbite Axe
			},
		},
		{ -- MaraPrincessTheradras
			name = AL["Princess Theradras"],
			npcID = 12201,
			Level = GetForVersion(51, 48),
			DisplayIDs = { { 12292 } },
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1, 223964 }, -- Blade of Eternal Darkness
				{ 3, 223519 }, -- Eye of Theradras
				{ 4, 223541 }, -- Gemshard Heart
				{ 5, 17714 }, -- Bracers of the Stone Princess
				{ 6, 17711 }, -- Elemental Rockridge Leggings
				{ 7, 17713 }, -- Blackstone Ring
				{ 8, 223518 }, -- Charstone Dirk
				{ 9, 221780 }, -- Princess Theradras' Scepter
			},
		},
		{ -- MaraNamelesProphet
			name = AL["The Nameless Prophet"],
			npcID = 13718,
			DisplayIDs = { { 9426 } },
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*A",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 17757 }, -- Amulet of Spirits
			},
		},
		{ -- MaraKhanKolk
			name = AL["Kolk"],
			npcID = 13742,
			DisplayIDs = { { 4860 } },
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*1",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 17761 }, -- Gem of the First Khan
			},
		},
		{ -- MaraKhanGelk
			name = AL["Gelk"],
			npcID = 13741,
			DisplayIDs = { { 9427 } },
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*2",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 17762 }, -- Gem of the Second Khan
			},
		},
		{ -- MaraKhanMagra
			name = AL["Magra"],
			npcID = 13740,
			DisplayIDs = { { 9433 } },
			AtlasMapFile = "CL_MaraudonEnt",
			AtlasMapFile_AL = "MaraudonEnt",
			AtlasMapBossID = "*3",
			ExtraList = true,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 17763 }, -- Gem of the Third Khan
			},
		},
	},
}

data["TheTempleOfAtal'Hakkar"] = {
	MapID = 1477,
	InstanceID = 109,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheTempleOfAtal'Hakkar",
	AtlasMapFile = { "CL_TheSunkenTemple", "CL_TheSunkenTempleEnt" },
	AtlasMapFile_AL = { "TheSunkenTemple", "TheSunkenTempleEnt" },
	ContentType = RAID20_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = { 50, 50, 60 },
	items = {
		{ -- STAtalalarion
			name = AL["Atal'alarion"],
			npcID = 218624,
			Level = GetForVersion(50, 50),
			DisplayIDs = { { 7873 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  220539 }, -- Warbands of Sacrifice
				{ 2,  220529 }, -- Spaulders of Fanaticism
				{ 3,  220527 }, -- Atal'ai Berserker's Mantle
				{ 4,  220602 }, -- Sewer Turtle Half-Shell
				{ 5,  220568 }, -- Temple Explorer's Gun Axe
				{ 6,  220567 }, -- Bloodied Headspike
				{ 7,  220615 }, -- Panther Fur Cloak
				{ 8,  220554 }, -- Atal'alarion's Tusk Band
				{ 9,  220511 }, -- Greathelm of the Nightmare
				{ 10, 220561 }, -- Tenacious Troll Kickers
				{ 11, 220537 }, -- Dreamer's Darkwater Bracers
				{ 12, 220580 }, -- Madness of the Avatar
				{ 13, 220635 }, -- Atal'alarion's Enchanted Boulder
				{ 16, 220636 }, -- Atal'ai Blood Icon
				{ 17, 220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STFesteringRotslime
			name = AL["Festering Rotslime"],
			npcID = 218819,
			Level = GetForVersion(50, 50),
			DisplayIDs = { { 119351 } },
			[NORMAL_DIFF] = {
				{ 1,  220542 }, -- Polluted Murkwater Gauntlets
				{ 2,  220552 }, -- Waistguard of Pain
				{ 3,  220538 }, -- Cursed Slimescale Bracers
				{ 4,  220545 }, -- Foul Smelling Fighter's Gloves
				{ 5,  220546 }, -- Hands of the Tormented
				{ 6,  220540 }, -- Corruption Laden Handguards
				{ 7,  220569 }, -- Blistering Ragehammer
				{ 8,  220550 }, -- Temple Looter's Waistband
				{ 9,  220518 }, -- Ba'ham's Dusty Hat
				{ 10, 220541 }, -- Disease-Ridden Plate Fists
				{ 11, 220571 }, -- Stinging Longbow
				{ 12, 220565 }, -- Ethereal Mistwalker Boots
				{ 13, 221484 }, -- Witch Doctor's Hex Stick
				{ 16, 220636 }, -- Atal'ai Blood Icon
				{ 17, 220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STAtalaiDefenders
			name = AL["Atal'ai Defenders"],
			npcID = 221637,
			Level = GetForVersion(50, 50),
			DisplayIDs = { { 118789 } },
			[NORMAL_DIFF] = {
				{ 1,  220555 }, -- Atal'ai Serpentscale Girdle
				{ 2,  220532 }, -- Reinforced Atal'ai Spaulders
				{ 3,  220516 }, -- Gasher's Forgotten Visor
				{ 4,  220591 }, -- Mijan's Restorative Rod
				{ 5,  220558 }, -- Atal'ai Assassin's Leggings
				{ 6,  220572 }, -- Rinzo's Rapid Repeater
				{ 7,  220528 }, -- Atal'ai Huntsman's Shoulders
				{ 8,  220611 }, -- Hukku's Hex Cape
				{ 9,  220533 }, -- Reforged Atal'ai Breastplate
				{ 10, 220522 }, -- Soulcatcher Crown
				{ 11, 220674 }, -- Debased Stealthblade
				{ 12, 220548 }, -- Atal'ai Hexxer's Gloves
				{ 13, 220560 }, -- Silvershell Legplates
				{ 14, 220638 }, -- Unorthodox Hex Stick
				{ 16, 220636 }, -- Atal'ai Blood Icon
				{ 17, 220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STDreamscytheandWeaver
			name = AL["Dreamscythe and Weaver"],
			npcID = 220833,
			Level = GetForVersion(50, 50),
			DisplayIDs = { { 6379 } },
			[NORMAL_DIFF] = {
				{ 1,  220549 }, -- Dawnspire Strap
				{ 2,  220521 }, -- Hakkari Ritualist's Headdress
				{ 3,  220587 }, -- Sacrificial Dream Dagger
				{ 4,  220536 }, -- Atal'ai Medicine Man's Wrists
				{ 5,  220581 }, -- Snake Clobberer
				{ 6,  220566 }, -- Smolder Claw
				{ 7,  220551 }, -- Devotee's Sash of the Emerald Dream
				{ 8,  220584 }, -- Flamebreath Blade
				{ 9,  220519 }, -- Voodoo Feathered Headdress
				{ 10, 220544 }, -- Bloodflare Talons
				{ 11, 220594 }, -- Scythe of the Dream
				{ 12, 220609 }, -- Drape of Nightfall
				{ 16, 220636 }, -- Atal'ai Blood Icon
				{ 17, 220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STJammalanandOgom
			name = AL["Jammal'an and Ogom"],
			npcID = 218721,
			Level = GetForVersion(50, 50),
			DisplayIDs = { { 6708 } },
			[NORMAL_DIFF] = {
				{ 1,  220578 }, -- Fist of the Forsaken
				{ 2,  220556 }, -- Kilt of the Fallen Atal'ai Prophet
				{ 3,  220601 }, -- Hakkari Witch Doctor's Guard
				{ 4,  220575 }, -- Eater of the Damned
				{ 5,  220547 }, -- Gloves of the Fallen Atal'ai Prophet
				{ 6,  220583 }, -- Vile Blade of the Wretched
				{ 7,  220576 }, -- Axe of the Atal'ai Executioner
				{ 8,  220625 }, -- Resilience of the Exiled
				{ 9,  220624 }, -- Bloodstained Charm of Valor
				{ 10, 220535 }, -- Garments of the Atal'ai Prophet
				{ 11, 220623 }, -- Jin'do's Lost Locket
				{ 12, 220605 }, -- Libram of Sacrilege
				{ 13, 220515 }, -- Enchanted Emerald Helmet
				{ 14, 220586 }, -- Hubris, the Bandit Brander
				{ 16, 220636 }, -- Atal'ai Blood Icon
				{ 17, 220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STMorphazandHazzas
			name = AL["Morphaz and Hazzas"],
			npcID = 221943,
			Level = GetForVersion(50, 50),
			DisplayIDs = { { 9584 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  220965 }, -- Scalebane Greataxe
				{ 2,  220514 }, -- Visor of Verdant Feathers
				{ 3,  220553 }, -- Belt of the Forsaken Worshipper
				{ 4,  220543 }, -- Emerald Scalemail Gloves
				{ 5,  220563 }, -- Boots of the Atal'ai Blood Shaman
				{ 6,  220599 }, -- Drakestone of the Blood Prophet
				{ 7,  220598 }, -- Drakestone of the Nightmare Harbinger
				{ 8,  220559 }, -- Revitalized Drake Scale Leggings
				{ 9,  220606 }, -- Idol of the Dream
				{ 10, 220607 }, -- Totem of Tormented Ancestry
				{ 11, 220597 }, -- Drakestone of the Dream Harbinger
				{ 12, 220512 }, -- Immaculate Goldsteel Helmet
				{ 13, 220589 }, -- Serpent's Striker
				{ 14, 220596 }, -- Ancient Divining Rod
				{ 16, 220636 }, -- Atal'ai Blood Icon
				{ 17, 220637 }, -- Atal'ai Ritual Token
			},
		},
		{ -- STEranikus
			name = AL["Shade of Eranikus"],
			npcID = 218571,
			Level = GetForVersion(50, 50),
			DisplayIDs = { { 117504 } },
			[NORMAL_DIFF] = {
				{ 1,  220604 }, -- Nightmare Trophy
				{ 2,  220622 }, -- Perfectly Preserved Dragon's Eye
				{ 3,  220564 }, -- Restored Slitherscale Boots
				{ 4,  220603 }, -- Rod of Irreversible Corrosion
				{ 5,  220523 }, -- Visage of the Exiled
				{ 6,  220600 }, -- Crest of Preeminence
				{ 7,  220574 }, -- Sharpened Tooth of Eranikus
				{ 8,  220573 }, -- Dreadstalker's Hunting Bow
				{ 9,  220595 }, -- Nightmare Focus Staff
				{ 10, 220579 }, -- Witch Doctor's Stick of Mojo
				{ 11, 220585 }, -- Degraded Dire Nail
				{ 12, 220582 }, -- Dragon's Cry
				{ 16, 220636 }, -- Atal'ai Blood Icon
				{ 17, 220637 }, -- Atal'ai Ritual Token
				{ 19, 221475 }, -- Essence of Eranikus
			},
		},
		{ -- STAvatarofHakkar
			name = AL["Avatar of Hakkar"],
			npcID = 221394,
			DisplayIDs = { { 8053 } },
			AtlasMapBossID = 3,
			Level = 48,
			[NORMAL_DIFF] = {
				{ 1,  [ATLASLOOT_IT_HORDE] = 221363, [ATLASLOOT_IT_ALLIANCE] = 221346 }, -- Scapula of the Fallen Avatar
				{ 3,  220608 },                                              -- Featherskin Drape
				{ 4,  220530 },                                              -- Will of the Atal'ai Warrior
				{ 5,  220577 },                                              -- Might of the Blood Loa
				{ 6,  220557 },                                              -- Cursed Windscale Sarong
				{ 7,  220562 },                                              -- Bloodshot Battle Greaves
				{ 8,  220636 },                                              -- Atal'ai Blood Icon
				{ 9,  220637 },                                              -- Atal'ai Ritual Token
				{ 11, 220634 },                                              -- Atal'ai Blood Ritual Charm
				{ 12, 220633 },                                              -- Atal'ai Blood Ritual Badge
				{ 13, 220632 },                                              -- Atal'ai Blood Ritual Medallion
				{ 16, 220590 },                                              -- Spire of Hakkari Worship
				{ 17, 220620 },                                              -- Wind Serpent Skull
				{ 18, 220534 },                                              -- Eternal Embrace of the Wind Serpent
				{ 19, 220686 },                                              -- Chieftain's Bane
				{ 20, 220588 },                                              -- Cobra Fang Claw
			},
		},
		{ -- STTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  10630 }, -- Soulcatcher Halo
				{ 2,  10632 }, -- Slimescale Bracers
				{ 3,  10631 }, -- Murkwater Gauntlets
				{ 4,  10633 }, -- Silvershell Leggings
				{ 5,  10629 }, -- Mistwalker Boots
				{ 6,  10634 }, -- Mindseye Circle
				{ 7,  10624 }, -- Stinging Bow
				{ 8,  10623 }, -- Winter's Bite
				{ 9,  10625 }, -- Stealthblade
				{ 10, 10626 }, -- Ragehammer
				{ 11, 10628 }, -- Deathblow
				{ 12, 10627 }, -- Bludgeon of the Grinning Dog
				{ 16, 10782 }, -- Hakkari Shroud
				{ 17, 10781 }, -- Hakkari Breastplate
				{ 18, 10780 }, -- Mark of Hakkar
				{ 20, 16216 }, -- Formula: Enchant Cloak - Greater Resistance
				{ 21, 15733 }, -- Pattern: Green Dragonscale Leggings
			},
		},
		ST_SET,
	},
}

data["BlackrockDepths"] = {
	MapID = 1584,
	InstanceID = 230,
	SubAreaIDs = { 26758, 26761, 26747, 26733, 26755, 26740, 26751, 26759, 26735, 26769, 26768, 26766, 26781, 26765, 26764, 26742, 26750, 26745, 26784, 26749 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackrockDepths",
	AtlasMapFile = { "CL_BlackrockDepths", "CL_BlackrockMountainEnt" },
	AtlasMapFile_AL = { "BlackrockDepths", "BlackrockMountainEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 42, 52, 60 }, { 40, 48, 56 }),
	items = {
		{ -- BRDLordRoccor
			name = AL["Lord Roccor"],
			npcID = 9025,
			Level = 51,
			SubAreaID = 26735,
			DisplayIDs = { { 5781 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 22234 }, -- Mantle of Lost Hope
				{ 2, 11632 }, -- Earthslag Shoulders
				{ 3, 11631 }, -- Stoneshell Guard
				{ 4, 22397 }, -- Idol of Ferocity
				{ 5, 11630 }, -- Rockshard Pellets
				{ 7, 11813 }, -- Formula: Smoking Heart of the Mountain
				--{ 8,  11811 }, -- Smoking Heart of the Mountain
			},
		},
		{ -- BRDHighInterrogatorGerstahn
			name = AL["High Interrogator Gerstahn "],
			npcID = 9018,
			Level = 52,
			SubAreaID = 26733,
			DisplayIDs = { { 8761 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  11626 }, -- Blackveil Cape
				{ 2,  11624 }, -- Kentic Amice
				{ 3,  22240 }, -- Greaves of Withering Despair
				{ 4,  223539 }, -- Enthralled Sphere
				{ 16, 11140 }, -- Prison Cell Key
			},
		},
		{ -- BRDHoundmaster
			name = AL["Houndmaster Grebmar"],
			npcID = 9319,
			Level = 52,
			SubAreaID = 26735,
			DisplayIDs = { { 9212 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 11623 }, -- Spritecaster Cape
				{ 2, 11627 }, -- Fleetfoot Greaves
				{ 3, 223540 }, -- Houndmaster's Bow
				{ 4, 223982 }, -- Houndmaster's Rifle
			},
		},
		-- ## RING START
		{ -- BRDGorosh
			name = AL["Gorosh the Dervish"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9027,
			Level = GetForVersion(56, 52),
			SubAreaID = 26742,
			DisplayIDs = { { 8760 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 227952 }, -- Savage Gladiator Chain
				{ 2, 22271 }, -- Leggings of Frenzied Magic
				{ 3, 22257 }, -- Bloodclot Band
				{ 4, 227962 }, -- Flarethorn
			},
		},
		{ -- BRDGrizzle
			name = AL["Grizzle"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9028,
			Level = GetForVersion(54, 52),
			DisplayIDs = { { 7873 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 223544 }, -- Dregmetal Spaulders
				{ 2, 11703 }, -- Stonewall Girdle
				{ 3, 22270 }, -- Entrenching Boots
				{ 4, 11702 }, -- Grizzle's Skinner
				{ 6, 11610 }, -- Plans: Dark Iron Pulverizer
				--{ 2,  11608 }, -- Dark Iron Pulverizer
			},
		},
		{ -- BRDEviscerator
			name = AL["Eviscerator"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9029,
			Level = GetForVersion(54, 52),
			DisplayIDs = { { 523 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 223987 }, -- Splinthide Shoulders
				{ 2, 11679 }, -- Rubicund Armguards
				{ 4, 11686 }, -- Girdle of Beastial Fury
				{ 5, 227961 }, -- Savage Gladiator Grips
			},
		},
		{ -- BRDOkthor
			name = AL["Ok'thor the Breaker"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9030,
			Level = GetForVersion(54, 53),
			DisplayIDs = { { 11538 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 11665 }, -- Ogreseer Fists
				{ 2, 11662 }, -- Ban'thok Sash
				{ 3, 11728 }, -- Savage Gladiator Leggings
				{ 4, 223985 }, -- Cyclopean Band
			},
		},
		{ -- BRDAnubshiah
			name = AL["Anub'shiah"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9031,
			Level = GetForVersion(54, 52),
			DisplayIDs = { { 3004 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 11678 }, -- Carapace of Anub'shiah
				{ 2, 223986 }, -- Graverot Cape
				{ 3, 11675 }, -- Shadefiend Boots
				{ 4, 227957 }, -- Savage Gladiator Greaves
			},
		},
		{ -- BRDHedrum
			name = AL["Hedrum the Creeper"],
			nameFormat = NAME_BRD_RING_OF_LAW,
			npcID = 9032,
			Level = GetForVersion(53, 52),
			DisplayIDs = { { 8271 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 11633 }, -- Spiderfang Carapace
				{ 2, 223984 }, -- Silkweb Gloves
				{ 3, 11635 }, -- Hookfang Shanker
				{ 4, 227955 }, -- Savage Gladiator Helm
			},
		},
		-- ## RING END
		{ -- BRDPyromancerLoregrain
			name = AL["Pyromancer Loregrain"],
			npcID = 9024,
			Level = 52,
			SubAreaID = 26745,
			DisplayIDs = { { 8762 } },
			AtlasMapBossID = 7,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 223981 }, -- Flamestrider Robes
				{ 2, 223980 }, -- Searingscale Leggings
				{ 3, 11748 }, -- Pyric Caduceus
				{ 4, 223538 }, -- Kindling Stave
				{ 6, 11207 }, -- Formula: Enchant Weapon - Fiery Weapon
			},
		},
		{ -- BRDTheVault
			name = AL["Dark Coffer"],
			SubAreaID = 26758,
			npcID = { 9438, 9442, 9443, 9439, 9437, 9441 },
			DisplayIDs = { { 8592 }, { 8595 }, { 8596 }, { 8593 }, { 8591 }, { 8594 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["Dark Keeper"],  nil },
				{ 2,  11197 }, -- Dark Keeper Key
				{ 5,  "INV_Box_01", nil, AL["Secret Safe"],  nil },
				{ 6,  22256 }, -- Mana Shaping Handwraps
				{ 7,  22205 }, -- Black Steel Bindings
				{ 8,  22255 }, -- Magma Forged Band
				{ 9,  22254 }, -- Wand of Eternal Light
				{ 10, 11923 }, -- The Hammer of Grace
				{ 16, "INV_Box_01", nil, AL["Relic Coffer"], nil },
				{ 17, 11945 }, -- Dark Iron Ring
				{ 18, 11946 }, -- Fire Opal Necklace
				{ 20, "INV_Box_01", nil, AL["Dark Coffer"],  nil },
				{ 21, 11752 }, -- Black Blood of the Tormented
				{ 22, 11751 }, -- Burning Essence
				{ 23, 11753 }, -- Eye of Kajal
			},
		},
		{ -- BRDWarderStilgiss
			name = AL["Warder Stilgiss"],
			npcID = 9041,
			Level = GetForVersion(56, 54),
			SubAreaID = 26758,
			DisplayIDs = { { 9089 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 11782 }, -- Boreal Mantle
				{ 2, 22241 }, -- Dark Warder's Pauldrons
				{ 3, 11783 }, -- Chillsteel Girdle
				{ 4, 223983 }, -- Arbiter's Blade
			},
		},
		{ -- BRDVerek
			name = AL["Verek"],
			npcID = 9042,
			Level = GetForVersion(55, 53),
			SubAreaID = 26758,
			DisplayIDs = { { 9019 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 11755 }, -- Verek's Collar
				{ 2, 22242 }, -- Verek's Leash
			},
		},
		{ -- BRDWatchmanDoomgrip
			name = AL["Watchman Doomgrip"],
			npcID = 9476,
			Level = GetForVersion(55, 54),
			SubAreaID = 26758,
			DisplayIDs = { { 8655 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 22205 }, -- Black Steel Bindings
				{ 2, 22255 }, -- Magma Forged Band
				{ 3, 22256 }, -- Mana Shaping Handwraps
				{ 4, 22254 }, -- Wand of Eternal Light
			},
		},
		{ -- BRDFineousDarkvire
			name = AL["Fineous Darkvire"],
			npcID = 9056,
			Level = GetForVersion(54, 53),
			SubAreaID = 26759,
			DisplayIDs = { { 8704 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1, 11839 }, -- Chief Architect's Monocle
				{ 2, 22223 }, -- Foreman's Head Protector
				{ 3, 11842 }, -- Lead Surveyor's Mantle
				{ 4, 11841 }, -- Senior Designer's Pantaloons
				{ 6, 11840 }, -- Master Builder's Shirt
			},
		},
		{ -- BRDLordIncendius
			name = AL["Lord Incendius"],
			npcID = 9017,
			Level = GetForVersion(55, 53),
			SubAreaID = 26750,
			DisplayIDs = { { 1204 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1, 11766 }, -- Flameweave Cuffs
				{ 2, 11764 }, -- Cinderhide Armsplints
				{ 3, 11765 }, -- Pyremail Wristguards
				{ 4, 11767 }, -- Emberplate Armguards
				{ 6, 19268 }, -- Ace of Elementals
				{ 8, 11768 }, -- Incendic Bracers
			},
		},
		{ -- BRDBaelGar
			name = AL["Bael'Gar"],
			npcID = 9016,
			Level = GetForVersion(54, 52),
			SubAreaID = 26747,
			DisplayIDs = { { 12162 } },
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1, 11807 }, -- Sash of the Burning Heart
				{ 2, 11802 }, -- Lavacrest Leggings
				{ 3, 11805 }, -- Rubidium Hammer
				{ 4, 11803 }, -- Force of Magma
			},
		},
		{ -- BRDGeneralAngerforge
			name = AL["General Angerforge"],
			npcID = 9033,
			Level = GetForVersion(57, 55),
			SubAreaID = 26749,
			DisplayIDs = { { 8756 } },
			AtlasMapBossID = 13,
			[NORMAL_DIFF] = {
				{ 1, 11820 }, -- Royal Decorated Armor
				{ 2, 11821 }, -- Warstrife Leggings
				{ 3, 11810 }, -- Force of Will
				{ 4, 227940 }, -- Lord General's Sword
				{ 5, 227948 }, -- Angerforge's Battle Axe
				{ 6, 11841 }, -- Senior Designer's Pantaloons
			},
		},
		{ -- BRDGolemLordArgelmach
			name = AL["Golem Lord Argelmach"],
			npcID = 8983,
			Level = GetForVersion(57, 55),
			SubAreaID = 26781,
			DisplayIDs = { { 8759 } },
			AtlasMapBossID = 14,
			[NORMAL_DIFF] = {
				{ 1, 227964 }, -- Luminary Kilt
				{ 2, 227965 }, -- Omnicast Boots
				{ 3, 11669 }, -- Naglering
				{ 4, 227967 }, -- Second Wind
			},
		},
		{ -- BRDGuzzler
			name = AL["Guzzler"],
			SubAreaID = 26751,
			npcID = { 9537, 12944, 9543, 9499 },
			Level = 55,
			DisplayIDs = { { 8658 }, { 14666 }, { 8667 }, { 8652 } },
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["Hurley Blackbreath"],    nil },
				{ 2,  11735 }, -- Ragefury Eyepatch
				{ 3,  18043 }, -- Coal Miner Boots
				{ 4,  22275 }, -- Firemoss Boots
				{ 5,  18044 }, -- Hurley's Tankard
				{ 7,  "INV_Box_01", nil, AL["Lokhtos Darkbargainer"], nil },
				{ 8,  18592 }, -- Plans: Sulfuron Hammer
				{ 16, "INV_Box_01", nil, AL["Ribbly Screwspigot"],    nil },
				{ 17, 227901 }, -- Plans: Tempered Dark Iron Plate
				{ 18, 2662 }, -- Ribbly's Quiver
				{ 19, 2663 }, -- Ribbly's Bandolier
				{ 20, 11742 }, -- Wayfarer's Knapsack
				{ 22, "INV_Box_01", nil, AL["Plugger Spazzring"],     nil },
				{ 23, 12793 }, -- Mixologist's Tunic
				{ 24, 12791 }, -- Barman Shanker
				{ 25, 18653 }, -- Schematic: Goblin Jumper Cables XL
				{ 26, 13483 }, -- Recipe: Transmute Fire to Earth
				{ 27, 15759 }, -- Pattern: Black Dragonscale Breastplate
				{ 28, 11325 }, -- Dark Iron Ale Mug
				{ 29, 11602 }, -- Grim Guzzler Key
			},
		},
		{ -- Phalanx
			name = AL["Phalanx"],
			npcID = 9502,
			Level = 55,
			SubAreaID = 26751,
			DisplayIDs = { { 8177 } },
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1, 227947 }, -- Golem Fitted Pauldrons
				{ 2, 11745 }, -- Fists of Phalanx
				{ 3, 11744 }, -- Bloodfist
				{ 4, 11743 }, -- Rockfist
			},
		},
		{ -- BRDFlamelash
			name = AL["Ambassador Flamelash"],
			npcID = 9156,
			Level = GetForVersion(57, 55),
			SubAreaID = 26761,
			DisplayIDs = { { 8329 } },
			AtlasMapBossID = 16,
			[NORMAL_DIFF] = {
				{ 1, 11808 }, -- Circle of Flame
				{ 3, 227970 }, -- Cape of the Fire Salamander
				{ 4, 227971 }, -- Molten Fists
				{ 5, 227972 }, -- Burst of Knowledge
				{ 6, 11809 }, -- Flame Wrath
				{ 8, 23320 }, -- Tablet of Flame Shock VI
			},
		},
		{ -- BRDPanzor
			name = AL["Panzor the Invincible"],
			npcID = 8923,
			Level = GetForVersion(57, 56),
			SubAreaID = 26764,
			DisplayIDs = { { 8270 } },
			AtlasMapBossID = 17,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 22245 }, -- Soot Encrusted Footwear
				{ 2, 11787 }, -- Shalehusk Boots
				{ 3, 11785 }, -- Rock Golem Bulwark
				{ 4, 11786 }, -- Stone of the Earth
			},
		},
		{ -- BRDTomb
			name = AL["Chest of The Seven"],
			SubAreaID = 26784,
			npcID = { 9034, 9035, 9036, 9037, 9038, 9039, 9040 },
			ObjectID = 169243,
			Level = GetForVersion({ 55, 57 }, { 55, 56 }),
			DisplayIDs = { { 8690 }, { 8686 }, { 8692 }, { 8689 }, { 8691 }, { 8687 }, { 8688 } },
			AtlasMapBossID = 18,
			[NORMAL_DIFF] = {
				{ 1, 227958 }, -- Ghostshroud
				{ 2, 227956 }, -- Deathdealer Breastplate
				{ 3, 11929 }, -- Haunting Specter Leggings
				{ 4, 227959 }, -- Legplates of the Eternal Guardian
				{ 5, 11920 }, -- Wraith Scythe
				{ 6, 11923 }, -- The Hammer of Grace
				{ 7, 227963 }, -- Blood-etched Blade
				{ 8, 227960 }, -- Impervious Giant
			},
		},
		{ -- BRDMagmus
			name = AL["Magmus"],
			npcID = 9938,
			Level = GetForVersion(57, 56),
			SubAreaID = 26768,
			DisplayIDs = { { 12162 } },
			AtlasMapBossID = 20,
			[NORMAL_DIFF] = {
				{ 1, 227975 }, -- Golem Skull Helm
				{ 2, 227978 }, -- Magmus Stone
				{ 3, 22395 }, -- Totem of Rage
				{ 4, 22400 }, -- Libram of Truth
				{ 5, 227974 }, -- Lavastone Hammer
			},
		},
		{ -- BRDPrincess
			name = AL["Princess Moira Bronzebeard "],
			npcID = 8929,
			Level = GetForVersion(58, 55),
			SubAreaID = 26769,
			DisplayIDs = { { 8705 } },
			AtlasMapBossID = 21,
			[NORMAL_DIFF] = {
				{ 1, 12557 }, -- Ebonsteel Spaulders
				{ 2, 12554 }, -- Hands of the Exalted Herald
				{ 3, 12556 }, -- High Priestess Boots
				{ 4, 12553 }, -- Swiftwalker Boots
			},
		},
		{ -- BRDEmperorDagranThaurissan
			name = AL["Emperor Dagran Thaurissan"],
			npcID = 9019,
			Level = GetForVersion(59, 56),
			SubAreaID = 26769,
			DisplayIDs = { { 8807 } },
			AtlasMapBossID = 21,
			[NORMAL_DIFF] = {
				{ 1,  227991 }, -- Ironfoe
				{ 3,  227988 }, -- Imperial Jewel
				{ 4,  227985 }, -- The Emperor's New Cape
				{ 5,  227980 }, -- Robes of the Royal Crown
				{ 6,  227986 }, -- Wristguards of Renown
				{ 7,  227987 }, -- Sash of the Grand Hunt
				{ 8,  11934 }, -- Emperor's Seal
				{ 9,  11815 }, -- Hand of Justice
				{ 10, 227984 }, -- Thaurissan's Royal Scepter
				{ 11, 227981 }, -- Dreadforge Retaliator
				{ 12, 227982 }, -- Guiding Stave of Wisdom
				{ 16, 12033 }, -- Thaurissan Family Jewels
			},
		},
		{ -- BRDTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  12549 }, -- Braincage
				{ 2,  12552 }, -- Blisterbane Wrap
				{ 3,  12551 }, -- Stoneshield Cloak
				{ 4,  12542 }, -- Funeral Pyre Vestment
				{ 5,  12546 }, -- Aristocratic Cuffs
				{ 6,  12550 }, -- Runed Golem Shackles
				{ 7,  12547 }, -- Mar Alom's Grip
				{ 8,  12555 }, -- Battlechaser's Greaves
				{ 9,  12527 }, -- Ribsplitter
				{ 10, 12531 }, -- Searing Needle
				{ 11, 12535 }, -- Doomforged Straightedge
				{ 12, 12528 }, -- The Judge's Gavel
				{ 13, 12532 }, -- Spire of the Stoneshaper
				{ 16, 15781 }, -- Pattern: Black Dragonscale Leggings
				{ 17, 15770 }, -- Pattern: Black Dragonscale Shoulders
				{ 19, 11611 }, -- Plans: Dark Iron Sunderer
				{ 20, 11614 }, -- Plans: Dark Iron Mail
				{ 21, 11615 }, -- Plans: Dark Iron Shoulders
				{ 23, 16048 }, -- Schematic: Dark Iron Rifle
				{ 24, 16053 }, -- Schematic: Master Engineer's Goggles
				{ 25, 16049 }, -- Schematic: Dark Iron Bomb
				{ 26, 18654 }, -- Schematic: Gnomish Alarm-O-Bot
				{ 27, 18661 }, -- Schematic: World Enlarger
			},
		},
		{ -- BRDBSPlans
			name = AL["Plans"],
			ExtraList = true,
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1, 11614 }, -- Plans: Dark Iron Mail
				{ 2, 11615 }, -- Plans: Dark Iron Shoulders
			},
		},
		{ -- BRDTheldren
			name = AL["Theldren"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16059,
			DisplayIDs = { { 15981 } },
			AtlasMapBossID = 6,
			Level = 60,
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 22305 }, -- Ironweave Mantle
				{ 2, 22330 }, -- Shroud of Arcane Mastery
				{ 3, 22318 }, -- Malgen's Long Bow
				{ 4, 22317 }, -- Lefty's Brass Knuckle
			},
		},
	},
}

data["LowerBlackrockSpire"] = {
	name = AL["Lower Blackrock Spire"],
	MapID = 1583,
	InstanceID = 229,
	SubAreaIDs = { 26683, 26718, 26711, 26713, 26686, 32528, 26688 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "LowerBlackrockSpire",
	AtlasMapFile = { "CL_BlackrockSpireLower", "CL_BlackrockMountainEnt" },
	AtlasMapFile_AL = { "BlackrockSpireLower", "BlackrockMountainEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 48, 55, 60 }, { 45, 54, 60 }),
	items = {
		{ -- LBRSFelguard
			name = AL["Burning Felguard"],
			npcID = 10263,
			Level = { 56, 57 },
			DisplayIDs = { { 5047 } },
			AtlasMapBossID = 1,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 228554 }, -- Demonskin Gloves
				{ 2, 228555 }, -- Phase Blade
			},
		},
		{ -- LBRSSpirestoneButcher
			name = AL["Spirestone Butcher"],
			npcID = 9219,
			Level = 57,
			DisplayIDs = { { 11574 } },
			AtlasMapBossID = 4,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 228556 }, -- Butcher's Apron
				{ 2, 13286 }, -- Rivenspike
			},
		},
		{ -- LBRSOmokk
			name = AL["Highlord Omokk"],
			npcID = 9196,
			Level = GetForVersion(59, 57),
			SubAreaID = 26713,
			DisplayIDs = { { 11565 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  226752 }, -- Boots of Elements
				{ 3,  13166 }, -- Slamshot Shoulders
				{ 4,  228571 }, -- Plate of the Shaman King
				{ 5,  13170 }, -- Skyshroud Leggings
				{ 6,  13169 }, -- Tressermane Leggings
				{ 7,  228570 }, -- Fist of Omokk
				{ 8,  12336 }, -- Gemstone of Spirestone
				{ 16, 12534 }, -- Omokk's Head
			},
		},
		{ -- LBRSSpirestoneBattleLord
			name = AL["Spirestone Battle Lord"],
			npcID = 9218,
			Level = 58,
			DisplayIDs = { { 11576 } },
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 228557 }, -- Swiftdart Battleboots
				{ 2, 13285 }, -- The Nicker
			},
		},
		{ -- LBRSSpirestoneLordMagus
			name = AL["Spirestone Lord Magus"],
			npcID = 9217,
			Level = { 57, 58 },
			DisplayIDs = { { 11578 } },
			AtlasMapBossID = 6,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 228564 }, -- Ogreseer Tower Boots
				{ 2, 13283 }, -- Magus Ring
				{ 3, 228563 }, -- Globe of D'sak
			},
		},
		{ -- LBRSVosh
			name = AL["Shadow Hunter Vosh'gajin"],
			npcID = 9236,
			Level = 58,
			SubAreaID = 26688,
			DisplayIDs = { { 9732 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 226702 }, -- Shadowcraft Gloves
				{ 3, 228562 }, -- Demonic Runed Spaulders
				{ 4, 228558 }, -- Funeral Cuffs
				{ 5, 228561 }, -- Trueaim Gauntlets
				{ 6, 12653 }, -- Riphook
				{ 7, 228559 }, -- Blackcrow
				{ 8, 12654 }, -- Doomshot
			},
		},
		{ -- LBRSVoone
			name = AL["War Master Voone"],
			npcID = 9237,
			Level = GetForVersion(59, 58),
			SubAreaID = 26688,
			DisplayIDs = { { 9733 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1, 226721 }, -- Beaststalker's Gloves
				{ 3, 228574 }, -- Talisman of Evasion
				{ 4, 228572 }, -- Brazecore Armguards
				{ 5, 228594 }, -- Kayser's Boots of Precision
				{ 6, 13173 }, -- Flightblade Throwing Axe
				{ 7, 12582 }, -- Keris of Zul'Serak
				{ 9, 12335 }, -- Gemstone of Smolderthorn
			},
		},
		{ -- LBRSGrimaxe
			name = AL["Bannok Grimaxe"],
			npcID = 9596,
			Level = 59,
			DisplayIDs = { { 9668 } },
			AtlasMapBossID = 12,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 228568 }, -- Backusarian Gauntlets
				{ 2, 228567 }, -- Chiselbrand Girdle
				{ 3, 12621 }, -- Demonfork
				{ 5, 12838, 12784 }, -- Plans: Arcanite Reaper
			},
		},
		{ -- LBRSSmolderweb
			name = AL["Mother Smolderweb"],
			npcID = 10596,
			Level = 59,
			SubAreaID = 26686,
			DisplayIDs = { { 9929 } },
			AtlasMapBossID = 13,
			[NORMAL_DIFF] = {
				{ 1, 226713 }, -- Wildheart Boots
				{ 3, 228577 }, -- Gilded Gauntlets
				{ 4, 228576 }, -- Smolderweb's Eye
				{ 5, 228573 }, -- Venomspitter
			},
		},
		{ -- LBRSCrystalFang
			name = AL["Crystal Fang"],
			npcID = 10376,
			Level = 60,
			SubAreaID = 26686,
			DisplayIDs = { { 9755 } },
			AtlasMapBossID = 14,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 228590 }, -- Sunderseer Mantle
				{ 2, 13184 }, -- Fallbrush Handgrips
				{ 3, 228592 }, -- Fang of the Crystal Spider
			},
		},
		{ -- LBRSDoomhowl
			name = AL["Urok Doomhowl"],
			npcID = 10584,
			Level = 60,
			DisplayIDs = { { 11583 } },
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1,  13258 }, -- Slaghide Gauntlets
				{ 2,  228595 }, -- Marksman's Girdle
				{ 3,  13259 }, -- Ribsteel Footguards
				{ 4,  13178 }, -- Rosewine Circle
				{ 16, 18784 }, -- Top Half of Advanced Armorsmithing: Volume III
			},
		},
		{ -- LBRSZigris
			name = AL["Quartermaster Zigris"],
			npcID = 9736,
			Level = 59,
			SubAreaID = 32528,
			DisplayIDs = { { 9738 } },
			AtlasMapBossID = 16,
			[NORMAL_DIFF] = {
				{ 1, 13247 }, -- Quartermaster Zigris' Footlocker
				{ 3, 13253 }, -- Hands of Power
				{ 4, 13252 }, -- Cloudrunner Girdle
				{ 6, 12835 }, -- Plans: Annihilator
				--{ 5,  12798 }, -- Annihilator
			},
		},
		{ -- LBRSHalycon
			name = AL["Halycon"],
			npcID = 10220,
			Level = 59,
			SubAreaID = 26711,
			DisplayIDs = { { 9567 } },
			AtlasMapBossID = 17,
			[NORMAL_DIFF] = {
				{ 1, 13212 }, -- Halycon's Spiked Collar
				{ 2, 228598 }, -- Ironweave Bracers
				{ 3, 228575 }, -- Slashclaw Bracers
				{ 4, 13210 }, -- Pads of the Dread Wolf
			},
		},
		{ -- LBRSSlavener
			name = AL["Gizrul the Slavener"],
			npcID = 10268,
			Level = 60,
			SubAreaID = 26711,
			DisplayIDs = { { 9564 } },
			AtlasMapBossID = 17,
			[NORMAL_DIFF] = {
				{ 1, 226710 }, -- Wildheart Spaulders
				{ 3, 13208 }, -- Bleak Howler Armguards
				{ 4, 13206 }, -- Wolfshear Leggings
				{ 5, 228591 }, -- Rhombeard Protector
			},
		},
		{ -- LBRSBashguud
			name = AL["Ghok Bashguud"],
			npcID = 9718,
			Level = 59,
			DisplayIDs = { { 11809 } },
			AtlasMapBossID = 18,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 13203 }, -- Armswake Cloak
				{ 2, 13198 }, -- Hurd Smasher
				{ 3, 13204 }, -- Bashguuder
			},
		},
		{ -- LBRSWyrmthalak
			name = AL["Overlord Wyrmthalak"],
			npcID = 9568,
			Level = 60,
			SubAreaID = 26718,
			DisplayIDs = { { 8711 } },
			AtlasMapBossID = 19,
			[NORMAL_DIFF] = {
				{ 1,  228585 }, -- Mark of the Dragon Lord
				{ 3,  226716 }, -- Beaststalker's Mantle
				{ 5,  228588 }, -- Reiver Claws
				{ 6,  228589 }, -- Heart of the Scale
				{ 7,  22321 }, -- Heart of Wyrmthalak
				{ 8,  228601 }, -- Relentless Scythe
				{ 9,  228586 }, -- Chillpike
				{ 10, 228587 }, -- Trindlehaven Staff
				{ 12, 12337 }, -- Gemstone of Bloodaxe
				{ 16, 12780 }, -- General Drakkisath's Command
			},
		},

		{ -- LBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  14513, 14152 }, -- Pattern: Robe of the Archmage
				{ 2,  226744 }, -- Devout Belt
				{ 3,  226724 }, -- Magister's Belt
				{ 4,  226725 }, -- Magister's Bindings
				{ 5,  226759 }, -- Dreadmist Bracers
				{ 6,  226701 }, -- Shadowcraft Belt
				{ 7,  226712 }, -- Wildheart Belt
				{ 8,  226718 }, -- Beaststalker's Belt
				{ 9,  226754 }, -- Cord of Elements
				{ 10, 226765 }, -- Belt of Valor
				{ 11, 226766 }, -- Bracers of Valor
				{ 16, 15749 }, -- Pattern: Volcanic Breastplate
				{ 17, 15775 }, -- Pattern: Volcanic Shoulders
				{ 18, 13494 }, -- Recipe: Greater Fire Protection Potion
				{ 19, 16250 }, -- Formula: Enchant Weapon - Superior Striking
				{ 20, 16244 }, -- Formula: Enchant Gloves - Greater Strength
				{ 21, 9214 }, -- Grimoire of Inferno
				{ 23, 12219 }, -- Unadorned Seal of Ascension
				{ 24, 12586 }, -- Immature Venom Sac
			},
		},
		{ -- LBRSGrayhoof
			name = AL["Mor Grayhoof"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16080,
			DisplayIDs = { { 15997 } },
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1, 228596 }, -- Ironweave Belt
				{ 2, 22325 }, -- Belt of the Trickster
				{ 3, 22319 }, -- Tome of Divine Right
				{ 4, 22398 }, -- Idol of Rejuvenation
				{ 5, 228600 }, -- The Jaw Breaker
			},
		},
	},
}

data["UpperBlackrockSpire"] = {
	name = AL["Upper Blackrock Spire"],
	MapID = 1583,
	InstanceID = 229,
	SubAreaIDs = { 26670, 26668, 26684, 26662, 26642, 26683, 15492, 26666, 26715 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "UpperBlackrockSpire",
	AtlasMapFile = { "CL_BlackrockSpireUpper", "CL_BlackrockMountainEnt" },
	AtlasMapFile_AL = { "BlackrockSpireUpper", "BlackrockMountainEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 48, 55, 60 }, { 45, 58, 60 }),
	items = {
		{ -- UBRSEmberseer
			name = AL["Pyroguard Emberseer"],
			npcID = 9816,
			Level = 60,
			SubAreaID = 26662,
			DisplayIDs = { { 2172 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 226748 }, -- Gauntlets of Elements
				{ 3, 228584 }, -- Emberfury Talisman
				{ 4, 228583 }, -- Truestrike Shoulders
				{ 5, 12905 }, -- Wildfire Cape
				{ 6, 12926 }, -- Flaming Band
				{ 8, 23320 }, -- Tablet of Flame Shock VI
			},
		},
		{ -- UBRSSolakar
			name = AL["Solakar Flamewreath"],
			npcID = 10264,
			Level = 60,
			SubAreaID = 26666,
			DisplayIDs = { { 9581 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 226741 }, -- Devout Mantle
				{ 3, 12609 }, -- Polychromatic Visionwrap
				{ 4, 12603 }, -- Nightbrace Tunic
				{ 5, 228578 }, -- Dustfeather Sash
				{ 6, 228579 }, -- Crystallized Girdle
				{ 8, 18657 }, -- Schematic: Hyper-Radiant Flame Reflector
			},
		},
		{ -- UBRSRunewatcher
			name = AL["Jed Runewatcher"],
			npcID = 10509,
			Level = 59,
			SubAreaID = 26642,
			DisplayIDs = { { 9686 } },
			AtlasMapBossID = 4,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 228566 }, -- Starfire Tiara
				{ 2, 12930 }, -- Briarwood Reed
				{ 3, 12605 }, -- Serpentine Skuller
			},
		},
		{ -- UBRSAnvilcrack
			name = AL["Goraluk Anvilcrack "],
			npcID = 10899,
			Level = 61,
			SubAreaID = 26642,
			DisplayIDs = { { 10222 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  13502 }, -- Handcrafted Mastersmith Girdle
				{ 2,  13498 }, -- Handcrafted Mastersmith Leggings
				{ 3,  228602 }, -- Flame Walkers
				{ 4,  18048 }, -- Mastersmith's Hammer
				{ 6,  12834 }, -- Plans: Arcanite Champion
				{ 7,  12837 }, -- Plans: Masterwork Stormhammer
				{ 9,  18779 }, -- Bottom Half of Advanced Armorsmithing: Volume I
				{ 16, "INV_Box_01", nil, AL["Unforged Rune Covered Breastplate"], nil },
				{ 17, 12806 }, -- Unforged Rune Covered Breastplate
				{ 18, 12696 }, -- Plans: Demon Forged Breastplate
			},
		},
		{ -- UBRSGyth
			name = AL["Gyth"],
			npcID = 10339,
			Level = 62,
			SubAreaID = 26670,
			DisplayIDs = { { 9806 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  12871 }, -- Chromatic Carapace
				{ 3,  226753 }, -- Pauldrons of Elements
				{ 5,  22225 }, -- Dragonskin Cowl
				{ 6,  12960 }, -- Tribal War Feathers
				{ 7,  12953 }, -- Dragoneye Coif
				{ 8,  12952 }, -- Gyth's Skull
				{ 10, 13522 }, -- Recipe: Flask of Chromatic Resistance
			},
		},
		{ -- UBRSRend
			name = AL["Warchief Rend Blackhand"],
			npcID = 10429,
			Level = 62,
			SubAreaID = 26670,
			DisplayIDs = { { 9778 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  228757 }, -- Felstriker
				{ 3,  226768 }, -- Spaulders of Valor
				{ 5,  228604 }, -- Eye of Rend
				{ 6,  228605 }, -- Bonespike Shoulder
				{ 7,  12936 }, -- Battleborn Armbraces
				{ 8,  18104 }, -- Feralsurge Girdle
				{ 9,  12935 }, -- Warmaster Legguards
				{ 10, 18102 }, -- Dragonrider Boots
				{ 11, 22247 }, -- Faith Healer's Boots
				{ 12, 18103 }, -- Band of Rumination
				{ 13, 12940 }, -- Dal'Rend's Sacred Charge
				{ 14, 12939 }, -- Dal'Rend's Tribal Guardian
				{ 15, 228603 }, -- Blackhand Doomsaw
			},
		},
		{ -- UBRSBeast
			name = AL["The Beast"],
			npcID = 10430,
			Level = 62,
			SubAreaID = 26684,
			DisplayIDs = { { 10193 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  12731 }, -- Pristine Hide of the Beast
				{ 3,  226735 }, -- Lightforge Spaulders
				{ 5,  12967 }, -- Bloodmoon Cloak
				{ 6,  12968 }, -- Frostweaver Cape
				{ 7,  12966 }, -- Blackmist Armguards
				{ 8,  12965 }, -- Spiritshroud Leggings
				{ 9,  12963 }, -- Blademaster Leggings
				{ 10, 12964 }, -- Tristam Legguards
				{ 11, 228597 }, -- Ironweave Boots
				{ 12, 12709 }, -- Finkle's Skinner
				{ 13, 12969 }, -- Seeping Willow
				{ 15, 24101 }, -- Book of Ferocious Bite V
				{ 16, 19227 }, -- Ace of Beasts
			},
		},
		{ -- UBRSDrakkisath
			name = AL["General Drakkisath"],
			npcID = 10363,
			Level = 62,
			SubAreaID = 26715,
			DisplayIDs = { { 10115 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  228606 }, -- Blackblade of Shahram
				{ 3,  22267 }, -- Spellweaver's Turban
				{ 4,  13141 }, -- Tooth of Gnarr
				{ 5,  22269 }, -- Shadow Prowler's Cloak
				{ 6,  13142 }, -- Brigam Girdle
				{ 7,  13098 }, -- Painweaver Band
				{ 8,  22268 }, -- Draconic Infused Emblem
				{ 9,  22253 }, -- Tome of the Lost
				{ 10, 12602 }, -- Draconian Deflector
				{ 12, 15730 }, -- Pattern: Red Dragonscale Breastplate
				{ 14, 13519 }, -- Recipe: Flask of the Titans
				{ 16, 226745 }, -- Devout Robe
				{ 17, 226729 }, -- Magister's Robes
				{ 18, 226757 }, -- Dreadmist Robe
				{ 19, 226700 }, -- Shadowcraft Tunic
				{ 20, 226715 }, -- Wildheart Vest
				{ 21, 226723 }, -- Beaststalker's Tunic
				{ 22, 226749 }, -- Vest of Elements
				{ 23, 226734 }, -- Lightforge Breastplate
				{ 24, 226770 }, -- Breastplate of Valor
			},
		},
		{ -- UBRSTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  24102 }, -- Manual of Eviscerate IX
				{ 2,  228593 }, -- Wind Dancer Boots
				{ 4,  226744 }, -- Devout Belt
				{ 5,  226725 }, -- Magister's Bindings
				{ 6,  226759 }, -- Dreadmist Bracers
				{ 7,  226701 }, -- Shadowcraft Belt
				{ 8,  226717 }, -- Beaststalker's Bindings
				{ 9,  226718 }, -- Beaststalker's Belt
				{ 10, 226754 }, -- Cord of Elements
				{ 11, 226766 }, -- Bracers of Valor
				{ 16, 16247 }, -- Formula: Enchant 2H Weapon - Superior Impact
			},
		},
		{
			name = AL["Darkstone Tablet"],
			ExtraList = true,
			AtlasMapBossID = 3,
			specialType = "quest",
			[NORMAL_DIFF] = {
				{ 1, 12358 }, -- Darkstone Tablet
			},
		},
		{ -- UBRSValthalak
			name = AL["Lord Valthalak"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16042,
			DisplayIDs = { { 14308 } },
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 228681 }, -- Ironweave Cowl
				{ 2, 22340 }, -- Pendant of Celerity
				{ 3, 22337 }, -- Shroud of Domination
				{ 4, 22343 }, -- Handguards of Savagery
				{ 5, 22342 }, -- Leggings of Torment
				{ 6, 22339 }, -- Rune Band of Wizardry
				{ 7, 22336 }, -- Draconian Aegis of the Legion
				{ 8, 22335 }, -- Lord Valthalak's Staff of Command
			},
		},
	},
}

data["DireMaulEast"] = {
	name = AL["Dire Maul East"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 34776, 33730 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaul",
	AtlasMapFile = { "DireMaulEast", "DireMaulEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = { 31, 55, 60 },
	items = {
		{ -- DMEPusillin
			name = AL["Pusillin"],
			npcID = 14354,
			Level = 57,
			DisplayIDs = { { 7552 } },
			AtlasMapBossID = "1-2",
			[NORMAL_DIFF] = {
				{ 1, 18267 }, -- Recipe: Runn Tum Tuber Surprise
				{ 3, 18249 }, -- Crescent Key
			},
		},
		{ -- DMEZevrimThornhoof
			name = AL["Zevrim Thornhoof"],
			npcID = 11490,
			Level = 57,
			DisplayIDs = { { 11335 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 228053 }, -- Fervent Helm
				{ 2, 18313 }, -- Helm of Awareness
				{ 3, 228050 }, -- Satyr's Bow
				{ 5, 18308 }, -- Clever Hat
				{ 6, 18306 }, -- Gloves of Shadowy Mist
			},
		},
		{ -- DMEHydro
			name = AL["Hydrospawn"],
			npcID = 13280,
			Level = 57,
			DisplayIDs = { { 5489 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 228054 }, -- Tempest Talisman
				{ 2, 18322 }, -- Waterspout Boots
				{ 3, 228052 }, -- Waveslicer
				{ 5, 19268 }, -- Ace of Elementals
				{ 7, 18305 }, -- Breakwater Legguards
				{ 8, 18307 }, -- Riptide Shoes
			},
		},
		{ -- DMELethtendris
			name = AL["Lethtendris"],
			npcID = 14327,
			Level = 57,
			DisplayIDs = { { 14378 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 18325 }, -- Felhide Cap
				{ 2, 228051 }, -- Quel'dorai Channeling Rod
				{ 4, 18301 }, -- Lethtendris's Wand
				{ 5, 18302 }, -- Band of Vigor
			},
		},
		{ -- DMEAlzzin
			name = AL["Alzzin the Wildshaper"],
			npcID = 11492,
			Level = 58,
			DisplayIDs = { { 14416 } },
			AtlasMapBossID = 5,
			SubAreaID = 33730,
			[NORMAL_DIFF] = {
				{ 1,  18328 }, -- Shadewood Cloak
				{ 2,  228055 }, -- Energized Chestplate
				{ 3,  18309 }, -- Gloves of Restoration
				{ 4,  18326 }, -- Razor Gauntlets
				{ 5,  18327 }, -- Whipvine Cord
				{ 6,  18318 }, -- Merciful Greaves
				{ 7,  18321 }, -- Energetic Rod
				{ 8,  18310 }, -- Fiendish Machete
				{ 9,  18314 }, -- Ring of Demonic Guile
				{ 10, 228057 }, -- Ring of Demonic Potency
			},
		},
		{ -- DMETrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18289 }, -- Barbed Thorn Necklace
				{ 2,  18296 }, -- Marksman Bands
				{ 3,  18298 }, -- Unbridled Leggings
				{ 4,  18295 }, -- Phasing Boots
				{ 6,  18333 }, -- Libram of Focus
				{ 7,  18334 }, -- Libram of Protection
				{ 8,  18332 }, -- Libram of Rapidity
				{ 10, 18255 }, -- Runn Tum Tuber
				{ 11, 18297 }, -- Thornling Seed
			},
		},
		{ -- DMEIsalien
			name = AL["Isalien"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16097,
			DisplayIDs = { { 16000 } },
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 228066 }, -- Ironweave Gloves
				{ 2, 22472 }, -- Boots of Ferocity
				{ 3, 22401 }, -- Libram of Hope
				{ 4, 22345 }, -- Totem of Rebirth
				{ 5, 22315 }, -- Hammer of Revitalization
				{ 6, 22314 }, -- Huntsman's Harpoon
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["DireMaulWest"] = {
	name = AL["Dire Maul West"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 33748, 33749, 33750, 33710 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaul",
	AtlasMapFile = { "DireMaulWest", "DireMaulEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = { 31, 58, 60 },
	items = {
		{ -- DMWTendrisWarpwood
			name = AL["Tendris Warpwood"],
			npcID = 11489,
			Level = 60,
			DisplayIDs = { { 14383 } },
			AtlasMapBossID = 2,
			SubAreaID = 33748,
			[NORMAL_DIFF] = {
				{ 1, 228063 }, -- Warpwood Binding
				{ 2, 18390 }, -- Tanglemoss Leggings
				{ 4, 18352 }, -- Petrified Bark Shield
				{ 5, 18353 }, -- Stoneflower Staff
			},
		},
		{ -- DMWIllyannaRavenoak
			name = AL["Illyanna Ravenoak"],
			npcID = 11488,
			Level = 60,
			DisplayIDs = { { 11270 } },
			SubAreaID = 33749,
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 18383 }, -- Force Imbued Gauntlets
				{ 2, 18386 }, -- Padre's Trousers
				{ 4, 18349 }, -- Gauntlets of Accuracy
				{ 5, 18347 }, -- Well Balanced Axe
			},
		},
		{ -- DMWMagisterKalendris
			name = AL["Magister Kalendris"],
			npcID = 11487,
			Level = 60,
			DisplayIDs = { { 14384 } },
			AtlasMapBossID = 4,
			SubAreaID = 33749,
			[NORMAL_DIFF] = {
				{ 1, 18374 }, -- Flamescarred Shoulders
				{ 2, 228067 }, -- Elder Magus Pendant
				{ 3, 18371 }, -- Mindtap Talisman
				{ 5, 18350 }, -- Amplifying Cloak
				{ 6, 18351 }, -- Magically Sealed Bracers
				{ 8, 22309 }, -- Pattern: Big Bag of Enchantment
				--{ 9,  22249 }, -- Big Bag of Enchantment
			},
		},
		{ -- DMWTsuzee
			name = AL["Tsu'zee"],
			npcID = 11467,
			Level = 60,
			DisplayIDs = { { 11250 } },
			specialType = "rare",
			AtlasMapBossID = 5,
			SubAreaID = 33749,
			[NORMAL_DIFF] = {
				{ 1, 228061 }, -- Brightspark Gloves
				{ 3, 18346 }, -- Threadbare Trousers
				{ 4, 18345 }, -- Murmuring Ring
			},
		},
		{ -- DMWImmolthar
			name = AL["Immol'thar"],
			npcID = 11496,
			Level = 61,
			DisplayIDs = { { 14173 } },
			AtlasMapBossID = 6,
			SubAreaID = 33750,
			[NORMAL_DIFF] = {
				{ 1,  18381 }, -- Evil Eye Pendant
				{ 2,  18384 }, -- Bile-etched Spaulders
				{ 3,  18389 }, -- Cloak of the Cosmos
				{ 4,  18385 }, -- Robe of Everlasting Night
				{ 5,  18394 }, -- Demon Howl Wristguards
				{ 6,  18377 }, -- Quickdraw Gloves
				{ 7,  18391 }, -- Eyestalk Cord
				{ 8,  18379 }, -- Odious Greaves
				{ 9,  18370 }, -- Vigilance Charm
				{ 10, 18372 }, -- Blade of the New Moon
			},
		},
		{ -- DMWPrinceTortheldrin
			name = AL["Prince Tortheldrin"],
			npcID = 11486,
			Level = 61,
			DisplayIDs = { { 11256 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  18382 }, -- Fluctuating Cloak
				{ 2,  18373 }, -- Chestplate of Tranquility
				{ 3,  18375 }, -- Bracers of the Eclipse
				{ 4,  18378 }, -- Silvermoon Leggings
				{ 5,  228069 }, -- Eldritch Reinforced Legplates
				{ 6,  18395 }, -- Emerald Flame Ring
				{ 7,  228471 }, -- Stoneshatter
				{ 8,  18396 }, -- Mind Carver
				{ 9,  18376 }, -- Timeworn Mace
				{ 10, 228472 }, -- Distracting Dagger
			},
		},
		{ -- DMWTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18340 }, -- Eidolon Talisman
				{ 2, 18344 }, -- Stonebark Gauntlets
				{ 3, 18338 }, -- Wand of Arcane Potency
				{ 5, 18333 }, -- Libram of Focus
				{ 6, 18334 }, -- Libram of Protection
				{ 7, 18332 }, -- Libram of Rapidity
			},
		},
		{ -- DMWRevanchion
			name = AL["Revanchion"],
			npcID = 14690,
			DisplayIDs = { { 14695 } },
			AtlasMapBossID = 2,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 238364 }, -- Cloak of Revanchion
				{ 2, 238362 }, -- Bracers of Mending
				{ 3, 238363 }, -- The Shadow's Grasp
			},
		},
		{ -- DMWShendralarProvisioner
			name = AL["Shen'dralar Provisioner"],
			npcID = 14371,
			DisplayIDs = { { 14412 } },
			ExtraList = true,
			AtlasMapBossID = "1'",
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1, 18487, [PRICE_EXTRA_ITTYPE] = "money:40000" }, -- Pattern: Mooncloth Robe
				--{ 2,  18486 }, -- Mooncloth Robe
			},
		},
		{ -- DMWHelnurath
			name = AL["Lord Hel'nurath"],
			npcID = 14506,
			DisplayIDs = { { 14556 } },
			ExtraList = true,
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 228475 }, -- Diabolic Mantle
				{ 2, 18754 }, -- Fel Hardened Bracers
				{ 3, 18755 }, -- Xorothian Firestick
				{ 4, 18756 }, -- Dreadguard's Protector
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["DireMaulNorth"] = {
	name = AL["Dire Maul North"],
	MapID = 2557,
	--InstanceID = 429,
	SubAreaIDs = { 33774, 33775 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DireMaulNorth",
	AtlasMapFile = { "DireMaulNorth", "DireMaulEnt" },
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = { 31, 58, 60 },
	items = {
		{ -- DMNGuardMoldar
			name = AL["Guard Mol'dar"],
			npcID = 14326,
			Level = 59,
			DisplayIDs = { { 11561 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  228059 }, -- Denwatcher's Shoulders
				{ 2,  228058 }, -- Bulky Iron Spaulders
				{ 3,  228060 }, -- Heliotrope Cloak
				{ 4,  18497 }, -- Sublime Wristguards
				{ 5,  18498 }, -- Hedgecutter
				{ 7,  18450 }, -- Robe of Combustion
				{ 8,  18458 }, -- Modest Armguards
				{ 9,  18459 }, -- Gallant's Wristguards
				{ 10, 18451 }, -- Hyena Hide Belt
				{ 11, 18462 }, -- Jagged Bone Fist
				{ 12, 18463 }, -- Ogre Pocket Knife
				{ 13, 18464 }, -- Gordok Nose Ring
				{ 14, 18460 }, -- Unsophisticated Hand Cannon
				{ 16, 18250 }, -- Gordok Shackle Key
				{ 17, 18268 }, -- Gordok Inner Door Key
			},
		},
		{ -- DMNStomperKreeg
			name = AL["Stomper Kreeg"],
			npcID = 14322,
			Level = 59,
			DisplayIDs = { { 11545 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  18425 },                                 -- Kreeg's Mug
				{ 16, "INV_Box_01", nil,                                AL["Sells:"], nil },
				{ 17, 18269,        [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Gordok Green Grog
				{ 18, 18284,        [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Kreeg's Stout Beatdown
				{ 19, 18287,        [PRICE_EXTRA_ITTYPE] = "money:200" }, -- Evermurky
				{ 20, 18288,        [PRICE_EXTRA_ITTYPE] = "money:1500" }, -- Molasses Firewater
				{ 21, 9260,         [PRICE_EXTRA_ITTYPE] = "money:1600" }, -- Volatile Rum
			},
		},
		{ -- DMNGuardFengus
			name = AL["Guard Fengus"],
			npcID = 14321,
			Level = 59,
			DisplayIDs = { { 11561 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  18450 }, -- Robe of Combustion
				{ 2,  18458 }, -- Modest Armguards
				{ 3,  18459 }, -- Gallant's Wristguards
				{ 4,  18451 }, -- Hyena Hide Belt
				{ 5,  18462 }, -- Jagged Bone Fist
				{ 6,  18463 }, -- Ogre Pocket Knife
				{ 7,  18464 }, -- Gordok Nose Ring
				{ 8,  18460 }, -- Unsophisticated Hand Cannon
				{ 10, 18250 }, -- Gordok Shackle Key
				{ 16, "INV_Box_01", nil, AL["Fengus's Chest"], nil },
				{ 17, 18266 }, -- Gordok Courtyard Key
			},
		},
		{ -- DMNGuardSlipkik
			name = AL["Guard Slip'kik"],
			npcID = 14323,
			Level = 59,
			DisplayIDs = { { 11561 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  228059 }, -- Denwatcher's Shoulders
				{ 2,  228058 }, -- Bulky Iron Spaulders
				{ 3,  228060 }, -- Heliotrope Cloak
				{ 4,  18497 }, -- Sublime Wristguards
				{ 5,  18498 }, -- Hedgecutter
				{ 7,  18450 }, -- Robe of Combustion
				{ 8,  18458 }, -- Modest Armguards
				{ 9,  18459 }, -- Gallant's Wristguards
				{ 10, 18451 }, -- Hyena Hide Belt
				{ 11, 18462 }, -- Jagged Bone Fist
				{ 12, 18463 }, -- Ogre Pocket Knife
				{ 13, 18464 }, -- Gordok Nose Ring
				{ 14, 18460 }, -- Unsophisticated Hand Cannon
				{ 16, 18250 }, -- Gordok Shackle Key
			},
		},
		{ -- DMNThimblejack
			name = AL["Knot Thimblejack's Cache"],
			AtlasMapBossID = 4,
			npcID = 14338,
			ObjectID = 179501,
			[NORMAL_DIFF] = {
				{ 1,  18414 }, -- Pattern: Belt of the Archmage
				{ 16, 18517 }, -- Pattern: Chromatic Cloak
				{ 17, 18518 }, -- Pattern: Hide of the Wild
				{ 18, 18519 }, -- Pattern: Shifting Cloak
				{ 5,  18415 }, -- Pattern: Felcloth Gloves
				{ 6,  18416 }, -- Pattern: Inferno Gloves
				{ 7,  18417 }, -- Pattern: Mooncloth Gloves
				{ 8,  18418 }, -- Pattern: Cloak of Warding
				{ 20, 18514 }, -- Pattern: Girdle of Insight
				{ 21, 18515 }, -- Pattern: Mongoose Boots
				{ 22, 18516 }, -- Pattern: Swift Flight Bracers
				{ 10, 18258 }, -- Gordok Ogre Suit
				{ 11, 18240 }, -- Ogre Tannin
			},
		},
		{ -- DMNCaptainKromcrush
			name = AL["Captain Kromcrush"],
			npcID = 14325,
			Level = 61,
			DisplayIDs = { { 11564 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 18503 }, -- Kromcrush's Chestplate
				{ 2, 228068 }, -- Mugger's Belt
				{ 3, 18507 }, -- Boots of the Full Moon
				{ 4, 18502 }, -- Monstrous Glaive
			},
		},
		{ -- DMNChoRush
			name = AL["Cho'Rush the Observer"],
			npcID = 14324,
			Level = 60,
			DisplayIDs = { { 11537 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 228062 }, -- Insightful Hood
				{ 2, 18483 }, -- Mana Channeling Wand
				{ 3, 228064 }, -- Observer's Shield
				{ 4, 18484 }, -- Cho'Rush's Blade
			},
		},
		{ -- DMNKingGordok
			name = AL["King Gordok"],
			npcID = 11501,
			Level = 62,
			DisplayIDs = { { 11583 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  228480 }, -- Crown of the Ogre King
				{ 2,  18525 }, -- Bracers of Prosperity
				{ 3,  18527 }, -- Harmonious Gauntlets
				{ 4,  228479 }, -- Leggings of Destruction
				{ 5,  18521 }, -- Grimy Metal Boots
				{ 6,  18522 }, -- Band of the Ogre King
				{ 7,  18523 }, -- Brightly Glowing Stone
				{ 8,  228478 }, -- Barbarous Blade
				{ 16, 19258 }, -- Ace of Warlords
				{ 18, 18780 }, -- Top Half of Advanced Armorsmithing: Volume I
			},
		},
		{ -- DMNTRIBUTERUN
			name = AL["Tribute"],
			ExtraList = true,
			npcID = 14324,
			ObjectID = 179564,
			[NORMAL_DIFF] = {
				{ 1,  228486 }, -- Treant's Bane
				{ 3,  228065 }, -- Cyclone Spaulders
				{ 4,  18495 }, -- Redoubt Cloak
				{ 5,  228474 }, -- Mindsurge Robe
				{ 6,  228070 }, -- Ogre Forged Hauberk
				{ 7,  18533 }, -- Gordok Bracers of Power
				{ 8,  18529 }, -- Elemental Plate Girdle
				{ 9,  228469 }, -- Tarnished Elven Ring
				{ 10, 18537 }, -- Counterattack Lodestone
				{ 11, 18499 }, -- Barrier Shield
				{ 12, 228473 }, -- Unyielding Maul
				{ 13, 228484 }, -- Rod of the Ogre Magi
				{ 16, 18479 }, -- Carrion Scorpid Helm
				{ 17, 18480 }, -- Scarab Plate Helm
				{ 18, 18478 }, -- Hyena Hide Jerkin
				{ 19, 18475 }, -- Oddly Magical Belt
				{ 20, 18477 }, -- Shaggy Leggings
				{ 21, 18476 }, -- Mud Stained Boots
				{ 22, 18482 }, -- Ogre Toothpick Shooter
				{ 23, 18481 }, -- Skullcracking Mace
				{ 25, 18655 }, -- Schematic: Major Recombobulator
			},
		},
		{ -- DMNTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18250 }, -- Gordok Shackle Key
				{ 3, 18333 }, -- Libram of Focus
				{ 4, 18334 }, -- Libram of Protection
				{ 5, 18332 }, -- Libram of Rapidity
				{ 7, 18640 }, -- Happy Fun Rock
			},
		},
		DM_BOOKS,
		KEYS,
	},
}

data["Scholomance"] = {
	MapID = 2057,
	InstanceID = 289,
	SubAreaIDs = { 32549, 32574, 32567, 32577, 32566, 32565, 32581, 32579, 32573, 32568, 32576, 32569 },
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Scholomance",
	AtlasMapFile = "CL_Scholomance",
	AtlasMapFile_AL = "Scholomance",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = { 45, 58, 60 },
	items = {
		{ -- SCHOLOBlood
			name = AL["Blood Steward of Kirtonos"],
			npcID = 14861,
			Level = 61,
			SubAreaID = 32573,
			DisplayIDs = { { 10925 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 13523 }, -- Blood of Innocents
			},
		},
		{ -- SCHOLOKirtonostheHerald
			name = AL["Kirtonos the Herald"],
			npcID = 10506,
			Level = 60,
			SubAreaID = 32574,
			DisplayIDs = { { 7534 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  226764 }, -- Boots of Valor
				{ 3,  228019 }, -- Heart of the Fiend
				{ 4,  228001 }, -- Stoneform Shoulders
				{ 5,  13969 }, -- Loomguard Armbraces
				{ 6,  228007 }, -- Gargoyle Slashers
				{ 7,  228005 }, -- Clutch of Andros
				{ 8,  228004 }, -- Windreaver Greaves
				{ 9,  228015 }, -- Frightalon
				{ 10, 228029 }, -- Gravestone War Axe
			},
		},
		{ -- SCHOLOJandiceBarov
			name = AL["Jandice Barov"],
			npcID = 10503,
			Level = 61,
			DisplayIDs = { { 11073 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  226756 }, -- Dreadmist Mantle
				{ 3,  14548 }, -- Royal Cap Spaulders
				{ 4,  18689 }, -- Phantasmal Cloak
				{ 5,  228031 }, -- Darkshade Gloves
				{ 6,  228040 }, -- Ghostloom Leggings
				{ 7,  228041 }, -- Wraithplate Leggings
				{ 8,  227997 }, -- Barovian Family Sword
				{ 9,  22394 }, -- Staff of Metanoia
				{ 12, 13523 }, -- Blood of Innocents
			},
		},
		{ -- SCHOLORattlegore
			name = AL["Rattlegore"],
			npcID = 11622,
			Level = 61,
			SubAreaID = 32577,
			DisplayIDs = { { 12073 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  226703 }, -- Shadowcraft Boots
				{ 3,  228032 }, -- Bone Ring Helm
				{ 4,  14538 }, -- Deadwalker Mantle
				{ 5,  18686 }, -- Bone Golem Shoulders
				{ 6,  14537 }, -- Corpselight Greaves
				{ 7,  228037 }, -- Rattlecage Buckler
				{ 8,  227994 }, -- Frightskull Shaft
				{ 10, 18782 }, -- Top Half of Advanced Armorsmithing: Volume II
				{ 12, 13873 }, -- Viewing Room Key
			},
		},
		{ -- SCHOLODeathKnight
			name = AL["Death Knight Darkreaver"],
			npcID = 14516,
			Level = 61,
			SubAreaID = 32577,
			DisplayIDs = { { 14591 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 228045 }, -- Necromantic Band
				{ 2, 18761 }, -- Oblivion's Touch
				{ 3, 18758 }, -- Specter's Blade
				{ 4, 228030 }, -- Malicious Axe
			},
		},
		{ -- SCHOLOMarduk
			name = AL["Marduk Blackpool"],
			npcID = 10433,
			Level = 58,
			SubAreaID = 32576,
			DisplayIDs = { { 10248 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 227992 }, -- Death Knight Sabatons
				{ 2, 227993 }, -- Ebon Hilt of Marduk
			},
		},
		{ -- SCHOLOVectus
			name = AL["Vectus"],
			npcID = 10432,
			Level = 60,
			SubAreaID = 32576,
			DisplayIDs = { { 2606 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 228017 }, -- Dark Advisor's Pendant
				{ 2, 14577 }, -- Skullsmoke Pants
			},
		},
		{ -- SCHOLORasFrostwhisper
			name = AL["Ras Frostwhisper"],
			npcID = 10508,
			Level = 62,
			SubAreaID = 32579,
			DisplayIDs = { { 7919 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  228023 }, -- Alanna's Embrace
				{ 3,  226726 }, -- Magister's Mantle
				{ 5,  228036 }, -- Death's Clutch
				{ 6,  14340 }, -- Freezing Lich Robes
				{ 7,  228034 }, -- Shivery Handwraps
				{ 8,  14525 }, -- Boneclenched Gauntlets
				{ 9,  14502 }, -- Frostbite Girdle
				{ 10, 228044 }, -- Maelstrom Leggings
				{ 11, 18694 }, -- Shadowy Mail Greaves
				{ 12, 228039 }, -- Spellbound Tome
				{ 13, 18696 }, -- Intricately Runed Shield
				{ 14, 13952 }, -- Iceblade Hacker
				{ 15, 14487 }, -- Bonechill Hammer
				{ 16, 13521 }, -- Recipe: Flask of Supreme Power
			},
		},
		{ -- SCHOLOInstructorMalicia
			name = AL["Instructor Malicia"],
			npcID = 10505,
			Level = 60,
			SubAreaID = 32567,
			DisplayIDs = { { 11069 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  226704 }, -- Shadowcraft Bracers
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  228010 }, -- Necropile Mantle
				{ 6,  228013 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  228012 }, -- Bloodmail Hauberk
				{ 9,  228000 }, -- Deathbone Chestplate
				{ 10, 228011 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 228020 }, -- Bloodmail Gauntlets
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 228014 }, -- Bloodmail Belt
				{ 16, 228002 }, -- Deathbone Girdle
				{ 17, 228018 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLODoctorTheolenKrastinov
			name = AL["Doctor Theolen Krastinov"],
			npcID = 11261,
			Level = 60,
			SubAreaID = 32565,
			DisplayIDs = { { 10901 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  226731 }, -- Magister's Gloves
				{ 2,  14617 }, -- Sawbones Shirt
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  228010 }, -- Necropile Mantle
				{ 6,  228013 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  228012 }, -- Bloodmail Hauberk
				{ 9,  228000 }, -- Deathbone Chestplate
				{ 10, 228011 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 228020 }, -- Bloodmail Gauntlets
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 228014 }, -- Bloodmail Belt
				{ 16, 228002 }, -- Deathbone Girdle
				{ 17, 228018 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLorekeeperPolkelt
			name = AL["Lorekeeper Polkelt"],
			npcID = 10901,
			Level = 60,
			SubAreaID = 32566,
			DisplayIDs = { { 11492 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  226758 }, -- Dreadmist Wraps
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  228010 }, -- Necropile Mantle
				{ 6,  228013 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  228012 }, -- Bloodmail Hauberk
				{ 9,  228000 }, -- Deathbone Chestplate
				{ 10, 228011 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 228020 }, -- Bloodmail Gauntlets
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 228014 }, -- Bloodmail Belt
				{ 16, 228002 }, -- Deathbone Girdle
				{ 17, 228018 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOTheRavenian
			name = AL["The Ravenian"],
			npcID = 10507,
			Level = 60,
			SubAreaID = 32569,
			DisplayIDs = { { 10433 } },
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  226712 }, -- Wildheart Belt
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  228010 }, -- Necropile Mantle
				{ 6,  228013 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  228012 }, -- Bloodmail Hauberk
				{ 9,  228000 }, -- Deathbone Chestplate
				{ 10, 228011 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 228020 }, -- Bloodmail Gauntlets
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 228014 }, -- Bloodmail Belt
				{ 16, 228002 }, -- Deathbone Girdle
				{ 17, 228018 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLordAlexeiBarov
			name = AL["Lord Alexei Barov"],
			npcID = 10504,
			Level = 60,
			SubAreaID = 32549,
			DisplayIDs = { { 11072 } },
			AtlasMapBossID = 12,
			[NORMAL_DIFF] = {
				{ 1,  226739 }, -- Lightforge Bracers
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  228010 }, -- Necropile Mantle
				{ 6,  228013 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  228012 }, -- Bloodmail Hauberk
				{ 9,  228000 }, -- Deathbone Chestplate
				{ 10, 228011 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 228020 }, -- Bloodmail Gauntlets
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 228014 }, -- Bloodmail Belt
				{ 16, 228002 }, -- Deathbone Girdle
				{ 17, 228018 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLOLadyIlluciaBarov
			name = AL["Lady Illucia Barov"],
			npcID = 10502,
			Level = 60,
			SubAreaID = 32568,
			DisplayIDs = { { 11835 } },
			AtlasMapBossID = 13,
			[NORMAL_DIFF] = {
				{ 4,  18681 }, -- Burial Shawl
				{ 5,  228010 }, -- Necropile Mantle
				{ 6,  228013 }, -- Necropile Robe
				{ 7,  14637 }, -- Cadaverous Armor
				{ 8,  228012 }, -- Bloodmail Hauberk
				{ 9,  228000 }, -- Deathbone Chestplate
				{ 10, 228011 }, -- Necropile Cuffs
				{ 11, 14640 }, -- Cadaverous Gloves
				{ 12, 228020 }, -- Bloodmail Gauntlets
				{ 13, 228006 }, -- Deathbone Gauntlets
				{ 14, 14636 }, -- Cadaverous Belt
				{ 15, 228014 }, -- Bloodmail Belt
				{ 16, 228002 }, -- Deathbone Girdle
				{ 17, 228018 }, -- Necropile Leggings
				{ 18, 14638 }, -- Cadaverous Leggings
				{ 19, 18682 }, -- Ghoul Skin Leggings
				{ 20, 228003 }, -- Bloodmail Legguards
				{ 21, 228008 }, -- Deathbone Legguards
				{ 22, 228009 }, -- Necropile Boots
				{ 23, 14641 }, -- Cadaverous Walkers
				{ 24, 227998 }, -- Bloodmail Boots
				{ 25, 227999 }, -- Deathbone Sabatons
				{ 26, 228016 }, -- Dimly Opalescent Ring
				{ 27, 23201 }, -- Libram of Divinity
				{ 28, 23200 }, -- Totem of Sustaining
				{ 29, 227996 }, -- Ancient Bone Bow
				{ 30, 18683 }, -- Hammer of the Vesper
			},
		},
		{ -- SCHOLODarkmasterGandling
			name = AL["Darkmaster Gandling"],
			npcID = 1853,
			Level = 61,
			SubAreaID = 32581,
			DisplayIDs = { { 11070 } },
			AtlasMapBossID = 14,
			[NORMAL_DIFF] = {
				{ 1,  228022 }, -- Headmaster's Charge
				{ 2,  14514 }, -- Pattern: Robe of the Void
				{ 4,  226746 }, -- Devout Crown
				{ 5,  226728 }, -- Magister's Crown
				{ 6,  226762 }, -- Dreadmist Mask
				{ 7,  226707 }, -- Shadowcraft Cap
				{ 8,  226708 }, -- Wildheart Cowl
				{ 9,  226720 }, -- Beaststalker's Cap
				{ 10, 226755 }, -- Coif of Elements
				{ 11, 226733 }, -- Lightforge Helm
				{ 12, 226769 }, -- Helm of Valor
				{ 16, 228025 }, -- Tombstone Breastplate
				{ 17, 13951 }, -- Vigorsteel Vambraces
				{ 18, 228042 }, -- Detention Strap
				{ 19, 13398 }, -- Boots of the Shrieker
				{ 20, 228046 }, -- Don Mauricio's Band of Domination
				{ 21, 13938 }, -- Bonecreeper Stylus
				{ 22, 228024 }, -- Silent Fang
				{ 23, 228021 }, -- Witchblade
				{ 25, 19276 }, -- Ace of Portals
				{ 27, 13501 }, -- Recipe: Major Mana Potion
			},
		},
		{ -- SCHOLOTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  226724 }, -- Magister's Belt
				{ 2,  226761 }, -- Dreadmist Belt
				{ 3,  226704 }, -- Shadowcraft Bracers
				{ 4,  226714 }, -- Wildheart Bracers
				{ 5,  226712 }, -- Wildheart Belt
				{ 6,  226751 }, -- Bindings of Elements
				{ 7,  226739 }, -- Lightforge Bracers
				{ 9,  12843 }, -- Corruptor's Scourgestone
				{ 10, 12841 }, -- Invader's Scourgestone
				{ 11, 12840 }, -- Minion's Scourgestone
				{ 13, 20520 }, -- Dark Rune
				{ 14, 12753 }, -- Skin of Shadow
				{ 16, 18698 }, -- Tattered Leather Hood
				{ 17, 18699 }, -- Icy Tomb Spaulders
				{ 18, 14536 }, -- Bonebrace Hauberk
				{ 19, 18700 }, -- Malefic Bracers
				{ 20, 18702 }, -- Belt of the Ordained
				{ 21, 18697 }, -- Coldstone Slippers
				{ 22, 18701 }, -- Innervating Band
				{ 24, 16254 }, -- Formula: Enchant Weapon - Lifestealing
				{ 25, 16255 }, -- Formula: Enchant 2H Weapon - Major Spirit
				{ 26, 15773 }, -- Pattern: Wicked Leather Armor
				{ 27, 15776 }, -- Pattern: Runic Leather Armor
				{ 29, 13920 }, -- Healthy Dragon Scale
			},
		},
		{ -- SCHOLOLordB
			name = AL["Lord Blackwood"],
			npcID = 14695,
			DisplayIDs = { { 14699 } },
			AtlasMapBossID = 2,
			ContentPhase = 6,
			specialType = "scourgeInvasion",
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 238361 }, -- Lord Blackwood's Blade
				{ 2, 238358 }, -- Blackwood's Thigh
				{ 3, 238360 }, -- Lord Blackwood's Buckler
			},
		},
		{ -- SCHOLOKormok
			name = AL["Kormok"].." - "..format(AL["Tier %s Sets"], "0.5"),
			npcID = 16118,
			DisplayIDs = { { 16020 } },
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 228038 }, -- Ironweave Pants
				{ 2, 228047 }, -- Amalgam's Band
				{ 3, 22331 }, -- Band of the Steadfast Hero
				{ 4, 228028 }, -- Blade of Necromancy
				{ 5, 228033 }, -- Hammer of Divine Might
			},
		},
		KEYS,
	},
}

data["Stratholme"] = {
	MapID = 2017,
	InstanceID = 329,
	SubAreaIDs = {
		-- Living
		32319, 32320, 32367, 32331, 32357, 32281, 32285, 32277,
		-- Undead
		32342, 32322, 32303, 32301, 32352,
		-- Ziggurats
		32344, 32345, 32349,
	},
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Stratholme",
	AtlasMapFile = "CL_Stratholme",
	AtlasMapFile_AL = "Stratholme",
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	LevelRange = GetForVersion({ 37, 58, 60 }, { 45, 58, 60 }),
	items = {
		{ -- STRATSkull
			name = AL["Skul"],
			NameColor = GREEN,
			npcID = 10393,
			Level = 58,
			DisplayIDs = { { 2606 } },
			AtlasMapBossID = 1,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 13395 }, -- Skul's Fingerbone Claws
				{ 2, 13394 }, -- Skul's Cold Embrace
				{ 3, 13396 }, -- Skul's Ghastly Touch
			},
		},
		{ -- STRATStratholmeCourier
			name = AL["Stratholme Courier"],
			NameColor = GREEN,
			npcID = 11082,
			Level = 57,
			DisplayIDs = { { 10547 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 13303 }, -- Crusaders' Square Postbox Key
				{ 2, 13305 }, -- Elders' Square Postbox Key
				{ 3, 13304 }, -- Festival Lane Postbox Key
				{ 4, 13307 }, -- Fras Siabi's Postbox Key
				{ 5, 13306 }, -- King's Square Postbox Key
				{ 6, 13302 }, -- Market Row Postbox Key
			},
		},
		{ -- STRATHearthsingerForresten
			name = AL["Hearthsinger Forresten"],
			NameColor = GREEN,
			npcID = 10558,
			Level = 57,
			SubAreaID = 32277,
			DisplayIDs = { { 10482 } },
			AtlasMapBossID = 3,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 226730 }, -- Magister's Boots
				{ 3, 228501 }, -- Songbird Blouse
				{ 4, 228504 }, -- Rainbow Girdle
				{ 5, 228503 }, -- Woollies of the Prancing Minstrel
				{ 6, 13379 }, -- Piccolo of the Flaming Fire
			},
		},
		{ -- STRATTheUnforgiven
			name = AL["The Unforgiven"],
			NameColor = GREEN,
			npcID = 10516,
			Level = 57,
			SubAreaID = 32281,
			DisplayIDs = { { 10771 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 226711 }, -- Wildheart Gloves
				{ 3, 228500 }, -- Mask of the Unforgiven
				{ 4, 13405 }, -- Wailing Nightbane Pauldrons
				{ 5, 13409 }, -- Tearfall Bracers
				{ 6, 13408 }, -- Soul Breaker
			},
		},
		{ -- STRATPostmaster
			name = AL["Postmaster Malown"],
			NameColor = GREEN,
			npcID = 11143,
			Level = 60,
			DisplayIDs = { { 10669 } },
			AtlasMapBossID = "6'",
			[NORMAL_DIFF] = {
				{ 1, 228528 }, -- The Postmaster's Band
				{ 2, 228525 }, -- The Postmaster's Tunic
				{ 3, 228527 }, -- The Postmaster's Trousers
				{ 4, 228529 }, -- The Postmaster's Treads
				{ 5, 228524 }, -- The Postmaster's Seal
				{ 6, 13393 }, -- Malown's Slam
			},
		},
		{ -- STRATTimmytheCruel
			name = AL["Timmy the Cruel"],
			NameColor = GREEN,
			npcID = 10808,
			Level = 58,
			SubAreaID = 32319,
			DisplayIDs = { { 571 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 226737 }, -- Lightforge Gauntlets
				{ 3, 228513 }, -- Vambraces of the Sadist
				{ 4, 228515 }, -- Grimgore Noose
				{ 5, 228514 }, -- Timmy's Galoshes
				{ 6, 13401 }, -- The Cruel Hand of Timmy
			},
		},
		{ -- STRATMalorsStrongbox
			name = AL["Malor the Zealous"],
			NameColor = GREEN,
			npcID = 11032,
			ObjectID = 176112,
			Level = 60,
			SubAreaID = 32319,
			DisplayIDs = { { 10458 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Malors Strongbox"], nil },
				{ 2, 12845 }, -- Medallion of Faith
			},
		},
		{ -- STRATCrimsonHammersmith
			name = AL["Crimson Hammersmith"],
			NameColor = GREEN,
			npcID = 11120,
			Level = 60,
			SubAreaID = 32357,
			DisplayIDs = { { 10637 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1, 18781 }, -- Bottom Half of Advanced Armorsmithing: Volume II
				--{ 3,  12824 }, -- Plans: Enchanted Battlehammer
			},
		},
		{ -- STRATCannonMasterWilley
			name = AL["Cannon Master Willey"],
			NameColor = GREEN,
			npcID = 10997,
			Level = 60,
			SubAreaID = 32357,
			DisplayIDs = { { 10674 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  226706 }, -- Shadowcraft Spaulders
				{ 3,  22407 }, -- Helm of the New Moon
				{ 4,  228533 }, -- Nacreous Shell Necklace
				{ 5,  22405 }, -- Mantle of the Scarlet Crusade
				{ 6,  18721 }, -- Barrage Girdle
				{ 7,  13381 }, -- Master Cannoneer Boots
				{ 8,  228523 }, -- Cannonball Runner
				{ 9,  228522 }, -- Willey's Portable Howitzer
				{ 10, 13377 }, -- Miniature Cannon Balls
				{ 11, 22404 }, -- Willey's Back Scratcher
				{ 12, 22406 }, -- Redemption
				{ 16, 12839 }, -- Plans: Heartseeker
			},
		},
		{ -- STRATArchivistGalford
			name = AL["Archivist Galford"],
			NameColor = GREEN,
			npcID = 10811,
			Level = 60,
			SubAreaID = 32331,
			DisplayIDs = { { 10544 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  226740 }, -- Devout Gloves
				{ 3,  13386 }, -- Archivist Cape
				{ 4,  13387 }, -- Foresight Girdle
				{ 5,  18716 }, -- Ash Covered Boots
				{ 6,  13385 }, -- Tome of Knowledge
				{ 8,  12811 }, -- Righteous Orb
				{ 10, 22897 }, -- Tome of Conjure Food VII
			},
		},
		{ -- STRATBalnazzar
			name = AL["Balnazzar"],
			NameColor = GREEN,
			npcID = { 10812, 10813 },
			Level = 999,
			SubAreaID = 32367,
			DisplayIDs = { { 10545 }, { 10691 } },
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  228539 }, -- Book of the Dead
				{ 2,  14512 }, -- Pattern: Truefaith Vestments
				{ 4,  226738 }, -- Lightforge Boots
				{ 6,  228540 }, -- Crown of Tyranny
				{ 7,  228545 }, -- Grand Crusader's Helm
				{ 8,  228536 }, -- Star of Mystaria
				{ 9,  228546 }, -- Shroud of the Nathrezim
				{ 10, 13358 }, -- Wyrmtongue Shoulders
				{ 11, 13369 }, -- Fire Striders
				{ 12, 228541 }, -- Gift of the Elven Magi
				{ 13, 228544 }, -- Hammer of the Grand Crusader
				{ 14, 22334 }, -- Band of Mending
				{ 15, 13348 }, -- Demonshear
				{ 16, 13520 }, -- Recipe: Flask of Distilled Wisdom
				{ 18, 13250 }, -- Head of Balnazzar
			},
		},
		{ -- STRATMagistrateBarthilas
			name = AL["Magistrate Barthilas"],
			NameColor = PURP,
			npcID = 10435,
			Level = 58,
			SubAreaID = 32342,
			DisplayIDs = { { 10433 } },
			AtlasMapBossID = 12,
			[NORMAL_DIFF] = {
				{ 1, 18727 }, -- Crimson Felt Hat
				{ 2, 228505 }, -- Royal Tribunal Cloak
				{ 3, 228518 }, -- Magistrate's Cuffs
				{ 4, 18722 }, -- Death Grips
				{ 5, 23198 }, -- Idol of Brutality
				{ 6, 228516 }, -- Peacemaker
				{ 8, 12382 }, -- Key to the City
			},
		},
		{ -- STRATStonespine
			name = AL["Stonespine"],
			NameColor = PURP,
			npcID = 10809,
			Level = 60,
			SubAreaID = 32303,
			DisplayIDs = { { 7856 } },
			AtlasMapBossID = 14,
			specialType = "rare",
			[NORMAL_DIFF] = {
				{ 1, 13397 }, -- Stoneskin Gargoyle Cape
				{ 2, 13954 }, -- Verdant Footpads
				{ 3, 13399 }, -- Gargoyle Shredder Talons
			},
		},
		{ -- STRATBaronessAnastari
			name = AL["Baroness Anastari"],
			NameColor = PURP,
			npcID = 10436,
			Level = 59,
			SubAreaID = 32344,
			DisplayIDs = { { 10698 } },
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1,  226763 }, -- Dreadmist Sandals
				{ 3,  18728 }, -- Anastari Heirloom
				{ 4,  228521 }, -- Shadowy Laced Handwraps
				{ 5,  18729 }, -- Screeching Bow
				{ 6,  13534 }, -- Banshee Finger
				{ 8,  13538 }, -- Windshrieker Pauldrons
				{ 9,  13535 }, -- Coldtouch Phantom Wraps
				{ 10, 13537 }, -- Chillhide Bracers
				{ 11, 13539 }, -- Banshee's Touch
				{ 12, 13514 }, -- Wail of the Banshee
			},
		},
		{ -- STRATBlackGuardSwordsmith
			name = AL["Black Guard Swordsmith"],
			NameColor = PURP,
			npcID = 11121,
			Level = { 61, 62 },
			SubAreaID = 32345,
			DisplayIDs = { { 775 } },
			AtlasMapBossID = 15,
			[NORMAL_DIFF] = {
				{ 1, 18783 }, -- Bottom Half of Advanced Armorsmithing: Volume III
				--{ 2,  12725 }, -- Plans: Enchanted Thorium Helm
				--{ 3,  12620 }, -- Enchanted Thorium Helm
				--{ 3,  12825 }, -- Plans: Blazing Rapier
				--{ 6,  12777 }, -- Blazing Rapier
			},
		},
		{ -- STRATNerubenkan
			name = AL["Nerub'enkan"],
			NameColor = PURP,
			npcID = 10437,
			Level = 60,
			SubAreaID = 32345,
			DisplayIDs = { { 9793 } },
			AtlasMapBossID = 16,
			[NORMAL_DIFF] = {
				{ 1,  226722 }, -- Beaststalker's Boots
				{ 3,  228531 }, -- Thuzadin Sash
				{ 4,  228530 }, -- Chitinous Plate Legguards
				{ 5,  18738 }, -- Carapace Spine Crossbow
				{ 6,  13529 }, -- Husk of Nerub'enkan
				{ 8,  13533 }, -- Acid-etched Pauldrons
				{ 9,  13532 }, -- Darkspinner Claws
				{ 10, 13531 }, -- Crypt Stalker Leggings
				{ 11, 13530 }, -- Fangdrip Runners
				{ 12, 13508 }, -- Eye of Arachnida
			},
		},
		{ -- STRATMalekithePallid
			name = AL["Maleki the Pallid"],
			NameColor = PURP,
			npcID = 10438,
			Level = 61,
			SubAreaID = 32349,
			DisplayIDs = { { 10546 } },
			AtlasMapBossID = 17,
			[NORMAL_DIFF] = {
				{ 1,  226743 }, -- Devout Sandals
				{ 3,  18734 }, -- Pale Moon Cloak
				{ 4,  18735 }, -- Maleki's Footwraps
				{ 5,  13524 }, -- Skull of Burning Shadows
				{ 6,  228535 }, -- Bone Slicing Hatchet
				{ 8,  13528 }, -- Twilight Void Bracers
				{ 9,  13525 }, -- Darkbind Fingers
				{ 10, 13526 }, -- Flamescarred Girdle
				{ 11, 13527 }, -- Lavawalker Greaves
				{ 12, 13509 }, -- Clutch of Foresight
				{ 16, 12833 }, -- Plans: Hammer of the Titans
			},
		},
		{ -- STRATRamsteintheGorger
			name = AL["Ramstein the Gorger"],
			NameColor = PURP,
			npcID = 10439,
			Level = 61,
			SubAreaID = 32301,
			DisplayIDs = { { 12818 } },
			AtlasMapBossID = 18,
			[NORMAL_DIFF] = {
				{ 1, 226771 }, -- Gauntlets of Valor
				{ 3, 18723 }, -- Animated Chain Necklace
				{ 4, 228520 }, -- Soulstealer Mantle
				{ 5, 13373 }, -- Band of Flesh
				{ 6, 13515 }, -- Ramstein's Lightning Bolts
				{ 7, 13375 }, -- Crest of Retribution
				{ 8, 13372 }, -- Slavedriver's Cane
			},
		},
		{ -- STRATBaronRivendare
			name = AL["Baron Rivendare"],
			NameColor = PURP,
			npcID = 10440,
			Level = 62,
			SubAreaID = 32352,
			DisplayIDs = { { 10729 } },
			AtlasMapBossID = 19,
			[NORMAL_DIFF] = {
				{ 1,  13335 }, -- Deathcharger's Reins
				{ 2,  228543 }, -- Runeblade of Baron Rivendare
				{ 4,  228553 }, -- Helm of the Executioner
				{ 5,  22412 }, -- Thuzadin Mantle
				{ 6,  13340 }, -- Cape of the Black Baron
				{ 7,  13346 }, -- Robes of the Exalted
				{ 8,  228551 }, -- Tunic of the Crescent Moon
				{ 9,  228537 }, -- Dracorian Gauntlets
				{ 10, 228552 }, -- Gauntlets of Deftness
				{ 11, 228538 }, -- Seal of Rivendare
				{ 12, 22408 }, -- Ritssyn's Wand of Bad Mojo
				{ 13, 13349 }, -- Scepter of the Unholy
				{ 14, 13368 }, -- Bonescraper
				{ 15, 228542 }, -- Skullforge Reaver
				{ 16, 226747 }, -- Devout Skirt
				{ 17, 226727 }, -- Magister's Leggings
				{ 18, 226760 }, -- Dreadmist Leggings
				{ 19, 226705 }, -- Shadowcraft Pants
				{ 20, 226709 }, -- Wildheart Kilt
				{ 21, 226719 }, -- Beaststalker's Pants
				{ 22, 226750 }, -- Kilt of Elements
				{ 23, 226736 }, -- Lightforge Legplates
				{ 24, 226767 }, -- Legplates of Valor
			},
		},
		{ -- STRATTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  226742 }, -- Devout Bracers
				{ 2,  226724 }, -- Magister's Belt
				{ 3,  226761 }, -- Dreadmist Belt
				{ 4,  226704 }, -- Shadowcraft Bracers
				{ 5,  226714 }, -- Wildheart Bracers
				{ 6,  226717 }, -- Beaststalker's Bindings
				{ 7,  226751 }, -- Bindings of Elements
				{ 8,  226732 }, -- Lightforge Belt
				{ 9,  226765 }, -- Belt of Valor
				{ 11, 12811 }, -- Righteous Orb
				{ 12, 12735 }, -- Frayed Abomination Stitching
				{ 13, 12843 }, -- Corruptor's Scourgestone
				{ 14, 12841 }, -- Invader's Scourgestone
				{ 15, 12840 }, -- Minion's Scourgestone
				{ 16, 18742 }, -- Stratholme Militia Shoulderguard
				{ 17, 18743 }, -- Gracious Cape
				{ 18, 17061 }, -- Juno's Shadow
				{ 19, 228532 }, -- Morlune's Bracer
				{ 20, 18744 }, -- Plaguebat Fur Gloves
				{ 21, 18745 }, -- Sacred Cloth Leggings
				{ 22, 228534 }, -- Plaguehound Leggings
				{ 24, 16249 }, -- Formula: Enchant 2H Weapon - Major Intellect
				{ 25, 16248 }, -- Formula: Enchant Weapon - Unholy
				{ 26, 14495 }, -- Pattern: Ghostweave Pants
				{ 27, 15777 }, -- Pattern: Runic Leather Shoulders
				{ 28, 15768 }, -- Pattern: Wicked Leather Belt
				{ 29, 18658 }, -- Schematic: Ultra-Flash Shadow Reflector
				{ 30, 16052 }, -- Schematic: Voice Amplification Modulator
			},
		},
		{ -- STRATBSPlansSerenity / STRATBSPlansCorruption
			name = AL["Plans"],
			ExtraList = true,
			IgnoreAsSource = true,
			[NORMAL_DIFF] = {
				{ 1,  12827 }, -- Plans: Serenity
				{ 16, 12830 }, -- Plans: Corruption
			},
		},
		{ -- STRATAtiesh
			name = AL["Atiesh"],
			NameColor = GREEN,
			ExtraList = true,
			AtlasMapBossID = 2,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1, 22736 }, -- Andonisus, Reaper of Souls
			},
		},
		{ -- STRATBalzaphon
			name = AL["Balzaphon"],
			NameColor = GREEN,
			ExtraList = true,
			specialType = "scourgeInvasion",
			npcID = 14684,
			DisplayIDs = { { 7919 } },
			AtlasMapBossID = 2,
			ContentPhase = 6,
			[NORMAL_DIFF] = {
				{ 1, 238356 }, -- Waistband of Balzaphon
				{ 2, 238355 }, -- Chains of the Lich
				{ 3, 238357 }, -- Staff of Balzaphon
			},
		},
		{ -- STRATSothosJarien
			name = AL["Sothos and Jarien's Heirlooms"].." - "..format(AL["Tier %s Sets"], "0.5"),
			NameColor = GREEN,
			ExtraList = true,
			ContentPhase = 5,
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1, 22327 }, -- Amulet of the Redeemed
				{ 2, 228547 }, -- Ironweave Robe
				{ 3, 22328 }, -- Legplates of Vigilance
				{ 4, 22334 }, -- Band of Mending
				{ 5, 228548 }, -- Scepter of Interminable Focus
			},
		},
		KEYS,
	},
}

data["DemonFallCanyon"] = {
	MapID = 15475,
	InstanceID = 15540,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "DemonFallCanyon",
	AtlasMapFile = "CL_DemonFallCanyon",
	ContentType = DUNGEON_CONTENT,
	LevelRange = { 60, 60, 60 },
	items = {
		{ -- DFCGrimroot
			name = AL["Grimroot"],
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1, 228080 }, -- Resin Loop
				{ 2, 228081 }, -- Germinating Poisonseed
				{ 3, 228079 }, -- Cloak of Leaves
				{ 4, 228082 }, -- Warsong Axe
				{ 5, 228083 }, -- Gloaming Treeheart
			},
		},
		{ -- DFCDestructor
			name = AL["Destructor's Wraith"],
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1, 228074 }, -- Hands of Temptation
				{ 2, 228075 }, -- Spear of Destiny
				{ 3, 228077 }, -- Dreambough
				{ 4, 228078 }, -- Accursed Chalice
				{ 5, 228076 }, -- Burning Ring of Fire
			},
		},
		{ -- DFCZilbagob
			name = AL["Zilbagob"],
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1, 228086 }, -- Repurposed Shredderblade
				{ 2, 228088 }, -- Shredder Operator's Dogtags
				{ 3, 228087 }, -- Supercharged Silver Moebius
				{ 4, 228084 }, -- Miniaturized Fire Extinguisher
				{ 5, 228085 }, -- Phaseshifted Legion Band
			},
		},
		{ -- DFCAzgaloth
			name = AL["Azgaloth"],
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1, 231911 }, -- Signet of the Legion General
				{ 2, 231910 }, -- Heart of Azgaloth
				{ 3, 231913 }, -- Eye of the Observer
				{ 4, 231460 }, -- Planebreaker of Azgaloth
				{ 5, 231912 }, -- Blade of the Pit
			},
		},
		{ -- DFCPyranis
			name = AL["Pyranis"],
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1, 228091 }, -- Thorned Boots
				{ 2, 228093 }, -- Dark Heart of Darkness
				{ 3, 228090 }, -- Cenarion Ritual Dagger
				{ 4, 228092 }, -- Druidic Mantle
				{ 5, 228089 }, -- Woodcarved Moonstalker
			},
		},
		{ -- DFCDiathorus
			name = AL["Diathorus The Seeker"],
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 228106 }, -- Shield of Life and Death
				{ 2, 228107 }, -- Fallen Huntress' Longbow
				{ 3, 228094 }, -- Dreadlord's Blade
				{ 4, 228104 }, -- Robes of Elune
				{ 5, 228103 }, -- Nathrezim's Greaves
			},
		},
		{ -- DFCHellscream
			name = AL["Hellscream's Phantom"],
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 228112 }, -- Nightmare Gown
				{ 2, 228113 }, -- Cold Embrace
				{ 3, 228111 }, -- Mask of the Godslayer
				{ 4, 228109 }, -- Legguards of Sacrifice
				{ 5, 228108 }, -- Shadow of Gorehowl
				{ 7, 228410 }, -- Dreadblade of the Destructor
			},
		},
	},
}

data["KarazhanCrypts"] = {
	MapID = 16074,
	InstanceID = 16074,
	ContentType = DUNGEON_CONTENT,
	LevelRange = { 60, 60, 60 },
	items = {
		{ -- The Warden
			name = AL["The Warden"],
			[NORMAL_DIFF] = {
				{ 1, 236707 }, -- Tunic of Undead Slaying
				{ 2, 236727 }, -- Tunic of Undead Cleansing
				{ 3, 236730 }, -- Tunic of Undead Purification
				{ 4, 237011 }, -- Key
			},
		},
		{ -- The Failed Apprentices
			name = AL["The Failed Apprentice"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["Barian Maryla"], nil },
				{ 2,  235887 }, -- Barian's Choker
				{ 3,  235880 }, -- Pauper Soles
				{ 4,  235894 }, -- Doomsayer's Demise
				{ 5,  235873 }, -- Crypt's Keepers
				{ 6,  235879 }, -- Nimble Links
				{ 8,  "INV_Box_01", nil, AL["Kaigy Maryla"],  nil },
				{ 9,  235886 }, -- Kaigy's Clasp
				{ 10, 235880 }, -- Pauper Soles
				{ 11, 235894 }, -- Doomsayer's Demise
				{ 12, 235873 }, -- Crypt's Keepers
				{ 13, 235879 }, -- Nimble Links
				{ 16, "INV_Box_01", nil, AL["Sairuh Maryla"], nil },
				{ 17, 236782 }, -- Sairuh's Collar
				{ 18, 235880 }, -- Pauper Soles
				{ 19, 235894 }, -- Doomsayer's Demise
				{ 20, 235873 }, -- Crypt's Keepers
				{ 21, 235879 }, -- Nimble Links
			},
		},
		{ -- Opera of Malediction
			name = AL["Opera of Malediction"],
			[NORMAL_DIFF] = {
				{ 1, 235889 }, -- Servant's Quarterstaff
				{ 2, 235883 }, -- Well Diver's Stumble
				{ 3, 235878 }, -- Malefic Belt
				{ 4, 235893 }, -- Shadowbound Grimoire
			},
		},
		{ -- Harbinger of Sin
			name = AL["Harbinger of Sin"],
			[NORMAL_DIFF] = {
				{ 1, 235891 }, -- Ol' Reliable
				{ 2, 235890 }, -- Shadow Weaver's Needle
				{ 3, 235869 }, -- The Master's Cowl
				{ 4, 235882 }, -- Clattering Steps
			},
		},
		{ -- Creeping Malison
			name = AL["Creeping Malison"],
			[NORMAL_DIFF] = {
				{ 1, 235888 }, -- Clobberclub
				{ 2, 235885 }, -- Ghastly Ring
				{ 3, 235884 }, -- Spectral Signet
				{ 4, 235881 }, -- Dreaded Treaders
			},
		},
		{ -- Kharon
			name = AL["Kharon"],
			[NORMAL_DIFF] = {
				{ 1,   235875 }, -- Gravedigger's Gloves
				{ 2,   235874 }, -- Cultist's Handwraps
				{ 3,   235877 }, -- Fanatic's Gauntlets
				{ 4,   236645 }, -- Lightwielder's Gauntlets
				{ 5,   235876 }, -- Sinner's Handguards
				{ 6,   236642 }, -- Mender's Handwraps
				{ 7,   236643 }, -- Nightwatcher's Gloves
				{ 8,   236644 }, -- Mourner's Handguards
				{ 9,   235878 }, -- Malefic Belt
				{ 10,  235870 }, -- Battlechain Helm
				{ 11,  235893 }, -- Shadowbound Grimoire
				{ 12,  235883 }, -- Well Diver's Stumble
				{ 13,  235889 }, -- Servant's Quarterstaff
				{ 16,  "INV_Box_01", nil, AL["Shared Loot"], nil },
				{ 17,  235881 }, -- Dreaded Treaders
				{ 18,  235880 }, -- Pauper Soles
				{ 19,  235879 }, -- Nimble Links
				{ 20,  235872 }, -- Stalker's Bands
				{ 21,  235869 }, -- The Master's Cowl
				{ 22,  235871 }, -- Clutching Death Helm
				{ 23,  235887 }, -- Barian's Choker
				{ 24,  235882 }, -- Clattering Steps
				{ 25,  235885 }, -- Ghastly Ring
				{ 26,  235868 }, -- Bulwark of Ire
				{ 27,  235892 }, -- Darkrider's Spine
				{ 28,  235886 }, -- Kaigy's Clasp
				{ 29,  235891 }, -- Ol' Reliable
				{ 30,  235888 }, -- Clobberclub
				{ 101, 235894 }, -- Doomsayer's Demise
				{ 102, 235890 }, -- Shadow Weaver's Needle
				{ 103, 235884 }, -- Spectral Signet
				{ 104, 236782 }, -- Sairuh's Collar
				{ 105, 235873 }, -- Crypt's Keepers
			},
		},
		{ -- Dark Rider
			name = AL["Dark Rider"],
			[NORMAL_DIFF] = {
				{ 1, 235892 }, -- Darkrider's Spine
				{ 2, 235868 }, -- Bulwark of Ire
				{ 3, 235871 }, -- Clutching Death Helm
				{ 4, 235872 }, -- Stalker's Bands
			},
		},

	},
}

-- ########################
-- Raids
-- ########################
data["WorldBosses"] = {
	name = AL["World Bosses"],
	AtlasMapFile = "Azuregos",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 2,
	items = {
		{ -- AAzuregos
			name = AL["Azuregos"],
			AtlasMapFile = "Azuregos",
			npcID = 6109,
			Level = 999,
			ContentPhase = 2,
			DisplayIDs = { { 11460 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  228385 }, -- Crystal Adorned Crown
				{ 2,  228389 }, -- Drape of Benediction
				{ 3,  228383 }, -- Puissant Cape
				{ 4,  228340 }, -- Unmelting Ice Girdle
				{ 5,  228345 }, -- Leggings of Arcane Supremacy
				{ 6,  228384 }, -- Snowblind Shoes
				{ 7,  228381 }, -- Cold Snap
				{ 8,  228382 }, -- Fang of the Mystics
				{ 9,  228349 }, -- Eskhandar's Left Claw
				{ 10, 228347 }, -- Typhoon
				{ 16, 18704 }, -- Mature Blue Dragon Sinew
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0,  17962 }, -- Blue Sack of Gems
				{ 0,  17963 }, -- Green Sack of Gems
				{ 0,  17964 }, -- Gray Sack of Gems
				{ 0,  17965 }, -- Yellow Sack of Gems
				{ 0,  17969 }, -- Red Sack of Gems
			},
		},
		{ -- KKazzak
			name = AL["Lord Kazzak"],
			AtlasMapFile = "LordKazzak",
			npcID = 12397,
			Level = 999,
			ContentPhase = 2,
			DisplayIDs = { { 12449 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  228353 }, -- Infernal Headcage
				{ 2,  228354 }, -- Blazefury Medallion
				{ 3,  228360 }, -- Eskhandar's Pelt
				{ 4,  228357 }, -- Blacklight Bracer
				{ 5,  228351 }, -- Doomhide Gauntlets
				{ 6,  228355 }, -- Flayed Doomguard Belt
				{ 7,  228352 }, -- Fel Infused Leggings
				{ 8,  228359 }, -- Ring of Entropy
				{ 9,  228397 }, -- Empyrean Demolisher
				{ 10, 228356 }, -- Amberseal Keeper
				{ 16, 18665 }, -- The Eye of Shadow
				{ 18, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0,  17962 }, -- Blue Sack of Gems
				{ 0,  17963 }, -- Green Sack of Gems
				{ 0,  17964 }, -- Gray Sack of Gems
				{ 0,  17965 }, -- Yellow Sack of Gems
				{ 0,  17969 }, -- Red Sack of Gems
			},
		},
		{ -- PrinceThunderaan
			name = AL["Prince Thunderaan"],
			npcID = 14435,
			Level = 999,
			DisplayIDs = { { 15825 } },
			[NORMAL_DIFF] = {
				{ 1,  231725 }, -- Ancient Belt
				{ 2,  231716 }, -- Primeval Belt
				{ 3,  231708 }, -- Draconian Belt
				{ 5,  19018 }, -- Dormant Wind Kissed Blade
				{ 16, 231782 }, -- Crown of the Successor
				{ 17, 231783 }, -- Drape of the Windlord
				{ 18, 231785 }, -- Echoes of Betrayal
				{ 19, 231815 }, -- Fleshrend
				{ 20, 231784 }, -- Lighhtning's Call
				{ 21, 231753 }, -- Skywall's Solace
				{ 22, 231777 }, -- Crystallized Qiraji Limb
				{ 23, 231387 }, -- Stormwrath, Snactified Shortblade of the Galefinder
				{ 24, 231781 }, -- Soul of Thunder
				{ 25, 231823 }, -- Geddon's Glaive
				{ 26, 231817 }, -- Windstriker
				{ 27, 231779 }, -- Wrath of Wray
			},
		},
		{ -- DLethon
			name = AL["Lethon"],
			AtlasMapFile = "FourDragons",
			npcID = 14888,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = { { 15365 } },
			[NORMAL_DIFF] = {
				{ 1,  234164 }, -- Deviate Growth Cap
				{ 2,  234162 }, -- Black Bark Wristbands
				{ 3,  234165 }, -- Gauntlets of the Shining Light
				{ 4,  234161 }, -- Belt of the Dark Bog
				{ 5,  234163 }, -- Dark Heart Pants
				{ 6,  234166 }, -- Malignant Footguards
				{ 9,  234151 }, -- Green Dragonskin Cloak
				{ 10, 234149 }, -- Dragonspur Wraps
				{ 11, 234148 }, -- Dragonbone Wristguards
				{ 12, 234150 }, -- Gloves of Delusional Power
				{ 13, 234147 }, -- Ancient Corroded Leggings
				{ 14, 234146 }, -- Acid Inscribed Greaves
				{ 15, 234154 }, -- Trance Stone
				{ 16, 235049 }, -- Nightmare Engulfed Object
				{ 17, 234155 }, -- Malfurion's Signet Ring
				{ 24, 234152 }, -- Hammer of Bestial Fury
				{ 25, 234153 }, -- Staff of Rampant Growth
				{ 29, 20381 }, -- Dreamscale
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0,  17962 }, -- Blue Sack of Gems
				{ 0,  17963 }, -- Green Sack of Gems
				{ 0,  17964 }, -- Gray Sack of Gems
				{ 0,  17965 }, -- Yellow Sack of Gems
				{ 0,  17969 }, -- Red Sack of Gems
			},
		},
		{ -- DEmeriss
			name = AL["Emeriss"],
			AtlasMapFile = "FourDragons",
			npcID = 14889,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = { { 15366 } },
			[NORMAL_DIFF] = {
				{ 1,  234157 }, -- Circlet of Restless Dreams
				{ 2,  234158 }, -- Dragonheart Necklace
				{ 3,  234160 }, -- Ring of the Unliving
				{ 4,  234156 }, -- Boots of the Endless Moor
				{ 5,  234159 }, -- Polished Ironwood Crossbow
				{ 9,  234151 }, -- Green Dragonskin Cloak
				{ 10, 234149 }, -- Dragonspur Wraps
				{ 11, 234148 }, -- Dragonbone Wristguards
				{ 12, 234150 }, -- Gloves of Delusional Power
				{ 13, 234147 }, -- Ancient Corroded Leggings
				{ 14, 234146 }, -- Acid Inscribed Greaves
				{ 15, 234154 }, -- Trance Stone
				{ 16, 235049 }, -- Nightmare Engulfed Object
				{ 17, 234155 }, -- Malfurion's Signet Ring
				{ 24, 234152 }, -- Hammer of Bestial Fury
				{ 25, 234153 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0,  17962 }, -- Blue Sack of Gems
				{ 0,  17963 }, -- Green Sack of Gems
				{ 0,  17964 }, -- Gray Sack of Gems
				{ 0,  17965 }, -- Yellow Sack of Gems
				{ 0,  17969 }, -- Red Sack of Gems
			},
		},
		{ -- DTaerar
			name = AL["Taerar"],
			AtlasMapFile = "FourDragons",
			npcID = 14890,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = { { 15363 }, { 15367 } },
			[NORMAL_DIFF] = {
				{ 1,  234171 }, -- Unnatural Leather Spaulders
				{ 2,  234168 }, -- Mendicant's Slippers
				{ 3,  234167 }, -- Boots of Fright
				{ 4,  234169 }, -- Mindtear Band
				{ 5,  234170 }, -- Nightmare Blade
				{ 9,  234151 }, -- Green Dragonskin Cloak
				{ 10, 234149 }, -- Dragonspur Wraps
				{ 11, 234148 }, -- Dragonbone Wristguards
				{ 12, 234150 }, -- Gloves of Delusional Power
				{ 13, 234147 }, -- Ancient Corroded Leggings
				{ 14, 234146 }, -- Acid Inscribed Greaves
				{ 15, 234154 }, -- Trance Stone
				{ 16, 235049 }, -- Nightmare Engulfed Object
				{ 17, 234155 }, -- Malfurion's Signet Ring
				{ 24, 234152 }, -- Hammer of Bestial Fury
				{ 25, 234153 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0,  17962 }, -- Blue Sack of Gems
				{ 0,  17963 }, -- Green Sack of Gems
				{ 0,  17964 }, -- Gray Sack of Gems
				{ 0,  17965 }, -- Yellow Sack of Gems
				{ 0,  17969 }, -- Red Sack of Gems
			},
		},
		{ -- DYsondre
			name = AL["Ysondre"],
			AtlasMapFile = "FourDragons",
			npcID = 14887,
			Level = 999,
			ContentPhase = 4,
			DisplayIDs = { { 15364 } },
			[NORMAL_DIFF] = {
				{ 1,  234174 }, -- Acid Inscribed Pauldrons
				{ 2,  234962 }, -- Jade Inlaid Vestments
				{ 3,  234173 }, -- Leggings of the Demented Mind
				{ 4,  234963 }, -- Strangely Glyphed Legplates
				{ 5,  234175 }, -- Hibernation Crystal
				{ 6,  234172 }, -- Emerald Dragonfang
				{ 9,  234151 }, -- Green Dragonskin Cloak
				{ 10, 234149 }, -- Dragonspur Wraps
				{ 11, 234148 }, -- Dragonbone Wristguards
				{ 12, 234150 }, -- Gloves of Delusional Power
				{ 13, 234147 }, -- Ancient Corroded Leggings
				{ 14, 234146 }, -- Acid Inscribed Greaves
				{ 15, 234154 }, -- Trance Stone
				{ 16, 235049 }, -- Nightmare Engulfed Object
				{ 17, 234155 }, -- Malfurion's Signet Ring
				{ 24, 234152 }, -- Hammer of Bestial Fury
				{ 25, 234153 }, -- Staff of Rampant Growth
				{ 30, 11938 }, -- Sack of Gems
				-- Hidden items
				{ 0,  17962 }, -- Blue Sack of Gems
				{ 0,  17963 }, -- Green Sack of Gems
				{ 0,  17964 }, -- Gray Sack of Gems
				{ 0,  17965 }, -- Yellow Sack of Gems
				{ 0,  17969 }, -- Red Sack of Gems
			},
		},
	}
}

data["MoltenCore"] = {
	MapID = 2717,
	InstanceID = 409,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "MoltenCore",
	AtlasMapFile = "CL_MoltenCore",
	AtlasMapFile_AL = "MoltenCore",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		{ --MCLucifron
			name = AL["Lucifron"],
			npcID = 12118,
			Level = 999,
			DisplayIDs = { { 13031 }, { 12030 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  227533 }, -- Incandescent Gloves
				{ 2,  227759 }, -- Scorched Core Gloves
				{ 3,  227756 }, -- Molten Scaled Gloves
				{ 16, 228285 }, -- Helm of the Lifegiver
				{ 17, 228247 }, -- Choker of Enlightenment
				{ 18, 228239 }, -- Robe of Volatile Power
				{ 19, 228246 }, -- Wristguards of Stability
				{ 20, 228244 }, -- Manastorm Leggings
				{ 21, 228245 }, -- Salamander Scale Pants
				{ 22, 228240 }, -- Flamewaker Legplates
				{ 23, 228242 }, -- Heavy Dark Iron Ring
				{ 24, 228243 }, -- Ring of Spell Power
				{ 25, 228262 }, -- Crimson Shocker
				{ 26, 228263 }, -- Sorcerous Dagger
				{ 27, 228127 }, -- Wristguards of Instability
				{ 30, 16665 }, -- Tome of Tranquilizing Shot
			},
		},
		{ --MCMagmadar
			name = AL["Magmadar"],
			npcID = 11982,
			Level = 999,
			DisplayIDs = { { 10193 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  227763 }, -- Scorched Core Leggings
				{ 2,  227534 }, -- Incandescent Leggings
				{ 3,  227754 }, -- Molten Scaled Leggings
				{ 5,  228146 }, -- Magmadar's Left Claw
				{ 6,  228101 }, -- Hide of the Behemoth
				{ 16, 228249 }, -- Medallion of Steadfast Might
				{ 17, 228258 }, -- Deep Earth Spaulders
				{ 18, 228257 }, -- Aged Core Leather Gloves
				{ 19, 228260 }, -- Flameguard Gauntlets
				{ 20, 228256 }, -- Mana Igniting Cord
				{ 21, 228240 }, -- Flamewaker Legplates
				{ 22, 228253 }, -- Sabatons of the Flamewalker
				{ 23, 228254 }, -- Magma Tempered Boots
				{ 24, 228261 }, -- Quick Strike Ring
				{ 25, 228255 }, -- Talisman of Ephemeral Power
				{ 26, 228259 }, -- Fire Runed Grimoire
				{ 27, 228252 }, -- Striker's Mark
				{ 28, 228248 }, -- Earthshaker
				{ 29, 228229 }, -- Obsidian Edged Blade
			},
		},
		{ --MCGehennas
			name = AL["Gehennas"],
			npcID = 12259,
			Level = 999,
			DisplayIDs = { { 13030 }, { 12002 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  227765 }, -- Scorched Core Boots
				{ 2,  227757 }, -- Molten Scaled Boots
				{ 3,  227536 }, -- Incandescent Boots
				{ 5,  228350 }, -- Eskhandar's Right Claw
				{ 16, 228285 }, -- Helm of the Lifegiver
				{ 17, 228239 }, -- Robe of Volatile Power
				{ 18, 228246 }, -- Wristguards of Stability
				{ 19, 228244 }, -- Manastorm Leggings
				{ 20, 228245 }, -- Salamander Scale Pants
				{ 21, 228240 }, -- Flamewaker Legplates
				{ 22, 228242 }, -- Heavy Dark Iron Ring
				{ 23, 228243 }, -- Ring of Spell Power
				{ 24, 228262 }, -- Crimson Shocker
				{ 25, 228263 }, -- Sorcerous Dagger
				{ 26, 228127 }, -- Wristguards of Instability
			},
		},
		{ --MCGarr
			name = AL["Garr"],
			npcID = 12057,
			Level = 999,
			DisplayIDs = { { 12110 }, { 5781 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  18564 }, -- Bindings of the Windseeker
				{ 3,  227532 }, -- Incandescent Hood
				{ 4,  227764 }, -- Scorched Core Helm
				{ 5,  227755 }, -- Molten Scaled Helm
				{ 7,  228139 }, -- Fist of the Firesworn
				{ 8,  228142 }, -- Earth and Fire
				{ 9,  228160 }, -- Faithbringer
				{ 16, 228258 }, -- Deep Earth Spaulders
				{ 17, 228257 }, -- Aged Core Leather Gloves
				{ 18, 228260 }, -- Flameguard Gauntlets
				{ 19, 228256 }, -- Mana Igniting Cord
				{ 20, 228240 }, -- Flamewaker Legplates
				{ 21, 228253 }, -- Sabatons of the Flamewalker
				{ 22, 228254 }, -- Magma Tempered Boots
				{ 23, 228261 }, -- Quick Strike Ring
				{ 24, 228255 }, -- Talisman of Ephemeral Power
				{ 25, 228259 }, -- Fire Runed Grimoire
				{ 26, 228266 }, -- Drillborer Disk
				{ 27, 228267 }, -- Gutgore Ripper
				{ 28, 228264 }, -- Aurastone Hammer
				{ 29, 228265 }, -- Brutality Blade
				{ 30, 228229 }, -- Obsidian Edged Blade
			},
		},
		{ --MCShazzrah
			name = AL["Shazzrah"],
			npcID = 12264,
			Level = 999,
			DisplayIDs = { { 13032 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  227531 }, -- Incandescent Bindings
				{ 2,  227760 }, -- Scorched Core Bindings
				{ 3,  227750 }, -- Molten Scaled Bindings
				{ 5,  "INV_Box_01", nil, AL["Heat 3 Only"], nil },
				{ 6,  228286 }, -- Band of Accuria
				{ 16, 228285 }, -- Helm of the Lifegiver
				{ 17, 228239 }, -- Robe of Volatile Power
				{ 18, 228246 }, -- Wristguards of Stability
				{ 19, 228244 }, -- Manastorm Leggings
				{ 20, 228245 }, -- Salamander Scale Pants
				{ 21, 228240 }, -- Flamewaker Legplates
				{ 22, 228242 }, -- Heavy Dark Iron Ring
				{ 23, 228243 }, -- Ring of Spell Power
				{ 24, 228262 }, -- Crimson Shocker
				{ 25, 228263 }, -- Sorcerous Dagger
				{ 26, 228127 }, -- Wristguards of Instability
				{ 27, 228253 }, -- Sabatons of the Flamewalker
			},
		},
		{ --MCGeddon
			name = AL["Baron Geddon"],
			npcID = 12056,
			Level = 999,
			DisplayIDs = { { 12129 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  18563 }, -- Bindings of the Windseeker
				{ 3,  227530 }, -- Incandescent Belt
				{ 4,  227761 }, -- Scorched Core Belt
				{ 5,  227751 }, -- Molten Scaled Belt
				{ 16, 228258 }, -- Deep Earth Spaulders
				{ 17, 228257 }, -- Aged Core Leather Gloves
				{ 18, 228260 }, -- Flameguard Gauntlets
				{ 19, 228256 }, -- Mana Igniting Cord
				{ 20, 228240 }, -- Flamewaker Legplates
				{ 21, 228253 }, -- Sabatons of the Flamewalker
				{ 22, 228254 }, -- Magma Tempered Boots
				{ 23, 228261 }, -- Quick Strike Ring
				{ 24, 228268 }, -- Seal of the Archmagus
				{ 25, 228255 }, -- Talisman of Ephemeral Power
				{ 26, 228259 }, -- Fire Runed Grimoire
				{ 27, 228229 }, -- Obsidian Edged Blade
				{ 28, 228139 }, -- Fist of the Firesworn
				{ 29, 228142 }, -- Earth and Fire
				{ 30, 228160 }, -- Faithbringer
			},
		},
		{ --MCGolemagg
			name = AL["Golemagg the Incinerator"],
			npcID = 11988,
			Level = 999,
			DisplayIDs = { { 11986 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,   17203 }, -- Sulfuron Ingot
				{ 2,   228137 }, -- Heart of Golemagg
				{ 3,   228147 }, -- Magmadar's Horn
				{ 4,   228258 }, -- Deep Earth Spaulders
				{ 5,   228257 }, -- Aged Core Leather Gloves
				{ 6,   228260 }, -- Flameguard Gauntlets
				{ 7,   228256 }, -- Mana Igniting Cord
				{ 8,   228240 }, -- Flamewaker Legplates
				{ 9,   228253 }, -- Sabatons of the Flamewalker
				{ 10,  228254 }, -- Magma Tempered Boots
				{ 11,  228261 }, -- Quick Strike Ring
				{ 12,  228255 }, -- Talisman of Ephemeral Power
				{ 13,  228259 }, -- Fire Runed Grimoire
				{ 14,  228270 }, -- Blastershot Launcher
				{ 15,  228269 }, -- Azuresong Mageblade
				{ 16,  228229 }, -- Obsidian Edged Blade
				{ 17,  228271 }, -- Staff of Dominance
				{ 19,  "INV_Box_01", nil, AL["Heat 3 Only"], nil },
				{ 20,  228290 }, -- Cloak of the Shrouded Mists
				{ 21,  228289 }, -- Choken of the Fire Lord
				{ 23,  227535 }, -- Incandescent Robe
				{ 24,  227766 }, -- Scorched Core Chest
				{ 25,  227758 }, -- Molten Scaled Chest
				{ 27,  227537 }, -- Incandescent Shoulderpads
				{ 28,  227752 }, -- Molten Scaled Shoulderpads
				{ 29,  227762 }, -- Scorched Core Shoulderpads
				{ 101, 227533 }, -- Incandescent Gloves
				{ 102, 227756 }, -- Molten Scaled Gloves
				{ 103, 227759 }, -- Scorched Core Gloves
				{ 105, 227531 }, -- Incandescent Bindings
				{ 106, 227750 }, -- Molten Scaled Bindings
				{ 107, 227760 }, -- Scorched Core Bindings
				{ 109, 227530 }, -- Incandescent Belt
				{ 110, 227751 }, -- Molten Scaled Belt
				{ 111, 227761 }, -- Scorched Core Belt
				{ 116, 227534 }, -- Incandescent Leggings
				{ 117, 227754 }, -- Molten Scaled Leggings
				{ 118, 227763 }, -- Scorched Core Leggings
				{ 120, 227536 }, -- Incandescent Boots
				{ 121, 227757 }, -- Molten Scaled Boots
				{ 122, 227765 }, -- Scorched Core Boots
				{ 124, 227532 }, -- Incandescent Hood
				{ 125, 227764 }, -- Scorched Core Helm
				{ 126, 227755 }, -- Molten Scaled Helm
			},
		},
		{ -- MCSulfuron
			name = AL["Sulfuron Harbinger"],
			npcID = 12098,
			Level = 999,
			DisplayIDs = { { 13030 }, { 12030 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,   17203 }, -- Sulfuron Ingot
				{ 3,   18870 }, -- Helm of the Lifegiver
				{ 4,   228239 }, -- Robe of Volatile Power
				{ 5,   228246 }, -- Wristguards of Stability
				{ 6,   228244 }, -- Manastorm Leggings
				{ 7,   228245 }, -- Salamander Scale Pants
				{ 8,   228240 }, -- Flamewaker Legplates
				{ 9,   228242 }, -- Heavy Dark Iron Ring
				{ 10,  228243 }, -- Ring of Spell Power
				{ 11,  228262 }, -- Crimson Shocker
				{ 12,  228263 }, -- Sorcerous Dagger
				{ 13,  228272 }, -- Shadowstrike
				{ 14,  228127 }, -- Wristguards of Instability
				{ 15,  228128 }, -- Hammer of the Black Anvil
				{ 16,  228260 }, -- Flameguard Gauntlets
				{ 17,  228292 }, -- Dragon's Blood Cape
				{ 19,  "INV_Box_01", nil, AL["Heat 2+"], nil },
				{ 20,  228295 }, -- Onslaught Girdle
				{ 22,  227535 }, -- Incandescent Robe
				{ 23,  227766 }, -- Scorched Core Chest
				{ 24,  227758 }, -- Molten Scaled Chest
				{ 26,  227537 }, -- Incandescent Shoulderpads
				{ 27,  227752 }, -- Molten Scaled Shoulderpads
				{ 28,  227762 }, -- Scorched Core Shoulderpads
				{ 101, 227533 }, -- Incandescent Gloves
				{ 102, 227756 }, -- Molten Scaled Gloves
				{ 103, 227759 }, -- Scorched Core Gloves
				{ 105, 227531 }, -- Incandescent Bindings
				{ 106, 227750 }, -- Molten Scaled Bindings
				{ 109, 227530 }, -- Incandescent Belt
				{ 110, 227751 }, -- Molten Scaled Belt
				{ 111, 227761 }, -- Scorched Core Belt
				{ 116, 227534 }, -- Incandescent Leggings
				{ 117, 227754 }, -- Molten Scaled Leggings
				{ 118, 227763 }, -- Scorched Core Leggings
				{ 120, 227536 }, -- Incandescent Boots
				{ 121, 227757 }, -- Molten Scaled Boots
				{ 122, 227765 }, -- Scorched Core Boots
				{ 124, 227532 }, -- Incandescent Hood
				{ 125, 227764 }, -- Scorched Core Helm
				{ 126, 227755 }, -- Molten Scaled Helm
			},
		},
		{ -- MCMajordomo
			name = AL["Majordomo Executus"],
			npcID = 12018,
			Level = 999,
			ObjectID = 179703,
			DisplayIDs = { { 12029 }, { 13029 }, { 12002 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,   17203 }, -- Sulfuron Ingot
				{ 2,   228279 }, -- Fireguard Shoulders
				{ 3,   228283 }, -- Wild Growth Spaulders
				{ 4,   228280 }, -- Fireproof Cloak
				{ 5,   228281 }, -- Gloves of the Hypnotic Flame
				{ 6,   228282 }, -- Sash of Whispered Secrets
				{ 7,   228284 }, -- Wristguards of True Flight
				{ 8,   228275 }, -- Core Forged Greaves
				{ 9,   228274 }, -- Cauterizing Band
				{ 10,  228102 }, -- Majordomo's Drape
				{ 11,  228277 }, -- Core Hound Tooth
				{ 12,  228278 }, -- Hyperthermically Insulated Lava Dredger
				{ 16,  18703 }, -- Ancient Petrified Leaf
				{ 17,  18646 }, -- The Eye of Divinity
				{ 18,  228129 }, -- Shadowflame Skull
				{ 20,  "INV_Box_01", nil, AL["Heat 3 Only"], nil },
				{ 21,  228461 }, -- Bonereaver's Edge
				{ 22,  228296 }, -- Perdition's Blade (Gutgore Ripper)
				{ 23,  227535 }, -- Incandescent Robe
				{ 24,  227766 }, -- Scorched Core Chest
				{ 25,  227758 }, -- Molten Scaled Chest
				{ 27,  227537 }, -- Incandescent Shoulderpads
				{ 28,  227752 }, -- Molten Scaled Shoulderpads
				{ 29,  227762 }, -- Scorched Core Shoulderpads
				{ 101, 227533 }, -- Incandescent Gloves
				{ 102, 227756 }, -- Molten Scaled Gloves
				{ 103, 227759 }, -- Scorched Core Gloves
				{ 105, 227531 }, -- Incandescent Bindings
				{ 106, 227750 }, -- Molten Scaled Bindings
				{ 107, 227760 }, -- Scorched Core Bindings
				{ 109, 227530 }, -- Incandescent Belt
				{ 110, 227751 }, -- Molten Scaled Belt
				{ 111, 227761 }, -- Scorched Core Belt
				{ 116, 227534 }, -- Incandescent Leggings
				{ 117, 227754 }, -- Molten Scaled Leggings
				{ 118, 227763 }, -- Scorched Core Leggings
				{ 120, 227536 }, -- Incandescent Boots
				{ 121, 227757 }, -- Molten Scaled Boots
				{ 122, 227765 }, -- Scorched Core Boots
				{ 124, 227532 }, -- Incandescent Hood
				{ 125, 227764 }, -- Scorched Core Helm
				{ 126, 227755 }, -- Molten Scaled Helm
			},
		},
		{ -- MCRagnaros
			name = AL["Ragnaros"],
			npcID = 11502,
			Level = 999,
			DisplayIDs = { { 11121 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,   227728 }, -- Eye of Sulfuras
				{ 2,   19017 }, -- Essence of the Firelord
				{ 3,   17203 }, -- Sulfuron Ingot
				{ 5,   228289 }, -- Choker of the Firelord
				{ 6,   228297 }, -- Shard of the Flame
				{ 7,   228291 }, -- Crown of Destruction
				{ 8,   228290 }, -- Cloak of the Shrouded Mists
				{ 9,   228292 }, -- Dragon's Blood Cape
				{ 10,  228295 }, -- Onslaught Girdle
				{ 11,  228286 }, -- Band of Accuria
				{ 12,  228287 }, -- Band of Sulfuras
				{ 13,  228266 }, -- Essence of the Pure Flame (Drillborer Disk)
				{ 14,  228294 }, -- Malistar's Defender
				{ 15,  228293 }, -- Essence of the Pure Flame
				{ 16,  228296 }, -- Perdition's Blade (Gutgore Ripper)
				{ 17,  228299 }, -- Spinal Reaper
				{ 18,  228288 }, -- Bonereaver's Edge
				{ 20,  227535 }, -- Incandescent Robe
				{ 21,  227766 }, -- Scorched Core Chest
				{ 22,  227758 }, -- Molten Scaled Chest
				{ 24,  227537 }, -- Incandescent Shoulderpads
				{ 25,  227752 }, -- Molten Scaled Shoulderpads
				{ 26,  227762 }, -- Scorched Core Shoulderpads
				{ 101, 227533 }, -- Incandescent Gloves
				{ 102, 227756 }, -- Molten Scaled Gloves
				{ 103, 227759 }, -- Scorched Core Gloves
				{ 105, 227531 }, -- Incandescent Bindings
				{ 106, 227750 }, -- Molten Scaled Bindings
				{ 107, 227760 }, -- Scorched Core Bindings
				{ 109, 227530 }, -- Incandescent Belt
				{ 110, 227751 }, -- Molten Scaled Belt
				{ 111, 227761 }, -- Scorched Core Belt
				{ 116, 227534 }, -- Incandescent Leggings
				{ 117, 227754 }, -- Molten Scaled Leggings
				{ 118, 227763 }, -- Scorched Core Leggings
				{ 120, 227536 }, -- Incandescent Boots
				{ 121, 227757 }, -- Molten Scaled Boots
				{ 122, 227765 }, -- Scorched Core Boots
				{ 124, 227532 }, -- Incandescent Hood
				{ 125, 227764 }, -- Scorched Core Helm
				{ 126, 227755 }, -- Molten Scaled Helm
			},
		},
		{ -- MCTheMoltenCore
			name = AL["The Molten Core"],
			npcID = 227959,
			Level = 999,
			[NORMAL_DIFF] = {
				{ 1,   227728 }, -- Eye of Sulfuras
				{ 2,   18563 }, -- Bindings of the Windseeker
				{ 3,   18564 }, -- Bindings of the Windseeker
				{ 5,   228286 }, -- Band of Accuria
				{ 6,   228287 }, -- Band of Sulfuras
				{ 7,   228296 }, -- Perdition's Blade
				{ 8,   228288 }, -- Bonereaver's Edge
				{ 9,   228299 }, -- Spinal Reaper
				{ 16,  227535 }, -- Incandescent Robe
				{ 17,  227766 }, -- Scorched Core Chest
				{ 18,  227758 }, -- Molten Scaled Chest
				{ 20,  227537 }, -- Incandescent Shoulderpads
				{ 21,  227752 }, -- Molten Scaled Shoulderpads
				{ 22,  227762 }, -- Scorched Core Shoulderpads
				{ 24,  227532 }, -- Incandescent Hood
				{ 25,  227764 }, -- Scorched Core Helm
				{ 26,  227755 }, -- Molten Scaled Helm
				{ 101, 227533 }, -- Incandescent Gloves
				{ 102, 227756 }, -- Molten Scaled Gloves
				{ 103, 227759 }, -- Scorched Core Gloves
				{ 105, 227531 }, -- Incandescent Bindings
				{ 106, 227750 }, -- Molten Scaled Bindings
				{ 107, 227760 }, -- Scorched Core Bindings
				{ 109, 227530 }, -- Incandescent Belt
				{ 110, 227751 }, -- Molten Scaled Belt
				{ 111, 227761 }, -- Scorched Core Belt
				{ 116, 227534 }, -- Incandescent Leggings
				{ 117, 227754 }, -- Molten Scaled Leggings
				{ 118, 227763 }, -- Scorched Core Leggings
				{ 120, 227536 }, -- Incandescent Boots
				{ 121, 227757 }, -- Molten Scaled Boots
				{ 122, 227765 }, -- Scorched Core Boots
			},
		},
		{ -- MCRANDOMBOSSDROPS
			name = AL["All bosses"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  18264 }, -- Plans: Elemental Sharpening Stone
				{ 3,  18292 }, -- Schematic: Core Marksman Rifle
				{ 4,  18291 }, -- Schematic: Force Reactive Disk
				{ 5,  18290 }, -- Schematic: Biznicks 247x128 Accurascope
				{ 7,  18259 }, -- Formula: Enchant Weapon - Spell Power
				{ 8,  18260 }, -- Formula: Enchant Weapon - Healing Power
				{ 16, 18252 }, -- Pattern: Core Armor Kit
				{ 18, 18265 }, -- Pattern: Flarecore Wraps
				{ 19, 21371 }, -- Pattern: Core Felcloth Bag
				{ 21, 18257 }, -- Recipe: Major Rejuvenation Potion
			},
		},
		{ -- MCTrashMobs
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 17011 }, -- Lava Core
				{ 2, 17010 }, -- Fiery Core
				{ 3, 11382 }, -- Blood of the Mountain
				{ 4, 17012 }, -- Core Leather
			},
		},
		T1_SET,
	}
}

data["Onyxia"] = {
	MapID = 2159,
	InstanceID = 249,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Onyxia",
	AtlasMapFile = "CL_OnyxiasLair",
	AtlasMapFile_AL = "OnyxiasLair",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	items = {
		{ -- Onyxia
			name = AL["Onyxia"],
			npcID = 10184,
			Level = 999,
			DisplayIDs = { { 8570 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,   [ATLASLOOT_IT_HORDE] = 228689, [ATLASLOOT_IT_ALLIANCE] = 228688 }, -- Head of Onyxia
				{ 2,   18705 },                                               -- Mature Black Dragon Sinew
				{ 3,   228759 },                                              -- Eskhandar's Collar
				{ 4,   17078 },                                               -- Sapphiron Drape
				{ 5,   18813 },                                               -- Ring of Binding
				{ 6,   228298 },                                              -- Shard of the Scale
				{ 7,   228955 },                                              -- Ancient Cornerstone Grimoire
				{ 8,   17068 },                                               -- Deathbringer
				{ 9,   17075 },                                               -- Vis'kag the Bloodletter
				{ 10,  228166 },                                              -- Key to the City
				{ 11,  228162 },                                              -- Deceit
				{ 12,  228165 },                                              -- Dragonslayer's Javelin
				{ 13,  228163 },                                              -- Broodmother's Brooch
				{ 14,  228188 },                                              -- Prestor's Hairpin
				{ 15,  228992 },                                              -- Onyxia Hide Backpack
				{ 16,  15410 },                                               -- Scale of Onyxia
				{ 17,  11938 },                                               -- Sack of Gems
				{ 19,  227535 },                                              -- Incandescent Robe
				{ 20,  227766 },                                              -- Scorched Core Chest
				{ 21,  227758 },                                              -- Molten Scaled Chest
				{ 23,  227537 },                                              -- Incandescent Shoulderpads
				{ 24,  227752 },                                              -- Molten Scaled Shoulderpads
				{ 25,  227762 },                                              -- Scorched Core Shoulderpads
				{ 27,  227532 },                                              -- Incandescent Hood
				{ 28,  227764 },                                              -- Scorched Core Helm
				{ 29,  227755 },                                              -- Molten Scaled Helm
				{ 101, 227533 },                                              -- Incandescent Gloves
				{ 102, 227756 },                                              -- Molten Scaled Gloves
				{ 103, 227759 },                                              -- Scorched Core Gloves
				{ 105, 227531 },                                              -- Incandescent Bindings
				{ 106, 227750 },                                              -- Molten Scaled Bindings
				{ 107, 227760 },                                              -- Scorched Core Bindings
				{ 109, 227530 },                                              -- Incandescent Belt
				{ 110, 227751 },                                              -- Molten Scaled Belt
				{ 111, 227761 },                                              -- Scorched Core Belt
				{ 116, 227534 },                                              -- Incandescent Leggings
				{ 117, 227754 },                                              -- Molten Scaled Leggings
				{ 118, 227763 },                                              -- Scorched Core Leggings
				{ 120, 227536 },                                              -- Incandescent Boots
				{ 121, 227757 },                                              -- Molten Scaled Boots
				{ 122, 227765 },                                              -- Scorched Core Boots
				-- Hidden items
				{ 0,   17962 },                                               -- Blue Sack of Gems
				{ 0,   17963 },                                               -- Green Sack of Gems
				{ 0,   17964 },                                               -- Gray Sack of Gems
				{ 0,   17965 },                                               -- Yellow Sack of Gems
				{ 0,   17969 },                                               -- Red Sack of Gems
			},
		},
	},
}

data["Zul'Gurub"] = {
	MapID = 1977,
	InstanceID = 309,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Zul'Gurub", -- ??
	AtlasMapFile = "CL_ZulGurub",
	AtlasMapFile_AL = "ZulGurub",
	ContentType = RAID20_CONTENT,
	LoadDifficulty = RAID20_DIFF,
	ContentPhase = 4,
	items = {
		{ -- ZGJeklik
			name = AL["High Priestess Jeklik"],
			npcID = 14517,
			Level = 999,
			DisplayIDs = { { 15219 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 230911 }, -- Jeklik's Crusher
				{ 18, 230913 }, -- Jeklik's Opaline Talisman
				{ 19, 230912 }, -- Animist's Spaulders
				{ 20, 230916 }, -- Seafury Boots
				{ 21, 230914 }, -- Peacekeeper Boots
				{ 22, 230915 }, -- Primalist's Band
				{ 23, 232299 }, -- Zulian Defender
			},
		},
		{ -- ZGVenoxis
			name = AL["High Priest Venoxis"],
			npcID = 14507,
			Level = 999,
			DisplayIDs = { { 15217 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 230864 }, -- Runed Bloodstained Hauberk
				{ 17, 230865 }, -- Fang of Venoxis
				{ 19, 232311 }, -- Zulian Tigerhide Cloak
				{ 20, 230866 }, -- Blooddrenched Footpads
				{ 21, 230867 }, -- Zanzil's Band
				{ 22, 230868 }, -- Zulian Stone Axe
			},
		},
		{ -- ZGMarli
			name = AL["High Priestess Mar'li"],
			npcID = 14510,
			Level = 999,
			DisplayIDs = { { 15220 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 230917 }, -- Flowing Ritual Robes
				{ 17, 230918 }, -- Mar'li's Touch
				{ 19, 230922 }, -- Talisman of Protection
				{ 20, 230919 }, -- Bloodstained Greaves
				{ 21, 230921 }, -- Band of Jin
				{ 22, 230920 }, -- Mar'li's Eye
			},
		},
		{ -- ZGMandokir
			name = AL["Bloodlord Mandokir"],
			npcID = 11382,
			Level = 999,
			DisplayIDs = { { 11288 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 19872 }, -- Swift Razzashi Raptor
				{ 17, 230993 }, -- Mandokir's Sting
				{ 18, 230989 }, -- Bloodlord's Defender
				{ 19, 230992 }, -- Warblade of the Hakkari
				{ 20, 230991 }, -- Halberd of Smiting
				{ 22, 230996 }, -- Bloodsoaked Pauldrons
				{ 23, 230998 }, -- Hakkari Loa Cloak
				{ 24, 230995 }, -- Blooddrenched Grips
				{ 25, 230997 }, -- Bloodtinged Kilt
				{ 26, 230994 }, -- Animist's Leggings
				{ 27, 230999 }, -- Overlord's Crimson Band
				{ 28, 231000 }, -- Primalist's Seal
				{ 29, 231001 }, -- Zanzil's Seal
			},
		},
		{ -- ZGGrilek
			name = AL["Gri'lek"],
			npcID = 15082,
			Level = 999,
			DisplayIDs = { { 8390 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 231274 }, -- Gri'lek's Grinder
				{ 2, 231273 }, -- Gri'lek's Carver
				{ 4, 19939 }, -- Gri'lek's Blood
			},
		},
		{ -- ZGHazzarah
			name = AL["Hazza'rah"],
			npcID = 15083,
			Level = 999,
			DisplayIDs = { { 15267 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 231276 }, -- Thoughtblighter
				{ 2, 231275 }, -- Fiery Retributer
				{ 4, 19942 }, -- Hazza'rah's Dream Thread
			},
		},
		{ -- ZGRenataki
			name = AL["Renataki"],
			npcID = 15084,
			Level = 999,
			DisplayIDs = { { 15268 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 232309 }, -- Renataki's Soul Conduit
				{ 2, 231277 }, -- Pitchfork of Madness
				{ 4, 19940 }, -- Renataki's Tooth
			},
		},
		{ -- ZGWushoolay
			name = AL["Wushoolay"],
			npcID = 15085,
			Level = 999,
			DisplayIDs = { { 15269 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1, 231278 }, -- Hoodoo Hunting Bow
				{ 2, 231279 }, -- Wushoolay's Poker
				{ 4, 19941 }, -- Wushoolay's Mane
			},
		},
		{ -- ZGGahzranka
			name = AL["Gahz'ranka"],
			npcID = 15114,
			Level = 999,
			DisplayIDs = { { 15288 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1, 231014 }, -- Foror's Eyepatch
				{ 2, 231016 }, -- Nat Pagle's Fish Terminator
				{ 4, 231271 }, -- Nat Pagle's Broken Reel
				{ 5, 231272 }, -- Tigule's Harpoon
				{ 7, 22739 }, -- Tome of Polymorph: Turtle
			},
		},
		{ -- ZGThekal
			name = AL["High Priest Thekal"],
			npcID = 14509,
			Level = 999,
			DisplayIDs = { { 15216 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 19902 }, -- Swift Zulian Tiger
				{ 17, 230923 }, -- Betrayer's Boots
				{ 18, 230925 }, -- Thekal's Grasp
				{ 20, 230927 }, -- Ritualistic Legguards
				{ 21, 230928 }, -- Seafury Leggings
				{ 22, 230926 }, -- Peacekeeper Leggings
				{ 23, 230929 }, -- Seal of Jin
				{ 24, 230930 }, -- Zulian Slicer
			},
		},
		{ -- ZGArlokk
			name = AL["High Priestess Arlokk"],
			npcID = 14515,
			Level = 999,
			DisplayIDs = { { 15218 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 16, 230934 }, -- Arlokk's Grasp
				{ 17, 230939 }, -- Will of Arlokk
				{ 19, 230942 }, -- Bloodsoaked Greaves
				{ 20, 230943 }, -- Overlord's Onyx Band
				{ 21, 230941 }, -- Arlokk's Hoodoo Stick
				{ 23, 19914 }, -- Panther Hide Sack
			},
		},
		{ -- ZGJindo
			name = AL["Jin'do the Hexxer"],
			npcID = 11380,
			Level = 999,
			DisplayIDs = { { 11311 } },
			AtlasMapBossID = 10,
			[NORMAL_DIFF] = {
				{ 1,  19721 }, -- Primal Hakkari Shawl
				{ 2,  19724 }, -- Primal Hakkari Aegis
				{ 3,  19723 }, -- Primal Hakkari Kossack
				{ 4,  19722 }, -- Primal Hakkari Tabard
				{ 5,  19717 }, -- Primal Hakkari Armsplint
				{ 6,  19716 }, -- Primal Hakkari Bindings
				{ 7,  19718 }, -- Primal Hakkari Stanchion
				{ 8,  19719 }, -- Primal Hakkari Girdle
				{ 9,  19720 }, -- Primal Hakkari Sash
				{ 11, 22637 }, -- Primal Hakkari Idol
				{ 16, 231003 }, -- Jin'do's Evil Eye
				{ 17, 231005 }, -- Jin'do's Bag of Whammies
				{ 18, 231002 }, -- Jin'do's Hexxer
				{ 19, 231004 }, -- Jin'do's Judgement
				{ 21, 231013 }, -- The Hexxer's Cover
				{ 22, 231007 }, -- Bloodstained Coif
				{ 23, 231012 }, -- Overlord's Embrace
				{ 24, 231011 }, -- Bloodtinged Gloves
				{ 25, 231010 }, -- Bloodsoaked Gauntlets
				{ 26, 231009 }, -- Blooddrenched Leggings
				{ 27, 231008 }, -- Bloodstained Legplates
				{ 28, 231006 }, -- Animist's Boots
			},
		},
		{ -- ZGHakkar
			name = AL["Hakkar"],
			npcID = 14834,
			Level = 999,
			DisplayIDs = { { 15295 } },
			AtlasMapBossID = 11,
			[NORMAL_DIFF] = {
				{ 1,  231300 },                       -- Cloak of Consumption
				{ 2,  231305, [ATLASLOOT_IT_ALLIANCE] = 231303 }, -- Seafury Gauntlets / Peacekeeper Gauntlets
				{ 3,  231299 },                       -- Bloodsoaked Legplates
				{ 4,  231306 },                       -- Soul Corrupter's Necklace
				{ 5,  231307 },                       -- The Eye of Hakkar
				{ 7,  19802 },                        -- Heart of Hakkar
				{ 16, 231308 },                       -- Touch of Chaos
				{ 17, 231302 },                       -- Gurubashi Dwarf Destroyer
				{ 18, 231289 },                       -- Aegis of the Blood God
				{ 19, 231296 },                       -- Bloodcaller
				{ 20, 231309 },                       -- Warblade of the Hakkari
				{ 21, 230992 },                       -- Warblade of the Hakkari
				{ 22, 231293 },                       -- Ancient Hakkari Manslayer
				{ 23, 231301 },                       -- Fang of the Faceless
				{ 24, 231315 },                       -- Zin'rokh, Destroyer of Worlds
			},
		},
		{ -- ZGShared
			name = AL["High Priest Shared loot"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  230854 }, -- Band of Servitude
				{ 2,  230855 }, -- Seal of the Gurubashi Berserker
				{ 4,  230862 }, -- Zulian Headdress
				{ 5,  230857 }, -- Blooddrenched Mask
				{ 6,  230858 }, -- Cloak of the Hakkari Worshipers
				{ 7,  230860 }, -- Might of the Tribe
				{ 8,  230859 }, -- Gloves of the Tormented
				{ 9,  230861 }, -- Sacrificial Gauntlets
				{ 10, 230856 }, -- Belt of Untapped Power
				{ 11, 230863 }, -- Zulian Scepter of Rites
			},
		},
		{ -- ZGTrash1
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  20263 }, -- Gurubashi Helm
				{ 2,  20259 }, -- Shadow Panther Hide Gloves
				{ 3,  20261 }, -- Shadow Panther Hide Belt
				{ 4,  19921 }, -- Zulian Hacker
				{ 5,  19908 }, -- Sceptre of Smiting
				{ 16, 20258 }, -- Zulian Ceremonial Staff
				{ 17, 19726 }, -- Bloodvine
				{ 18, 19774 }, -- Souldarite
				{ 19, 19767 }, -- Primal Bat Leather
				{ 20, 19768 }, -- Primal Tiger Leather
				{ 7,  19706 }, -- Bloodscalp Coin
				{ 8,  19701 }, -- Gurubashi Coin
				{ 9,  19700 }, -- Hakkari Coin
				{ 10, 19699 }, -- Razzashi Coin
				{ 11, 19704 }, -- Sandfury Coin
				{ 12, 19705 }, -- Skullsplitter Coin
				{ 13, 19702 }, -- Vilebranch Coin
				{ 14, 19703 }, -- Witherbark Coin
				{ 15, 19698 }, -- Zulian Coin
				{ 22, 19708 }, -- Blue Hakkari Bijou
				{ 23, 19713 }, -- Bronze Hakkari Bijou
				{ 24, 19715 }, -- Gold Hakkari Bijou
				{ 25, 19711 }, -- Green Hakkari Bijou
				{ 26, 19710 }, -- Orange Hakkari Bijou
				{ 27, 19712 }, -- Purple Hakkari Bijou
				{ 28, 19707 }, -- Red Hakkari Bijou
				{ 29, 19714 }, -- Silver Hakkari Bijou
				{ 30, 19709 }, -- Yellow Hakkari Bijou
			},
		},
		{ -- ZGEnchants
			name = AL["Enchants"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  19789 }, -- Prophetic Aura
				{ 2,  19787 }, -- Presence of Sight
				{ 3,  19788 }, -- Hoodoo Hex
				{ 4,  19784 }, -- Death's Embrace
				{ 5,  19790 }, -- Animist's Caress
				{ 6,  19785 }, -- Falcon's Call
				{ 7,  19786 }, -- Vodouisant's Vigilant Embrace
				{ 8,  19783 }, -- Syncretist's Sigil
				{ 9,  19782 }, -- Presence of Might
				{ 16, 20077 }, -- Zandalar Signet of Might
				{ 17, 20076 }, -- Zandalar Signet of Mojo
				{ 18, 20078 }, -- Zandalar Signet of Serenity
				{ 20, 22635 }, -- Savage Guard
			},
		},
		{ -- ZGMuddyChurningWaters
			name = AL["Muddy Churning Waters"],
			ExtraList = true,
			AtlasMapBossID = "1'",
			[NORMAL_DIFF] = {
				{ 1, 19975 }, -- Zulian Mudskunk
			},
		},
		{ -- ZGJinxedHoodooPile
			name = AL["Jinxed Hoodoo Pile"],
			ExtraList = true,
			AtlasMapBossID = "2'",
			[NORMAL_DIFF] = {
				{ 1,  19727 }, -- Blood Scythe
				{ 3,  19820 }, -- Punctured Voodoo Doll
				{ 4,  19818 }, -- Punctured Voodoo Doll
				{ 5,  19819 }, -- Punctured Voodoo Doll
				{ 6,  19814 }, -- Punctured Voodoo Doll
				{ 7,  19821 }, -- Punctured Voodoo Doll
				{ 8,  19816 }, -- Punctured Voodoo Doll
				{ 9,  19817 }, -- Punctured Voodoo Doll
				{ 10, 19815 }, -- Punctured Voodoo Doll
				{ 11, 19813 }, -- Punctured Voodoo Doll
			},
		},
	},
}

data["BlackwingLair"] = {
	MapID = 2677,
	InstanceID = 469,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "BlackwingLair",
	AtlasMapFile = "CL_BlackwingLair",
	AtlasMapFile_AL = "BlackwingLair",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 3,
	items = {
		{ -- BWLRazorgore
			name = AL["Razorgore the Untamed"],
			npcID = 12435,
			Level = 999,
			DisplayIDs = { { 10115 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  231729 }, -- Ancient Gloves
				{ 2,  231720 }, -- Primeval Gloves
				{ 3,  231712 }, -- Draconian Gloves
				{ 5,  231722 }, -- Depleted Scythe of Chaos
				{ 6,  229352 }, -- Intelligence Findings
				{ 16, 230237 }, -- Arcane Infused Gem
				{ 17, 230238 }, -- The Black Book
				{ 19, 230240 }, -- Mantle of the Blackwing Cabal
				{ 20, 230239 }, -- Gloves of Rapid Evolution
				{ 21, 230241 }, -- Spineshatter
				{ 22, 230242 }, -- The Untamed Blade
			},
		},
		{ -- BWLVaelastrasz
			name = AL["Vaelastrasz the Corrupt"],
			npcID = 13020,
			Level = 999,
			DisplayIDs = { { 13992 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  231727 }, -- Ancient Leggings
				{ 2,  231718 }, -- Primeval Leggings
				{ 3,  231710 }, -- Draconian Leggings
				{ 5,  230243 }, -- Mind Quickening Gem
				{ 7,  230904 }, -- Scroll: SEENECS FO RIEF
				{ 8,  231378 }, -- Shimmering Golden Disk
				{ 16, 230244 }, -- Shapeshifter's Sigil
				{ 17, 230246 }, -- Helm of Endless Rage
				{ 18, 230245 }, -- Pendant of the Fallen Dragon
				{ 19, 230248 }, -- Red Dragonscale Protector
				{ 20, 230247 }, -- Dragonfang Blade
				{ 21, 230848 }, -- Interlaced Shadow Jerkin
				{ 22, 230843 }, -- Boots of Pure Thought
				{ 23, 230849 }, -- Ringo's Blizzard Boots
				{ 24, 230846 }, -- Band of Dark Dominion
				{ 25, 230845 }, -- Doom's Edge
				{ 26, 232357 }, -- Draconic Avenger
			},
		},
		{ -- BWLLashlayer
			name = AL["Broodlord Lashlayer"],
			npcID = 12017,
			Level = 999,
			DisplayIDs = { { 14308 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  231730 }, -- Ancient Boots
				{ 2,  231721 }, -- Primeval Boots
				{ 3,  231713 }, -- Draconian Boots
				{ 5,  231452 }, -- Blood of the Lightbringer
				{ 6,  231882 }, -- Suppression Device Receipt
				{ 7,  231995 }, -- Hardened Elementium Slag
				{ 16, 230249 }, -- Lifegiving Gem
				{ 17, 230250 }, -- Venomous Totem
				{ 19, 230251 }, -- Black Brood Pauldrons
				{ 20, 230252 }, -- Bracers of Arcane Accuracy
				{ 21, 230253 }, -- Heartstriker
				{ 22, 230254 }, -- Maladath, Runed Blade of the Black Flight
				{ 24, 20383 }, -- Head of the Broodlord Lashlayer
			},
		},
		{ -- BWLFiremaw
			name = AL["Firemaw"],
			npcID = 11983,
			Level = 999,
			DisplayIDs = { { 6377 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  231727 }, -- Ancient Leggings
				{ 2,  231718 }, -- Primeval Leggings
				{ 3,  231710 }, -- Draconian Leggings
				{ 5,  230273 }, -- Natural Alignment Crystal
				{ 6,  230272 }, -- Scrolls of Blinding Light
				{ 7,  230282 }, -- Drake Fang Talisman
				{ 9,  230847 }, -- Essence Gatherer
				{ 10, 230844 }, -- Draconic Maul
				{ 11, 230276 }, -- Claw of the Black Drake
				{ 12, 230270 }, -- Shadow Wing Focus Staff
				{ 16, 230256 }, -- Drake Talon Pauldrons
				{ 17, 230277 }, -- Cloak of Firemaw
				{ 18, 230274 }, -- Black Ash Robe
				{ 19, 230275 }, -- Firemaw's Clutch
				{ 20, 230255 }, -- Taut Dragonhide Belt
				{ 21, 230279 }, -- Primalist's Linked Legguards
				{ 22, 230278 }, -- Legguards of the Fallen Crusader
				{ 23, 230842 }, -- Cloak of Draconic Might
				{ 25, 230257 }, -- Ring of Blackrock
				{ 26, 230269 }, -- Rejuvenating Gem
			},
		},
		{ -- BWLEbonroc
			name = AL["Ebonroc"],
			npcID = 14601,
			Level = 999,
			DisplayIDs = { { 6377 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  231728 }, -- Ancient Helm
				{ 2,  231719 }, -- Primeval Helm
				{ 3,  231711 }, -- Draconian Hood
				{ 5,  230280 }, -- Aegis of Preservation
				{ 7,  230269 }, -- Rejuvenating Gem
				{ 16, 230256 }, -- Drake Talon Pauldrons
				{ 17, 19407 }, -- Ebony Flame Gloves
				{ 18, 230255 }, -- Taut Dragonhide Belt
				{ 19, 230725 }, -- Malfurion's Blessed Bulwark
				{ 20, 230726 }, -- Dragonbreath Hand Cannon
				{ 21, 230271 }, -- Drake Talon Cleaver
				{ 22, 230270 }, -- Shadow Wing Focus Staff
				{ 23, 230281 }, -- Band of Forced Concentration
				{ 24, 230257 }, -- Ring of Blackrock

			},
		},
		{ -- BWLFlamegor
			name = AL["Flamegor"],
			npcID = 11981,
			Level = 999,
			DisplayIDs = { { 6377 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  230269 }, -- Rejuvenating Gem
				{ 2,  230736 }, -- Styleen's Impeding Scarab
				{ 3,  230282 }, -- Drake Fang Talisman
				{ 5,  230256 }, -- Drake Talon Pauldrons
				{ 6,  230733 }, -- Shroud of Pure Thought
				{ 7,  230255 }, -- Taut Dragonhide Belt
				{ 8,  230735 }, -- Emberweave Leggings
				{ 9,  230842 }, -- Cloak of Draconic Might
				{ 11, 230734 }, -- Circle of Applied Force
				{ 12, 230257 }, -- Ring of Blackrock
				{ 16, 230737 }, -- Dragon's Touch
				{ 17, 230738 }, -- Herald of Woe
				{ 18, 230844 }, -- Draconic Maul
				{ 19, 230847 }, -- Essence Gatherer
				{ 20, 230270 }, -- Shadow Wing Focus Staff
			},
		},
		{ -- BWLChromaggus
			name = AL["Chromaggus"],
			npcID = 14020,
			Level = 999,
			DisplayIDs = { { 14367 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  231726 }, -- Ancient Shoulderpads
				{ 2,  231717 }, -- Primeval Shoulderpads
				{ 3,  231709 }, -- Draconian Shoulderpads
				{ 5,  231814 }, -- Chromatic Heart
				{ 6,  229906 }, -- Tarnished Bronze Scale
				{ 16, 230740 }, -- Taut Dragonhide Shoulderpads
				{ 17, 230744 }, -- Elementium Threaded Cloak
				{ 18, 230742 }, -- Taut Dragonhide Gloves
				{ 19, 230739 }, -- Angelista's Grasp
				{ 20, 230800 }, -- Primalist's Linked Waistguard
				{ 21, 230745 }, -- Girdle of the Fallen Crusader
				{ 22, 230746 }, -- Empowered Leggings
				{ 23, 230743 }, -- Shimmering Geta
				{ 24, 230741 }, -- Chromatic Boots
				{ 26, 230801 }, -- Ashjre'thul, Crossbow of Smiting
				{ 27, 230802 }, -- Elementium Reinforced Bulwark
				{ 28, 230794 }, -- Claw of Chromaggus
				{ 29, 230747 }, -- Chromatically Tempered Sword
			},
		},
		{ -- BWLNefarian
			name = AL["Nefarian"],
			npcID = 11583,
			Level = 999,
			DisplayIDs = { { 11380 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,   19002, [ATLASLOOT_IT_ALLIANCE] = 19003 }, -- Head of Nefarian
				{ 2,   230838 },                     -- Lok'amir il Romathis
				{ 3,   230837 },                     -- Crul'shorukh, Edge of Chaos
				{ 4,   230818 },                     -- Ashkandi, Greatsword of the Brotherhood
				{ 5,   230813 },                     -- Staff of the Shadow Flame
				{ 6,   230812 },                     -- Mish'undare, Circlet of the Mind Flayer
				{ 7,   231803 },                     -- Prestor's Talisman of Connivery
				{ 8,   230804 },                     -- Cloak of the Brood Lord
				{ 9,   230806 },                     -- Therazane's Link
				{ 10,  230805 },                     -- Boots of the Shadow Flame
				{ 11,  230808 },                     -- Archimtiros' Ring of Reckoning
				{ 12,  230811 },                     -- Pure Elementium Band
				{ 13,  230810 },                     -- Neltharion's Tear
				{ 16,  231726 },                     -- Ancient Shoulderpads
				{ 17,  231717 },                     -- Primeval Shoulderpads
				{ 18,  231709 },                     -- Draconian Shoulderpads
				{ 20,  231731 },                     -- Ancient Chest
				{ 21,  231723 },                     -- Primeval Chest
				{ 22,  231714 },                     -- Draconian Robe
				{ 24,  231727 },                     -- Ancient Leggings
				{ 25,  231718 },                     -- Primeval Leggings
				{ 26,  231710 },                     -- Draconian Leggings
				{ 101, 231724 },                     -- Ancient Bindings
				{ 102, 231715 },                     -- Primeval Bindings
				{ 103, 231707 },                     -- Draconian Bindings
				{ 105, 231729 },                     -- Ancient Gloves
				{ 106, 231720 },                     -- Primeval Gloves
				{ 107, 231712 },                     -- Draconian Gloves
				{ 109, 231730 },                     -- Ancient Boots
				{ 110, 231721 },                     -- Primeval Boots
				{ 111, 231713 },                     -- Draconian Boots
				{ 113, 231725 },                     -- Ancient Belt
				{ 114, 231716 },                     -- Primeval Belt
				{ 115, 231708 },                     -- Draconian Belt
				{ 116, 231728 },                     -- Ancient Helm
				{ 117, 231719 },                     -- Primeval Helm
				{ 118, 231711 },                     -- Draconian Hood
			},
		},
		{ -- BWLTrashMobs
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  19436 }, -- Cloak of Draconic Might
				{ 2,  19439 }, -- Interlaced Shadow Jerkin
				{ 3,  19437 }, -- Boots of Pure Thought
				{ 4,  19438 }, -- Ringo's Blizzard Boots
				{ 5,  19434 }, -- Band of Dark Dominion
				{ 6,  19435 }, -- Essence Gatherer
				{ 7,  19362 }, -- Doom's Edge
				{ 8,  19354 }, -- Draconic Avenger
				{ 9,  19358 }, -- Draconic Maul
				{ 11, 18562 }, -- Elementium Ore
			},
		},
		T2_SET,
	},
}

data["TheRuinsofAhnQiraj"] = { -- AQ20
	MapID = 3429,
	InstanceID = 509,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheRuinsofAhnQiraj",
	AtlasMapFile = "CL_TheRuinsofAhnQiraj",
	AtlasMapFile_AL = "TheRuinsofAhnQiraj",
	ContentType = RAID20_CONTENT,
	LoadDifficulty = RAID20_DIFF,
	ContentPhase = 5,
	items = {
		{ -- AQ20Kurinnaxx
			name = AL["Kurinnaxx"],
			npcID = 15348,
			Level = 999,
			DisplayIDs = { { 15742 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  234062 }, -- Vestments of the Shifting Sands
				{ 2,  234061 }, -- Qiraji Sacrificial Dagger
				{ 3,  234118 }, -- Gavel of Qiraji Authority
				{ 4,  234065 }, -- Sand Reaver Wristguards
				{ 5,  234066 }, -- Toughened Silithid Hide Gloves
				{ 6,  234064 }, -- Belt of the Inquisition
				{ 7,  234063 }, -- Belt of the Sand Reaver
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Rajaxx
			name = AL["General Rajaxx"],
			npcID = 15341,
			Level = 999,
			DisplayIDs = { { 15376 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  234068 }, -- Boots of the Vanguard
				{ 2,  234067 }, -- Manslayer of the Qiraji
				{ 4,  234070 }, -- Bracers of Qiraji Command
				{ 5,  234072 }, -- Southwind's Grasp
				{ 6,  234071 }, -- Legplates of the Qiraji Command
				{ 7,  234069 }, -- Boots of the Qiraji General
				{ 8,  234116 }, -- Fury of the Forgotten Swarm
				{ 19, 20885 }, -- Qiraji Martial Drape
				{ 20, 20889 }, -- Qiraji Regal Drape
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Moam
			name = AL["Moam"],
			npcID = 15340,
			Level = 999,
			DisplayIDs = { { 15392 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  234073 }, -- Dustwind Turban
				{ 2,  234077 }, -- Thick Silithid Chestguard
				{ 3,  234075 }, -- Gauntlets of the Immovable
				{ 4,  234076 }, -- Talon of Furious Concentration
				{ 5,  234117 }, -- Treads of the Wandering Nomad
				{ 6,  234084 }, -- Southwind Helm
				{ 7,  234082 }, -- Mantle of Maz'Nadir
				{ 8,  234078 }, -- Chitinous Shoulderguards
				{ 9,  234079 }, -- Cloak of the Savior
				{ 10, 234081 }, -- Gauntlets of Southwind
				{ 11, 234087 }, -- Obsidian Scaled Leggings
				{ 12, 234088 }, -- Legplates of the Destroyer
				{ 13, 234083 }, -- Ring of Fury
				{ 14, 234080 }, -- Eye of Moam
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 21, 20888 }, -- Qiraji Ceremonial Ring
				{ 22, 20884 }, -- Qiraji Magisterial Ring
				{ 24, 22220, 22194 }, -- Plans: Black Grasp of the Destroyer
			},
		},
		{ -- AQ20Buru
			name = AL["Buru the Gorger"],
			npcID = 15370,
			Level = 999,
			DisplayIDs = { { 15654 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  [ATLASLOOT_IT_HORDE] = 234091, [ATLASLOOT_IT_ALLIANCE] = 234090 }, -- Slimy Scaled Gauntlets / Gloves of the Swarm
				{ 2,  234089 },                                              -- Buru's Skull Fragment
				{ 5,  234094 },                                              -- Scaled Bracers of the Gorger
				{ 6,  234093 },                                              -- Quicksand Waders
				{ 7,  234095 },                                              -- Slime Kickers
				{ 8,  234092 },                                              -- Fetish of Chitinous Spikes
				{ 16, 20890 },                                               -- Qiraji Ornate Hilt
				{ 17, 20886 },                                               -- Qiraji Spiked Hilt
				{ 20, 20885 },                                               -- Qiraji Martial Drape
				{ 21, 20889 },                                               -- Qiraji Regal Drape
				{ 22, 20888 },                                               -- Qiraji Ceremonial Ring
				{ 23, 20884 },                                               -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ayamiss
			name = AL["Ayamiss the Hunter"],
			npcID = 15369,
			Level = 999,
			DisplayIDs = { { 15431 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  234075 }, -- Gauntlets of the Immovable
				{ 2,  234096 }, -- Bow of Taut Sinew
				{ 3,  234097 }, -- Stinger of Ayamiss
				{ 5,  234100 }, -- Helm of Regrowth
				{ 6,  234102 }, -- Scaled Silithid Gauntlets
				{ 7,  234099 }, -- Boots of the Fiery Sands
				{ 8,  234098 }, -- Boots of the Desert Protector
				{ 9,  234101 }, -- Ring of the Desert Winds
				{ 16, 20890 }, -- Qiraji Ornate Hilt
				{ 17, 20886 }, -- Qiraji Spiked Hilt
				{ 20, 20885 }, -- Qiraji Martial Drape
				{ 21, 20889 }, -- Qiraji Regal Drape
				{ 22, 20888 }, -- Qiraji Ceremonial Ring
				{ 23, 20884 }, -- Qiraji Magisterial Ring
			},
		},
		{ -- AQ20Ossirian
			name = AL["Ossirian the Unscarred"],
			npcID = 15339,
			Level = 999,
			DisplayIDs = { { 15432 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  234107 },                             -- Helm of Domination
				{ 2,  234111,       [ATLASLOOT_IT_ALLIANCE] = 234109 }, -- Runic Stone Shoulders / Mantle of the Horusath
				{ 3,  234113 },                             -- Sandstorm Cloak
				{ 4,  234114 },                             -- Shackles of the Unscarred
				{ 5,  234103 },                             -- Bracers of Brutality
				{ 6,  234106 },                             -- Gloves of Dark Wisdom
				{ 7,  234105 },                             -- Gauntlets of New Life
				{ 8,  234110 },                             -- Ossirian's Binding
				{ 9,  234108 },                             -- Leggings of the Black Blizzard
				{ 10, 234104 },                             -- Crossbow of Imminent Doom
				{ 11, 234112 },                             -- Sand Polished Hammer
				{ 12, 234115 },                             -- Staff of the Ruins
				{ 16, 20890 },                              -- Qiraji Ornate Hilt
				{ 17, 20886 },                              -- Qiraji Spiked Hilt
				{ 20, 20888 },                              -- Qiraji Ceremonial Ring
				{ 21, 20884 },                              -- Qiraji Magisterial Ring
				{ 23, 21220 },                              -- Head of Ossirian the Unscarred
				{ 25, "INV_Box_01", nil,                             AL["Hard Mode Mounts"], nil },
				{ 26, 235511 },                             -- Flawless Yellow Qiraji Resonating Crystal
				{ 27, 235512 },                             -- Flawless Green Qiraji Resonating Crystal
				{ 28, 235513 },                             -- Flawless Blue Qiraji Resonating Crystal
				{ 29, 235514 },                             -- Flawless Red Qiraji Resonating Crystal
			},
		},
		{ -- AQ20Trash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  234123, [ATLASLOOT_IT_ALLIANCE] = 234120 }, -- Coif of Elemental Fury / Helm of the Holy Avenger
				{ 2,  21805 },                        -- Polished Obsidian Pauldrons
				{ 5,  20873 },                        -- Alabaster Idol
				{ 6,  20869 },                        -- Amber Idol
				{ 7,  20866 },                        -- Azure Idol
				{ 8,  20870 },                        -- Jasper Idol
				{ 9,  20868 },                        -- Lambent Idol
				{ 10, 20871 },                        -- Obsidian Idol
				{ 11, 20867 },                        -- Onyx Idol
				{ 12, 20872 },                        -- Vermillion Idol
				{ 14, 21761 },                        -- Scarab Coffer Key
				{ 15, 21156 },                        -- Scarab Bag
				{ 16, 234119 },                       -- Antenna of Invigoration
				{ 17, 234121 },                       -- Silithid Husked Launcher
				{ 18, 234122 },                       -- The Lost Kris of Zedd
				{ 20, 20864 },                        -- Bone Scarab
				{ 21, 20861 },                        -- Bronze Scarab
				{ 22, 20863 },                        -- Clay Scarab
				{ 23, 20862 },                        -- Crystal Scarab
				{ 24, 20859 },                        -- Gold Scarab
				{ 25, 20865 },                        -- Ivory Scarab
				{ 26, 20860 },                        -- Silver Scarab
				{ 27, 20858 },                        -- Stone Scarab
				{ 29, 22203 },                        -- Large Obsidian Shard
				{ 30, 22202 },                        -- Small Obsidian Shard
			},
		},
		{ -- AQ20ClassBooks
			name = AL["Class books"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  21284 }, -- Codex of Greater Heal V
				{ 2,  21287 }, -- Codex of Prayer of Healing V
				{ 3,  21285 }, -- Codex of Renew X
				{ 4,  21279 }, -- Tome of Fireball XII
				{ 5,  21214 }, -- Tome of Frostbolt XI
				{ 6,  21280 }, -- Tome of Arcane Missiles VIII
				{ 7,  21281 }, -- Grimoire of Shadow Bolt X
				{ 8,  21283 }, -- Grimoire of Corruption VII
				{ 9,  21282 }, -- Grimoire of Immolate VIII
				{ 10, 21300 }, -- Handbook of Backstab IX
				{ 11, 21303 }, -- Handbook of Feint V
				{ 12, 21302 }, -- Handbook of Deadly Poison V
				{ 13, 21294 }, -- Book of Healing Touch XI
				{ 14, 21296 }, -- Book of Rejuvenation XI
				{ 15, 21295 }, -- Book of Starfire VII
				{ 16, 21306 }, -- Guide: Serpent Sting IX
				{ 17, 21304 }, -- Guide: Multi-Shot V
				{ 18, 21307 }, -- Guide: Aspect of the Hawk VII
				{ 19, 21291 }, -- Tablet of Healing Wave X
				{ 20, 21292 }, -- Tablet of Strength of Earth Totem V
				{ 21, 21293 }, -- Tablet of Grace of Air Totem III
				{ 22, 21288 }, -- Libram: Blessing of Wisdom VI
				{ 23, 21289 }, -- Libram: Blessing of Might VII
				{ 24, 21290 }, -- Libram: Holy Light IX
				{ 25, 21298 }, -- Manual of Battle Shout VII
				{ 26, 21299 }, -- Manual of Revenge VI
				{ 27, 21297 }, -- Manual of Heroic Strike IX
			},
		},
		AQ_SCARABS,
		AQ_ENCHANTS,
		AQ_OPENING,
	},
}

data["TheTempleofAhnQiraj"] = { -- AQ40
	MapID = 3428,
	InstanceID = 531,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "TheTempleofAhnQiraj",
	AtlasMapFile = "CL_TheTempleofAhnQiraj",
	AtlasMapFile_AL = "TheTempleofAhnQiraj",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 5,
	items = {
		{ -- AQ40Skeram
			name = AL["The Prophet Skeram"],
			npcID = 15263,
			Level = 999,
			DisplayIDs = { { 15345 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  233496 }, -- Barrage Shoulders
				{ 2,  233516 }, -- Breastplate of Annihilation
				{ 3,  233506 }, -- Beetle Scaled Wristguards
				{ 4,  233505 }, -- Leggings of Immersion
				{ 5,  233518 }, -- Boots of the Fallen Prophet
				{ 6,  233517 }, -- Boots of the Redeemed Prophecy
				{ 7,  233514 }, -- Boots of the Unwavering Will
				{ 9,  233502 }, -- Amulet of Foul Warding
				{ 10, 233503 }, -- Pendant of the Qiraji Guardian
				{ 11, 233504 }, -- Cloak of Concentrated Hatred
				{ 12, 233507 }, -- Ring of Swarming Thought
				{ 13, 233515 }, -- Hammer of Ji'zhi
				{ 14, 233509 }, -- Staff of the Qiraji Prophets
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
				{ 19, 22222, 22196 }, -- Plans: Thick Obsidian Breastplate
			},
		},
		{ -- AQ40Trio
			name = AL["Bug Trio"],
			npcID = { 15543, 15544, 15511 },
			Level = 999,
			DisplayIDs = { { 15657 }, { 15658 }, { 15656 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  233522 }, -- Guise of the Devourer
				{ 2,  233521 }, -- Ternary Mantle
				{ 3,  233519 }, -- Cape of the Trinity
				{ 4,  233520 }, -- Robes of the Triumvirate
				{ 5,  233523 }, -- Triad Girdle
				{ 6,  233524 }, -- Angelista's Touch
				{ 8,  235045 }, -- Imperial Qiraji Regalia
				{ 9,  235046 }, -- Imperial Qiraji Armaments
				{ 11, "INV_BOX_02", nil, format(AL["%s killed last"], AL["Lord Kri"]) },
				{ 12, 233568 }, -- Vest of Swift Execution
				{ 13, 233569 }, -- Ring of the Devoured
				{ 14, 233570 }, -- Petrified Scarab
				{ 15, 233571 }, -- Wand of Qiraji Nobility
				{ 16, "INV_BOX_02", nil, format(AL["%s killed last"], AL["Vem"]) },
				{ 17, 233562 }, -- Angelista's Charm
				{ 18, 233559 }, -- Gloves of Ebru
				{ 19, 233560 }, -- Ooze-ridden Gauntlets
				{ 20, 233561 }, -- Boots of the Fallen Hero
				{ 22, "INV_BOX_02", nil, format(AL["%s killed last"], AL["Princess Yauj"]) },
				{ 23, 233563 }, -- Mantle of Phrenic Power
				{ 24, 233566 }, -- Mantle of the Desert's Fury
				{ 25, 233567 }, -- Mantle of the Desert Crusade
				{ 26, 233564 }, -- Bile-Covered Gauntlets
				{ 27, 233565 }, -- Ukko's Ring of Darkness
			},
		},
		{ -- AQ40Sartura
			name = AL["Battleguard Sartura"],
			npcID = 15516,
			Level = 999,
			DisplayIDs = { { 15583 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  233578 }, -- Creeping Vine Helm
				{ 2,  233572 }, -- Necklace of Purity
				{ 3,  233575 }, -- Robes of the Battleguard
				{ 4,  233579 }, -- Gloves of Enforcement
				{ 5,  233582 }, -- Gauntlets of Steadfast Determination
				{ 6,  233577 }, -- Thick Qirajihide Belt
				{ 7,  233574 }, -- Leggings of the Festering Swarm
				{ 8,  233584 }, -- Scaled Leggings of Qiraji Fury
				{ 9,  233583 }, -- Legplates of Blazing Light
				{ 10, 233573 }, -- Recomposed Boots
				{ 11, 233580 }, -- Badge of the Swarmguard
				{ 12, 233581 }, -- Sartura's Might
				{ 13, 233576 }, -- Silithid Claw
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
			},
		},
		{ -- AQ40Fankriss
			name = AL["Fankriss the Unyielding"],
			npcID = 15510,
			Level = 999,
			DisplayIDs = { { 15743 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  233592 }, -- Mantle of Wicked Revenge
				{ 2,  233593 }, -- Pauldrons of the Unrelenting
				{ 3,  233588 }, -- Cloak of Untold Secrets
				{ 4,  233594 }, -- Robes of the Guardian Saint
				{ 5,  233591 }, -- Silithid Carapace Chestguard
				{ 6,  233595 }, -- Scaled Sand Reaver Leggings
				{ 7,  233590 }, -- Hive Tunneler's Boots
				{ 8,  233585 }, -- Ancient Qiraji Ripper
				{ 9,  233586 }, -- Barb of the Sand Reaver
				{ 11, 233587 }, -- Barbed Choker
				{ 12, 233589 }, -- Fetish of the Sand Reaver
				{ 13, 233596 }, -- Libram of Grace
				{ 14, 233597 }, -- Totem of Life
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
				{ 19, 233370 }, -- Qiraji Bindings of Command
				{ 20, 233369 }, -- Qiraji Bindings of Dominance
				{ 21, 233371 }, -- Qiraji Bindings of Sovereignty
			},
		},
		{ -- AQ40Viscidus
			name = AL["Viscidus"],
			npcID = 15299,
			Level = 999,
			DisplayIDs = { { 15686 } },
			AtlasMapBossID = 5,
			[NORMAL_DIFF] = {
				{ 1,  233604 }, -- Gauntlets of Kalimdor
				{ 2,  233603 }, -- Gauntlets of the Righteous Champion
				{ 3,  233598 }, -- Slime-coated Leggings
				{ 4,  233599 }, -- Sharpened Silithid Femur
				{ 6,  233600 }, -- Ring of the Qiraji Fury
				{ 7,  233601 }, -- Scarab Brooch
				{ 8,  233602 }, -- Idol of Health
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
				{ 19, 233370 }, -- Qiraji Bindings of Command
				{ 20, 233369 }, -- Qiraji Bindings of Dominance
				{ 21, 233371 }, -- Qiraji Bindings of Sovereignty
			},
		},
		{ -- AQ40Huhuran
			name = AL["Princess Huhuran"],
			npcID = 15509,
			Level = 999,
			DisplayIDs = { { 15739 } },
			AtlasMapBossID = 6,
			[NORMAL_DIFF] = {
				{ 1,  233606 }, -- Cloak of the Golden Hive
				{ 2,  233610 }, -- Hive Defiler Wristguards
				{ 3,  233607 }, -- Gloves of the Messiah
				{ 4,  233608 }, -- Wasphide Gauntlets
				{ 5,  233609 }, -- Ring of the Martyr
				{ 6,  233605 }, -- Huhuran's Stinger
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
				{ 19, 233370 }, -- Qiraji Bindings of Command
				{ 20, 233369 }, -- Qiraji Bindings of Dominance
				{ 21, 233371 }, -- Qiraji Bindings of Sovereignty
			},
		},
		{ -- AQ40Emperors
			name = AL["Twin Emperors"],
			npcID = { 15275, 15276 },
			Level = 999,
			DisplayIDs = { { 15761 }, { 15778 } },
			AtlasMapBossID = 7,
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["Emperor Vek'lor"],    nil },
				{ 2,  233612 }, -- Qiraji Execution Bracers
				{ 3,  233613 }, -- Vek'lor's Gloves of Devastation
				{ 4,  233614 }, -- Royal Qiraji Belt
				{ 5,  233611 }, -- Boots of Epiphany
				{ 6,  233615 }, -- Ring of Emperor Vek'lor
				{ 7,  233616 }, -- Royal Scepter of Vek'lor
				{ 8,  20735 }, -- Formula: Enchant Cloak - Subtlety
				{ 12, 235046 }, -- Imperial Qiraji Armaments
				{ 13, 233365 }, -- Intact Viscera
				{ 14, 233367 }, -- Intact Peritoneum
				{ 15, 233368 }, -- Intact Entrails
				{ 16, "INV_Box_01", nil, AL["Emperor Vek'nilash"], nil },
				{ 17, 233620 }, -- Amulet of Vek'nilash
				{ 18, 233617 }, -- Bracelets of Royal Redemption
				{ 19, 233618 }, -- Gloves of the Hidden Temple
				{ 20, 21609 }, -- Regenerating Belt of Vek'nilash
				{ 21, 233622 }, -- Grasp of the Fallen Emperor
				{ 22, 233623 }, -- Belt of the Fallen Emperor
				{ 23, 233621 }, -- Kalimdor's Revenge
				{ 24, 20726 }, -- Formula: Enchant Gloves - Threat
				{ 27, 235045 }, -- Imperial Qiraji Regalia
				{ 28, 233365 }, -- Intact Viscera
				{ 29, 233367 }, -- Intact Peritoneum
				{ 30, 233368 }, -- Intact Entrails
			},
		},
		{ -- AQ40Ouro
			name = AL["Ouro"],
			npcID = 15517,
			Level = 999,
			DisplayIDs = { { 15509 } },
			AtlasMapBossID = 8,
			[NORMAL_DIFF] = {
				{ 1,  233624 }, -- Don Rigoberto's Lost Hat
				{ 2,  233625 }, -- Burrower Bracers
				{ 3,  233628 }, -- The Burrower's Shell
				{ 4,  233627 }, -- Jom Gabbar
				{ 5,  21610 }, -- Wormscale Blocker
				{ 6,  233626 }, -- Larvae of the Great Worm
				{ 16, 235045 }, -- Imperial Qiraji Regalia
				{ 17, 235046 }, -- Imperial Qiraji Armaments
				{ 18, 233365 }, -- Intact Viscera
				{ 19, 233367 }, -- Intact Peritoneum
				{ 20, 233368 }, -- Intact Entrails
			},
		},
		{ -- AQ40CThun
			name = AL["C'Thun"],
			npcID = 15727,
			Level = 999,
			DisplayIDs = { { 15787 } },
			AtlasMapBossID = 9,
			[NORMAL_DIFF] = {
				{ 1,  233642 }, -- Mark of C'Thun
				{ 2,  233641 }, -- Cloak of Clarity
				{ 3,  233630 }, -- Cloak of the Devoured
				{ 4,  233633 }, -- Eyestalk Waist Cord
				{ 5,  233632 }, -- Grasp of the Old God
				{ 6,  233635 }, -- Belt of Never-ending Agony
				{ 7,  233631 }, -- Dark Storm Gauntlets
				{ 8,  233637 }, -- Gauntlets of Annihilation
				{ 9,  233638 }, -- Ring of the Godslayer
				{ 10, 233639 }, -- Vanquished Tentacle of C'Thun
				{ 11, 233636 }, -- Scepter of the False Prophet
				{ 12, 233634 }, -- Death's Sting
				{ 13, 233640 }, -- Dark Edge of Insanity
				{ 16, 233363 }, -- Carapace of the Old God
				{ 17, 233362 }, -- Husk of the Old God
				{ 18, 233364 }, -- Skin of the Old God
				{ 20, 21221 }, -- Eye of C'Thun
				{ 22, 22734 }, -- Base of Atiesh
				{ 24, "INV_Box_01", nil, AL["Hard Mode Mounts"], nil },
				{ 25, 233351 }, -- Light Green Qiraji Resonating Crystal
				{ 26, 233352 }, -- Dark Blue Qiraji Resonating Crystal
				{ 27, 233353 }, -- Light Blue Qiraji Resonating Crystal
				{ 28, 233356 }, -- Orange Qiraji Resonating Crystal
				{ 29, 233357 }, -- Twilight Qiraji Resonating Crystal
			},
		},
		{ -- AQ40Trash1
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  233644 }, -- Garb of Royal Ascension
				{ 2,  233645 }, -- Gloves of the Immortal
				{ 3,  233646 }, -- Gloves of the Redeemed Prophecy
				{ 4,  233647 }, -- Neretzek, The Blood Drinker
				{ 5,  233643 }, -- Anubisath Warhammer
				{ 6,  233648 }, -- Ritssyn's Ring of Chaos
				{ 7,  233649 }, -- Shard of the Fallen Star
				{ 16, 21218 }, -- Blue Qiraji Resonating Crystal
				{ 17, 21324 }, -- Yellow Qiraji Resonating Crystal
				{ 18, 21323 }, -- Green Qiraji Resonating Crystal
				{ 19, 21321 }, -- Red Qiraji Resonating Crystal
			},
		},
		AQ_SCARABS,
		AQ_ENCHANTS,
		AQ_OPENING,
	},
}

data["Naxxramas"] = {
	MapID = 3456,
	InstanceID = 533,
	AtlasModule = ATLAS_MODULE_NAME,
	AtlasMapID = "Naxxramas",
	AtlasMapFile = "CL_Naxxramas",
	AtlasMapFile_AL = "Naxxramas",
	ContentType = RAID40_CONTENT,
	LoadDifficulty = RAID40_DIFF,
	ContentPhase = 6,
	items = {
		-- The Arachnid Quarter
		{ -- NAXAnubRekhan
			name = AL["Anub'Rekhan"],
			npcID = 15956,
			Level = 999,
			DisplayIDs = { { 15931 } },
			AtlasMapBossID = "1",
			NameColor = BLUE,
			[NORMAL_DIFF] = {
				{ 1,  22726 },                                               -- Splinter of Atiesh
				{ 2,  22727 },                                               -- Frame of Atiesh
				{ 4,  236245 },                                              -- Desecrated Bindings
				{ 5,  236247 },                                              -- Desecrated Wristguards
				{ 6,  236235 },                                              -- Desecrated Bracers
				{ 8,  236256 },                                              -- Touch of Frost
				{ 9,  236258 },                                              -- Cryptfiend Silk Cloak
				{ 10, 236255 },                                              -- Wristguards of Vengeance
				{ 11, 236259 },                                              -- Band of Unanswered Prayers
				{ 12, 236257 },                                              -- Gem of Nerubis
				{ 13, [ATLASLOOT_IT_HORDE] = 236226, [ATLASLOOT_IT_ALLIANCE] = 236228 }, -- Pauldrons of Elemental Fury / Spaulders of the Grand Grusader
			},
		},
		{ -- NAXGrandWidowFaerlina
			name = AL["Grand Widow Faerlina"],
			npcID = 15953,
			Level = 999,
			DisplayIDs = { { 15940 } },
			AtlasMapBossID = "2",
			NameColor = BLUE,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236245 }, -- Desecrated Bindings
				{ 5,  236247 }, -- Desecrated Wristguards
				{ 6,  236235 }, -- Desecrated Bracers
				{ 8,  236261 }, -- Malice Stone Pendant
				{ 9,  236262 }, -- Polar Shoulder Pads
				{ 10, 236260 }, -- Icebane Pauldrons
				{ 11, 236264 }, -- The Widow's Embrace
				{ 12, 236263 }, -- Widow's Remorse
				{ 13, 236223 }, -- Ring of the Eternal Flame
			},
		},
		{ -- NAXMaexxna
			name = AL["Maexxna"],
			npcID = 15952,
			Level = 999,
			DisplayIDs = { { 15928 } },
			AtlasMapBossID = "3",
			NameColor = BLUE,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236243 }, -- Desecrated Gloves
				{ 5,  236250 }, -- Desecrated Handguards
				{ 6,  236233 }, -- Desecrated Gauntlets
				{ 8,  236266 }, -- Pendant of Forgotten Names
				{ 9,  236267 }, -- Crystal Webbed Robe
				{ 10, 236268 }, -- Kiss of the Spider
				{ 11, 236265 }, -- Wraith Blade
				{ 12, 236269 }, -- Maexxna's Fang
			},
		},
		-- The Plague Quarter
		{ -- NAXNoththePlaguebringer
			name = AL["Noth the Plaguebringer"],
			npcID = 15954,
			Level = 999,
			DisplayIDs = { { 16590 } },
			AtlasMapBossID = "1",
			NameColor = PURP,
			[NORMAL_DIFF] = {
				{ 1,  22726 },                                               -- Splinter of Atiesh
				{ 2,  22727 },                                               -- Frame of Atiesh
				{ 4,  236244 },                                              -- Desecrated Belt
				{ 5,  236252 },                                              -- Desecrated Girdle
				{ 6,  236232 },                                              -- Desecrated Waistguard
				{ 8,  236272 },                                              -- Cloak of the Scourge
				{ 9,  236273 },                                              -- Band of the Inevitable
				{ 10, 236274 },                                              -- Hailstone Band
				{ 11, 236275 },                                              -- Noth's Frigid Heart
				{ 12, 236271 },                                              -- Libram of Light
				{ 13, 236276 },                                              -- Totem of Flowing Water
				{ 14, 236270 },                                              -- Hatchet of Sundered Bone
				{ 15, [ATLASLOOT_IT_HORDE] = 236230, [ATLASLOOT_IT_ALLIANCE] = 236229 }, -- Leggings of Elemental Fury / Leggings of the Grand Crusader
			},
		},
		{ -- NAXHeigantheUnclean
			name = AL["Heigan the Unclean"],
			npcID = 15936,
			Level = 999,
			DisplayIDs = { { 16309 } },
			AtlasMapBossID = "2",
			NameColor = PURP,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236244 }, -- Desecrated Belt
				{ 5,  236252 }, -- Desecrated Girdle
				{ 6,  236232 }, -- Desecrated Waistguard
				{ 8,  236279 }, -- Preceptor's Hat
				{ 9,  236281 }, -- Icy Scale Coif
				{ 10, 237275 }, -- Icebane Helmet
				{ 11, 236277 }, -- Necklace of Necropsy
				{ 12, 236280 }, -- Legplates of Carnage
				{ 13, 236219 }, -- Harbinger of Doom
			},
		},
		{ -- NAXLoatheb
			name = AL["Loatheb"],
			npcID = 16011,
			Level = 999,
			DisplayIDs = { { 16110 } },
			AtlasMapBossID = "3",
			NameColor = PURP,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236246 }, -- Desecrated Leggings
				{ 5,  236253 }, -- Desecrated Legguards
				{ 6,  236238 }, -- Desecrated Legplates
				{ 8,  236286 }, -- Band of Unnatural Forces
				{ 9,  236283 }, -- Ring of Spiritual Fervor
				{ 10, 236282 }, -- Loatheb's Reflection
				{ 11, 236285 }, -- The Eye of Nerub
				{ 12, 236284 }, -- Brimstone Staff
			},
		},
		-- The Military Quarter
		{ -- NAXInstructorRazuvious
			name = AL["Instructor Razuvious"],
			npcID = 16061,
			Level = 999,
			DisplayIDs = { { 16582 } },
			AtlasMapBossID = "1",
			NameColor = _RED,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236239 }, -- Desecrated Sandals
				{ 5,  236248 }, -- Desecrated Boots
				{ 6,  236234 }, -- Desecrated Sabatons
				{ 8,  236307 }, -- Veil of Eclipse
				{ 9,  236309 }, -- Girdle of the Mentor
				{ 10, 236311 }, -- Signet of the Fallen Defender
				{ 11, 236308 }, -- Idol of Longevity
				{ 12, 236310 }, -- Wand of the Whispering Dead
				{ 13, 236312 }, -- Iblis, Blade of the Fallen Seraph
				{ 14, 236220 }, -- Necro-Knight's Garb
			},
		},
		{ -- NAXGothiktheHarvester
			name = AL["Gothik the Harvester"],
			npcID = 16060,
			Level = 999,
			DisplayIDs = { { 16279 } },
			AtlasMapBossID = "2",
			NameColor = _RED,
			[NORMAL_DIFF] = {
				{ 1,  22726 },                                               -- Splinter of Atiesh
				{ 2,  22727 },                                               -- Frame of Atiesh
				{ 4,  236239 },                                              -- Desecrated Sandals
				{ 5,  236248 },                                              -- Desecrated Boots
				{ 6,  236234 },                                              -- Desecrated Sabatons
				{ 8,  236278 },                                              -- Glacial Headdress
				{ 9,  236315 },                                              -- Polar Helmet
				{ 10, 236316 },                                              -- Sadist's Collar
				{ 11, 236313 },                                              -- The Soul Harvester's Bindings
				{ 12, 236314 },                                              -- Boots of Displacement
				{ 13, [ATLASLOOT_IT_HORDE] = 236225, [ATLASLOOT_IT_ALLIANCE] = 236227 }, -- Girdle of Elemental Fury / Belt of the Grand Crusader
			},
		},
		{ -- NAXTheFourHorsemen
			name = AL["The Four Horsemen"],
			npcID = { 16064, 16065, 16062, 16063 },
			Level = 999,
			DisplayIDs = { { 16155 }, { 16153 }, { 16139 }, { 16154 } },
			AtlasMapBossID = "3",
			NameColor = _RED,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236242 }, -- Desecrated Robe
				{ 5,  236251 }, -- Desecrated Tunic
				{ 6,  236231 }, -- Desecrated Breastplate
				{ 8,  236319 }, -- Leggings of Apocalypse
				{ 9,  236318 }, -- Seal of the Damned
				{ 10, 236320 }, -- Warmth of Forgiveness
				{ 11, 236322 }, -- Soulstring
				{ 12, 236321 }, -- Maul of the Redeemed Crusader
				{ 13, 237512 }, -- Blade of Inquisition
			},
		},
		-- The Construct Quarter
		{ -- NAXPatchwerk
			name = AL["Patchwerk"],
			npcID = 16028,
			Level = 999,
			DisplayIDs = { { 16174 } },
			AtlasMapBossID = 1,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236240 }, -- Desecrated Shoulderpads
				{ 5,  236254 }, -- Desecrated Spaulders
				{ 6,  236237 }, -- Desecrated Pauldrons
				{ 8,  236289 }, -- Cloak of Suturing
				{ 9,  236291 }, -- Band of Reanimation
				{ 10, 236290 }, -- Wand of Fates
				{ 11, 236288 }, -- The Plague Bearer
				{ 12, 236287 }, -- Severance
				{ 13, 236222 }, -- Ghoul Skin Tunic
			},
		},
		{ -- NAXGrobbulus
			name = AL["Grobbulus"],
			npcID = 15931,
			Level = 999,
			DisplayIDs = { { 16035 } },
			AtlasMapBossID = 2,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236240 }, -- Desecrated Shoulderpads
				{ 5,  236254 }, -- Desecrated Spaulders
				{ 6,  236237 }, -- Desecrated Pauldrons
				{ 8,  236295 }, -- Glacial Mantle
				{ 9,  236294 }, -- Icy Scale Spaulders
				{ 10, 236293 }, -- Toxin Injector
				{ 11, 236292 }, -- Midnight Haze
				{ 12, 236297 }, -- The End of Dreams
				{ 13, 236221 }, -- Misplaced Servo Arm
			},
		},
		{ -- NAXGluth
			name = AL["Gluth"],
			npcID = 15932,
			Level = 999,
			DisplayIDs = { { 16064 } },
			AtlasMapBossID = 3,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236298 }, -- Rime Covered Mantle
				{ 5,  236300 }, -- Gluth's Missing Collar
				{ 6,  236301 }, -- Digested Hand of Power
				{ 7,  236296 }, -- Death's Bargain
				{ 8,  236299 }, -- Claymore of Unholy Might
				{ 9,  237577 }, -- Totem of Unholy Might
				{ 10, 236224 }, -- Stygian Buckler
				{ 16, 236240 }, -- Desecrated Shoulderpads
				{ 17, 236245 }, -- Desecrated Bindings
				{ 18, 236244 }, -- Desecrated Belt
				{ 19, 236239 }, -- Desecrated Sandals
				{ 20, 236254 }, -- Desecrated Spaulders
				{ 21, 236247 }, -- Desecrated Wristguards
				{ 22, 236252 }, -- Desecrated Girdle
				{ 23, 236248 }, -- Desecrated Boots
				{ 24, 236237 }, -- Desecrated Pauldrons
				{ 25, 236235 }, -- Desecrated Bracers
				{ 26, 236232 }, -- Desecrated Waistguard
				{ 27, 236234 }, -- Desecrated Sabatons
			},
		},
		{ -- NAXThaddius
			name = AL["Thaddius"],
			npcID = 15928,
			Level = 999,
			DisplayIDs = { { 16137 } },
			AtlasMapBossID = 4,
			[NORMAL_DIFF] = {
				{ 1,  22726 }, -- Splinter of Atiesh
				{ 2,  22727 }, -- Frame of Atiesh
				{ 4,  236241 }, -- Desecrated Circlet
				{ 5,  236249 }, -- Desecrated Headpiece
				{ 6,  236236 }, -- Desecrated Helmet
				{ 8,  236304 }, -- Plated Abomination Ribcage
				{ 9,  236303 }, -- Leggings of Polarity
				{ 10, 236302 }, -- Eye of Diminution
				{ 11, 236306 }, -- The Castigator
				{ 12, 236305 }, -- Spire of Twilight
			},
		},
		-- Frostwyrm Lair
		{ -- NAXSapphiron
			name = AL["Sapphiron"],
			npcID = 15989,
			Level = 999,
			DisplayIDs = { { 16033 } },
			AtlasMapBossID = "1",
			NameColor = GREEN,
			[NORMAL_DIFF] = {
				{ 1,  236327 }, -- Cloak of the Necropolis
				{ 2,  236333 }, -- Shroud of Dominion
				{ 3,  236337 }, -- Glyph of Deflection
				{ 4,  236329 }, -- Eye of the Dead
				{ 5,  236334 }, -- Slayer's Crest
				{ 6,  236331 }, -- The Restrained Essence of Sapphiron
				{ 7,  236328 }, -- Sapphiron's Left Eye
				{ 8,  236330 }, -- Sapphiron's Right Eye
				{ 9,  236336 }, -- The Face of Death
				{ 10, 236338 }, -- Claw of the Frost Wyrm
				{ 11, 236335 }, -- Fists of the Unrelenting
				{ 16, 236325 }, -- Fortitude of the Scourge
				{ 17, 236326 }, -- Might of the Scourge
				{ 18, 236324 }, -- Power of the Scourge
				{ 19, 236323 }, -- Resilience of the Scourge
			},
		},
		{ -- NAXKelThuzard
			name = AL["Kel'Thuzad"],
			npcID = 15990,
			Level = 999,
			DisplayIDs = { { 15945 } },
			AtlasMapBossID = "2",
			NameColor = GREEN,
			[NORMAL_DIFF] = {
				{ 1,  236345 }, -- Gem of Trapped Innocents
				{ 2,  236342 }, -- Stormrage's Talisman of Seething
				{ 3,  236344 }, -- Nerubian Slavemaker
				{ 4,  236349 }, -- Doomfinger
				{ 5,  236347 }, -- Shield of Condemnation
				{ 6,  236343 }, -- Kingsfall
				{ 7,  236348 }, -- Hammer of the Twisting Nether
				{ 8,  236339 }, -- Gressil, Dawn of Ruin
				{ 9,  236341 }, -- The Hungering Cold
				{ 10, 236340 }, -- Might of Menethil
				{ 11, 236346 }, -- Soulseeker
				{ 13, 236350 }, -- The Phylactery of Kel'Thuzad
				{ 14, 237381 }, -- Desecrated Ring
				{ 16, 22733 }, -- Staff Head of Atiesh
				{ 18, 236665 }, -- Reins of Famine
				{ 19, 236664 }, -- Reins of Death
				{ 20, 236663 }, -- Reins of Conquest
				{ 21, 236662 }, -- Reins of War
			},
		},
		{ -- NAXTrash
			name = AL["Trash"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 22376 }, -- Wartorn Cloth Scrap
				{ 2, 22373 }, -- Wartorn Leather Scrap
				{ 3, 22374 }, -- Wartorn Chain Scrap
				{ 4, 22375 }, -- Wartorn Plate Scrap
				{ 6, 237773 }, -- Word of Thawing
				{ 7, 236656 }, -- Frozen Rune
			},
		},
		T3_SET,
	},
}

data["The Scarlet Enclave"] = {
	MapID = 16236,
	ContentType = RAID40_CONTENT,
	items = {
		{
			name = AL["Balnazzar"],
			npcID = 240811,
			DisplayIDs = { { 129113 } },
			[NORMAL_DIFF] = {
				{ 1,  239719 }, -- Consecrated Bindings
				{ 2,  239759 }, -- Consecrated Bracers
				{ 3,  239722 }, -- Consecrated Wristguards
				{ 5,  242365 }, -- Wing of Balnazzar
				{ 16, 241179 }, -- Leggings of Catastrophe
				{ 17, 241178 }, -- Stalwart Pain Plate
				{ 18, 241184 }, -- Savior Sandals
				{ 19, 241157 }, -- Scarlet Chestplate
				{ 20, 241152 }, -- Dawnwrought Shoulders
				{ 21, 241176 }, -- Diesalven's Demise
				{ 22, 241171 }, -- Gloves of Departed Souls
				{ 23, 240922 }, -- Deception
				{ 24, 241017 }, -- Demon's Folly
				{ 25, 241018 }, -- Nathrezim Heart
				{ 26, 240839 }, -- Thal'kituum, the Unseen Guest
				{ 27, 241028 }, -- Nathrezim Loop
			},
		},
		{
			name = AL["High Commander Beatrix"],
			npcID = 240812,
			DisplayIDs = { { 127686 } },
			[NORMAL_DIFF] = {
				{ 1,  239718 }, -- Consecrated Belt
				{ 2,  239760 }, -- Consecrated Waistguard
				{ 3,  239756 }, -- Consecrated Girdle
				{ 5,  239196 }, -- Ruined Lightforged Blade
				{ 7,  239694 }, -- Covenant of Light
				{ 16, 240997 }, -- Fratlet's Spur
				{ 17, 241077 }, -- Cardinal's Chapeau
				{ 18, 241159 }, -- Monastery Garb
				{ 19, 241173 }, -- High Wizard Wrap
				{ 20, 241177 }, -- Kilt of the Scarlet Arcanist
				{ 21, 241076 }, -- Cowl of the Covenant
				{ 22, 241074 }, -- Helm of the Red Crusade
				{ 23, 241170 }, -- Enclave Protectors
				{ 24, 241068 }, -- Stiltz's Standard
				{ 25, 241027 }, -- Shield Warden's Guard
				{ 26, 241026 }, -- Cardinal's Shawl
			},
		},
		{
			name = AL["Solistrasza"],
			npcID = 238954,
			DisplayIDs = { { 126697 } },
			[NORMAL_DIFF] = {
				{ 1,  239714 }, -- Consecrated Circlet
				{ 2,  239707 }, -- Consecrated Helmet
				{ 3,  239729 }, -- Consecrated Headpiece
				{ 5,  242364 }, -- Mature Light Dragon Sinew
				{ 16, 236317 }, -- Vis'era the Gutrender
				{ 17, 241002 }, -- Remnants of the Red
				{ 18, 240174 }, -- Solistra, Fang of the First Light
				{ 19, 241180 }, -- Lightscale Leggings
				{ 20, 241163 }, -- Sunblaze Bracers
				{ 21, 241186 }, -- Polished Scarlet Mail Boots
				{ 22, 241166 }, -- Dawnstripped Bands
				{ 23, 241022 }, -- Dawnbringer's Cloak
				{ 24, 241073 }, -- Touch of Light
				{ 25, 241034 }, -- Heart of Light
				{ 26, 241168 }, -- Sunblaze Grips
				{ 27, 240850 }, -- Lightfist Hammer
			},
		},
		{
			name = AL["Mason the Echo"],
			npcID = 241021,
			DisplayIDs = { { 127818 } },
			[NORMAL_DIFF] = {
				{ 1,  239716 }, -- Consecrated Gloves
				{ 2,  239762 }, -- Consecrated Gauntlets
				{ 3,  239730 }, -- Consecrated Handguards
				{ 16, 241011 }, -- Greatstaff of Fealty
				{ 17, 240925 }, -- Experiment-800M
				{ 18, 240843 }, -- Starter's Pistol
				{ 19, 241183 }, -- Ashwalkers
				{ 20, 241181 }, -- Dawnworn Chain Leggings
				{ 21, 242793 }, -- Portable Cannon
				{ 22, 241030 }, -- Mason's Fraternity Ring
				{ 23, 241023 }, -- Drape of the Dastardly
				{ 24, 241071 }, -- Talisman of the Scarlet Scoundrel
				{ 25, 239060 }, -- Will of the Mountain
				{ 26, 241187 }, -- Crimson Wartreads
				{ 27, 241182 }, -- Templar Plate Legguards
				{ 28, 241025 }, -- Flag of the Broken Admiral
			},
		},
		{
			name = AL["Alexei the Beastlord"],
			npcID = 240974,
			DisplayIDs = { { 128013 } },
			[NORMAL_DIFF] = {
				{ 1,  239710 }, -- Consecrated Sandals
				{ 2,  239706 }, -- Consecrated Sabatons
				{ 3,  239726 }, -- Consecrated Boots
				{ 16, 240924 }, -- Poleaxe of the Beast
				{ 17, 240849 }, -- Staff of the Glade
				{ 18, 241079 }, -- Weight of the World
				{ 19, 241162 }, -- Sunblessed Leathers
				{ 20, 241158 }, -- Chains of the Abandoned
				{ 21, 241038 }, -- Sir Dornel's Didgeridoo
				{ 22, 241069 }, -- Choke Chain
				{ 23, 241167 }, -- Prisoner Shackles
				{ 24, 241164 }, -- Scrapped Argent Leathers
				{ 25, 241185 }, -- Bear Training Boots
				{ 26, 241165 }, -- Penitent Wraps
				{ 27, 241154 }, -- Bearskin Mantle
			},
		},
		{
			name = AL["Reborn Council"],
			npcID = 241768,
			DisplayIDs = { { 2041 } },
			[NORMAL_DIFF] = {
				{ 1,  239712 }, -- Consecrated Shoulderpads
				{ 2,  239708 }, -- Consecrated Pauldrons
				{ 3,  239758 }, -- Consecrated Spaulders
				{ 5,  239117 }, -- Crusader's Chalice
				{ 16, 241008 }, -- Condemnation
				{ 17, 241003 }, -- Mirage, Rod of Illusion
				{ 18, 240919 }, -- Ravagane
				{ 19, 240998 }, -- Soporific Blade
				{ 20, 240854 }, -- Mercy
				{ 21, 240853 }, -- Queensfall
				{ 22, 241015 }, -- Aegis of the Scarlet Bastion
				{ 23, 241075 }, -- Raging Destroyer's Helm
				{ 24, 241070 }, -- Hope of Herod
				{ 25, 241153 }, -- Doan's Mantle
				{ 26, 241175 }, -- Torturer's Toolbelt
				{ 27, 241080 }, -- Herod's Pauldron
				{ 28, 241174 }, -- Girdle of the Reborn Champion
			},
		},
		{
			name = AL["Lilian Voss"],
			npcID = 243021,
			DisplayIDs = { { 128659 } },
			[NORMAL_DIFF] = {
				{ 1,  239721 }, -- Consecrated Leggings
				{ 2,  239709 }, -- Consecrated Legplates
				{ 3,  239757 }, -- Consecrated Legguards
				{ 16, 240923 }, -- Duplicity
				{ 17, 241031 }, -- Barthalomew's Promise
				{ 18, 241037 }, -- Abandoned Experiment
				{ 19, 240842 }, -- Scarlet Rotbringer
				{ 20, 240844 }, -- Putress' Poker
				{ 21, 241004 }, -- Conundrum
				{ 22, 241012 }, -- Wand of Reanimation
				{ 23, 242436 }, -- Putress' Diary
				{ 24, 241078 }, -- Shroud of the Embalmed
				{ 25, 241160 }, -- Dawnworn Chainmail
				{ 26, 241161 }, -- Templar Breastplate
				{ 27, 241072 }, -- Vial of Pus
				{ 28, 241156 }, -- Blighted Robes
			},
		},
		{
			name = AL["Grand Crusader Caldoran"],
			npcID = 241006,
			DisplayIDs = { { 126218 } },
			[NORMAL_DIFF] = {
				{ 1,  239715 }, -- Consecrated Robe
				{ 2,  239761 }, -- Consecrated Breastplate
				{ 3,  239731 }, -- Consecrated Tunic
				{ 5,  239117 }, -- Crusader's Chalice
				{ 6,  239215 }, -- Charred Emblem
				{ 7,  242366 }, -- Inescapable Fate
				{ 9,  239695 }, -- Scarlet Steed
				{ 11, 239696 }, -- Hilt of the Ashbringer
				{ 16, 241029 }, -- Baelin's Band
				{ 17, 240921 }, -- Scarlet Smashbringer
				{ 18, 240920 }, -- Leogan
				{ 19, 240851 }, -- Regicide
				{ 20, 241006 }, -- Spire of Sacrifice
				{ 21, 240841 }, -- High Commander's Guard
				{ 22, 241001 }, -- Tyr's Fall
				{ 23, 240852 }, -- Crimson Cleaver
				{ 24, 241172 }, -- Caldoran's Locked Gauntlets
				{ 25, 241039 }, -- Infusion of Souls
				{ 26, 241032 }, -- Ring of Resurrection
				{ 27, 241024 }, -- Scarlet Commander's Cape
				{ 28, 241021 }, -- The Light
			},
		},
		{ -- ScarletEnclaveExtra
			name = AL["World Spawn"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Various Spawn Locations"],  nil },
				{ 2, 238945 }, -- Caladboulder
				{ 4, "INV_Box_01", nil, AL["Hoard of the Pirate Lord"], nil },
				{ 5, 241241 }, -- Lucky Doubloon
			},
		},
		T3_5_SET,
	},
}
