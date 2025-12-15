-- If we aren't on a SoD realm, ignore everything in this file
if C_Seasons.GetActiveSeason() ~= 2 then return end

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local string = _G.string
local format = string.format

-- WoW
local function C_Map_GetAreaInfo(id)
	local d = C_Map.GetAreaInfo(id)
	return d or ("GetAreaInfo"..id)
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1, 0)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID10H_DIFF = data:AddDifficulty("10RAIDH")
local RAID25_DIFF = data:AddDifficulty("25RAID")
local RAID25H_DIFF = data:AddDifficulty("25RAIDH")

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)
local T10_1_DIFF = data:AddDifficulty(AL["10H / 25 / 25H"], "T10_1", 0)
local T10_2_DIFF = data:AddDifficulty(AL["25 Raid Heroic"], "T10_2", 0)

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
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
--local WORLD_BOSS_CONTENT = data:AddContentType(AL["World Bosses"], ATLASLOOT_WORLD_BOSS_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTIONS_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)

-- colors
local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
--local WHIT = "|cffffffff%s|r"

data["TierSets"] = {
	name = AL["Tier Sets"],
	ContentType = SET_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{
			name = AL["Level 25"],
			[NORMAL_DIFF] = {
				{ 1, 1570 },
				{ 3, 1578 },
				{ 4, 1579 },
				{ 6, 1577 },
			},
		},
		{
			name = AL["Level 40"],
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
		},
		{
			name = AL["Level 50"],
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
		},
		{ -- T1
			name = format(AL["Tier %s Sets"], "1"),
			[NORMAL_DIFF] = {
				{ 1,  1698 }, --Balance
				{ 2,  1699 }, --Feral
				{ 3,  1701 }, --Tank
				{ 4,  1700 }, --Resto
				{ 6,  1702 }, --Ranged Hunter
				{ 7,  1703 }, --Melee Hunter
				{ 9,  1704 }, --Damage Mage
				{ 10, 1705 }, --Healer Mage
				{ 12, 1713 }, -- Healer Sham
				{ 13, 1715 }, -- Melee Sham
				{ 14, 1714 }, -- Ranged Sham
				{ 15, 1716 }, -- Tank Sham
				{ 16, 1706 }, -- Holy Pally
				{ 17, 1707 }, -- Ret Pally
				{ 18, 1708 }, -- Tank Pally
				{ 20, 1709 }, -- Healer Priest
				{ 21, 1710 }, -- DPS Priest
				{ 23, 1711 }, -- DPS Rogue
				{ 24, 1712 }, -- Tank Rogue
				{ 26, 1717 }, -- DPS Lock
				{ 27, 1718 }, -- Tank Lock
				{ 29, 1719 }, -- Tank Warr
				{ 30, 1720 }, -- Dps Warr
			},
		},
		{ -- T2
			name = format(AL["Tier %s Sets"], "2"),
			[NORMAL_DIFF] = {
				{ 1,  1801 }, --Balance
				{ 2,  1803 }, --Feral
				{ 3,  1804 }, --Tank
				{ 4,  1802 }, --Resto
				{ 6,  1805 }, --Ranged Hunter
				{ 7,  1806 }, --Melee Hunter
				{ 9,  1807 }, --Damage Mage
				{ 10, 1808 }, --Healer Mage
				{ 12, 1816 }, -- Healer Sham
				{ 13, 1818 }, -- Melee Sham
				{ 14, 1817 }, -- Ranged Sham
				{ 15, 1819 }, -- Tank Sham
				{ 16, 1809 }, -- Holy Pally
				{ 17, 1810 }, -- Ret Pally
				{ 18, 1811 }, -- Tank Pally -
				{ 20, 1812 }, -- Healer Priest
				{ 21, 1813 }, -- DPS Priest -
				{ 23, 1814 }, -- DPS Rogue
				{ 24, 1815 }, -- Tank Rogue -
				{ 26, 1820 }, -- DPS Lock
				{ 27, 1821 }, -- Tank Lock
				{ 29, 1822 }, -- Tank Warr
				{ 30, 1823 }, -- Dps Warr
			},
		},
		{ -- T2.5
			name = format(AL["Tier %s Sets"], "2.5"),
			[NORMAL_DIFF] = {
				{ 1,  1835 }, --Balance
				{ 2,  1836 }, --Feral
				{ 3,  1837 }, --Tank
				{ 4,  1838 }, --Resto
				{ 6,  1839 }, --Ranged Hunter
				{ 7,  1840 }, --Melee Hunter
				{ 9,  1841 }, --Damage Mage
				{ 10, 1842 }, --Healer Mage
				{ 12, 1850 }, -- Healer Sham
				{ 13, 1851 }, -- Ele Sham
				{ 14, 1852 }, -- Tank Sham
				{ 15, 1853 }, -- Melee Sham
				{ 16, 1843 }, -- Holy Pally
				{ 17, 1844 }, -- Tank Pally
				{ 18, 1845 }, -- Ret Pally
				{ 20, 1846 }, -- Healer Priest
				{ 21, 1847 }, -- DPS Priest
				{ 23, 1848 }, -- DPS Rogue
				{ 24, 1849 }, -- Tank Rogue
				{ 26, 1854 }, -- DPS Lock
				{ 27, 1855 }, -- Tank Lock
				{ 29, 1856 }, -- Tank Warr
				{ 30, 1857 }, -- Dps Warr
			},
		},
		{ -- T3
			name = format(AL["Tier %s Sets"], "3"),
			[NORMAL_DIFF] = {
				{ 1,  1904 }, -- Druid Balance
				{ 2,  1903 }, -- Druid Feral
				{ 3,  1902 }, -- Druid Resto
				{ 4,  1901 }, -- Druid Tank
				{ 6,  1899 }, -- Hunter (Ranged)
				{ 7,  1900 }, -- Hunter (Melee)
				{ 9,  1898 }, -- Mage (DPS)
				{ 10, 1897 }, -- Mage (Healer)
				{ 12, 1889 }, -- Shaman (Ele)
				{ 13, 1888 }, -- Shaman (Enhance)
				{ 14, 1887 }, -- Shaman (Resto)
				{ 15, 1886 }, -- Shaman (Tank)
				{ 16, 1896 }, -- Paladin (DPS)
				{ 17, 1895 }, -- Paladin (Healer)
				{ 18, 1894 }, -- Paladin (Tank)
				{ 20, 1893 }, -- Priest (DPS)
				{ 21, 1892 }, -- Priest (Healer)
				{ 23, 1891 }, -- Rogue (DPS)
				{ 24, 1890 }, -- Rogue (Tank)
				{ 26, 1885 }, -- Warlock (DPS)
				{ 27, 1884 }, -- Warlock (Tank)
				{ 29, 1883 }, -- Warrior (DPS)
				{ 30, 1882 }, -- Warrior (Tank)
			},
		},
		{ -- T3.5
			name = format(AL["Tier %s Sets"], "3.5"),
			[NORMAL_DIFF] = {
				{ 1,  1945 }, -- Druid
				{ 2,  1946 }, -- Druid
				{ 3,  1947 }, -- Druid
				{ 4,  1948 }, -- Druid
				{ 6,  1936 }, -- Hunter
				{ 7,  1937 }, -- Hunter
				{ 9,  1943 }, -- Mage
				{ 10, 1944 }, -- Mage
				{ 12, 1949 }, -- Shaman
				{ 13, 1950 }, -- Shaman
				{ 14, 1951 }, -- Shaman
				{ 15, 1952 }, -- Shaman
				{ 16, 1940 }, -- Paladin
				{ 17, 1941 }, -- Paladin
				{ 18, 1942 }, -- Paladin
				{ 19, 1963 }, -- Paladin
				{ 21, 1938 }, -- Priest
				{ 22, 1939 }, -- Priest
				{ 23, 1934 }, -- Rogue
				{ 24, 1935 }, -- Rogue
				{ 26, 1953 }, -- Warlock
				{ 27, 1954 }, -- Warlock
				{ 29, 1932 }, -- Warrior
				{ 30, 1933 }, -- Warrior
			},
		},
	},
}

data["DungeonSets"] = {
	name = AL["Dungeon Sets"],
	ContentType = SET_CONTENT,
	TableType = SET_ITTYPE,
	items = {
		{ -- T0 / D1
			name = format(AL["Dungeon Set %s"], "1"),
			[NORMAL_DIFF] = {
				{ 1,  1666 },
				{ 3,  1668 },
				{ 5,  1670 },
				{ 7,  1672 },
				{ 9,  1674 },
				{ 16, 1677 },
				{ 18, 1678 },
				{ 20, 1680 },
				{ 22, 1682 },
			},
		},
		{ -- T0.5 / D2
			name = format(AL["Dungeon Set %s"], "2"),
			[NORMAL_DIFF] = {
				{ 1,  1667 },
				{ 3,  1669 },
				{ 5,  1671 },
				{ 7,  1673 },
				{ 9,  1675 },
				{ 16, 1676 },
				{ 18, 1679 },
				{ 20, 1681 },
				{ 22, 1778 },
			},
		},
	}
}

data["ZGSets"] = {
	name = format(AL["%s Sets"], C_Map_GetAreaInfo(1977)),
	ContentType = SET_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	ContentPhase = 4,
	items = {
		{
			name = format(AL["%s Sets"], C_Map_GetAreaInfo(1977)),
			[NORMAL_DIFF] = {
				{ 1,  1824 },
				{ 3,  1825 },
				{ 5,  1826 },
				{ 7,  1827 },
				{ 9,  1828 },
				{ 16, 1829 },
				{ 18, 1830 },
				{ 20, 1831 },
				{ 22, 1832 },
			},
		},
		{ -- Misc
			name = format(AL["%s Sets"], AL["Misc"]),
			[NORMAL_DIFF] = {
				-- Swords
				{ 1,  461 }, -- Warblade of the Hakkari
				{ 3,  463 }, -- Primal Blessing
				-- Rings
				{ 16, 466 }, -- Major Mojo Infusion
				{ 17, 462 }, -- Zanzil's Concentration
				{ 18, 465 }, -- Prayer of the Primal
				{ 19, 464 }, -- Overlord's Resolution
			},
		},
	},
}

