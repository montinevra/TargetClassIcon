TargetSpecIconFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
TargetSpecIconFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

TargetSpecIconFrame:SetScript("OnEvent", 
	function (self, event, ...)
		local FACTION_OFFSET_Y = 5
		local spec_id
		local spec_icon

		if event == "PLAYER_TARGET_CHANGED" or (event == "PLAYER_SPECIALIZATION_CHANGED" and ... == "target") then
			TargetSpecIcon:Hide()
			TargetFaction:SetPoint("TOP", "TargetClassIcon", "BOTTOM", 0, FACTION_OFFSET_Y);
			if CanInspect("target") then
				NotifyInspect("target")
				TargetSpecIconFrame:RegisterEvent("INSPECT_READY")
			end
		end
		if event == "INSPECT_READY" then
			spec_id = GetInspectSpecialization("target")
			spec_icon = select(4, GetSpecializationInfoByID(spec_id))
			TargetSpecIcon:SetTexture(spec_icon)
			TargetSpecIcon:Show()
			TargetFaction:SetPoint("TOP", "TargetSpecIcon", "BOTTOM", 0, FACTION_OFFSET_Y);
			TargetSpecIconFrame:UnregisterEvent("INSPECT_READY")
			ClearInspectPlayer()
		end
	end
)