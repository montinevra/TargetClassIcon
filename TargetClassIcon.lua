local factionIconCoords = {
	["Alliance"] = {.18,.5,0,1},
	["Horde"] = {.5,.82,0,1}
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
				TargetClassIcon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[targetClass]))
			end
			if UnitIsPlayer("target") and targetFaction~="Neutral" then
				TargetFaction:SetTexCoord(unpack(factionIconCoords[targetFaction]))
				TargetFaction:Show()
			else
				TargetFaction:Hide()
			end
		end
	end
)