data["AQSets"] = {
	name = format(AL["%s Sets"], C_Map_GetAreaInfo(3428)),
	ContentType = SET_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	ContentPhase = 5,
	items = {
		{ -- AQ20
			name = format(AL["%s Sets"], C_Map_GetAreaInfo(3428).." 20"),
			[NORMAL_DIFF] = {
				{ 1,  1860 },
				{ 3,  1862 },
				{ 5,  1865 },
				{ 7,  1858 },
				{ 9,  1863 },
				{ 16, 1859 },
				{ 18, 1864 },
				{ 20, 1861 },
				{ 22, 1866 },
			},
		},
		{ -- AQ40
			name = format(AL["%s Sets"], C_Map_GetAreaInfo(3428).." 40"),
			[ALLIANCE_DIFF] = {
				{ 1,  499 }, -- Warlock
				{ 3,  507 }, -- Priest
				{ 16, 503 }, -- Mage
				{ 5,  497 }, -- Rogue
				{ 20, 493 }, -- Druid
				{ 7,  509 }, -- Hunter
				{ 9,  496 }, -- Warrior
				{ 24, 505 }, -- Paladin
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 22, 501 }, -- Shaman
				{ 24 }, -- Paladin
			},
		},
	},
}

data["MiscSets"] = {
	name = format(AL["%s Sets"], AL["Misc"]),
	ContentType = SET_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = SET_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- Cloth
			name = ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1,  421 }, -- Bloodvine Garb / 65
				{ 2,  520 }, -- Ironweave Battlesuit / 61-63
				{ 3,  122 }, -- Necropile Raiment / 61
				{ 4,  81 }, -- Twilight Trappings / 61
				{ 5,  492 }, -- Twilight Trappings / 60
				{ 16, 536 }, -- Regalia of Undead Cleansing / 63
				{ 18, 1660 },
				{ 19, 1661 },
			},
		},
		{ -- Leather
			name = ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1,  442 }, -- Blood Tiger Harness / 65
				{ 2,  441 }, -- Primal Batskin / 65
				{ 3,  121 }, -- Cadaverous Garb / 61
				{ 4,  142 }, -- Stormshroud Armor / 55-62
				{ 5,  141 }, -- Volcanic Armor / 54-61
				{ 6,  143 }, -- Devilsaur Armor / 58-60
				{ 7,  144 }, -- Ironfeather Armor / 54-58
				{ 8,  221 }, -- Garb of Thero-shan / 32-42
				{ 9,  161 }, -- Defias Leather / 18-24
				{ 10, 162 }, -- Embrace of the Viper / 19-23
				{ 16, 534 }, -- Undead Slayer's Armor / 63
				{ 18, 1657 },
				{ 19, 1658 },
				{ 20, 1659 },
			},
		},
		{ -- Mail
			name = ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1,  443 }, -- Bloodsoul Embrace / 65
				{ 2,  123 }, -- Bloodmail Regalia / 61
				{ 3,  489 }, -- Black Dragon Mail / 58-62
				{ 4,  491 }, -- Blue Dragon Mail / 57-60
				{ 5,  1 }, -- The Gladiator / 57
				{ 6,  490 }, -- Green Dragon Mail / 52-56
				{ 7,  163 }, -- Chain of the Scarlet Crusade / 35-43
				{ 16, 535 }, -- Garb of the Undead Slayer / 63
				{ 18, 1654 },
				{ 19, 1655 },
				{ 20, 1656 },
			},
		},
		{ -- Plate
			name = ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1,  444 }, -- The Darksoul / 65
				{ 2,  124 }, -- Deathbone Guardian / 61
				{ 3,  321 }, -- Imperial Plate / 53-61
				{ 16, 533 }, -- Battlegear of Undead Slaying / 63
				{ 18, 1652 },
				{ 19, 1653 },
			},
		},
		{ -- Misc
			name = format(AL["%s Sets"], AL["Misc"]),
			[NORMAL_DIFF] = {
				-- Fist weapons
				{ 1,  261 }, -- Spirit of Eskhandar
				-- Swords
				{ 3,  41 }, -- Dal'Rend's Arms
				-- Dagger / Mace
				{ 5,  65 }, -- Spider's Kiss
				-- Trinket
				{ 16, 241 }, -- Shard of the Gods / 60
			},
		},
	},
}

data["WorldEpics"] = {
	name = AL["World Epics"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.WORLD_EPICS,
	items = {
		{
			name = AL["One-Handed Weapons"],
			[NORMAL_ITTYPE] = {
				-- Mace
				{ 1,  2243 }, -- Hand of Edward the Odd
				{ 2,  810 }, -- Hammer of the Northern Wind
				{ 3,  868 }, -- Ardent Custodian
				-- Axe
				{ 7,  811 }, -- Axe of the Deep Woods
				{ 8,  871 }, -- Flurry Axe
				-- Sword
				{ 16, 1728 }, -- Teebu's Blazing Longsword
				{ 17, 20698 }, -- Elemental Attuned Blade
				{ 18, 2244 }, -- Krol Blade
				{ 19, 809 }, -- Bloodrazor
				{ 20, 869 }, -- Dazzling Longsword
				-- Dagger
				{ 22, 14555 }, -- Alcor's Sunrazor
				{ 23, 2163 }, -- Shadowblade
				{ 24, 2164 }, -- Gut Ripper
			},
		},
		{
			name = AL["Two-Handed Weapons"],
			[NORMAL_ITTYPE] = {
				-- Axe
				{ 1,  2801 }, -- Blade of Hanna
				{ 2,  647 }, -- Destiny
				{ 3,  2291 }, -- Kang the Decapitator
				{ 4,  870 }, -- Fiery War Axe
				-- Mace
				{ 6,  2915 }, -- Taran Icebreaker
				-- Sword
				{ 16, 1263 }, -- Brain Hacker
				{ 17, 1982 }, -- Nightblade
				-- Staff
				{ 21, 944 }, -- Elemental Mage Staff
				{ 22, 812 }, -- Glowing Brightwood Staff
				{ 23, 943 }, -- Warden Staff
				{ 24, 873 }, -- Staff of Jordan
			},
		},
		{
			name = AL["Ranged Weapons"].." & "..ALIL["Shield"],
			[NORMAL_ITTYPE] = {
				-- Bow
				{ 1,  2824 }, -- Hurricane
				{ 2,  2825 }, -- Bow of Searing Arrows
				-- Gun
				{ 4,  2099 }, -- Dwarven Hand Cannon
				{ 5,  2100 }, -- Precisely Calibrated Boomstick
				-- Shield
				{ 16, 1168 }, -- Skullflame Shield
				{ 17, 1979 }, -- Wall of the Dead
				{ 18, 1169 }, -- Blackskull Shield
				{ 19, 1204 }, -- The Green Tower
			},
		},
		{
			name = ALIL["Trinket"].." & "..ALIL["Finger"].." & "..ALIL["Neck"],
			[NORMAL_ITTYPE] = {
				-- Trinket
				{ 1,  14557 }, -- The Lion Horn of Stormwind
				{ 2,  833 }, -- Lifestone
				-- Neck
				{ 6,  14558 }, -- Lady Maye's Pendant
				{ 7,  1443 }, -- Jeweled Amulet of Cainwyn
				{ 8,  1315 }, -- Lei of Lilies
				--Finger
				{ 16, 2246 }, -- Myrmidon's Signet
				{ 17, 942 }, -- Freezing Band
				{ 18, 1447 }, -- Ring of Saviors
				{ 19, 1980 }, -- Underworld Band
			},
		},
		{
			name = AL["Equip"],
			[NORMAL_ITTYPE] = {
				-- Cloth
				{ 1,  3075 }, -- Eye of Flame
				{ 2,  940 }, -- Robes of Insight
				-- Mail
				{ 4,  2245 }, -- Helm of Narv
				{ 5,  17007 }, -- Stonerender Gauntlets
				{ 6,  14551 }, -- Edgemaster's Handguards
				{ 7,  1981 }, -- Icemail Jerkin
				-- Back
				{ 9,  3475 }, -- Cloak of Flames
				-- Leather
				{ 16, 14553 }, -- Sash of Mercy
				{ 17, 867 }, -- Gloves of Holy Might
				-- Plate
				{ 19, 14554 }, -- Cloudkeeper Legplates
				{ 20, 14552 }, -- Stockade Pauldrons
				{ 21, 14549 }, -- Boots of Avoidance
			},
		},
	},
}

data["Mounts"] = {
	name = ALIL["Mounts"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.MOUNTS,
	items = {
		{
			name = AL["Faction Mounts"],
			[ALLIANCE_DIFF] = {
				{ 1,   18785 }, -- Swift White Ram
				{ 2,   18786 }, -- Swift Brown Ram
				{ 3,   18787 }, -- Swift Gray Ram
				{ 16,  5873 }, -- White Ram
				{ 17,  5872 }, -- Brown Ram
				{ 18,  5864 }, -- Gray Ram
				{ 5,   18772 }, -- Swift Green Mechanostrider
				{ 6,   18773 }, -- Swift White Mechanostrider
				{ 7,   18774 }, -- Swift Yellow Mechanostrider
				{ 20,  13321 }, -- Green Mechanostrider
				{ 21,  13322 }, -- Unpainted Mechanostrider
				{ 22,  8563 }, -- Red Mechanostrider
				{ 23,  8595 }, -- Blue Mechanostrider
				{ 10,  18776 }, -- Swift Palomino
				{ 11,  18777 }, -- Swift Brown Steed
				{ 12,  18778 }, -- Swift White Steed
				{ 25,  2414 }, -- Pinto Bridle
				{ 26,  5656 }, -- Brown Horse Bridle
				{ 27,  5655 }, -- Chestnut Mare Bridle
				{ 28,  2411 }, -- Black Stallion Bridle
				{ 101, 18902 }, -- Reins of the Swift Stormsaber
				{ 102, 18767 }, -- Reins of the Swift Mistsaber
				{ 103, 18766 }, -- Reins of the Swift Frostsaber
				{ 116, 8632 }, -- Reins of the Spotted Frostsaber
				{ 117, 8631 }, -- Reins of the Striped Frostsaber
				{ 118, 8629 }, -- Reins of the Striped Nightsaber
			},
			[HORDE_DIFF] = {
				{ 1,  18798 }, -- Horn of the Swift Gray Wolf
				{ 2,  18797 }, -- Horn of the Swift Timber Wolf
				{ 3,  18796 }, -- Horn of the Swift Brown Wolf
				{ 16, 5668 }, -- Horn of the Brown Wolf
				{ 17, 5665 }, -- Horn of the Dire Wolf
				{ 18, 1132 }, -- Horn of the Timber Wolf
				{ 5,  18795 }, -- Great Gray Kodo
				{ 6,  18794 }, -- Great Brown Kodo
				{ 7,  18793 }, -- Great White Kodo
				{ 20, 15290 }, -- Brown Kodo
				{ 21, 15277 }, -- Gray Kodo
				{ 9,  18790 }, -- Swift Orange Raptor
				{ 10, 18789 }, -- Swift Olive Raptor
				{ 11, 18788 }, -- Swift Blue Raptor
				{ 24, 8592 }, -- Whistle of the Violet Raptor
				{ 25, 8591 }, -- Whistle of the Turquoise Raptor
				{ 26, 8588 }, -- Whistle of the Emerald Raptor
				{ 13, 18791 }, -- Purple Skeletal Warhorse
				{ 14, 13334 }, -- Green Skeletal Warhorse
				{ 28, 13333 }, -- Brown Skeletal Horse
				{ 29, 13332 }, -- Blue Skeletal Horse
				{ 30, 13331 }, -- Red Skeletal Horse
			},
		},
		{ -- PvPMountsPvP
			name = AL["PvP"],
			[ALLIANCE_DIFF] = {
				{ 1, 19030 },           -- Stormpike Battle Charger
				{ 3, GetForVersion(18244, 29467) }, -- Black War Ram
				{ 4, GetForVersion(18243, 29465) }, -- Black Battlestrider
				{ 5, GetForVersion(18241, 29468) }, -- Black War Steed Bridle
				{ 6, GetForVersion(18242, 29471) }, -- Reins of the Black War Tiger
			},
			[HORDE_DIFF] = {
				{ 1, 19029 },           -- Horn of the Frostwolf Howler
				{ 3, GetForVersion(18245, 29469) }, -- Horn of the Black War Wolf
				{ 4, GetForVersion(18247, 29466) }, -- Black War Kodo
				{ 5, GetForVersion(18246, 29472) }, -- Whistle of the Black War Raptor
				{ 6, GetForVersion(18248, 29470) }, -- Red Skeletal Warhorse
			},
		},
		{ -- Drops
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 13335 }, -- Deathcharger's Reins
				{ 3, 19872 }, -- Swift Razzashi Raptor
				{ 5, 19902 }, -- Swift Zulian Tiger
			},
		},
		{ -- Reputation
			name = AL["Reputation"],
			[ALLIANCE_DIFF] = {
				{ 1, 13086 }, -- Reins of the Winterspring Frostsaber
			}
		},
		{
			name = ALIL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 21176 }, -- Black Qiraji Resonating Crystal
				{ 3, 23720 }, -- Riding Turtle
			},
		},
		{ -- AQ40
			MapID = 3428,
			[NORMAL_DIFF] = {
				{ 1, 21218 }, -- Blue Qiraji Resonating Crystal
				{ 2, 21323 }, -- Green Qiraji Resonating Crystal
				{ 3, 21321 }, -- Red Qiraji Resonating Crystal
				{ 4, 21324 }, -- Yellow Qiraji Resonating Crystal
			},
		},
	},
}

