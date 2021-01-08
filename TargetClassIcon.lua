local factionIconCoords = {
	["Alliance"] = {1,.5,0,1},
	["Horde"] = {.5,1,0,1}
}
local classIconCoords = {
	["WARRIOR"] = {0,.25,0,.25},
	["MAGE"] = {.25,.5,0,.25},
	["ROGUE"] = {.5,.74,0,.25},
	["DRUID"] = {.75,.98,0,.25},
	["HUNTER"] = {0,.25,.25,.5},
	["SHAMAN"] = {.25,.5,.25,.5},
	["PRIEST"] = {.5,.74,.25,.5},
	["WARLOCK"] = {.75,.98,.25,.5},
	["PALADIN"] = {0,.25,.5,.75},
	["DEATHKNIGHT"] = {.25,.5,.5,.75},
	["MONK"] = {.5,.74,.5,.75},
}
TargetClassIconFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
TargetClassIconFrame:RegisterEvent("UNIT_AURA")
TargetClassIconFrame:SetScript("OnEvent", 
	function (self, event, ...)
		if event == "PLAYER_TARGET_CHANGED" or (event == "UNIT_AURA" and ... == "target" ) then
			TargetType:SetText(UnitCreatureType("target"))
		end
		if event == "PLAYER_TARGET_CHANGED" then
			local targetClass = select(2,UnitClass("target"))
			local targetFaction = UnitFactionGroup("target")
			if targetClass then 
				TargetClassIcon:SetTexCoord(unpack(classIconCoords[targetClass]))
			end
			if UnitPlayerControlled("target") and targetFaction~="Neutral" then
				TargetFaction:SetTexCoord(unpack(factionIconCoords[targetFaction]))
				TargetFaction:Show()
			else
				TargetFaction:Hide()
			end
		end
	end
)
