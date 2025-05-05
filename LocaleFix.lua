-- make sure that ptBR client returns "ptBR" instead of "xxYY"
if GetLocale() == "xxYY" then
  GetLocale = function() return "ptBR" end
end

-- fix return values of wrong translated faction groups
-- currently each faction is called "player" instead of "horde" or "alliance"
if GetLocale() == "ptBR" or GetLocale() == "esES" then
  local horde_races = {
    ["Orc"] = true,
    ["Tauren"] = true,
    ["Troll"] = true,
    ["Scourge"] = true,
    ["Goblin"] = true,
  }

  local alliance_races = {
    ["Human"] = true,
    ["Dwarf"] = true,
    ["NightElf"] = true,
    ["Gnome"] = true,
    ["BloodElf"] = true,
  }

  -- rewrite the function to manually return
  -- the proper unlocalized faction
  local hookUnitFactionGroup = UnitFactionGroup
  UnitFactionGroup = function(unitstr)
    -- skip workaround on fixed clients
    if hookUnitFactionGroup("player") ~= "Player" then
      return hookUnitFactionGroup(unitstr)
    end

    -- manually detect the correct faction
    local wrong, localized = hookUnitFactionGroup(unitstr)
    local _, race = UnitRace(unitstr)

    if horde_races[race] then
      return "Horde", localized
    elseif alliance_races[race] then
      return "Alliance", localized
    elseif wrong == "Player" then
      return "GM", localized
    end
  end
end