data["Companions"] = {
	name = ALIL["Companions"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.COMPANIONS,
	items = {
		{
			name = AL["Crafting"],
			[NORMAL_DIFF] = {
				{ 1, 15996 }, -- Lifelike Mechanical Toad
				{ 2, 11826 }, -- Lil' Smoky
				{ 3, 4401 }, -- Mechanical Squirrel Box
				{ 4, 11825 }, -- Pet Bombling
				{ 5, 21277 }, -- Tranquil Mechanical Yeti
			},
		},
		{
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1,  8494 }, -- Parrot Cage (Hyacinth Macaw)
				{ 2,  8492 }, -- Parrot Cage (Green Wing Macaw)
				{ 4,  8498 }, -- Tiny Emerald Whelpling
				{ 5,  8499 }, -- Tiny Crimson Whelpling
				{ 6,  10822 }, -- Dark Whelpling
				{ 8,  8490 }, -- Cat Carrier (Siamese)
				{ 9,  8491 }, -- Cat Carrier (Black Tabby)
				{ 16, 20769 }, -- Disgusting Oozeling
				{ 17, 11110 }, -- Chicken Egg
			},
		},
		{
			name = AL["Quest"],
			[NORMAL_DIFF] = {
				{ 1, 12264 }, -- Worg Carrier
				{ 2, 11474 }, -- Sprite Darter Egg
				{ 3, 12529 }, -- Smolderweb Carrier
				{ 4, 10398 }, -- Mechanical Chicken
			},
		},
		{
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
				{ 1,  11023 }, -- Ancona Chicken
				{ 2,  10393 }, -- Cockroach
				{ 3,  10394 }, -- Prairie Dog Whistle
				{ 4,  10392 }, -- Crimson Snake
				{ 5,  8497 }, -- Rabbit Crate (Snowshoe)
				{ 7,  10360 }, -- Black Kingsnake
				{ 8,  10361 }, -- Brown Snake
				{ 10, 8500 }, -- Great Horned Owl
				{ 11, 8501 }, -- Hawk Owl
				{ 16, 8485 }, -- Cat Carrier (Bombay)
				{ 17, 8486 }, -- Cat Carrier (Cornish Rex)
				{ 18, 8487 }, -- Cat Carrier (Orange Tabby)
				{ 19, 8490 }, -- Cat Carrier (Siamese)
				{ 20, 8488 }, -- Cat Carrier (Silver Tabby)
				{ 21, 8489 }, -- Cat Carrier (White Kitten)
				{ 23, 8496 }, -- Parrot Cage (Cockatiel)
				{ 24, 8495 }, -- Parrot Cage (Senegal)
				{ 26, 11026 }, -- Tree Frog Box
				{ 27, 11027 }, -- Wood Frog Box
			},
		},
		{
			name = AL["World Events"],
			[NORMAL_DIFF] = {
				{ 1,  21305 }, -- Red Helper Box
				{ 2,  21301 }, -- Green Helper Box
				{ 3,  21308 }, -- Jingling Bell
				{ 4,  21309 }, -- Snowman Kit
				{ 16, 22235 }, -- Truesilver Shafted Arrow
				{ 18, 23083 }, -- Captured Flame
				{ 20, 23015 }, -- Rat Cage
				{ 21, 22781 }, -- Polar Bear Collar
				{ 22, 23007 }, -- Piglet's Collar
				{ 23, 23002 }, -- Turtle Box
			},
		},
		{ -- Unobtainable
			name = AL["Unobtainable"],
			[NORMAL_DIFF] = {
				{ 1,  13582 }, -- Zergling Leash
				{ 2,  13584 }, -- Diablo Stone
				{ 3,  13583 }, -- Panda Collar
				{ 16, 22780 }, -- White Murloc Egg
				{ 17, 22114 }, -- Pink Murloc Egg
				{ 18, 20651 }, -- Orange Murloc Egg
				{ 19, 20371 }, -- Blue Murloc Egg
			},
		},
	},
}

data["Tabards"] = {
	name = ALIL["Tabard"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.TABARDS,
	items = {
		{
			name = ALIL["Tabard"],
			[NORMAL_DIFF] = {
				{ 1, 23192 }, -- Tabard of the Scarlet Crusade
			},
		},
		{ -- Faction
			name = AL["Capitals"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1,  45579 },                                         -- Darnassus Tabard
				{ 2,  45577 },                                         -- Ironforge Tabard
				{ 3,  45578 },                                         -- Gnomeregan Tabard
				{ 4,  45574 },                                         -- Stormwind Tabard
				{ 16, 45580 },                                         -- Exodar Tabard
				AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 17, 64882 }), -- Gilneas Tabard
			},
			[HORDE_DIFF] = {
				{ 1, 45582 },                                          -- Darkspear Tabard
				{ 2, 45581 },                                          -- Orgrimmar Tabard
				{ 3, 45584 },                                          -- Thunder Bluff Tabard
				{ 4, 45583 },                                          -- Undercity Tabard
				AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 16, 45585 }), -- Silvermoon City Tabard
			},
		},
		{
			name = format("%s - %s", AL["Factions"], AL["Classic"]),
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, 43154 }, -- Tabard of the Argent Crusade
			},
		},
		{ -- PvP
			name = AL["PvP"],
			[ALLIANCE_DIFF] = {
				{ 1,  15196 }, -- Private's Tabard
				{ 2,  15198 }, -- Knight's Colors
				{ 16, 19506 }, -- Silverwing Battle Tabard
				{ 17, 19032 }, -- Stormpike Battle Tabard
				{ 18, 20132 }, -- Arathor Battle Tabard
			},
			[HORDE_DIFF] = {
				{ 1,  15197 }, -- Scout's Tabard
				{ 2,  15199 }, -- Stone Guard's Herald
				{ 16, 19505 }, -- Warsong Battle Tabard
				{ 17, 19031 }, -- Frostwolf Battle Tabard
				{ 18, 20131 }, -- Battle Tabard of the Defilers
			},
		},
		{ -- PvP
			name = AL["Arena"],
			[NORMAL_DIFF] = {
				{ 1, 45983 }, -- Furious Gladiator's Tabard
				{ 2, 49086, }, -- Relentless Gladiator's Tabard
				{ 3, 51534 }, -- Wrathful Gladiator's Tabard
			},
		},
		{ -- Unobtainable Tabards
			name = AL["Unobtainable"],
			[NORMAL_DIFF] = {
				{ 1,  19160 },                                        -- Contest Winner's Tabard
				AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 3, 36941 }), -- Competitor's Tabard
				AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, { 5, 28788 }), -- Tabard of the Protector
				{ 16, "INV_Box_01", nil, AL["Card Game Tabards"], nil },
				{ 17, 38312 },                                        -- Tabard of Brilliance
				{ 18, 23705 },                                        -- Tabard of Flame
				{ 19, 23709 },                                        -- Tabard of Frost
				{ 20, 38313 },                                        -- Tabard of Fury
				{ 21, 38309 },                                        -- Tabard of Nature
				{ 22, 38310 },                                        -- Tabard of the Arcane
				{ 23, 38314 },                                        -- Tabard of the Defender
				{ 24, 38311 },                                        -- Tabard of the Void
			},
		},
	},
}
data["Toys"] = {
	name = AL["Toys"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["Toys"],
			[NORMAL_DIFF] = {
				{ 1,  215449 },                        -- World Shrinker
				{ 2,  223160 },                        -- Bargain Bush
				{ 3,  223161 },                        -- Empty Supply Crate
				{ 4,  215437 },                        -- Trogg Transfigurator 3000
				{ 5,  220635 },                        -- Atal'alarion's Enchanted Boulder
				{ 6,  221484 },                        -- Witch Doctor's Hex Stick
				{ 7,  220638 },                        -- Unorthodox Hex Stick
				{ 8,  216494 },                        -- Aragriar's Whimsical World Warper
				{ 9,  216608 },                        -- Radiant Ray Reflectors
				{ 10, 220639 },                        -- Lledra's Inanimator
				{ 11, 220619 },                        -- Atal'ai Blood Ceremony
				{ 16, 234144 },                        -- Censer of the False Prophet
				{ 17, 234447 },                        -- Bubbles' Rod of Transformation
				{ 18, 234467 },                        -- Bubbles' Rod of Dragons
				{ 19, 234464 },                        -- Bubbles' Rod of Bubbles
				{ 20, 234142, [PRICE_EXTRA_ITTYPE] = "8529:200" }, -- Bottomless Noggenfogger Elixir
				{ 21, 234143, [PRICE_EXTRA_ITTYPE] = "1973:1" }, -- Globe of Deception
			},
		},
	},
}

