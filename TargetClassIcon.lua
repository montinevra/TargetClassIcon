local factionIconCoords = {
	["Alliance"] = {.18,.5,0,1},
	["Horde"] = {.5,.82,0,1}
}
TargetClassIconFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
TargetClassIconFrame:RegisterEvent("UNIT_AURA")
TargetClassIconFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
TargetClassIconFrame:SetScript("OnEvent", 
	function (self, event, ...)
		if event == "PLAYER_TARGET_CHANGED" or (event == "PLAYER_SPECIALIZATION_CHANGED" and ... == "target") then
			TargetSpec:SetText("")
			if CanInspect("target") then
				NotifyInspect("target")
				TargetClassIconFrame:RegisterEvent("INSPECT_READY")
			end
		end
		if event == "INSPECT_READY" then
			ClearInspectPlayer()
			TargetSpec:SetText(select(2, GetSpecializationInfoByID(GetInspectSpecialization("target"))))
			TargetClassIconFrame:UnregisterEvent("INSPECT_READY")
		end
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