data["Legendarys"] = {
	name = AL["Legendarys"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.LEGENDARYS,
	items = {
		{
			name = AL["Legendarys"],
			[NORMAL_ITTYPE] = {
				{ 1,  19019 }, -- Thunderfury, Blessed Blade of the Windseeker

				{ 3,  22631 }, -- Atiesh, Greatstaff of the Guardian / Priest
				{ 4,  22589 }, -- Atiesh, Greatstaff of the Guardian / Mage
				{ 5,  22630 }, -- Atiesh, Greatstaff of the Guardian / Warlock
				{ 6,  22632 }, -- Atiesh, Greatstaff of the Guardian / Druid

				{ 16, 17182 }, -- Sulfuras, Hand of Ragnaros

				{ 18, 21176 }, -- Black Qiraji Resonating Crystal
			},
		},
		{
			name = ALIL["Quest Item"],
			[NORMAL_ITTYPE] = {
				{ 1,  232018 }, -- Dormant Wind Kissed Blade
				{ 2,  19017 }, -- Essence of the Firelord
				{ 3,  19016 }, -- Vessel of Rebirth
				{ 4,  18564 }, -- Bindings of the Windseeker / Right
				{ 5,  18563 }, -- Bindings of the Windseeker / Left
				{ 7,  17204 }, -- Eye of Sulfuras
				{ 9,  17771 }, -- Elementium Bar
				{ 16, 22736 }, -- Andonisus, Reaper of Souls
				{ 17, 22737 }, -- Atiesh, Greatstaff of the Guardian
				{ 18, 22733 }, -- Staff Head of Atiesh
				{ 19, 22734 }, -- Base of Atiesh
				{ 20, 22727 }, -- Frame of Atiesh
				{ 21, 22726 }, -- Splinter of Atiesh
			},
		},
		{
			name = AL["Unobtainable"],
			[NORMAL_ITTYPE] = {
				{ 1,  17782 }, -- Talisman of Binding Shard
				{ 16, 20221 }, -- Foror's Fabled Steed
			},
		},
	},
}

data["WaylaidSupplies"] = {
	name = AL["Waylaid Supplies"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["Level 25"],
			[NORMAL_DIFF] = {
				{ 1,   211322 }, -- Waylaid Supplies: Minor Wizard Oil
				{ 2,   211321 }, -- Waylaid Supplies: Lesser Magic Wands
				{ 3,   211318 }, -- Waylaid Supplies: Minor Healing Potions
				{ 4,   211320 }, -- Waylaid Supplies: Runed Copper Pants
				{ 5,   211323 }, -- Waylaid Supplies: Rough Copper Bombs
				{ 6,   211329 }, -- Waylaid Supplies: Herb Baked Eggs
				{ 7,   211326 }, -- Waylaid Supplies: Embossed Leather Vests
				{ 8,   211332 }, -- Waylaid Supplies: Heavy Linen Bandages
				{ 9,   211319 }, -- Waylaid Supplies: Copper Shortswords
				{ 10,  211330 }, -- Waylaid Supplies: Spiced Wolf Meat
				{ 11,  211324 }, -- Waylaid Supplies: Rough Boomsticks
				{ 12,  211327 }, -- Waylaid Supplies: Brown Linen Pants
				{ 13,  211317 }, -- Waylaid Supplies: Silverleaf
				{ 14,  211325 }, -- Waylaid Supplies: Handstitched Leather Belts
				{ 15,  211328 }, -- Waylaid Supplies: Brown Linen Robes
				{ 16,  211934 }, -- Waylaid Supplies: Healing Potions
				{ 17,  211315 }, -- Waylaid Supplies: Light Leather
				{ 18,  211331 }, -- Waylaid Supplies: Brilliant Smallfish
				{ 19,  210771 }, -- Waylaid Supplies: Copper Bars
				{ 20,  211933 }, -- Waylaid Supplies: Rough Stone
				{ 21,  211316 }, -- Waylaid Supplies: Peacebloom
				{ 22,  211828 }, -- Waylaid Supplies: Minor Mana Oil
				{ 23,  211824 }, -- Waylaid Supplies: Lesser Mana Potions
				{ 24,  211835 }, -- Waylaid Supplies: Smoked Sagefish
				{ 25,  211829 }, -- Waylaid Supplies: Small Bronze Bombs
				{ 26,  211822 }, -- Waylaid Supplies: Bruiseweed
				{ 27,  211838 }, -- Waylaid Supplies: Heavy Wool Bandages
				{ 28,  211825 }, -- Waylaid Supplies: Rough Bronze Boots
				{ 29,  211836 }, -- Waylaid Supplies: Smoked Bear Meat
				{ 30,  211831 }, -- Waylaid Supplies: Dark Leather Cloaks
				{ 101, 211837 }, -- Waylaid Supplies: Goblin Deviled Clams
				{ 102, 211820 }, -- Waylaid Supplies: Silver Bars
				{ 103, 211821 }, -- Waylaid Supplies: Medium Leather
				{ 104, 211833 }, -- Waylaid Supplies: Gray Woolen Shirts
				{ 105, 211827 }, -- Waylaid Supplies: Runed Silver Rods
				{ 106, 211819 }, -- Waylaid Supplies: Bronze Bars
				{ 107, 211830 }, -- Waylaid Supplies: Ornate Spyglasses
				{ 108, 211826 }, -- Waylaid Supplies: Silver Skeleton Keys
				{ 109, 211935 }, -- Waylaid Supplies: Elixir of Firepower
				{ 110, 211834 }, -- Waylaid Supplies: Pearl-clasped Cloaks
				{ 111, 211823 }, -- Waylaid Supplies: Swiftthistle
				{ 112, 211832 }, -- Waylaid Supplies: Hillman's Shoulders
			},
		},
		{
			name = AL["Level 40"],
			[NORMAL_DIFF] = {
				{ 1,   215403 }, -- Waylaid Supplies: Deadly Scopes
				{ 2,   215400 },
				{ 3,   215402 },
				{ 4,   215389 },
				{ 5,   215391 },
				{ 6,   215411 }, -- Waylaid Supplies: Frost Leather Cloaks
				{ 7,   215398 },
				{ 8,   215387 },
				{ 9,   215420 },
				{ 10,  215421 },
				{ 11,  215413 },
				{ 12,  215408 }, -- Waylaid Supplies: Frost Leather Cloaks
				{ 13,  215392 },
				{ 14,  215386 },
				{ 15,  215390 },
				{ 16,  215399 },
				{ 17,  215395 }, -- Waylaid Supplies: Elixirs of Agility
				{ 18,  215388 },
				{ 19,  215393 },
				{ 20,  215401 }, -- Waylaid Supplies: Compact Harvest Reaper Kits
				{ 21,  215419 },
				{ 22,  215414 },
				{ 23,  215385 },
				{ 24,  215417 },
				{ 25,  215415 },
				{ 26,  215407 },
				{ 27,  215418 }, -- Waylaid Supplies: Spider Sausages
				{ 28,  215404 },
				{ 29,  215396 },
				{ 30,  215397 },
				{ 101, 215409 },
				{ 102, 215416 }, -- Waylaid Supplies: White Bandit Masks
			},
		},
		{
			name = AL["Level 50"],
			[NORMAL_DIFF] = {
				{ 1,  220927 }, -- Waylaid Supplies: Thick Hide
				{ 2,  220926 }, --Waylaid Supplies: Rugged Leather
				{ 3,  220925 }, --Waylaid Supplies: Thorium Bars
				{ 4,  220924 }, --Waylaid Supplies: Truesilver Bars
				{ 5,  220923 }, --Waylaid Supplies: Dreamfoil
				{ 6,  220922 }, --Waylaid Supplies: Sungrass
				{ 7,  220921 }, --Waylaid Supplies: Heavy Mageweave Bandages
				{ 8,  220920 }, --Waylaid Supplies: Tender Wolf Steaks
				{ 9,  220919 }, --Waylaid Supplies: Nightfin Soup
				{ 10, 220918 }, --Waylaid Supplies: Undermine Clam Chowder
				{ 11, 220942 }, --Waylaid Supplies: Tuxedo Shirts
				{ 12, 220941 }, --Waylaid Supplies: Runecloth Belts
				{ 13, 220940 }, --Waylaid Supplies: Black Mageweave Headbands
				{ 14, 220939 }, --Waylaid Supplies: Runic Leather Bracers
				{ 15, 220938 }, --Waylaid Supplies: Wicked Leather Bracers
				{ 16, 220937 }, --Waylaid Supplies: Rugged Armor Kits
				{ 17, 220936 }, --Waylaid Supplies: Truesilver Gauntlets
				{ 18, 220935 }, --Waylaid Supplies: Thorium Belts
				{ 19, 220934 }, --Waylaid Supplies: Mithril Coifs
				{ 20, 220933 }, --Waylaid Supplies: Thorium Rifles
				{ 21, 220932 }, --Waylaid Supplies: Thorium Grenades
				{ 22, 220931 }, --Waylaid Supplies: Hi-Explosive Bombs
				{ 23, 220930 }, --Waylaid Supplies: Major Healing Potions
				{ 24, 220929 }, -- Waylaid Supplies: Superior Mana Potions
				{ 25, 220928 }, -- Waylaid Supplies: Enchanted Thorium Bars
			},
		},
	},
}

data["SoDVendors"] = {
	name = AL["Vendors"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["Tarnished Undermine Reals - Tier Sets"],
			[NORMAL_DIFF] = {
				{ 1,   227533,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Incandescent Gloves
				{ 2,   227756,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Molten Scaled Gloves
				{ 3,   227759,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Scorched Core Gloves
				{ 5,   227531,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Incandescent Bindings
				{ 6,   227750,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Molten Scaled Bindings
				{ 7,   227760,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Scorched Core Bindings
				{ 9,   227530,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Incandescent Belt
				{ 10,  227751,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Molten Scaled Belt
				{ 11,  227761,       [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Scorched Core Belt
				{ 13,  227536,       [PRICE_EXTRA_ITTYPE] = "TUF:20" }, -- Incandescent Boots
				{ 14,  227757,       [PRICE_EXTRA_ITTYPE] = "TUF:20" }, -- Molten Scaled Boots
				{ 15,  227765,       [PRICE_EXTRA_ITTYPE] = "TUF:20" }, -- Scorched Core Boots
				{ 16,  227537,       [PRICE_EXTRA_ITTYPE] = "TUF:20" }, -- Incandescent Shoulderpads
				{ 17,  227752,       [PRICE_EXTRA_ITTYPE] = "TUF:20" }, -- Molten Scaled Shoulderpads
				{ 18,  227762,       [PRICE_EXTRA_ITTYPE] = "TUF:20" }, -- Scorched Core Shoulderpads
				{ 20,  227534,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Incandescent Leggings
				{ 21,  227754,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Molten Scaled Leggings
				{ 22,  227763,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Scorched Core Leggings
				{ 24,  227535,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Incandescent Robe
				{ 25,  227766,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Scorched Core Chest
				{ 26,  227758,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Molten Scaled Chest
				{ 28,  227532,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Incandescent Hood
				{ 29,  227764,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Scorched Core Helm
				{ 30,  227755,       [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Molten Scaled Helm
				{ 101, 231724,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Ancient Bindings
				{ 102, 231715,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Primeval Bindings
				{ 103, 231707,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Draconian Bindings
				{ 105, 231729,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Ancient Gloves
				{ 106, 231720,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Primeval Gloves
				{ 107, 231712,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Draconian Gloves
				{ 109, 231730,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Ancient Boots
				{ 110, 231721,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Primeval Boots
				{ 111, 231713,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Draconian Boots
				{ 113, 231725,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Ancient Belt
				{ 114, 231716,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Primeval Belt
				{ 115, 231708,       [PRICE_EXTRA_ITTYPE] = "TUF:35" }, -- Draconian Belt
				{ 116, "INV_Box_01", nil,                            AL["Dungeon Set 1"],     nil },
				{ 117, "INV_Box_01", nil,                            AL["Bracers"],           [PRICE_EXTRA_ITTYPE] = "TUF:15" },
				{ 118, "INV_Box_01", nil,                            AL["Boots, Gloves"],     [PRICE_EXTRA_ITTYPE] = "TUF:25" },
				{ 119, "INV_Box_01", nil,                            AL["Shoulders, Belt"],   [PRICE_EXTRA_ITTYPE] = "TUF:25" },
				{ 120, "INV_Box_01", nil,                            AL["Helm, Chest, Legs"], [PRICE_EXTRA_ITTYPE] = "TUF:50" },
			},
		},
		{
			name = AL["Tarnished Undermine Reals - Gear"],
			[NORMAL_DIFF] = {
				{ 1,  227284, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Band of the Beast
				{ 2,  227279, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Loop of the Magister
				{ 3,  227280, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Craft of the Shadows
				{ 4,  227282, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Ring of the Dreaded Mist
				{ 5,  228432, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Whistle of the Beast
				{ 6,  228168, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Goblin Gear Grinder
				{ 7,  228169, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- The Attitude Adjustor
				{ 8,  228170, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Makeshift South Sea Oar
				{ 9,  228185, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Broken Bottle of Goblino Noir
				{ 10, 228184, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Goblin Clothesline
				{ 12, 228186, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Abandoned Wedding Band
				{ 13, 228187, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Stick of the South Sea
				{ 14, 227990, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Hand of Injustice
				{ 16, 220597, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Drakestone of the Dream Harbinger
				{ 17, 220598, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Drakestone of the Nightmare Harbinger
				{ 18, 220599, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Drakestone of the Blood Prophet
			},
		},
		{
			name = AL["Tarnished Undermine Reals - Relics"],
			[NORMAL_DIFF] = {
				{ 1,  232390, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Idol of Celestial Focus
				{ 2,  232391, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Idol of Feline Focus
				{ 3,  232423, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Idol of Nurture
				{ 4,  232424, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Idol of Cruelty
				{ 6,  231811, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Libram of Awe
				{ 7,  232389, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Libram of Plenty
				{ 8,  232420, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Libram of Wrath
				{ 9,  232421, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Libram of Avenging
				{ 11, 232392, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Totem of Relentless Thunder
				{ 12, 232409, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Totem of the Elements
				{ 13, 232416, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Totem of Astral Flow
				{ 14, 232419, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Totem of Conductive Elements
				{ 16, 228180, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Idol of the Swarm
				{ 17, 228181, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Idol of Exsanguination (Cat)
				{ 18, 228182, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Idol of Exsanguination (Bear)
				{ 19, 228183, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Idol of the Grove
				{ 21, 228173, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Libram of the Consecrated
				{ 22, 228174, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Libram of the Devoted
				{ 23, 228175, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Libram of Holy Alacrity
				{ 26, 228176, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Totem of Thunder
				{ 27, 228177, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Totem of Raging Fire
				{ 28, 228178, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Totem of Earthen Vitality
				{ 29, 228179, [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Totem of the Plains
			},
		},
		{
			name = AL["Tarnished Undermine Reals - Other"],
			[NORMAL_DIFF] = {
				{ 1,  236414, [PRICE_EXTRA_ITTYPE] = "TUF:10" }, -- Damaged Undermine Supply Crate
				{ 2,  237386, [PRICE_EXTRA_ITTYPE] = "TUF:10" }, -- Damaged Undermine Supply Crate
				{ 3,  228171, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Kezan Cash Carrier
				{ 4,  228189, [PRICE_EXTRA_ITTYPE] = "TUF:25" }, -- Gift of Gob
				{ 6,  228121, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Pattern: Leather-Reinforced Runecloth Bag
				{ 7,  13518,  [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Recipe: Flask of Petrification 50
				{ 8,  13519,  [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Recipe: Flask of the Titans 50
				{ 9,  13520,  [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Recipe: Flask of Distilled Wisdom 50
				{ 10, 13521,  [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Recipe: Flask of Supreme Power 50
				{ 11, 13522,  [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Recipe: Flask of Chromatic Resistance 50
				{ 13, 17011,  [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Lava Core
				{ 14, 17010,  [PRICE_EXTRA_ITTYPE] = "TUF:15" }, -- Fiery Core
				{ 15, 17012,  [PRICE_EXTRA_ITTYPE] = "TUF:10" }, -- Core Leather
				{ 16, 231996, [PRICE_EXTRA_ITTYPE] = "TUF:50" }, -- Supercharged Gobmogrifier
				{ 18, 231995, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Hardened Elementium Slag
				{ 19, 229352, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Intelligence Findings
				{ 20, 230904, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Scroll: SEENECS FO RIEF
				{ 21, 231378, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Shimmering Golden Disk
				{ 22, 231452, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Blood of the Lightbringer
				{ 23, 231722, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Depleted Scythe of Chaos
				{ 24, 231814, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Chromatic Heart
				{ 25, 231882, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Suppression Device Receipt
				{ 26, 229906, [PRICE_EXTRA_ITTYPE] = "TUF:150" }, -- Tarnished Bronze Scale
			},
		},
		{
			name = AL["Wild Offerings"],
			[NORMAL_DIFF] = {
				{ 1, 223194, [PRICE_EXTRA_ITTYPE] = "wildoffering:12" }, -- Band of the Wilds
				{ 2, 223195, [PRICE_EXTRA_ITTYPE] = "wildoffering:12" }, -- Breadth of the Beast
				{ 3, 223197, [PRICE_EXTRA_ITTYPE] = "wildoffering:12" }, -- Defender of the Wilds
				{ 4, 223192, [PRICE_EXTRA_ITTYPE] = "wildoffering:15" }, -- Cord of the Untamed
				{ 5, 223193, [PRICE_EXTRA_ITTYPE] = "wildoffering:15" }, -- Crown of the Dreamweaver
				{ 6, 223196, [PRICE_EXTRA_ITTYPE] = "wildoffering:15" }, -- Godslayer's Greaves
				{ 7, 221491, [PRICE_EXTRA_ITTYPE] = "wildoffering:10" }, -- Shadowtooth Bag
			},
		},
		{
			name = AL["Firelands Embers"],
			[NORMAL_DIFF] = {
				{ 1, 7076,  [PRICE_EXTRA_ITTYPE] = "firelandsember:30" }, -- Essence of Earth
				{ 2, 7080,  [PRICE_EXTRA_ITTYPE] = "firelandsember:30" }, -- Essence of Water
				{ 3, 7082,  [PRICE_EXTRA_ITTYPE] = "firelandsember:30" }, -- Essence of Air
				{ 4, 7078,  [PRICE_EXTRA_ITTYPE] = "firelandsember:30" }, -- Essence of Fire
				{ 5, 11382, [PRICE_EXTRA_ITTYPE] = "firelandsember:30" }, -- Blood of the Mountain
			},
		},
	},
}

data["Darkmoon"] = {
	FactionID = 909,
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	ContentPhase = 3,
	items = {
		{ -- Exalted
			name = GetFactionInfoByID(909),
			[NORMAL_DIFF] = {
				{ 1,  19491, 19182, [ATLASLOOT_IT_AMOUNT2] = 1200 }, -- Amulet of the Darkmoon
				{ 2,  19426, 19182, [ATLASLOOT_IT_AMOUNT2] = 1200 }, -- Orb of the Darkmoon
				{ 4,  19293, 19182, [ATLASLOOT_IT_AMOUNT2] = 50 }, -- Last Year's Mutton
				{ 5,  19291, 19182, [ATLASLOOT_IT_AMOUNT2] = 50 }, -- Darkmoon Storage Box
				{ 7,  9249,  19182, [ATLASLOOT_IT_AMOUNT2] = 40 }, -- Schematic: Steam Tonk Controller
				{ 8,  19296, 19182, [ATLASLOOT_IT_AMOUNT2] = 40 }, -- Greater Darkmoon Prize
				{ 10, 19297, 19182, [ATLASLOOT_IT_AMOUNT2] = 12 }, -- Lesser Darkmoon Prize
				{ 12, 19292, 19182, [ATLASLOOT_IT_AMOUNT2] = 10 }, -- Last Month's Mutton
				{ 14, 19298, 19182, [ATLASLOOT_IT_AMOUNT2] = 5 }, -- Minor Darkmoon Prize
				{ 15, 19295, 19182, [ATLASLOOT_IT_AMOUNT2] = 5 }, -- Darkmoon Flower
			},
		},
		{
			name = AL["Classic"],
			[NORMAL_DIFF] = {
				{ 1, 235278 }, -- Darkmoon Card: Blue Dragon
				{ 2, 235276 }, -- Darkmoon Card: Maelstrom
				{ 3, 235277 }, -- Darkmoon Card: Heroism
				{ 4, 235275 }, -- Darkmoon Card: Twisting Nether
				{ 6, 221272 }, -- Darkmoon Card: Overgrowth
				{ 7, 221280 }, -- Darkmoon Card: Decay
				{ 8, 221289 }, -- Darkmoon Card: Sandstorm
				{ 9, 221299 }, -- Darkmoon Card: Torment
			},
		},
		AtlasLoot:GameVersion_GE(AtlasLoot.BC_VERSION_NUM, {
			name = AL["BC"],
			[NORMAL_DIFF] = {
				{ 1, 31907 }, -- Darkmoon Card: Vengeance
				{ 2, 31890 }, -- Darkmoon Card: Crusade
				{ 3, 31891 }, -- Darkmoon Card: Wrath
				{ 4, 31914 }, -- Darkmoon Card: Madness
			},
		}),
		AtlasLoot:GameVersion_GE(AtlasLoot.WRATH_VERSION_NUM, {
			name = AL["Wrath"],
			[NORMAL_DIFF] = {
				{ 1, 44276 }, -- Chaos Deck
				{ 2, 44259 }, -- Prisms Deck
				{ 3, 44294 }, -- Undeath Deck
				{ 4, 44326 }, -- Nobles Deck
			},
		}),
	},
}

data["GurubashiArena"] = {
	name = AL["Gurubashi Arena"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- GurubashiArena
			name = AL["Gurubashi Arena"],
			[NORMAL_DIFF] = {
				{ 1,  18709 }, -- Arena Wristguards
				{ 2,  18710 }, -- Arena Bracers
				{ 3,  18711 }, -- Arena Bands
				{ 4,  18712 }, -- Arena Vambraces
				{ 16, 18706 }, -- Arena Master
			},
		},
	},
}

data["FishingExtravaganza"] = {
	name = AL["Stranglethorn Fishing Extravaganza"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- FishingExtravaganza
			name = AL["Stranglethorn Fishing Extravaganza"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["First Prize"] },
				{ 2,  19970 }, -- Arcanite Fishing Pole
				{ 3,  19979 }, -- Hook of the Master Angler
				{ 5,  "INV_Box_01", nil, AL["Rare Fish"] },
				{ 6,  19805 }, -- Keefer's Angelfish
				{ 7,  19803 }, -- Brownell's Blue Striped Racer
				{ 8,  19806 }, -- Dezian Queenfish
				{ 9,  19808 }, -- Rockhide Strongfish
				{ 20, "INV_Box_01", nil, AL["Rare Fish Rewards"] },
				{ 21, 19972 }, -- Lucky Fishing Hat
				{ 22, 19969 }, -- Nat Pagle's Extreme Anglin' Boots
				{ 23, 19971 }, -- High Test Eternium Fishing Line
			},
		},
	},
}

data["LunarFestival"] = {
	name = AL["Lunar Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- LunarFestival1
			name = AL["Lunar Festival"],
			[NORMAL_DIFF] = {
				{ 1, 21100 }, -- Coin of Ancestry
				{ 3, 21157 }, -- Festive Green Dress
				{ 4, 21538 }, -- Festive Pink Dress
				{ 5, 21539 }, -- Festive Purple Dress
				{ 6, 21541 }, -- Festive Black Pant Suit
				{ 7, 21544 }, -- Festive Blue Pant Suit
				{ 8, 21543 }, -- Festive Teal Pant Suit
			},
		},
		{
			name = AL["Lunar Festival Fireworks Pack"],
			[NORMAL_DIFF] = {
				{ 1,  21558 }, -- Small Blue Rocket
				{ 2,  21559 }, -- Small Green Rocket
				{ 3,  21557 }, -- Small Red Rocket
				{ 4,  21561 }, -- Small White Rocket
				{ 5,  21562 }, -- Small Yellow Rocket
				{ 7,  21537 }, -- Festival Dumplings
				{ 8,  21713 }, -- Elune's Candle
				{ 16, 21589 }, -- Large Blue Rocket
				{ 17, 21590 }, -- Large Green Rocket
				{ 18, 21592 }, -- Large Red Rocket
				{ 19, 21593 }, -- Large White Rocket
				{ 20, 21595 }, -- Large Yellow Rocket
			}
		},
		{
			name = AL["Lucky Red Envelope"],
			[NORMAL_DIFF] = {
				{ 1,  21540 }, -- Elune's Lantern
				{ 2,  21536 }, -- Elune Stone
				{ 16, 21744 }, -- Lucky Rocket Cluster
				{ 17, 21745 }, -- Elder's Moonstone
			}
		},
		{ -- LunarFestival2
			name = AL["Plans"],
			[NORMAL_DIFF] = {
				{ 1,  21722 }, -- Pattern: Festival Dress
				{ 3,  21738 }, -- Schematic: Firework Launcher
				{ 5,  21724 }, -- Schematic: Small Blue Rocket
				{ 6,  21725 }, -- Schematic: Small Green Rocket
				{ 7,  21726 }, -- Schematic: Small Red Rocket
				{ 9,  21727 }, -- Schematic: Large Blue Rocket
				{ 10, 21728 }, -- Schematic: Large Green Rocket
				{ 11, 21729 }, -- Schematic: Large Red Rocket
				{ 16, 21723 }, -- Pattern: Festive Red Pant Suit
				{ 18, 21737 }, -- Schematic: Cluster Launcher
				{ 20, 21730 }, -- Schematic: Blue Rocket Cluster
				{ 21, 21731 }, -- Schematic: Green Rocket Cluster
				{ 22, 21732 }, -- Schematic: Red Rocket Cluster
				{ 24, 21733 }, -- Schematic: Large Blue Rocket Cluster
				{ 25, 21734 }, -- Schematic: Large Green Rocket Cluster
				{ 26, 21735 }, -- Schematic: Large Red Rocket Cluster
			},
		},
	},
}

data["Valentineday"] = {
	name = AL["Love is in the Air"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- Valentineday
			name = AL["Love is in the Air"],
			[NORMAL_DIFF] = {
				{ 1,  22206 }, -- Bouquet of Red Roses
				{ 3,  "INV_ValentinesBoxOfChocolates02", nil, AL["Gift of Adoration"] },
				{ 4,  22279 }, -- Lovely Black Dress
				{ 5,  22235 }, -- Truesilver Shafted Arrow
				{ 6,  22200 }, -- Silver Shafted Arrow
				{ 7,  22261 }, -- Love Fool
				{ 8,  22218 }, -- Handful of Rose Petals
				{ 9,  21813 }, -- Bag of Candies
				{ 11, "INV_Box_02",                      nil, AL["Box of Chocolates"] },
				{ 12, 22237 }, -- Dark Desire
				{ 13, 22238 }, -- Very Berry Cream
				{ 14, 22236 }, -- Buttermilk Delight
				{ 15, 22239 }, -- Sweet Surprise
				{ 16, 22276 }, -- Lovely Red Dress
				{ 17, 22278 }, -- Lovely Blue Dress
				{ 18, 22280 }, -- Lovely Purple Dress
				{ 19, 22277 }, -- Red Dinner Suit
				{ 20, 22281 }, -- Blue Dinner Suit
				{ 21, 22282 }, -- Purple Dinner Suit
			},
		},
	},
}
data["Noblegarden"] = {
	name = AL["Noblegarden"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- Noblegarden
			name = AL["Brightly Colored Egg"],
			[NORMAL_DIFF] = {
				{ 1,  19028 }, -- Elegant Dress
				{ 2,  6833 }, -- White Tuxedo Shirt
				{ 3,  6835 }, -- Black Tuxedo Pants
				{ 16, 7807 }, -- Candy Bar
				{ 17, 7808 }, -- Chocolate Square
				{ 18, 7806 }, -- Lollipop
			},
		},
	},
}

data["ChildrensWeek"] = {
	name = AL["Childrens Week"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- ChildrensWeek
			name = AL["Childrens Week"],
			[NORMAL_DIFF] = {
				{ 1, 23007 }, -- Piglet's Collar
				{ 2, 23015 }, -- Rat Cage
				{ 3, 23002 }, -- Turtle Box
				{ 4, 23022 }, -- Curmudgeon's Payoff
			},
		},
	},
}

data["MidsummerFestival"] = {
	name = AL["Midsummer Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- MidsummerFestival
			name = AL["Midsummer Festival"],
			[NORMAL_DIFF] = {
				{ 1,  23379 }, -- Cinder Bracers
				{ 3,  23323 }, -- Crown of the Fire Festival
				{ 4,  23324 }, -- Mantle of the Fire Festival
				{ 6,  23083 }, -- Captured Flame
				{ 7,  23247 }, -- Burning Blossom
				{ 8,  23246 }, -- Fiery Festival Brew
				{ 9,  23435 }, -- Elderberry Pie
				{ 10, 23327 }, -- Fire-toasted Bun
				{ 11, 23326 }, -- Midsummer Sausage
				{ 12, 23211 }, -- Toasted Smorc
			},
		},
	},
}

data["HarvestFestival"] = {
	name = AL["Harvest Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- HarvestFestival
			name = AL["Harvest Festival"],
			[NORMAL_DIFF] = {
				{ 1,  19697 }, -- Bounty of the Harvest
				{ 2,  20009 }, -- For the Light!
				{ 3,  20010 }, -- The Horde's Hellscream
				{ 16, 19995 }, -- Harvest Boar
				{ 17, 19996 }, -- Harvest Fish
				{ 18, 19994 }, -- Harvest Fruit
				{ 19, 19997 }, -- Harvest Nectar
			},
		},
	},
}

data["Halloween"] = {
	name = AL["Hallow's End"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.HALLOWEEN,
	items = {
		{ -- Halloween1
			name = AL["Hallow's End"].." - "..AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  20400 }, -- Pumpkin Bag
				{ 3,  18633 }, -- Styleen's Sour Suckerpop
				{ 4,  18632 }, -- Moonbrook Riot Taffy
				{ 5,  18635 }, -- Bellara's Nutterbar
				{ 6,  20557 }, -- Hallow's End Pumpkin Treat
				{ 8,  20389 }, -- Candy Corn
				{ 9,  20388 }, -- Lollipop
				{ 10, 20390 }, -- Candy Bar
			},
		},
		{ -- Halloween1
			name = AL["Hallow's End"].." - "..AL["Wands"],
			[NORMAL_DIFF] = {
				{ 1, 20410 }, -- Hallowed Wand - Bat
				{ 2, 20409 }, -- Hallowed Wand - Ghost
				{ 3, 20399 }, -- Hallowed Wand - Leper Gnome
				{ 4, 20398 }, -- Hallowed Wand - Ninja
				{ 5, 20397 }, -- Hallowed Wand - Pirate
				{ 6, 20413 }, -- Hallowed Wand - Random
				{ 7, 20411 }, -- Hallowed Wand - Skeleton
				{ 8, 20414 }, -- Hallowed Wand - Wisp
			},
		},
		{ -- Halloween3
			name = AL["Hallow's End"].." - "..AL["Masks"],
			[NORMAL_DIFF] = {
				{ 1,  20561 }, -- Flimsy Male Dwarf Mask
				{ 2,  20391 }, -- Flimsy Male Gnome Mask
				{ 3,  20566 }, -- Flimsy Male Human Mask
				{ 4,  20564 }, -- Flimsy Male Nightelf Mask
				{ 5,  20570 }, -- Flimsy Male Orc Mask
				{ 6,  20572 }, -- Flimsy Male Tauren Mask
				{ 7,  20568 }, -- Flimsy Male Troll Mask
				{ 8,  20573 }, -- Flimsy Male Undead Mask
				{ 16, 20562 }, -- Flimsy Female Dwarf Mask
				{ 17, 20392 }, -- Flimsy Female Gnome Mask
				{ 18, 20565 }, -- Flimsy Female Human Mask
				{ 19, 20563 }, -- Flimsy Female Nightelf Mask
				{ 20, 20569 }, -- Flimsy Female Orc Mask
				{ 21, 20571 }, -- Flimsy Female Tauren Mask
				{ 22, 20567 }, -- Flimsy Female Troll Mask
				{ 23, 20574 }, -- Flimsy Female Undead Mask
			},
		},
	},
}

data["WinterVeil"] = {
	name = AL["Feast of Winter Veil"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{ -- Winterviel1
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  21525 }, -- Green Winter Hat
				{ 2,  21524 }, -- Red Winter Hat
				{ 16, 17712 }, -- Winter Veil Disguise Kit
				{ 17, 17202 }, -- Snowball
				{ 18, 21212 }, -- Fresh Holly
				{ 19, 21519 }, -- Mistletoe
			},
		},
		{
			name = AL["Gaily Wrapped Present"],
			[NORMAL_DIFF] = {
				{ 1, 21301 }, -- Green Helper Box
				{ 2, 21308 }, -- Jingling Bell
				{ 3, 21305 }, -- Red Helper Box
				{ 4, 21309 }, -- Snowman Kit
			},
		},
		{
			name = AL["Festive Gift"],
			[NORMAL_DIFF] = {
				{ 1, 21328 }, -- Wand of Holiday Cheer
			},
		},
		{
			name = AL["Smokywood Pastures Special Gift"],
			[NORMAL_DIFF] = {
				{ 1,  17706 }, -- Plans: Edge of Winter
				{ 2,  17725 }, -- Formula: Enchant Weapon - Winter's Might
				{ 3,  17720 }, -- Schematic: Snowmaster 9000
				{ 4,  17722 }, -- Pattern: Gloves of the Greatfather
				{ 5,  17709 }, -- Recipe: Elixir of Frost Power
				{ 6,  17724 }, -- Pattern: Green Holiday Shirt
				{ 16, 21325 }, -- Mechanical Greench
				{ 17, 21213 }, -- Preserved Holly
			},
		},
		{
			name = AL["Gently Shaken Gift"],
			[NORMAL_DIFF] = {
				{ 1, 21235 }, -- Winter Veil Roast
				{ 2, 21241 }, -- Winter Veil Eggnog
			},
		},
		{
			name = AL["Smokywood Pastures"],
			[NORMAL_DIFF] = {
				{ 1,  17201 }, -- Recipe: Egg Nog
				{ 2,  17200 }, -- Recipe: Gingerbread Cookie
				{ 3,  17344 }, -- Candy Cane
				{ 4,  17406 }, -- Holiday Cheesewheel
				{ 5,  17407 }, -- Graccu's Homemade Meat Pie
				{ 6,  17408 }, -- Spicy Beefstick
				{ 7,  17404 }, -- Blended Bean Brew
				{ 8,  17405 }, -- Green Garden Tea
				{ 9,  17196 }, -- Holiday Spirits
				{ 10, 17403 }, -- Steamwheedle Fizzy Spirits
				{ 11, 17402 }, -- Greatfather's Winter Ale
				{ 12, 17194 }, -- Holiday Spices
				{ 16, 17303 }, -- Blue Ribboned Wrapping Paper
				{ 17, 17304 }, -- Green Ribboned Wrapping Paper
				{ 18, 17307 }, -- Purple Ribboned Wrapping Paper
			},
		},
	},
}

data["ElementalInvasions"] = {
	name = AL["Elemental Invasions"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 2.5,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- ElementalInvasion
			name = AL["Elemental Invasions"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["Baron Charr"] },
				{ 2,  18671 }, -- Baron Charr's Sceptre
				{ 3,  19268 }, -- Ace of Elementals
				{ 4,  18672 }, -- Elemental Ember
				{ 6,  "INV_Box_01", nil, AL["Princess Tempestria"] },
				{ 7,  18678 }, -- Tempestria's Frozen Necklace
				{ 8,  19268 }, -- Ace of Elementals
				{ 9,  21548 }, -- Pattern: Stormshroud Gloves
				{ 10, 18679 }, -- Frigid Ring
				{ 16, "INV_Box_01", nil, AL["Avalanchion"] },
				{ 17, 18673 }, -- Avalanchion's Stony Hide
				{ 18, 19268 }, -- Ace of Elementals
				{ 19, 18674 }, -- Hardened Stone Band
				{ 21, "INV_Box_01", nil, AL["The Windreaver"] },
				{ 22, 18676 }, -- Sash of the Windreaver
				{ 23, 19268 }, -- Ace of Elementals
				{ 24, 21548 }, -- Pattern: Stormshroud Gloves
				{ 25, 18677 }, -- Zephyr Cloak
			},
		},
	},
}

data["SilithusAbyssal"] = {
	name = AL["Silithus Abyssal"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 4,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{ -- AbyssalDukes
			name = AL["Abyssal Dukes"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["The Duke of Cynders"] },
				{ 2,  20665 }, -- Abyssal Leather Leggings
				{ 3,  20666 }, -- Hardened Steel Warhammer
				{ 4,  20514 }, -- Abyssal Signet
				{ 5,  20664 }, -- Abyssal Cloth Sash
				{ 8,  "INV_Box_01", nil, AL["The Duke of Fathoms"] },
				{ 9,  20668 }, -- Abyssal Mail Legguards
				{ 10, 20669 }, -- Darkstone Claymore
				{ 11, 20514 }, -- Abyssal Signet
				{ 12, 20667 }, -- Abyssal Leather Belt
				{ 16, "INV_Box_01", nil, AL["The Duke of Zephyrs"] },
				{ 17, 20674 }, -- Abyssal Cloth Pants
				{ 18, 20675 }, -- Soulrender
				{ 19, 20514 }, -- Abyssal Signet
				{ 20, 20673 }, -- Abyssal Plate Girdle
				{ 23, "INV_Box_01", nil, AL["The Duke of Shards"] },
				{ 24, 20671 }, -- Abyssal Plate Legplates
				{ 25, 20672 }, -- Sparkling Crystal Wand
				{ 26, 20514 }, -- Abyssal Signet
				{ 27, 20670 }, -- Abyssal Mail Clutch
			},
		},
		{ -- AbyssalLords
			name = AL["Abyssal Lords"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["Prince Skaldrenox"] },
				{ 2,  20682 }, -- Elemental Focus Band
				{ 3,  20515 }, -- Abyssal Scepter
				{ 4,  20681 }, -- Abyssal Leather Bracers
				{ 5,  20680 }, -- Abyssal Mail Pauldrons
				{ 7,  "INV_Box_01", nil, AL["Lord Skwol"] },
				{ 8,  20685 }, -- Wavefront Necklace
				{ 9,  20515 }, -- Abyssal Scepter
				{ 10, 20684 }, -- Abyssal Mail Armguards
				{ 11, 20683 }, -- Abyssal Plate Epaulets
				{ 16, "INV_Box_01", nil, AL["High Marshal Whirlaxis"] },
				{ 17, 20691 }, -- Windshear Cape
				{ 18, 20515 }, -- Abyssal Scepter
				{ 19, 20690 }, -- Abyssal Cloth Wristbands
				{ 20, 20689 }, -- Abyssal Leather Shoulders
				{ 22, "INV_Box_01", nil, AL["Baron Kazum"] },
				{ 23, 20688 }, -- Earthen Guard
				{ 24, 20515 }, -- Abyssal Scepter
				{ 25, 20686 }, -- Abyssal Cloth Amice
				{ 26, 20687 }, -- Abyssal Plate Vambraces
			},
		},
		{ -- AbyssalTemplars
			name = AL["Abyssal Templars"],
			[NORMAL_DIFF] = {
				{ 1,  "INV_Box_01", nil, AL["Crimson Templar"] },
				{ 2,  20657 }, -- Crystal Tipped Stiletto
				{ 3,  20655 }, -- Abyssal Cloth Handwraps
				{ 4,  20656 }, -- Abyssal Mail Sabatons
				{ 5,  20513 }, -- Abyssal Crest
				{ 7,  "INV_Box_01", nil, AL["Azure Templar"] },
				{ 8,  20654 }, -- Amethyst War Staff
				{ 9,  20653 }, -- Abyssal Plate Gauntlets
				{ 10, 20652 }, -- Abyssal Cloth Slippers
				{ 11, 20513 }, -- Abyssal Crest
				{ 16, "INV_Box_01", nil, AL["Hoary Templar"] },
				{ 17, 20660 }, -- Stonecutting Glaive
				{ 18, 20659 }, -- Abyssal Mail Handguards
				{ 19, 20658 }, -- Abyssal Leather Boots
				{ 20, 20513 }, -- Abyssal Crest
				{ 22, "INV_Box_01", nil, AL["Earthen Templar"] },
				{ 23, 20663 }, -- Deep Strike Bow
				{ 24, 20661 }, -- Abyssal Leather Gloves
				{ 25, 20662 }, -- Abyssal Plate Greaves
				{ 26, 20513 }, -- Abyssal Crest
			},
		},
	},
}

data["AQOpening"] = {
	name = AL["AQ opening"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 5,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	items = {
		{
			name = AL["AQ opening"],
			[NORMAL_DIFF] = {
				{ 1,  21138 }, -- Red Scepter Shard
				{ 2,  21529 }, -- Amulet of Shadow Shielding
				{ 3,  21530 }, -- Onyx Embedded Leggings
				{ 5,  21139 }, -- Green Scepter Shard
				{ 6,  21531 }, -- Drake Tooth Necklace
				{ 7,  21532 }, -- Drudge Boots
				{ 9,  21137 }, -- Blue Scepter Shard
				{ 10, 21517 }, -- Gnomish Turban of Psychic Might
				{ 11, 21527 }, -- Darkwater Robes
				{ 12, 21526 }, -- Band of Icy Depths
				{ 13, 21025 }, -- Recipe: Dirge's Kickin' Chimaerok Chops
				{ 16, 21175 }, -- The Scepter of the Shifting Sands
				{ 17, 21176 }, -- Black Qiraji Resonating Crystal
				{ 18, 21523 }, -- Fang of Korialstrasz
				{ 19, 21521 }, -- Runesword of the Red
				{ 20, 21522 }, -- Shadowsong's Sorrow
				{ 21, 21520 }, -- Ravencrest's Legacy
			},
		},
	},
}

data["ScourgeInvasion"] = {
	name = AL["Scourge Invasion"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	ContentPhase = 6,
	gameVersion = AtlasLoot.CLASSIC_VERSION_NUM,
	CorrespondingFields = private.SCOURGE_INVASION,
	items = {
		{ -- ScourgeInvasionEvent1
			name = AL["Scourge Invasion"],
			[NORMAL_DIFF] = {
				{ 1,   23123 }, -- Blessed Wizard Oil
				{ 2,   23122 }, -- Consecrated Sharpening Stone
				{ 3,   22999 }, -- Tabard of the Argent Dawn
				{ 4,   22484 }, -- Necrotic Rune
				{ 6,   236724 }, -- Robe of Undead Slaying
				{ 7,   236723 }, -- Gloves of Undead Slaying
				{ 8,   236722 }, -- Bracers of Undead Slaying
				{ 10,  236721 }, -- Robe of Undead Purification
				{ 11,  236720 }, -- Gloves of Undead Purification
				{ 12,  236719 }, -- Bracers of Undead Purification
				{ 16,  23194 }, -- Lesser Mark of the Dawn
				{ 17,  23195 }, -- Mark of the Dawn
				{ 18,  23196 }, -- Greater Mark of the Dawn
				{ 21,  236718 }, -- Robe of Undead Cleansing
				{ 22,  236717 }, -- Gloves of Undead Cleansing
				{ 23,  236716 }, -- Bracers of Undead Cleansing
				{ 25,  236707 }, -- Tunic of Undead Slaying
				{ 26,  236713 }, -- Handwraps of Undead Slaying
				{ 27,  236711 }, -- Wristwraps of Undead Slaying
				{ 101, 236727 }, -- Tunic of Undead Cleansing
				{ 102, 236726 }, -- Handwraps of Undead Cleansing
				{ 103, 236725 }, -- Wristwraps of Undead Cleansing
				{ 105, 236730 }, -- Tunic of Undead Purification
				{ 106, 236729 }, -- Handwraps of Undead Purification
				{ 107, 236728 }, -- Wristwraps of Undead Purification
				{ 109, 236709 }, -- Chestgruard of Undead Slaying
				{ 110, 236710 }, -- Wristguards of Undead Slaying
				{ 111, 236715 }, -- Handguards of Undead Slaying
				{ 113, 236736 }, -- Chestguard of Undead Cleansing
				{ 114, 236735 }, -- Handguards of Undead Cleansing
				{ 115, 236734 }, -- Wristguards of Undead Cleansing
				{ 116, 236739 }, -- Chestguard of Undead Warding
				{ 117, 236738 }, -- Handguards of Undead Warding
				{ 118, 236737 }, -- Wristguards of Undead Warding
				{ 120, 236742 }, -- Chestguard of Undead Purification
				{ 121, 236741 }, -- Handguards of Undead Purification
				{ 122, 236740 }, -- Wristguards of Undead Purification
				{ 124, 236708 }, -- Breastplate of Undead Slaying
				{ 125, 236714 }, -- Gauntlets of Undead Slaying
				{ 126, 236712 }, -- Bracers of Undead Slaying
				{ 128, 236748 }, -- Breastplate of Undead Warding
				{ 129, 236747 }, -- Gauntlets of Undead Warding
				{ 130, 236746 }, -- Bracers of Undead Warding
				{ 201, 236745 }, -- Breastplate of Undead Purification
				{ 202, 236744 }, -- Gauntlets of Undead Purification
				{ 203, 236743 }, -- Bracers of Undead Purification
			},
		},
		{
			name = C_Map_GetAreaInfo(2017).." - "..AL["Balzaphon"],
			[NORMAL_DIFF] = {
				{ 1, 238356 }, -- Waistband of Balzaphon
				{ 2, 238355 }, -- Chains of the Lich
				{ 3, 238357 }, -- Staff of Balzaphon
			}
		},
		{
			name = C_Map_GetAreaInfo(2057).." - "..AL["Lord Blackwood"],
			[NORMAL_DIFF] = {
				{ 1, 238361 }, -- Lord Blackwood's Blade
				{ 2, 238358 }, -- Blackwood's Thigh
				{ 3, 238360 }, -- Lord Blackwood's Buckler
			}
		},
		{
			name = C_Map_GetAreaInfo(2557).." - "..AL["Revanchion"],
			[NORMAL_DIFF] = {
				{ 1, 238364 }, -- Cloak of Revanchion
				{ 2, 238362 }, -- Bracers of Mending
				{ 3, 238363 }, -- The Shadow's Grasp
			}
		},
		{
			name = AL["Scarlet Monastery - Graveyard"].." - "..AL["Scorn"],
			[NORMAL_DIFF] = {
				{ 1, 238352 }, -- Scorn's Icy Choker
				{ 2, 238351 }, -- The Frozen Clutch
				{ 3, 238350 }, -- Scorn's Focal Dagger
			}
		},
		{
			name = C_Map_GetAreaInfo(209).." - "..AL["Sever"],
			[NORMAL_DIFF] = {
				{ 1, 238349 }, -- Abomination Skin Leggings
				{ 2, 238348 }, -- The Axe of Severing
			}
		},
		{
			name = C_Map_GetAreaInfo(722).." - "..AL["Lady Falther'ess"],
			[NORMAL_DIFF] = {
				{ 1, 238353 }, -- Mantle of Lady Falther'ess
				{ 2, 238354 }, -- Lady Falther'ess' Finger
			}
		},
	},
}
